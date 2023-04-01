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

                attributes = {
                    "id": f"{endpoint_id}_{rule['GroupId']}",
                    "client_vpn_endpoint_id": endpoint_id,
                    "target_network_cidr": rule["AccessAll"],
                    "authorize_all_groups": rule["AccessAll"],
                }

                self.hcl.process_resource("aws_ec2_client_vpn_authorization_rule",
                                          f"{endpoint_id}_{rule['GroupId']}".replace("-", "_"), attributes)

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
            route_id = f"{endpoint_id}_{route['DestinationCidr']}_{route['TargetSubnet']}"
            print(f"  Processing EC2 Client VPN Route: {route_id}")

            attributes = {
                "id": route_id,
                "client_vpn_endpoint_id": endpoint_id,
                "destination_cidr_block": route["DestinationCidr"],
                "target_vpc_subnet_id": route["TargetSubnet"],
            }

            self.hcl.process_resource(
                "aws_ec2_client_vpn_route", route_id.replace("-", "_"), attributes)
