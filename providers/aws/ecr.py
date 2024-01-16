import os
import botocore
from utils.hcl import HCL
import json
from providers.aws.kms import KMS

class ECR:
    def __init__(self, ecr_client, kms_client, iam_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl = None):
        self.ecr_client = ecr_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.aws_account_id = aws_account_id
        self.kms_client = kms_client
        
        self.workspace_id = workspace_id
        self.modules = modules
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        else:
            self.hcl = hcl

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'build_registry_replication_rules': self.build_registry_replication_rules,
            'get_registry_scan_rules': self.get_registry_scan_rules,
            'ecr_get_repository_kms_key': self.ecr_get_repository_kms_key,
            'ecr_get_repository_kms_key_alias': self.ecr_get_repository_kms_key_alias,
        }

        self.hcl.functions.update(functions)

        self.resource_list = {}
        self.kms_instance = KMS(kms_client, iam_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)

    def get_field_from_attrs(self, attributes, arg):
        keys = arg.split(".")
        result = attributes
        for key in keys:
            if isinstance(result, list):
                result = [sub_result.get(key, None) if isinstance(
                    sub_result, dict) else None for sub_result in result]
                if len(result) == 1:
                    result = result[0]
            else:
                result = result.get(key, None)
            if result is None:
                return None
        return result
    
    def build_registry_replication_rules(self, attributes):
        formatted_rules = []
        replication_configuration = attributes.get("replication_configuration", [])
        if not replication_configuration:
            return formatted_rules
        for replication in replication_configuration:
            rules = replication.get("rule", [])
            if not rules:
                continue
            for rule in rules:
                destinations = rule.get("destination", [])
                records = []
                for destination in destinations:
                    records.append({
                        "region": destination["region"],
                        "registry_id": destination["registry_id"]
                    })
                formatted_rules.append({
                    "destinations": records
                })
        return formatted_rules
    
    def get_registry_scan_rules(self, attributes):
        result = []
        rules = attributes.get("rule", [])
        for rule in rules:
            record={}
            record["scan_frequency"] = rule.get("scan_frequency", None)
            repository_filter = rule.get('repository_filter')
            record["repository_filter"] = []
            for filter in repository_filter:
                record2 = {}
                record2["filter"] = filter.get("filter")
                record2["filter_type"] = filter.get("filter_type")
                record["repository_filter"].append(record2)

            result.append(record)
        return result
    
    def get_kms_alias(self, kms_key_id):
        try:
            value = ""
            response = self.kms_client.list_aliases()
            aliases = response.get('Aliases', [])
            while 'NextMarker' in response:
                response = self.kms_client.list_aliases(Marker=response['NextMarker'])
                aliases.extend(response.get('Aliases', []))
            for alias in aliases:
                if 'TargetKeyId' in alias and alias['TargetKeyId'] == kms_key_id.split('/')[-1]:
                    value = alias['AliasName']
                    break
            return value
        except botocore.exceptions.ClientError as e:
            if e.response['Error']['Code'] == 'AccessDeniedException':
                return ""
            else:
                raise e    

    def ecr_get_repository_kms_key(self, attributes, arg):
        kms_key_id = self.get_field_from_attrs(attributes, arg)
        if kms_key_id:
            kms_alias = self.get_kms_alias(kms_key_id)
            if kms_alias:
                return None
            return kms_key_id
        return None
    
    def ecr_get_repository_kms_key_alias(self, attributes, arg):
        kms_key_id = self.get_field_from_attrs(attributes, arg)
        if kms_key_id:
            kms_alias = self.get_kms_alias(kms_key_id)
            if kms_alias:
                return kms_alias
            return None
        return None

    def ecr(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_ecr_repository()

        if "gov" not in self.region:
            self.aws_ecr_registry_policy()
            self.aws_ecr_pull_through_cache_rule()
            self.aws_ecr_replication_configuration()



        self.hcl.refresh_state()
        self.hcl.module_hcl_code("terraform.tfstate","../providers/aws/", {}, self.region, self.aws_account_id, {}, {})

        # self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_ecr_repository(self):
        resource_type = "aws_ecr_repository"
        print("Processing ECR Repositories...")

        repositories = self.ecr_client.describe_repositories()["repositories"]
        for repo in repositories:
            repository_name = repo["repositoryName"]
            repository_arn = repo["repositoryArn"]

            print(f"  Processing ECR Repository: {repository_name}")
            id = repository_name

            ftstack = "ecr"
            try:
                tags_response = self.ecr_client.list_tags_for_resource(resourceArn=repository_arn)
                tags = tags_response.get('tags', [])
                for tag in tags:
                    if tag['Key'] == 'ftstack':
                        if tag['Value'] != 'ecr':
                            ftstack = "stack_"+tag['Value']
                        break
            except Exception as e:
                print("Error occurred: ", e)

            attributes = {
                "id": id,
                "arn": repository_arn,
            }
            self.hcl.process_resource(
                resource_type, repository_name.replace("-", "_"), attributes)
            

            emcryption_configuration = repo.get("encryptionConfiguration", {})
            if emcryption_configuration:
                kmsKey = emcryption_configuration.get("kmsKey", None)
                if kmsKey:
                    self.kms_instance.aws_kms_key(kmsKey, ftstack)

            self.hcl.add_stack(resource_type, id, ftstack)

            self.aws_ecr_repository_policy(repository_name)
            self.aws_ecr_lifecycle_policy(repository_name)

            if "gov" not in self.region:
                # Call to the aws_ecr_registry_scanning_configuration function
                self.aws_ecr_registry_scanning_configuration(repo)

    def aws_ecr_repository_policy(self, repository_name):
        print(f"Processing ECR Repository Policy for: {repository_name}")

        try:
            policy = self.ecr_client.get_repository_policy(
                repositoryName=repository_name)
        except self.ecr_client.exceptions.RepositoryPolicyNotFoundException:
            return

        policy_text = json.loads(policy["policyText"])

        attributes = {
            "id": repository_name,
            "policy": json.dumps(policy_text, indent=2),
        }
        self.hcl.process_resource(
            "aws_ecr_repository_policy", f"{repository_name}_policy".replace("-", "_"), attributes)

    def aws_ecr_lifecycle_policy(self, repository_name):
        print(f"Processing ECR Lifecycle Policy for: {repository_name}")

        try:
            lifecycle_policy = self.ecr_client.get_lifecycle_policy(repositoryName=repository_name)[
                "lifecyclePolicyText"]
        except self.ecr_client.exceptions.LifecyclePolicyNotFoundException:
            return

        print(
            f"  Processing ECR Lifecycle Policy for repository: {repository_name}")

        attributes = {
            "id": repository_name,
            "policy": json.dumps(json.loads(lifecycle_policy), indent=2),
        }
        self.hcl.process_resource(
            "aws_ecr_lifecycle_policy", repository_name.replace("-", "_"), attributes)

    def aws_ecr_registry_policy(self):
        print("Processing ECR Registry Policies...")
        resource_type = "aws_ecr_registry_policy"

        try:
            registry_policy = self.ecr_client.get_registry_policy()
            if "registryPolicyText" not in registry_policy:
                return
            registry_policy = registry_policy["registryPolicyText"]
        except self.ecr_client.exceptions.RegistryPolicyNotFoundException:
            return

        print(f"  Processing ECR Registry Policy")
        id = self.ecr_client.describe_registries()["registries"][0]["registryId"],

        attributes = {
            "policy": json.dumps(json.loads(registry_policy), indent=2),
        }
        self.hcl.process_resource(
            resource_type, "ecr_registry_policy", attributes)

        ftstack = "ecr"
        self.hcl.add_stack(resource_type, id, ftstack)


    def aws_ecr_pull_through_cache_rule(self):
        print("Processing ECR Pull Through Cache Rules...")
        resource_type = "aws_ecr_pull_through_cache_rule"

        repositories = self.ecr_client.describe_repositories()["repositories"]
        for repo in repositories:
            repository_name = repo["repositoryName"]
            try:
                cache_settings = self.ecr_client.get_registry_policy()
                if "registryPolicyText" not in cache_settings:
                    continue
                cache_settings = cache_settings["registryPolicyText"]
                cache_settings_data = json.loads(cache_settings)
            except self.ecr_client.exceptions.RegistryPolicyNotFoundException:
                continue

            for rule in cache_settings_data.get("rules", []):
                if rule["repositoryName"] == repository_name:
                    print(
                        f"  Processing ECR Pull Through Cache Rule for repository: {repository_name}")
                    id = repository_name
                    attributes = {
                        "id": id,
                        "action": rule["action"],
                        "rule_priority": rule["rulePriority"],
                    }
                    self.hcl.process_resource(
                        resource_type, id, attributes)
                    ftstack = "ecr"
                    self.hcl.add_stack(resource_type, id, ftstack)


    def aws_ecr_registry_scanning_configuration(self, repo):
        repository_name = repo["repositoryName"]
        image_scanning_config = repo["imageScanningConfiguration"]

        print(
            f"  Processing ECR Registry Scanning Configuration for repository: {repository_name}")

        attributes = {
            "id": repository_name,
            "scan_on_push": image_scanning_config["scanOnPush"],
        }
        self.hcl.process_resource(
            "aws_ecr_registry_scanning_configuration", repository_name.replace("-", "_"), attributes)

    def aws_ecr_replication_configuration(self):
        print("Processing ECR Replication Configurations...")
        resource_type = "aws_ecr_replication_configuration"

        try:
            registry = self.ecr_client.describe_registry()
            registryId = registry["registryId"]
            replication_configuration = registry["replicationConfiguration"]
        except KeyError:
            return

        rules = replication_configuration["rules"]

        # Skip the resource if the rules are empty
        if len(rules) == 0:
            print("  No rules for ECR Replication Configuration. Skipping...")
            return

        print(f"  Processing ECR Replication Configuration")

        # formatted_rules = []
        # for rule in rules:
        #     formatted_rules.append({
        #         "destination": {
        #             "region": rule["destination"]["region"],
        #             "registry_id": rule["destination"]["registryId"]
        #         }
        #     })

        attributes = {
            "id": registryId,
            # "rule": formatted_rules,
        }
        self.hcl.process_resource(
            resource_type, registryId, attributes)
        
        ftstack = "ecr"
        self.hcl.add_stack(resource_type, registryId, ftstack)
