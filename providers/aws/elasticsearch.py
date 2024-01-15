import os
from utils.hcl import HCL
from providers.aws.security_group import SECURITY_GROUP
from providers.aws.kms import KMS

class Elasticsearch:
    def __init__(self, elasticsearch_client, ec2_client, kms_client, iam_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.elasticsearch_client = elasticsearch_client
        self.ec2_client = ec2_client
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
        self.aws_account_id = aws_account_id

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'es_get_vpc_options': self.es_get_vpc_options,
            'es_get_tags': self.es_get_tags,
            'es_get_vpc_name': self.es_get_vpc_name,
            # 'es_get_subnet_names': self.es_get_subnet_names,
            # 'es_get_subnet_ids': self.es_get_subnet_ids,
        }

        self.hcl.functions.update(functions)

        self.security_group_instance = SECURITY_GROUP(ec2_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)
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
    
    def es_get_tags(self, attributes):
        arn = attributes.get("arn", None)
        if arn:
            tags_response = self.elasticsearch_client.list_tags(
                ARN=arn
            )
            tags = tags_response.get("TagList", [])
            result = {}
            for tag in tags:
                key = tag["Key"]
                value = tag["Value"]
                result[key] = value
            return result
        return None
    
    def es_get_vpc_name(self, attributes):
        vpc_name = None
        vpc_id = None
        vpc_options = attributes.get('vpc_options', [])
        if vpc_options:
            subnets = vpc_options[0].get("subnet_ids")
            if subnets:
                #get the vpc id for the first subnet
                subnet_id = subnets[0]
                response = self.ec2_client.describe_subnets(SubnetIds=[subnet_id])
                vpc_id = response['Subnets'][0]['VpcId']
        if vpc_id:
            response = self.ec2_client.describe_vpcs(VpcIds=[vpc_id])
            vpc_name = next(
                (tag['Value'] for tag in response['Vpcs'][0]['Tags'] if tag['Key'] == 'Name'), None)
            return vpc_name
    

    def es_get_vpc_options(self, attributes):
        vpc_options = attributes.get("vpc_options", None)
        if vpc_options is None:
            return None
        result = {}
        result["security_group_ids"] = vpc_options[0].get(
            "security_group_ids", None)
        subnet_ids = result["subnet_ids"] = vpc_options[0].get("subnet_ids", None)
        subnet_names = self.es_get_subnet_names(subnet_ids)
        if subnet_names:
            result["subnet_names"] = subnet_names
            del result["subnet_ids"]
        return result
    
    def es_get_subnet_names(self, subnet_ids):
        subnet_names = []
        for subnet_id in subnet_ids:
            response = self.ec2_client.describe_subnets(SubnetIds=[subnet_id])

            # Check if 'Subnets' key exists and it's not empty
            if not response or 'Subnets' not in response or not response['Subnets']:
                print(
                    f"No subnet information found for Subnet ID: {subnet_id}")
                continue

            # Extract the 'Tags' key safely using get
            subnet_tags = response['Subnets'][0].get('Tags', [])

            # Extract the subnet name from the tags
            subnet_name = next(
                (tag['Value'] for tag in subnet_tags if tag['Key'] == 'Name'), None)

            if subnet_name:
                subnet_names.append(subnet_name)
            else:
                print(f"No 'Name' tag found for Subnet ID: {subnet_id}")

        return subnet_names

    def elasticsearch(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_elasticsearch_domain()

        self.hcl.refresh_state()
        config_file_list = ["elasticsearch.yaml", "security_group.yaml"]
        for index,config_file in enumerate(config_file_list):
            config_file_list[index] = os.path.join(os.path.dirname(os.path.abspath(__file__)),config_file )
        self.hcl.module_hcl_code("terraform.tfstate",config_file_list, {}, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

    def aws_elasticsearch_domain(self):
        resource_type = "aws_elasticsearch_domain"
        print("Processing OpenSearch Domain...")

        domains = self.elasticsearch_client.list_domain_names()["DomainNames"]
        for domain in domains:
            domain_name = domain["DomainName"]
            domain_info = self.elasticsearch_client.describe_elasticsearch_domain(DomainName=domain_name)[
                "DomainStatus"]
            arn = domain_info["ARN"]
            print(f"  Processing OpenSearch Domain: {domain_name}")

            id = domain_name

            attributes = {
                "id": id,
                "domain_name": domain_name,
            }

            # Get the tags of the domain
            tags_response = self.elasticsearch_client.list_tags(
                ARN=arn
            )
            tags = tags_response.get("TagList", [])

            ftstack = "elasticsearch"    
            for tag in tags:
                key = tag["Key"]
                if key == "ftstack":
                    ftstack = tag["Value"]
                    break

            # Process the domain resource
            self.hcl.process_resource(
                resource_type, domain_name, attributes)

            self.hcl.add_stack(resource_type, id, ftstack)


            vpc_options = domain_info.get('VPCOptions', {})
            if vpc_options:
                security_groups = vpc_options.get(
                    'SecurityGroupIds', [])
                for sg in security_groups:
                    self.security_group_instance.aws_security_group(sg, ftstack)

            encrypt_at_rest = domain_info.get('EncryptionAtRestOptions', {})
            if encrypt_at_rest:
                kmsKeyId = encrypt_at_rest.get('KmsKeyId', None)
                if kmsKeyId:
                    kmsKeyId = kmsKeyId.split('/')[-1]
                    self.kms_instance.aws_kms_key(kmsKeyId, ftstack)        

            # self.aws_elasticsearch_domain_policy(domain_name)

    # Updated function signature
    def aws_elasticsearch_domain_policy(self, domain_name):
        print("Processing OpenSearch Domain Policy...")

        # Since the domain is already known, we don't need to retrieve all domains
        domain_info = self.elasticsearch_client.describe_elasticsearch_domain(DomainName=domain_name)[
            "DomainStatus"]
        arn = domain_info["ARN"]
        # access_policy = domain_info["AccessPolicies"]
        print(f"  Processing OpenSearch Domain Policy: {domain_name}")

        id = domain_name

        attributes = {
            "id": id,
            "domain_name": id,
        }

        # Process the policy resource
        self.hcl.process_resource(
            "aws_elasticsearch_domain_policy", id, attributes)

