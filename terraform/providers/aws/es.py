import os
from utils.hcl import HCL


class ES:
    def __init__(self, es_client, script_dir, provider_name, schema_data, region):
        self.es_client = es_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def es(self):
        self.hcl.prepare_folder(os.path.join("generated", "es"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_elasticsearch_domain(self):
        print("Processing Elasticsearch Domains...")

        paginator = self.es_client.get_paginator("list_domain_names")
        for page in paginator.paginate():
            for domain in page["DomainNames"]:
                domain_name = domain["DomainName"]
                domain_info = self.es_client.describe_elasticsearch_domain(
                    DomainName=domain_name)["DomainStatus"]
                print(f"  Processing Elasticsearch Domain: {domain_name}")

                attributes = {
                    "id": domain_info["DomainId"],
                    "domain_name": domain_name,
                    "arn": domain_info["ARN"],
                    # Add more attributes as needed
                }

                self.hcl.process_resource(
                    "aws_elasticsearch_domain", domain_name.replace("-", "_"), attributes)

    def aws_elasticsearch_domain_policy(self):
        print("Processing Elasticsearch Domain Policies...")

        paginator = self.es_client.get_paginator("list_domain_names")
        for page in paginator.paginate():
            for domain in page["DomainNames"]:
                domain_name = domain["DomainName"]
                policy = self.es_client.describe_elasticsearch_domain_config(
                    DomainName=domain_name)["DomainConfig"]["AccessPolicies"]
                print(
                    f"  Processing Elasticsearch Domain Policy: {domain_name}")

                attributes = {
                    "id": domain_name,
                    "domain_name": domain_name,
                    "access_policies": policy["Options"],
                }

                self.hcl.process_resource(
                    "aws_elasticsearch_domain_policy", domain_name.replace("-", "_"), attributes)

    def aws_elasticsearch_domain_saml_options(self):
        print("Processing Elasticsearch Domain SAML Options...")

        paginator = self.es_client.get_paginator("list_domain_names")
        for page in paginator.paginate():
            for domain in page["DomainNames"]:
                domain_name = domain["DomainName"]
                saml_options = self.es_client.describe_elasticsearch_domain_config(
                    DomainName=domain_name)["DomainConfig"]["SAMLOptions"]
                print(
                    f"  Processing Elasticsearch Domain SAML Options: {domain_name}")

                attributes = {
                    "id": domain_name,
                    "domain_name": domain_name,
                    "saml_options": saml_options["Options"],
                }

                self.hcl.process_resource(
                    "aws_elasticsearch_domain_saml_options", domain_name.replace("-", "_"), attributes)
