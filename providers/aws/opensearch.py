import os
from utils.hcl import HCL


class Opensearch:
    def __init__(self, opensearch_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key):
        self.opensearch_client = opensearch_client
        self.transform_rules = {
            "aws_opensearch_domain_policy": {
                "hcl_json_multiline": {"access_policies": True},
            },
            "aws_opensearch_domain": {
                "hcl_drop_blocks": {"cognito_options": {"enabled": False}},
                "hcl_drop_fields": {"warm_count": 0},
            }
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key)
        self.resource_list = {}

    def opensearch(self):
        self.hcl.prepare_folder(os.path.join("generated", "opensearch"))

        self.aws_opensearch_domain()
        self.aws_opensearch_domain_policy()
        # self.aws_opensearch_domain_saml_options() # Currently, there's no direct way to list or describe outbound connections using boto3.
        # self.aws_opensearch_outbound_connection() # Currently, there's no direct way to list or describe outbound connections using boto3.

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_opensearch_domain(self):
        print("Processing OpenSearch Domain...")

        domains = self.opensearch_client.list_domain_names(
            EngineType='OpenSearch')["DomainNames"]
        for domain in domains:
            domain_name = domain["DomainName"]
            domain_info = self.opensearch_client.describe_domain(DomainName=domain_name)[
                "DomainStatus"]
            arn = domain_info["ARN"]
            print(f"  Processing OpenSearch Domain: {domain_name}")

            attributes = {
                "id": arn,
                "domain_name": domain_name,
                # "domain_info": domain_info,
            }

            self.hcl.process_resource(
                "aws_opensearch_domain", domain_name.replace("-", "_"), attributes)

    def aws_opensearch_domain_policy(self):
        print("Processing OpenSearch Domain Policy...")

        domains = self.opensearch_client.list_domain_names(
            EngineType='OpenSearch')["DomainNames"]
        for domain in domains:
            domain_name = domain["DomainName"]
            domain_info = self.opensearch_client.describe_domain(
                DomainName=domain_name)["DomainStatus"]
            arn = domain_info["ARN"]
            access_policy = domain_info["AccessPolicies"]
            print(f"  Processing OpenSearch Domain Policy: {domain_name}")

            attributes = {
                "id": arn,
                "domain_name": domain_name,
                "access_policy": access_policy,
            }

            self.hcl.process_resource(
                "aws_opensearch_domain_policy", domain_name.replace("-", "_"), attributes)

    # def aws_opensearch_domain_saml_options(self):
    #     print("Processing OpenSearch Domain SAML Options...")

    #     domains = self.opensearch_client.list_domain_names(
    #         EngineType='OpenSearch')["DomainNames"]
    #     for domain in domains:
    #         domain_name = domain["DomainName"]
    #         domain_status = self.opensearch_client.describe_domain(DomainName=domain_name)[
    #             "DomainStatus"]
    #         arn = domain_status["ARN"]
    #         saml_options = domain_status.get("SamlOptions", None)

    #         if saml_options is not None:
    #             print(
    #                 f"  Processing OpenSearch Domain SAML Options: {domain_name}")

    #             attributes = {
    #                 "id": arn,
    #                 "domain_name": domain_name,
    #                 "saml_options": saml_options,
    #             }

    #             self.hcl.process_resource(
    #                 "aws_opensearch_domain_saml_options", domain_name.replace("-", "_"), attributes)

    # def aws_opensearch_outbound_connection(self):
    #     print("Processing OpenSearch Outbound Connection...")

    #     # Currently, there's no direct way to list or describe outbound connections using boto3.
    #     # You need to create the connection first, then use the connection_id to describe the connection.
    #     # Replace <your_connection_id> with the actual connection_id.
    #     connection_id = "<your_connection_id>"
    #     connection_info = self.opensearch_client.describe_outbound_cross_cluster_search_connections(
    #         ConnectionIds=[connection_id])["CrossClusterSearchConnections"][0]
    #     domain_info = connection_info["SourceDomainInfo"]
    #     destination_info = connection_info["DestinationDomainInfo"]

    #     attributes = {
    #         "id": connection_id,
    #         "connection_id": connection_id,
    #         "source_domain_name": domain_info["DomainName"],
    #         "source_domain_owner_id": domain_info["OwnerId"],
    #         "source_domain_region": domain_info["Region"],
    #         "destination_domain_name": destination_info["DomainName"],
    #         "destination_domain_owner_id": destination_info["OwnerId"],
    #         "destination_domain_region": destination_info["Region"],
    #     }

    #     self.hcl.process_resource(
    #         "aws_opensearch_outbound_connection", connection_id.replace("-", "_"), attributes)
