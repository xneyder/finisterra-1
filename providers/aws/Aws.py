import os
import boto3
import os
import subprocess
import shutil
import json
from utils.hcl import HCL

class Aws:
    def __init__(self, script_dir):
        self.aws_access_key_id = os.getenv("AWS_ACCESS_KEY_ID")
        self.aws_secret_access_key = os.getenv("AWS_SECRET_ACCESS_KEY")
        self.aws_session_token = os.getenv("AWS_SESSION_TOKEN")
        self.region = os.getenv("AWS_REGION")

        if self.aws_access_key_id and self.aws_secret_access_key and self.region:
            self.session = boto3.Session(
                aws_access_key_id=self.aws_access_key_id,
                aws_secret_access_key=self.aws_secret_access_key,
                aws_session_token=self.aws_session_token,
                region_name=self.region,
            )
        else:
            print("AWS credentials not found in environment variables.")
            exit()

        self.transform_rules = {
            "aws_vpc": {
                "hcl_drop_fields": {"ipv6_netmask_length": 0},
                "hcl_keep_fields": {"cidr_block": True},
            },
            "aws_subnet": {
                "hcl_drop_fields": {"map_customer_owned_ip_on_launch": False},
            },
            "aws_route53_zone": {
                "hcl_transform_fields": {
                    "force_destroy": {'source': None, 'target': False},
                    "comment": {'source': "", 'target': ""},
                },
            },
            "aws_route53_record": {
                "hcl_drop_fields": {
                    "multivalue_answer_routing_policy": False,
                    "ttl": 0,
                },
            },
        }
        self.provider_name = "registry.terraform.io/hashicorp/aws"
        self.script_dir = script_dir
        self.schema_data=self.load_provider_schema()
        self.hcl = HCL(self.schema_data, self.provider_name, self.script_dir, self.transform_rules)

    def create_folder(self,folder):
        if not os.path.exists(folder):
            os.makedirs(folder)
            print(f"Folder '{folder}' has been created.")
        else:
            print(f"Folder '{folder}' already exists.")
    
    def load_provider_schema(self):
        self.create_folder(os.path.join("tmp"))
        os.chdir(os.path.join("tmp"))
        self.create_version_file()
        print("Initializing Terraform...")
        subprocess.run(["terraform", "init"], check=True)
        print("Loading provider schema...")
        global schema_data
        temp_file='terraform_providers_schema.json'
        # Load the provider schema using the terraform cli
        output = open(temp_file, 'w')
        subprocess.run(["terraform", "providers", "schema",
                    "-json"], check=True, stdout=output)
        with open(temp_file, "r") as schema_file:
            schema_data = json.load(schema_file)
        # remove the temporary file
        os.chdir(self.script_dir)
        shutil.rmtree(os.path.join("tmp"))
        return schema_data
    
    def create_version_file(self):
        with open("version.tf", "w") as version_file:
            version_file.write('terraform {\n')
            version_file.write('  required_providers {\n')
            version_file.write('  aws = {\n')
            version_file.write('  source  = "hashicorp/aws"\n')
            version_file.write('  version = "~> 4.0"\n')
            version_file.write('}\n')
            version_file.write('}\n')
            version_file.write('}\n')

    def prepare_folder(self,folder):
        try:
            os.chdir(self.script_dir)
            generated_path=os.path.join(folder)
            self.hcl.create_folder(generated_path)
            os.chdir(generated_path)
            self.create_version_file()
            print("Initializing Terraform...")
            subprocess.run(["terraform", "init"], check=True)
        except Exception as e:
            print(e)
            exit()


    def route53(self):
        self.prepare_folder(os.path.join("generated","route53"))
        self.process_route53()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()


    def process_route53(self):
        route53 = self.session.client("route53", region_name=self.region)

        print("Processing Route53 hosted zones and records...")
        paginator = route53.get_paginator("list_hosted_zones")
        for page in paginator.paginate():
            for hosted_zone in page["HostedZones"]:
                zone_id = hosted_zone["Id"].split("/")[-1]
                zone_name = hosted_zone["Name"].rstrip(".")

                attributes = {
                    "id": zone_id,
                }
                print(f"Processing hosted zone: {zone_name} (ID: {zone_id})")

                self.hcl.process_resource("aws_route53_zone",
                                zone_id+"_"+zone_name.replace(".", "_"), attributes)

                record_paginator = route53.get_paginator(
                    "list_resource_record_sets")
                for record_page in record_paginator.paginate(HostedZoneId=hosted_zone["Id"]):
                    for record in record_page["ResourceRecordSets"]:
                        record_name = record["Name"].rstrip(".")
                        record_type = record["Type"]

                        if record_type in ["SOA", "NS"]:
                            continue

                        print(
                            f"  Processing record: {record_name} ({record_type})")

                        resource_name = f"{zone_name}_{record_name}_{record_type}".replace(
                            ".", "_")
                        resource_id = f"{zone_id}_{record_name}_{record_type}"
                        attributes = {
                            "id": resource_id,
                            "type": record_type,
                            "name": record_name,
                            "zone_id": zone_id,
                        }
                        self.hcl.process_resource("aws_route53_record",
                                        resource_name, attributes)


    def vpc(self):
        self.prepare_folder(os.path.join("generated","vpc"))

        # self.aws_vpc() #OK
        # self.aws_subnet() #OK
        # self.aws_default_network_acl() #OK
        # self.aws_default_route_table() #OK
        # self.aws_default_security_group() #OK
        # self.aws_default_subnet() # terraform plan error
        # self.aws_default_vpc() # terraform plan error
        # self.aws_default_vpc_dhcp_options() # compilation error no boto3 filter
        # self.aws_ec2_managed_prefix_list() # terraform plan error
        # self.aws_ec2_network_insights_analysis() #OK
        # self.aws_ec2_network_insights_path() #OK
        # self.aws_ec2_subnet_cidr_reservation() # no records
        # self.aws_ec2_traffic_mirror_filter() #OK
        # self.aws_ec2_traffic_mirror_filter_rule() #OK
        # self.aws_ec2_traffic_mirror_session() #OK
        # self.aws_ec2_traffic_mirror_target() #OK
        # self.aws_egress_only_internet_gateway() #OK
        # self.aws_flow_log() #OK
        # self.aws_internet_gateway() #OK
        # self.aws_internet_gateway_attachment() # state refresh error
        # self.aws_main_route_table_association() # OK
        # self.aws_nat_gateway() #OK
        # self.aws_network_acl() #OK
        # self.aws_network_acl_association() #OK
        # self.aws_network_acl_rule()  # state refresh error
        # self.aws_network_interface() # terraform plan error
        # self.aws_network_interface_attachment() # OK
        # self.aws_network_interface_sg_attachment() #OK
        # self.aws_route() # terraform plan error
        # self.aws_route_table() #OK
        # self.aws_route_table_association() #OK
        # self.aws_security_group() #OK
        # self.aws_security_group_rule()  # state refresh error
        # self.aws_vpc_dhcp_options() #OK
        # self.aws_vpc_dhcp_options_association() #OK
        # self.aws_vpc_endpoint() # OK
        # self.aws_vpc_endpoint_connection_accepter() #OK
        # self.aws_vpc_endpoint_connection_notification() #OK
        # self.aws_vpc_endpoint_policy() #OK
        # self.aws_vpc_endpoint_route_table_association() #OK
        # self.aws_vpc_endpoint_security_group_association() #OK
        # self.aws_vpc_endpoint_service() #OK
        # self.aws_vpc_endpoint_service_allowed_principal() # no records
        # self.aws_vpc_endpoint_subnet_association() #OK
        # self.aws_vpc_ipv4_cidr_block_association() # OK
        # self.aws_vpc_ipv6_cidr_block_association() # no records
        # self.aws_vpc_network_performance_metric_subscription() #no boto3 lib
        # self.aws_vpc_peering_connection() #OK
        # self.aws_vpc_peering_connection_accepter() #OK
        self.aws_vpc_peering_connection_options() # compilation error
        # self.aws_vpc_security_group_egress_rule()  # state refresh error
        # self.aws_vpc_security_group_ingress_rule() # state refresh error



        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        

    def aws_vpc(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPCs...")
        vpcs = ec2.describe_vpcs()["Vpcs"]
        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            print(f"  Processing VPC: {vpc_id}")
            attributes = {
                "id": vpc_id,
            }
            self.hcl.process_resource("aws_vpc", vpc_id.replace("-", "_"), attributes)

    def aws_subnet(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Subnets...")
        subnets = ec2.describe_subnets()["Subnets"]
        for subnet in subnets:
            vpc_id = subnet["VpcId"]
            subnet_id = subnet["SubnetId"]
            print(f"    Processing Subnet: {subnet_id}")
            attributes = {
                "id": subnet_id,
                "vpc_id": vpc_id,
                "cidr_block": subnet["CidrBlock"],
                "availability_zone": subnet["AvailabilityZone"],
            }
            self.hcl.process_resource("aws_subnet", subnet_id.replace("-", "_"), attributes)

    def aws_default_network_acl(self):
        ec2 = self.session.client("ec2", region_name=self.region)

        print("Processing Default Network ACLs...")
        network_acls = ec2.describe_network_acls(
            Filters=[{"Name": "default", "Values": ["true"]}]
        )["NetworkAcls"]
        for network_acl in network_acls:
            network_acl_id = network_acl["NetworkAclId"]
            vpc_id = network_acl["VpcId"]
            default_network_acl_id = network_acl["NetworkAclId"]
            print(f"  Processing Default Network ACL: {network_acl_id} for VPC: {vpc_id}")

            attributes = {
                "id": network_acl_id,
                "vpc_id": vpc_id,
                "default_network_acl_id": default_network_acl_id,
            }
            self.hcl.process_resource("aws_default_network_acl", network_acl_id.replace("-", "_"), attributes)

    def aws_default_route_table(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Default Route Tables...")
        route_tables = ec2.describe_route_tables(
            Filters=[{"Name": "association.main", "Values": ["true"]}]
        )["RouteTables"]
        
        for route_table in route_tables:
            vpc_id = route_table["VpcId"]
            route_table_id = route_table["RouteTableId"]
            print(f"  Processing Default Route Table: {route_table_id} for VPC: {vpc_id}")

            attributes = {
                "id": route_table_id,
                "vpc_id": vpc_id,
            }
            self.hcl.process_resource("aws_default_route_table", route_table_id.replace("-", "_"), attributes)

    def aws_default_security_group(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Default Security Groups...")
        security_groups = ec2.describe_security_groups(
            Filters=[{"Name": "group-name", "Values": ["default"]}]
        )["SecurityGroups"]
        
        for security_group in security_groups:
            vpc_id = security_group["VpcId"]
            security_group_id = security_group["GroupId"]
            print(f"  Processing Default Security Group: {security_group_id} for VPC: {vpc_id}")

            attributes = {
                "id": security_group_id,
                "vpc_id": vpc_id,
            }
            self.hcl.process_resource("aws_default_security_group", security_group_id.replace("-", "_"), attributes)

    def aws_default_subnet(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Default Subnets...")
        subnets = ec2.describe_subnets(
            Filters=[{"Name": "default-for-az", "Values": ["true"]}]
        )["Subnets"]

        for subnet in subnets:
            vpc_id = subnet["VpcId"]
            subnet_id = subnet["SubnetId"]
            print(f"  Processing Default Subnet: {subnet_id} for VPC: {vpc_id}")

            attributes = {
                "id": subnet_id,
                "vpc_id": vpc_id,
                "cidr_block": subnet["CidrBlock"],
                "availability_zone": subnet["AvailabilityZone"],
            }
            self.hcl.process_resource("aws_default_subnet", subnet_id.replace("-", "_"), attributes)

    def aws_default_vpc(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Default VPCs...")
        vpcs = ec2.describe_vpcs(
            Filters=[{"Name": "isDefault", "Values": ["true"]}]
        )["Vpcs"]

        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            print(f"  Processing Default VPC: {vpc_id}")

            attributes = {
                "id": vpc_id,
            }
            self.hcl.process_resource("aws_default_vpc", vpc_id.replace("-", "_"), attributes)


    def aws_default_vpc_dhcp_options(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Default VPC DHCP Options...")
        dhcp_options = ec2.describe_dhcp_options(
            Filters=[{"Name": "default", "Values": ["true"]}]
        )["DhcpOptions"]

        for dhcp_option in dhcp_options:
            dhcp_options_id = dhcp_option["DhcpOptionsId"]
            print(f"  Processing Default VPC DHCP Options: {dhcp_options_id}")

            attributes = {
                "id": dhcp_options_id,
            }
            self.hcl.process_resource("aws_default_vpc_dhcp_options", dhcp_options_id.replace("-", "_"), attributes)

    def aws_ec2_managed_prefix_list(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing EC2 Managed Prefix Lists...")
        prefix_lists = ec2.describe_managed_prefix_lists()["PrefixLists"]

        for prefix_list in prefix_lists:
            prefix_list_id = prefix_list["PrefixListId"]
            print(f"  Processing EC2 Managed Prefix List: {prefix_list_id}")

            # Get the entries for the prefix list
            entries = ec2.get_managed_prefix_list_entries(PrefixListId=prefix_list_id)["Entries"]

            entry_attributes = []
            for entry in entries:
                entry_attributes.append({
                    "cidr": entry["Cidr"],
                    "description": entry.get("Description", ""),
                })

            attributes = {
                "id": prefix_list_id,
                "name": prefix_list["PrefixListName"],
                "address_family": prefix_list["AddressFamily"],
                "entries": entry_attributes,
            }
            self.hcl.process_resource("aws_ec2_managed_prefix_list", prefix_list_id.replace("-", "_"), attributes)

    def aws_ec2_network_insights_analysis(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing EC2 Network Insights Analysis...")
        network_insights_analyses = ec2.describe_network_insights_analyses()["NetworkInsightsAnalyses"]

        for analysis in network_insights_analyses:
            analysis_id = analysis["NetworkInsightsAnalysisId"]
            print(f"  Processing EC2 Network Insights Analysis: {analysis_id}")

            attributes = {
                "id": analysis_id,
                "network_insights_path_id": analysis["NetworkInsightsPathId"],
                "status": analysis["Status"],
                "status_message": analysis.get("StatusMessage", ""),
            }
            self.hcl.process_resource("aws_ec2_network_insights_analysis", analysis_id.replace("-", "_"), attributes)

    def aws_ec2_network_insights_path(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing EC2 Network Insights Paths...")
        network_insights_paths = ec2.describe_network_insights_paths()["NetworkInsightsPaths"]

        for path in network_insights_paths:
            path_id = path["NetworkInsightsPathId"]
            print(f"  Processing EC2 Network Insights Path: {path_id}")

            attributes = {
                "id": path_id,
                "source": path["Source"],
                "destination": path["Destination"],
                "protocol": path.get("Protocol", ""),
                "destination_port": path.get("DestinationPort", ""),
            }
            self.hcl.process_resource("aws_ec2_network_insights_path", path_id.replace("-", "_"), attributes)

    def aws_ec2_subnet_cidr_reservation(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Subnet CIDR Reservations...")
        subnets = ec2.describe_subnets()["Subnets"]

        for subnet in subnets:
            subnet_id = subnet["SubnetId"]
            cidr_reservations_response = ec2.get_subnet_cidr_reservations(SubnetId=subnet_id)
            
            # Process IPv4 CIDR reservations
            ipv4_cidr_reservations = cidr_reservations_response["SubnetIpv4CidrReservations"]
            for cidr_reservation in ipv4_cidr_reservations:
                reservation_id = cidr_reservation["CidrReservationId"]
                print(f"  Processing IPv4 Subnet CIDR Reservation: {reservation_id} in Subnet: {subnet_id}")

                attributes = {
                    "id": reservation_id,
                    "subnet_id": subnet_id,
                    "cidr_block": cidr_reservation["Cidr"],
                }
                self.hcl.process_resource("aws_ec2_subnet_cidr_reservation", reservation_id.replace("-", "_"), attributes)

            # Process IPv6 CIDR reservations
            ipv6_cidr_reservations = cidr_reservations_response["SubnetIpv6CidrReservations"]
            for cidr_reservation in ipv6_cidr_reservations:
                reservation_id = cidr_reservation["CidrReservationId"]
                print(f"  Processing IPv6 Subnet CIDR Reservation: {reservation_id} in Subnet: {subnet_id}")

                attributes = {
                    "id": reservation_id,
                    "subnet_id": subnet_id,
                    "cidr_block": cidr_reservation["Cidr"],
                }
                self.hcl.process_resource("aws_ec2_subnet_cidr_reservation", reservation_id.replace("-", "_"), attributes)

    def aws_ec2_traffic_mirror_filter(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing EC2 Traffic Mirror Filters...")
        traffic_mirror_filters = ec2.describe_traffic_mirror_filters()["TrafficMirrorFilters"]

        for tm_filter in traffic_mirror_filters:
            tm_filter_id = tm_filter["TrafficMirrorFilterId"]
            print(f"  Processing EC2 Traffic Mirror Filter: {tm_filter_id}")

            attributes = {
                "id": tm_filter_id,
                "description": tm_filter.get("Description", ""),
            }
            self.hcl.process_resource("aws_ec2_traffic_mirror_filter", tm_filter_id.replace("-", "_"), attributes)

    def aws_ec2_traffic_mirror_filter_rule(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing EC2 Traffic Mirror Filter Rules...")
        traffic_mirror_filters = ec2.describe_traffic_mirror_filters()["TrafficMirrorFilters"]

        for tm_filter in traffic_mirror_filters:
            tm_filter_id = tm_filter["TrafficMirrorFilterId"]

            # Describe the ingress and egress rules for the traffic mirror filter
            ingress_rules = ec2.describe_traffic_mirror_filter_rules(
                Filters=[{"Name": "traffic-mirror-filter-id", "Values": [tm_filter_id]}],
                Direction="ingress"
            )["TrafficMirrorFilterRules"]

            egress_rules = ec2.describe_traffic_mirror_filter_rules(
                Filters=[{"Name": "traffic-mirror-filter-id", "Values": [tm_filter_id]}],
                Direction="egress"
            )["TrafficMirrorFilterRules"]

            # Combine ingress and egress rules
            rules = ingress_rules + egress_rules

            for rule in rules:
                rule_id = rule["TrafficMirrorFilterRuleId"]
                print(f"  Processing EC2 Traffic Mirror Filter Rule: {rule_id} for Filter: {tm_filter_id}")

                attributes = {
                    "id": rule_id,
                    "traffic_mirror_filter_id": tm_filter_id,
                    "direction": rule["Direction"],
                    "action": rule["Action"],
                    "protocol": rule["Protocol"],
                    "source_cidr_block": rule["SourceCidrBlock"],
                    "destination_cidr_block": rule["DestinationCidrBlock"],
                    "rule_action": rule["RuleAction"],
                    "rule_number": rule["RuleNumber"],
                }
                self.hcl.process_resource("aws_ec2_traffic_mirror_filter_rule", rule_id.replace("-", "_"), attributes)

    def aws_ec2_traffic_mirror_session(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing EC2 Traffic Mirror Sessions...")
        traffic_mirror_sessions = ec2.describe_traffic_mirror_sessions()["TrafficMirrorSessions"]

        for tm_session in traffic_mirror_sessions:
            tm_session_id = tm_session["TrafficMirrorSessionId"]
            print(f"  Processing EC2 Traffic Mirror Session: {tm_session_id}")

            attributes = {
                "id": tm_session_id,
                "traffic_mirror_target_id": tm_session["TrafficMirrorTargetId"],
                "traffic_mirror_filter_id": tm_session["TrafficMirrorFilterId"],
                "network_interface_id": tm_session["NetworkInterfaceId"],
                "session_number": tm_session["SessionNumber"],
                "virtual_network_id": tm_session.get("VirtualNetworkId", ""),
                "description": tm_session.get("Description", ""),
            }
            self.hcl.process_resource("aws_ec2_traffic_mirror_session", tm_session_id.replace("-", "_"), attributes)



    def aws_ec2_traffic_mirror_target(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing EC2 Traffic Mirror Targets...")
        traffic_mirror_targets = ec2.describe_traffic_mirror_targets()["TrafficMirrorTargets"]

        for tm_target in traffic_mirror_targets:
            tm_target_id = tm_target["TrafficMirrorTargetId"]
            print(f"  Processing EC2 Traffic Mirror Target: {tm_target_id}")

            attributes = {
                "id": tm_target_id,
                "description": tm_target.get("Description", ""),
                "network_load_balancer_arn": tm_target.get("NetworkLoadBalancerArn", ""),
                "network_interface_id": tm_target.get("NetworkInterfaceId", ""),
            }
            self.hcl.process_resource("aws_ec2_traffic_mirror_target", tm_target_id.replace("-", "_"), attributes)

    def aws_egress_only_internet_gateway(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Egress Only Internet Gateways...")
        egress_only_igws = ec2.describe_egress_only_internet_gateways()["EgressOnlyInternetGateways"]

        for egress_only_igw in egress_only_igws:
            egress_only_igw_id = egress_only_igw["EgressOnlyInternetGatewayId"]
            print(f"  Processing Egress Only Internet Gateway: {egress_only_igw_id}")

            # Assuming there is only one attachment per egress-only internet gateway
            vpc_id = egress_only_igw["Attachments"][0]["VpcId"] if egress_only_igw["Attachments"] else ""

            attributes = {
                "id": egress_only_igw_id,
                "vpc_id": vpc_id,
            }
            self.hcl.process_resource("aws_egress_only_internet_gateway", egress_only_igw_id.replace("-", "_"), attributes)

    def aws_flow_log(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Flow Logs...")
        flow_logs = ec2.describe_flow_logs()["FlowLogs"]

        for flow_log in flow_logs:
            flow_log_id = flow_log["FlowLogId"]
            print(f"  Processing Flow Log: {flow_log_id}")

            attributes = {
                "id": flow_log_id,
                "resource_id": flow_log["ResourceId"],
                "traffic_type": flow_log["TrafficType"],
                "log_destination_type": flow_log["LogDestinationType"],
                "log_destination": flow_log["LogDestination"],
                "log_group_name": flow_log.get("LogGroupName", ""),
                "iam_role_arn": flow_log.get("DeliverLogsPermissionArn", ""),
                "max_aggregation_interval": flow_log.get("MaxAggregationInterval", ""),
            }
            self.hcl.process_resource("aws_flow_log", flow_log_id.replace("-", "_"), attributes)

    def aws_internet_gateway(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Internet Gateways...")
        internet_gateways = ec2.describe_internet_gateways()["InternetGateways"]

        for igw in internet_gateways:
            igw_id = igw["InternetGatewayId"]
            print(f"  Processing Internet Gateway: {igw_id}")

            # Assuming there is only one attachment per internet gateway
            vpc_id = igw["Attachments"][0]["VpcId"] if igw["Attachments"] else ""

            attributes = {
                "id": igw_id,
                "vpc_id": vpc_id,
            }
            self.hcl.process_resource("aws_internet_gateway", igw_id.replace("-", "_"), attributes)

    def aws_internet_gateway_attachment(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Internet Gateway Attachments...")
        internet_gateways = ec2.describe_internet_gateways()["InternetGateways"]

        for igw in internet_gateways:
            igw_id = igw["InternetGatewayId"]

            for attachment in igw["Attachments"]:
                vpc_id = attachment["VpcId"]
                print(f"  Processing Internet Gateway Attachment: {igw_id} <-> {vpc_id}")

                attributes = {
                    "id": f"{igw_id}-{vpc_id}",
                    "internet_gateway_id": igw_id,
                    "vpc_id": vpc_id,
                }
                self.hcl.process_resource("aws_internet_gateway_attachment", f"{igw_id.replace('-', '_')}-{vpc_id.replace('-', '_')}", attributes)

    def aws_main_route_table_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Main Route Table Associations...")
        route_tables = ec2.describe_route_tables()["RouteTables"]

        for rt in route_tables:
            rt_id = rt["RouteTableId"]
            vpc_id = rt["VpcId"]


            for assoc in rt["Associations"]:
                if assoc["Main"]:
                    assoc_id = assoc["RouteTableAssociationId"]
                    print(f"  Processing Main Route Table Association: {assoc_id} for VPC: {vpc_id}")

                    attributes = {
                        "id": assoc_id,
                        "vpc_id": vpc_id,
                        "route_table_id": rt_id,
                    }
                    self.hcl.process_resource("aws_main_route_table_association", assoc_id.replace("-", "_"), attributes)

    def aws_nat_gateway(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing NAT Gateways...")
        nat_gateways = ec2.describe_nat_gateways()["NatGateways"]

        for nat_gw in nat_gateways:
            nat_gw_id = nat_gw["NatGatewayId"]
            print(f"  Processing NAT Gateway: {nat_gw_id}")

            attributes = {
                "id": nat_gw_id,
                "subnet_id": nat_gw["SubnetId"],
                "allocation_id": nat_gw["NatGatewayAddresses"][0]["AllocationId"],
                "network_interface_id": nat_gw["NatGatewayAddresses"][0]["NetworkInterfaceId"],
                "private_ip": nat_gw["NatGatewayAddresses"][0]["PrivateIp"],
                "public_ip": nat_gw["NatGatewayAddresses"][0]["PublicIp"],
            }
            self.hcl.process_resource("aws_nat_gateway", nat_gw_id.replace("-", "_"), attributes)

    def aws_network_acl(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Network ACLs...")
        network_acls = ec2.describe_network_acls()["NetworkAcls"]

        for network_acl in network_acls:
            if not network_acl["IsDefault"]:
                network_acl_id = network_acl["NetworkAclId"]
                vpc_id = network_acl["VpcId"]
                print(f"  Processing Network ACL: {network_acl_id} for VPC: {vpc_id}")

                attributes = {
                    "id": network_acl_id,
                    "vpc_id": vpc_id,
                }
                self.hcl.process_resource("aws_network_acl", network_acl_id.replace("-", "_"), attributes)

    def aws_network_acl_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Network ACL Associations...")
        network_acls = ec2.describe_network_acls()["NetworkAcls"]

        for network_acl in network_acls:
            if not network_acl["IsDefault"]:
                network_acl_id = network_acl["NetworkAclId"]

                for assoc in network_acl["Associations"]:
                    assoc_id = assoc["NetworkAclAssociationId"]
                    subnet_id = assoc["SubnetId"]
                    print(f"  Processing Network ACL Association: {assoc_id} for Subnet: {subnet_id}")

                    attributes = {
                        "id": assoc_id,
                        "network_acl_id": network_acl_id,
                        "subnet_id": subnet_id,
                    }
                    self.hcl.process_resource("aws_network_acl_association", assoc_id.replace("-", "_"), attributes)

    def aws_network_acl_rule(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Network ACL Rules...")
        network_acls = ec2.describe_network_acls()["NetworkAcls"]

        for network_acl in network_acls:
            if not network_acl["IsDefault"]:
                network_acl_id = network_acl["NetworkAclId"]

                for entry in network_acl["Entries"]:
                    rule_number = entry["RuleNumber"]
                    rule_action = entry["RuleAction"]
                    rule_egress = entry["Egress"]
                    print(f"  Processing Network ACL Rule: {rule_number} for Network ACL: {network_acl_id}")

                    attributes = {
                        "id": f"{network_acl_id}-{rule_number}",
                        "network_acl_id": network_acl_id,
                        "rule_number": rule_number,
                        "protocol": entry["Protocol"],
                        "rule_action": rule_action,
                        "egress": rule_egress,
                        "cidr_block": entry.get("CidrBlock", ""),
                        "ipv6_cidr_block": entry.get("Ipv6CidrBlock", ""),
                        "from_port": entry.get("PortRange", {}).get("From", ""),
                        "to_port": entry.get("PortRange", {}).get("To", ""),
                    }
                    self.hcl.process_resource("aws_network_acl_rule", f"{network_acl_id.replace('-', '_')}-{rule_number}", attributes)

    def aws_network_interface(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Network Interfaces...")
        network_interfaces = ec2.describe_network_interfaces()["NetworkInterfaces"]

        for eni in network_interfaces:
            eni_id = eni["NetworkInterfaceId"]
            print(f"  Processing Network Interface: {eni_id}")

            attributes = {
                "id": eni_id,
                "subnet_id": eni["SubnetId"],
                "vpc_id": eni["VpcId"],
                "description": eni.get("Description", ""),
                "private_ip": eni["PrivateIpAddress"],
                "security_groups": [sg["GroupId"] for sg in eni["Groups"]],
                "availability_zone": eni["AvailabilityZone"],
            }
            self.hcl.process_resource("aws_network_interface", eni_id.replace("-", "_"), attributes)


    def aws_network_interface_attachment(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Network Interface Attachments...")
        network_interfaces = ec2.describe_network_interfaces()["NetworkInterfaces"]

        for eni in network_interfaces:
            eni_id = eni["NetworkInterfaceId"]
            attachment = eni.get("Attachment")
            if attachment and "InstanceId" in attachment:
                attachment_id = attachment["AttachmentId"]
                instance_id = attachment["InstanceId"]
                device_index = attachment["DeviceIndex"]
                print(f"  Processing Network Interface Attachment: {attachment_id} for ENI: {eni_id}")

                attributes = {
                    "id": attachment_id,
                    "instance_id": instance_id,
                    "network_interface_id": eni_id,
                    "device_index": device_index,
                }
                self.hcl.process_resource("aws_network_interface_attachment", attachment_id.replace("-", "_"), attributes)

    def aws_network_interface_sg_attachment(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Network Interface Security Group Attachments...")
        network_interfaces = ec2.describe_network_interfaces()["NetworkInterfaces"]

        for eni in network_interfaces:
            eni_id = eni["NetworkInterfaceId"]

            for sg in eni["Groups"]:
                sg_id = sg["GroupId"]
                print(f"  Processing Security Group Attachment for ENI: {eni_id} and SG: {sg_id}")

                attributes = {
                    "id": f"{eni_id}-{sg_id}",
                    "network_interface_id": eni_id,
                    "security_group_id": sg_id,
                }
                self.hcl.process_resource("aws_network_interface_sg_attachment", f"{eni_id.replace('-', '_')}-{sg_id.replace('-', '_')}", attributes)

    def aws_route(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Routes...")
        route_tables = ec2.describe_route_tables()["RouteTables"]

        for rt in route_tables:
            route_table_id = rt["RouteTableId"]

            for route in rt["Routes"]:
                destination = route.get("DestinationCidrBlock", route.get("DestinationIpv6CidrBlock", ""))
                if destination:
                    print(f"  Processing Route in Route Table: {route_table_id} for destination: {destination}")

                    attributes = {
                        "id": f"{route_table_id}-{destination.replace('/', '-')}",
                        "route_table_id": route_table_id,
                        "destination_cidr_block": route.get("DestinationCidrBlock", ""),
                        "destination_ipv6_cidr_block": route.get("DestinationIpv6CidrBlock", ""),
                        "gateway_id": route.get("GatewayId", ""),
                        "nat_gateway_id": route.get("NatGatewayId", ""),
                        "instance_id": route.get("InstanceId", ""),
                        "egress_only_gateway_id": route.get("EgressOnlyInternetGatewayId", ""),
                        "transit_gateway_id": route.get("TransitGatewayId", ""),
                        "local_gateway_id": route.get("LocalGatewayId", ""),
                    }
                    self.hcl.process_resource("aws_route", f"{route_table_id.replace('-', '_')}-{destination.replace('/', '-')}", attributes)

    def aws_route_table(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Route Tables...")
        route_tables = ec2.describe_route_tables()["RouteTables"]

        for rt in route_tables:
            route_table_id = rt["RouteTableId"]
            vpc_id = rt["VpcId"]
            print(f"  Processing Route Table: {route_table_id} for VPC: {vpc_id}")

            attributes = {
                "id": route_table_id,
                "vpc_id": vpc_id,
            }
            self.hcl.process_resource("aws_route_table", route_table_id.replace("-", "_"), attributes)

    def aws_route_table_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Route Table Associations...")
        route_tables = ec2.describe_route_tables()["RouteTables"]

        for rt in route_tables:
            route_table_id = rt["RouteTableId"]

            for assoc in rt["Associations"]:
                if not assoc.get("Main"):
                    assoc_id = assoc["RouteTableAssociationId"]
                    subnet_id = assoc["SubnetId"]
                    print(f"  Processing Route Table Association: {assoc_id} for Route Table: {route_table_id}")

                    attributes = {
                        "id": assoc_id,
                        "route_table_id": route_table_id,
                        "subnet_id": subnet_id,
                    }
                    self.hcl.process_resource("aws_route_table_association", assoc_id.replace("-", "_"), attributes)

    def aws_security_group(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Security Groups...")
        security_groups = ec2.describe_security_groups()["SecurityGroups"]

        for sg in security_groups:
            sg_id = sg["GroupId"]
            vpc_id = sg["VpcId"]
            print(f"  Processing Security Group: {sg_id} for VPC: {vpc_id}")

            attributes = {
                "id": sg_id,
                "vpc_id": vpc_id,
                "name": sg.get("GroupName", ""),
                "description": sg.get("Description", ""),
            }
            self.hcl.process_resource("aws_security_group", sg_id.replace("-", "_"), attributes)

    def aws_security_group_rule(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Security Group Rules...")
        security_groups = ec2.describe_security_groups()["SecurityGroups"]

        for sg in security_groups:
            sg_id = sg["GroupId"]

            for rule in sg["IpPermissions"]:
                ip_protocol = rule["IpProtocol"]
                from_port = rule.get("FromPort", "")
                to_port = rule.get("ToPort", "")

                for ip_range in rule["IpRanges"]:
                    cidr_ip = ip_range["CidrIp"]
                    print(f"  Processing Security Group Rule: {sg_id} {ip_protocol} {from_port}-{to_port} {cidr_ip}")

                    rule_id = f"{sg_id}-{ip_protocol}-{from_port}-{to_port}-{cidr_ip.replace('/', '-')}"
                    attributes = {
                        "id": rule_id,
                        "security_group_id": sg_id,
                        "type": "ingress",
                        "from_port": from_port,
                        "to_port": to_port,
                        "protocol": ip_protocol,
                        "cidr_blocks": [cidr_ip],
                    }
                    self.hcl.process_resource("aws_security_group_rule", rule_id.replace("-", "_"), attributes)

            for rule in sg["IpPermissionsEgress"]:
                ip_protocol = rule["IpProtocol"]
                from_port = rule.get("FromPort", "")
                to_port = rule.get("ToPort", "")

                for ip_range in rule["IpRanges"]:
                    cidr_ip = ip_range["CidrIp"]
                    print(f"  Processing Security Group Rule: {sg_id} {ip_protocol} {from_port}-{to_port} {cidr_ip}")

                    rule_id = f"{sg_id}-{ip_protocol}-{from_port}-{to_port}-{cidr_ip.replace('/', '-')}"
                    attributes = {
                        "id": rule_id,
                        "security_group_id": sg_id,
                        "type": "egress",
                        "from_port": from_port,
                        "to_port": to_port,
                        "protocol": ip_protocol,
                        "cidr_blocks": [cidr_ip],
                    }
                    self.hcl.process_resource("aws_security_group_rule", rule_id.replace("-", "_"), attributes)

    def aws_vpc_dhcp_options(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC DHCP Options...")
        dhcp_options_list = ec2.describe_dhcp_options()["DhcpOptions"]

        for dhcp_options in dhcp_options_list:
            dhcp_options_id = dhcp_options["DhcpOptionsId"]
            print(f"  Processing VPC DHCP Options: {dhcp_options_id}")

            attributes = {
                "id": dhcp_options_id,
                "tags": {tag["Key"]: tag["Value"] for tag in dhcp_options.get("Tags", [])},
            }
            for config in dhcp_options["DhcpConfigurations"]:
                key = config["Key"]
                values = [value["Value"] for value in config["Values"]]
                attributes[key.lower()] = values

            self.hcl.process_resource("aws_vpc_dhcp_options", dhcp_options_id.replace("-", "_"), attributes)

    def aws_vpc_dhcp_options_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC DHCP Options Associations...")
        vpcs = ec2.describe_vpcs()["Vpcs"]

        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            dhcp_options_id = vpc["DhcpOptionsId"]
            if dhcp_options_id != "default":
                print(f"  Processing VPC DHCP Options Association: {dhcp_options_id} for VPC: {vpc_id}")

                assoc_id = f"{vpc_id}-{dhcp_options_id}"
                attributes = {
                    "id": assoc_id,
                    "vpc_id": vpc_id,
                    "dhcp_options_id": dhcp_options_id,
                }
                self.hcl.process_resource("aws_vpc_dhcp_options_association", assoc_id.replace("-", "_"), attributes)

    def aws_vpc_endpoint(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoints...")
        vpc_endpoints = ec2.describe_vpc_endpoints()["VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            vpc_id = endpoint["VpcId"]
            service_name = endpoint["ServiceName"]
            print(f"  Processing VPC Endpoint: {endpoint_id} for VPC: {vpc_id}")
            attributes = {
                "id": endpoint_id,
                "vpc_id": vpc_id,
                "service_name": service_name,
                "vpc_endpoint_type": endpoint["VpcEndpointType"],
                "private_dns_enabled": endpoint["PrivateDnsEnabled"],
                "subnet_ids": endpoint.get("SubnetIds", []),
                "policy": endpoint["PolicyDocument"],
            }
            self.hcl.process_resource("aws_vpc_endpoint", endpoint_id.replace("-", "_"), attributes)

    def aws_vpc_endpoint_connection_accepter(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoint Connection Accepters...")
        vpc_endpoints = ec2.describe_vpc_endpoints()["VpcEndpoints"]

        for endpoint in vpc_endpoints:
            if endpoint["State"] == "pendingAcceptance":
                endpoint_id = endpoint["VpcEndpointId"]
                vpc_id = endpoint["VpcId"]
                service_name = endpoint["ServiceName"]
                print(f"  Processing VPC Endpoint Connection Accepter: {endpoint_id} for VPC: {vpc_id}")

                accepter_id = f"{vpc_id}-{endpoint_id}"
                attributes = {
                    "id": accepter_id,
                    "vpc_endpoint_id": endpoint_id,
                    "vpc_id": vpc_id,
                    "service_name": service_name,
                }
                self.hcl.process_resource("aws_vpc_endpoint_connection_accepter", accepter_id.replace("-", "_"), attributes)

    def aws_vpc_endpoint_connection_notification(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoint Connection Notifications...")
        connection_notifications = ec2.describe_vpc_endpoint_connection_notifications()["ConnectionNotificationSet"]

        for notification in connection_notifications:
            notification_id = notification["ConnectionNotificationId"]
            vpc_endpoint_id = notification["VpcEndpointId"]
            service_id = notification["ServiceId"]
            sns_topic_arn = notification["ConnectionNotificationArn"]
            print(f"  Processing VPC Endpoint Connection Notification: {notification_id}")

            attributes = {
                "id": notification_id,
                "vpc_endpoint_id": vpc_endpoint_id,
                "service_id": service_id,
                "sns_topic_arn": sns_topic_arn,
                "notification_type": notification["ConnectionNotificationType"],
                "state": notification["ConnectionNotificationState"],
            }
            self.hcl.process_resource("aws_vpc_endpoint_connection_notification", notification_id.replace("-", "_"), attributes)


    def aws_vpc_endpoint_policy(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoint Policies...")
        vpc_endpoints = ec2.describe_vpc_endpoints()["VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            vpc_id = endpoint["VpcId"]
            service_name = endpoint["ServiceName"]
            policy_document = endpoint["PolicyDocument"]
            print(f"  Processing VPC Endpoint Policy: {endpoint_id} for VPC: {vpc_id}")

            attributes = {
                "id": endpoint_id,
                "vpc_endpoint_id": endpoint_id,
                "policy": policy_document,
            }
            self.hcl.process_resource("aws_vpc_endpoint_policy", endpoint_id.replace("-", "_"), attributes)

    def aws_vpc_endpoint_route_table_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoint Route Table Associations...")
        vpc_endpoints = ec2.describe_vpc_endpoints()["VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            route_table_ids = endpoint.get("RouteTableIds", [])

            for route_table_id in route_table_ids:
                print(f"  Processing VPC Endpoint Route Table Association: {endpoint_id} - {route_table_id}")

                assoc_id = f"{endpoint_id}-{route_table_id}"
                attributes = {
                    "id": assoc_id,
                    "vpc_endpoint_id": endpoint_id,
                    "route_table_id": route_table_id,
                }
                self.hcl.process_resource("aws_vpc_endpoint_route_table_association", assoc_id.replace("-", "_"), attributes)

    def aws_vpc_endpoint_security_group_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoint Security Group Associations...")
        vpc_endpoints = ec2.describe_vpc_endpoints()["VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            security_group_ids = [group["GroupId"] for group in endpoint.get("Groups", [])]

            for security_group_id in security_group_ids:
                print(f"  Processing VPC Endpoint Security Group Association: {endpoint_id} - {security_group_id}")

                assoc_id = f"{endpoint_id}-{security_group_id}"
                attributes = {
                    "id": assoc_id,
                    "vpc_endpoint_id": endpoint_id,
                    "security_group_id": security_group_id,
                }
                self.hcl.process_resource("aws_vpc_endpoint_security_group_association", assoc_id.replace("-", "_"), attributes)

    def aws_vpc_endpoint_service(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoint Services...")
        vpc_endpoint_services = ec2.describe_vpc_endpoint_services()["ServiceDetails"]

        for service in vpc_endpoint_services:
            service_id = service["ServiceId"]
            service_name = service["ServiceName"]
            print(f"  Processing VPC Endpoint Service: {service_id}")

            attributes = {
                "id": service_id,
                "service_name": service_name,
                "acceptance_required": service["AcceptanceRequired"],
                "availability_zones": service["AvailabilityZones"],
                "base_endpoint_dns_names": service["BaseEndpointDnsNames"],
                "service_type": service["ServiceType"][0]["ServiceType"],
            }
            self.hcl.process_resource("aws_vpc_endpoint_service", service_id.replace("-", "_"), attributes)

    def aws_vpc_endpoint_service_allowed_principal(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoint Service Allowed Principals...")
        vpc_endpoint_services = ec2.describe_vpc_endpoint_service_configurations()["ServiceConfigurations"]

        for service in vpc_endpoint_services:
            service_id = service["ServiceId"]
            allowed_principals = service.get("AllowedPrincipals", [])

            for principal in allowed_principals:
                print(f"  Processing VPC Endpoint Service Allowed Principal: {principal} for Service: {service_id}")

                assoc_id = f"{service_id}-{principal}"
                attributes = {
                    "id": assoc_id,
                    "vpc_endpoint_service_id": service_id,
                    "principal_arn": principal,
                }
                self.hcl.process_resource("aws_vpc_endpoint_service_allowed_principal", assoc_id.replace("-", "_"), attributes)


    def aws_vpc_endpoint_subnet_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Endpoint Subnet Associations...")
        vpc_endpoints = ec2.describe_vpc_endpoints()["VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            subnet_ids = endpoint["SubnetIds"]

            for subnet_id in subnet_ids:
                print(f"  Processing VPC Endpoint Subnet Association: {endpoint_id} - {subnet_id}")

                assoc_id = f"{endpoint_id}-{subnet_id}"
                attributes = {
                    "id": assoc_id,
                    "vpc_endpoint_id": endpoint_id,
                    "subnet_id": subnet_id,
                }
                self.hcl.process_resource("aws_vpc_endpoint_subnet_association", assoc_id.replace("-", "_"), attributes)

    def aws_vpc_ipv4_cidr_block_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC IPv4 CIDR Block Associations...")
        vpcs = ec2.describe_vpcs()["Vpcs"]

        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            cidr_blocks = vpc["CidrBlockAssociationSet"]

            for cidr_block in cidr_blocks:
                assoc_id = cidr_block["AssociationId"]
                print(f"  Processing VPC IPv4 CIDR Block Association: {assoc_id} for VPC: {vpc_id}")

                attributes = {
                    "id": assoc_id,
                    "vpc_id": vpc_id,
                    "cidr_block": cidr_block["CidrBlock"],
                }
                self.hcl.process_resource("aws_vpc_ipv4_cidr_block_association", assoc_id.replace("-", "_"), attributes)

    def aws_vpc_ipv6_cidr_block_association(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC IPv6 CIDR Block Associations...")
        vpcs = ec2.describe_vpcs()["Vpcs"]

        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            ipv6_cidr_blocks = vpc.get("Ipv6CidrBlockAssociationSet", [])

            for ipv6_cidr_block in ipv6_cidr_blocks:
                assoc_id = ipv6_cidr_block["AssociationId"]
                print(f"  Processing VPC IPv6 CIDR Block Association: {assoc_id} for VPC: {vpc_id}")

                attributes = {
                    "id": assoc_id,
                    "vpc_id": vpc_id,
                    "ipv6_cidr_block": ipv6_cidr_block["Ipv6CidrBlock"],
                }
                self.hcl.process_resource("aws_vpc_ipv6_cidr_block_association", assoc_id.replace("-", "_"), attributes)

    def aws_vpc_peering_connection(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Peering Connections...")
        vpc_peering_connections = ec2.describe_vpc_peering_connections()["VpcPeeringConnections"]

        for peering_connection in vpc_peering_connections:
            peering_connection_id = peering_connection["VpcPeeringConnectionId"]
            print(f"  Processing VPC Peering Connection: {peering_connection_id}")

            attributes = {
                "id": peering_connection_id,
                "vpc_id": peering_connection["RequesterVpcInfo"]["VpcId"],
                "peer_vpc_id": peering_connection["AccepterVpcInfo"]["VpcId"],
                "peer_owner_id": peering_connection["AccepterVpcInfo"]["OwnerId"],
                "peer_region": peering_connection["AccepterVpcInfo"]["Region"],
            }
            self.hcl.process_resource("aws_vpc_peering_connection", peering_connection_id.replace("-", "_"), attributes)

    def aws_vpc_peering_connection_accepter(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Peering Connection Accepters...")
        vpc_peering_connections = ec2.describe_vpc_peering_connections()["VpcPeeringConnections"]

        for peering_connection in vpc_peering_connections:
            peering_connection_id = peering_connection["VpcPeeringConnectionId"]
            if peering_connection["Status"]["Code"] != "active":
                continue

            print(f"  Processing VPC Peering Connection Accepter: {peering_connection_id}")

            attributes = {
                "id": peering_connection_id,
                "vpc_peering_connection_id": peering_connection_id,
                "auto_accept": True,
            }
            self.hcl.process_resource("aws_vpc_peering_connection_accepter", peering_connection_id.replace("-", "_"), attributes)

    def aws_vpc_peering_connection_options(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Peering Connection Options...")
        vpc_peering_connections = ec2.describe_vpc_peering_connections()["VpcPeeringConnections"]

        for peering_connection in vpc_peering_connections:
            peering_connection_id = peering_connection["VpcPeeringConnectionId"]
            print(f"  Processing VPC Peering Connection Options: {peering_connection_id}")
            attributes = {
                "id": peering_connection_id,
                "vpc_peering_connection_id": peering_connection_id,
                # "requester": peering_connection["RequesterVpcInfo"]["PeeringOptions"],
                # "accepter": peering_connection["AccepterVpcInfo"]["PeeringOptions"],
            }
            self.hcl.process_resource("aws_vpc_peering_connection_options", peering_connection_id.replace("-", "_"), attributes)

    def aws_vpc_security_group_egress_rule(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Security Group Egress Rules...")
        security_groups = ec2.describe_security_groups()["SecurityGroups"]

        for sg in security_groups:
            group_id = sg["GroupId"]
            egress_rules = sg["IpPermissionsEgress"]

            for rule in egress_rules:
                from_port = rule.get("FromPort", 0)
                to_port = rule.get("ToPort", 0)
                protocol = rule["IpProtocol"]

                for ip_range in rule["IpRanges"]:
                    cidr_block = ip_range["CidrIp"]

                    rule_id = f"{group_id}-{protocol}-{from_port}-{to_port}-{cidr_block.replace('/', '-')}"
                    print(f"  Processing VPC Security Group Egress Rule: {rule_id}")

                    attributes = {
                        "id": rule_id,
                        "security_group_id": group_id,
                        "from_port": from_port,
                        "to_port": to_port,
                        "protocol": protocol,
                        "cidr_blocks": [cidr_block],
                    }
                    self.hcl.process_resource("aws_vpc_security_group_egress_rule", rule_id.replace("-", "_"), attributes)

    def aws_vpc_security_group_ingress_rule(self):
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing VPC Security Group Ingress Rules...")
        security_groups = ec2.describe_security_groups()["SecurityGroups"]

        for sg in security_groups:
            group_id = sg["GroupId"]
            ingress_rules = sg["IpPermissions"]

            for rule in ingress_rules:
                from_port = rule.get("FromPort", 0)
                to_port = rule.get("ToPort", 0)
                protocol = rule["IpProtocol"]

                for ip_range in rule["IpRanges"]:
                    cidr_block = ip_range["CidrIp"]

                    rule_id = f"{group_id}-{protocol}-{from_port}-{to_port}-{cidr_block.replace('/', '-')}"
                    print(f"  Processing VPC Security Group Ingress Rule: {rule_id}")

                    attributes = {
                        "id": rule_id,
                        "security_group_id": group_id,
                        "from_port": from_port,
                        "to_port": to_port,
                        "protocol": protocol,
                        "cidr_blocks": [cidr_block],
                    }
                    self.hcl.process_resource("aws_vpc_security_group_ingress_rule", rule_id.replace("-", "_"), attributes)
