import os
from utils.hcl import HCL


class ES:
    def __init__(self, es_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.es_client = es_client
        self.transform_rules = {
            "aws_elasticsearch_domain_policy": {
                "hcl_json_multiline": {"access_policies": True},
            },
            "aws_elasticsearch_domain": {
                "hcl_drop_blocks": {"cognito_options": {"enabled": False}},
                "hcl_drop_fields": {"warm_count": 0,
                                    "vpc_options.availability_zones": "ALL",
                                    "vpc_options.vpc_id": "ALL",
                                    "cluster_config.warm_count": 0,
                                    "ebs_options.throughput": 0
                                    },
            }
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}

    def es(self):
        self.hcl.prepare_folder(os.path.join("generated", "es"))

        self.aws_elasticsearch_domain()
        self.aws_elasticsearch_domain_policy()
        # self.aws_elasticsearch_domain_saml_options() # Currently, there's no direct way to list or describe outbound connections using boto3.

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_elasticsearch_domain(self):
        print("Processing Elasticsearch Domains...")

        domains = self.es_client.list_domain_names(
            EngineType='Elasticsearch')["DomainNames"]
        for domain in domains:
            domain_name = domain["DomainName"]
            domain_info = self.es_client.describe_elasticsearch_domain(
                DomainName=domain_name)["DomainStatus"]

            print(f"  Processing Elasticsearch Domain: {domain_name}")

            attributes = {
                "id": domain_info["ARN"],
                "domain_name": domain_name,
                "arn": domain_info["ARN"],
                # Add more attributes as needed
            }

            self.hcl.process_resource(
                "aws_elasticsearch_domain", domain_name.replace("-", "_"), attributes)

    def aws_elasticsearch_domain_policy(self):
        print("Processing Elasticsearch Domain Policies...")

        domains = self.es_client.list_domain_names(
            EngineType='Elasticsearch')["DomainNames"]
        for domain in domains:
            domain_name = domain["DomainName"]
            domain_info = self.es_client.describe_elasticsearch_domain(
                DomainName=domain_name)["DomainStatus"]
            arn = domain_info["ARN"]
            # access_policy = self.es_client.describe_elasticsearch_domain_config(
            #     DomainName=domain_name)["DomainConfig"]["AccessPolicies"]

            print(f"  Processing Elasticsearch Domain Policy: {domain_name}")

            attributes = {
                "id": arn,
                "domain_name": domain_name,
                # "access_policies": access_policy,
            }

            self.hcl.process_resource(
                "aws_elasticsearch_domain_policy", domain_name.replace("-", "_"), attributes)
