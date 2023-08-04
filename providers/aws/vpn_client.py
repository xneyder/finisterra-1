import os
from utils.hcl import HCL


class VpnClient:
    def __init__(self, ec2_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
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

    def vpn_client(self):
        self.hcl.prepare_folder(os.path.join("generated", "vpn_client"))

        self.aws_ec2_client_vpn_authorization_rule()
        self.aws_ec2_client_vpn_endpoint()
        self.aws_ec2_client_vpn_network_association()
        self.aws_ec2_client_vpn_route()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_ec2_client_vpn_authorization_rule(self):
        print("Processing EC2 Client VPN Authorization Rules...")

        response = self.ec2_client.describe_client_vpn_endpoints()
        for endpoint in response["ClientVpnEndpoints"]:
            endpoint_id = endpoint["ClientVpnEndpointId"]
            try:
                auth_rules_resp = self.ec2_client.describe_client_vpn_authorization_rules(
                    ClientVpnEndpointId=endpoint_id)
                for rule in auth_rules_resp["AuthorizationRules"]:
                    print(
                        f"  Processing EC2 Client VPN Authorization Rule: {rule['GroupId']}")

                    if rule['GroupId'] != "":
                        id = f"{endpoint_id},{rule['DestinationCidr']},{rule['GroupId']}"
                    else:
                        id = f"{endpoint_id},{rule['DestinationCidr']}"
                    attributes = {
                        # Assuming DestinationCidr holds the CIDR value
                        "id": id,
                        "client_vpn_endpoint_id": endpoint_id,
                        # Assuming DestinationCidr holds the CIDR value
                        "target_network_cidr": rule["DestinationCidr"],
                        "authorize_all_groups": rule["AccessAll"],
                    }

                    self.hcl.process_resource("aws_ec2_client_vpn_authorization_rule",
                                              f"{endpoint_id}_{rule['DestinationCidr']}_{rule['GroupId']}".replace("-", "_"), attributes)

            except self.ec2_client.exceptions.ClientError as e:
                print(
                    f"  Error processing EC2 Client VPN Authorization Rule: {str(e)}")

    def aws_ec2_client_vpn_endpoint(self):
        print("Processing EC2 Client VPN Endpoints...")

        response = self.ec2_client.describe_client_vpn_endpoints()
        for endpoint in response["ClientVpnEndpoints"]:
            endpoint_id = endpoint["ClientVpnEndpointId"]
            print(f"  Processing EC2 Client VPN Endpoint: {endpoint_id}")

            attributes = {
                "id": endpoint_id,
                "description": endpoint["Description"],
                "server_certificate_arn": endpoint["ServerCertificateArn"],
                "client_cidr_block": endpoint["ClientCidrBlock"],
                "dns_servers": endpoint["DnsServers"],
                "transport_protocol": endpoint["TransportProtocol"],
                "vpn_protocol": endpoint["VpnProtocol"],
                "authentication_options": endpoint["AuthenticationOptions"],
            }

            if "Tags" in endpoint:
                attributes["tags"] = {tag["Key"]: tag["Value"]
                                      for tag in endpoint["Tags"]}

            self.hcl.process_resource(
                "aws_ec2_client_vpn_endpoint", endpoint_id.replace("-", "_"), attributes)

    def aws_ec2_client_vpn_network_association(self):
        print("Processing EC2 Client VPN Network Associations...")

        response = self.ec2_client.describe_client_vpn_endpoints()
        for endpoint in response["ClientVpnEndpoints"]:
            endpoint_id = endpoint["ClientVpnEndpointId"]
            associations = self.ec2_client.describe_client_vpn_target_networks(
                ClientVpnEndpointId=endpoint_id)
            for association in associations["ClientVpnTargetNetworks"]:
                association_id = association["AssociationId"]
                print(
                    f"  Processing EC2 Client VPN Network Association: {association_id}")

                attributes = {
                    "id": association_id,
                    "client_vpn_endpoint_id": endpoint_id,
                    "subnet_id": association["TargetNetworkId"],
                }

                self.hcl.process_resource(
                    "aws_ec2_client_vpn_network_association", association_id.replace("-", "_"), attributes)

    def aws_ec2_client_vpn_route(self):
        print("Processing EC2 Client VPN Routes...")

        response = self.ec2_client.describe_client_vpn_endpoints()
        for endpoint in response["ClientVpnEndpoints"]:
            endpoint_id = endpoint["ClientVpnEndpointId"]
            routes = self.ec2_client.describe_client_vpn_routes(
                ClientVpnEndpointId=endpoint_id)
            for route in routes["Routes"]:
                route_id = f"{endpoint_id},{route['DestinationCidr']},{route['TargetSubnet']}"
                print(f"  Processing EC2 Client VPN Route: {route_id}")

                attributes = {
                    "id": route_id,
                    "client_vpn_endpoint_id": endpoint_id,
                    "destination_cidr_block": route["DestinationCidr"],
                    "target_vpc_subnet_id": route["TargetSubnet"],
                }

                self.hcl.process_resource(
                    "aws_ec2_client_vpn_route", route_id.replace("-", "_"), attributes)
