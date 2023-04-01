
def aws_opensearch_domain(self):
    print("Processing OpenSearch Domain...")

    paginator = self.opensearch_client.get_paginator("list_domain_names")
    for page in paginator.paginate():
        for domain in page["DomainNames"]:
            domain_name = domain["DomainName"]
            domain_info = self.opensearch_client.describe_domain(DomainName=domain_name)[
                "DomainStatus"]
            print(f"  Processing OpenSearch Domain: {domain_name}")

            attributes = {
                "id": domain_name,
                "domain_name": domain_name,
                "domain_info": domain_info,
            }

            self.hcl.process_resource(
                "aws_opensearch_domain", domain_name.replace("-", "_"), attributes)


def aws_opensearch_domain_policy(self):
    print("Processing OpenSearch Domain Policy...")

    paginator = self.opensearch_client.get_paginator("list_domain_names")
    for page in paginator.paginate():
        for domain in page["DomainNames"]:
            domain_name = domain["DomainName"]
            access_policy = self.opensearch_client.describe_domain(
                DomainName=domain_name)["DomainStatus"]["AccessPolicies"]
            print(f"  Processing OpenSearch Domain Policy: {domain_name}")

            attributes = {
                "id": domain_name,
                "domain_name": domain_name,
                "access_policy": access_policy,
            }

            self.hcl.process_resource(
                "aws_opensearch_domain_policy", domain_name.replace("-", "_"), attributes)


def aws_opensearch_domain_saml_options(self):
    print("Processing OpenSearch Domain SAML Options...")

    paginator = self.opensearch_client.get_paginator("list_domain_names")
    for page in paginator.paginate():
        for domain in page["DomainNames"]:
            domain_name = domain["DomainName"]
            saml_options = self.opensearch_client.describe_domain(
                DomainName=domain_name)["DomainStatus"]["SamlOptions"]
            print(
                f"  Processing OpenSearch Domain SAML Options: {domain_name}")

            attributes = {
                "id": domain_name,
                "domain_name": domain_name,
                "saml_options": saml_options,
            }

            self.hcl.process_resource(
                "aws_opensearch_domain_saml_options", domain_name.replace("-", "_"), attributes)


def aws_opensearch_outbound_connection(self):
    print("Processing OpenSearch Outbound Connection...")

    # Currently, there's no direct way to list or describe outbound connections using boto3.
    # You need to create the connection first, then use the connection_id to describe the connection.
    # Replace <your_connection_id> with the actual connection_id.
    connection_id = "<your_connection_id>"
    connection_info = self.opensearch_client.describe_outbound_cross_cluster_search_connections(
        ConnectionIds=[connection_id])["CrossClusterSearchConnections"][0]
    domain_info = connection_info["SourceDomainInfo"]
    destination_info = connection_info["DestinationDomainInfo"]

    attributes = {
        "id": connection_id,
        "connection_id": connection_id,
        "source_domain_name": domain_info["DomainName"],
        "source_domain_owner_id": domain_info["OwnerId"],
        "source_domain_region": domain_info["Region"],
        "destination_domain_name": destination_info["DomainName"],
        "destination_domain_owner_id": destination_info["OwnerId"],
        "destination_domain_region": destination_info["Region"],
    }

    self.hcl.process_resource(
        "aws_opensearch_outbound_connection", connection_id.replace("-", "_"), attributes)
