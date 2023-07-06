import os
from utils.hcl import HCL
import json


class ECR:
    def __init__(self, ecr_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.ecr_client = ecr_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}

    def ecr(self):
        self.hcl.prepare_folder(os.path.join("generated", "ecr"))

        if "gov" not in self.region:
            self.aws_ecr_lifecycle_policy()  # -
            self.aws_ecr_registry_policy()  # -
            self.aws_ecr_pull_through_cache_rule()  # -
            self.aws_ecr_replication_configuration()  # -
            self.aws_ecr_registry_scanning_configuration()  # -

        self.aws_ecr_repository()  # -
        self.aws_ecr_repository_policy()  # -

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_ecr_lifecycle_policy(self):
        print("Processing ECR Lifecycle Policies...")

        repositories = self.ecr_client.describe_repositories()["repositories"]
        for repo in repositories:
            repository_name = repo["repositoryName"]
            try:
                lifecycle_policy = self.ecr_client.get_lifecycle_policy(repositoryName=repository_name)[
                    "lifecyclePolicyText"]
            except self.ecr_client.exceptions.LifecyclePolicyNotFoundException:
                continue

            print(
                f"  Processing ECR Lifecycle Policy for repository: {repository_name}")

            attributes = {
                "id": repository_name,
                "policy": json.dumps(json.loads(lifecycle_policy), indent=2),
            }
            self.hcl.process_resource(
                "aws_ecr_lifecycle_policy", repository_name.replace("-", "_"), attributes)

    def aws_ecr_pull_through_cache_rule(self):
        print("Processing ECR Pull Through Cache Rules...")

        repositories = self.ecr_client.describe_repositories()["repositories"]
        for repo in repositories:
            repository_name = repo["repositoryName"]
            try:
                cache_settings = self.ecr_client.get_registry_policy()[
                    "registryPolicyText"]
                cache_settings_data = json.loads(cache_settings)
            except self.ecr_client.exceptions.RegistryPolicyNotFoundException:
                continue

            for rule in cache_settings_data.get("rules", []):
                if rule["repositoryName"] == repository_name:
                    print(
                        f"  Processing ECR Pull Through Cache Rule for repository: {repository_name}")
                    attributes = {
                        "id": repository_name,
                        "action": rule["action"],
                        "rule_priority": rule["rulePriority"],
                    }
                    self.hcl.process_resource(
                        "aws_ecr_pull_through_cache_rule", repository_name.replace("-", "_"), attributes)

    def aws_ecr_registry_policy(self):
        print("Processing ECR Registry Policies...")

        try:
            registry_policy = self.ecr_client.get_registry_policy()[
                "registryPolicyText"]
        except self.ecr_client.exceptions.RegistryPolicyNotFoundException:
            return

        print(f"  Processing ECR Registry Policy")

        attributes = {
            "policy": json.dumps(json.loads(registry_policy), indent=2),
        }
        self.hcl.process_resource(
            "aws_ecr_registry_policy", "ecr_registry_policy", attributes)

    def aws_ecr_registry_scanning_configuration(self):
        print("Processing ECR Registry Scanning Configurations...")

        repositories = self.ecr_client.describe_repositories()["repositories"]
        for repo in repositories:
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

        formatted_rules = []
        for rule in rules:
            formatted_rules.append({
                "destination": {
                    "region": rule["destination"]["region"],
                    "registry_id": rule["destination"]["registryId"]
                }
            })

        attributes = {
            "id": registryId,
            "rule": formatted_rules,
        }
        self.hcl.process_resource(
            "aws_ecr_replication_configuration", "ecr_replication_configuration", attributes)

    def aws_ecr_repository(self):
        print("Processing ECR Repositories...")

        repositories = self.ecr_client.describe_repositories()["repositories"]
        for repo in repositories:
            repository_name = repo["repositoryName"]
            repository_arn = repo["repositoryArn"]

            print(f"  Processing ECR Repository: {repository_name}")

            attributes = {
                "id": repository_name,
                "arn": repository_arn,
            }
            self.hcl.process_resource(
                "aws_ecr_repository", repository_name.replace("-", "_"), attributes)

    def aws_ecr_repository_policy(self):
        print("Processing ECR Repository Policies...")

        repositories = self.ecr_client.describe_repositories()["repositories"]
        for repo in repositories:
            repository_name = repo["repositoryName"]
            repository_arn = repo["repositoryArn"]

            try:
                policy = self.ecr_client.get_repository_policy(
                    repositoryName=repository_name)
            except self.ecr_client.exceptions.RepositoryPolicyNotFoundException:
                continue

            policy_text = json.loads(policy["policyText"])

            print(f"  Processing ECR Repository Policy for: {repository_name}")

            attributes = {
                "id": repository_name,
                "policy": json.dumps(policy_text, indent=2),
            }
            self.hcl.process_resource(
                "aws_ecr_repository_policy", f"{repository_name}_policy".replace("-", "_"), attributes)
