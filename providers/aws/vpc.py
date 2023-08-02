import os
from utils.hcl import HCL
from utils.filesystem import create_backend_file
import json


class VPC:
    def __init__(self, ec2_client, iam_client, logs_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.ec2_client = ec2_client
        self.iam_client = iam_client
        self.logs_client = logs_client
        self.transform_rules = {
            "aws_vpc": {
                "hcl_drop_fields": {"ipv6_netmask_length": 0},
                "hcl_keep_fields": {"cidr_block": True, "enable_dns_hostnames": True},
            },
            "aws_network_acl": {
                "hcl_keep_fields": {"subnet_ids": True,
                                    "ingress": True,
                                    "egress": True,
                                    },
                "hcl_transform_fields": {
                    "ipv6_cidr_block": {'source': "", 'target': None},
                },
            },
            "aws_default_security_group": {
                "hcl_keep_fields": {"vpc_id": True,
                                    "egress": True,
                                    "ingress": True,
                                    "ipv6_cidr_blocks": True,
                                    "prefix_list_ids": True,
                                    "security_groups": True,
                                    },
            },
            "aws_flow_log": {
                "hcl_keep_fields": {"log_destination": True},
            },
            "aws_vpc_peering_connection": {
                "hcl_drop_fields": {"allow_classic_link_to_remote_vpc": "ALL"},
            },
            "aws_default_vpc": {
                "hcl_drop_fields": {"ipv6_netmask_length": 0},
                "hcl_transform_fields": {
                    "force_destroy": {'source': None, 'target': False},
                },
            },
            "aws_subnet": {
                "hcl_drop_fields": {"map_customer_owned_ip_on_launch": False,
                                    "enable_lni_at_device_index": 0
                                    },
            },
            "aws_default_subnet": {
                "hcl_drop_fields": {"map_customer_owned_ip_on_launch": False},
            },
            "aws_network_interface": {
                "hcl_keep_fields": {"instance": True},
                "hcl_drop_blocks": {"attachment": {"instance": ""}},
                "hcl_drop_fields": {"attachment.attachment_id": 'ALL'},
            },
            "aws_vpc_security_group_ingress_rule": {
                "hcl_transform_fields": {
                    "description": {'source': "", 'target': ""},
                },
            },

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
        self.public_subnets = {}
        self.private_subnets = {}
        self.public_route_table_ids = {}
        self.private_route_table_ids = {}
        self.public_nat_gateway_ids = {}
        self.private_route_tables = {}
        self.network_acl_ids = {}
        self.network_acls = {}
        self.dhcp_options_domain_name = {}

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

    def get_dhcp_options_domain_name(self, attributes):
        assoc_id = attributes.get('id')
        return self.dhcp_options_domain_name[assoc_id]

    def is_subnet_public(self, attributes, arg):
        subnet_id = attributes.get('id')
        route_tables = self.ec2_client.describe_route_tables(
            Filters=[{'Name': 'association.subnet-id', 'Values': [subnet_id]}])
        for route_table in route_tables['RouteTables']:
            for route in route_table['Routes']:
                if route.get('GatewayId', '').startswith('igw-'):
                    return True
        return False

    def is_subnet_private(self, attributes, arg):
        subnet_id = attributes.get('id')
        route_tables = self.ec2_client.describe_route_tables(
            Filters=[{'Name': 'association.subnet-id', 'Values': [subnet_id]}])
        for route_table in route_tables['RouteTables']:
            for route in route_table['Routes']:
                if route.get('GatewayId', '').startswith('igw-'):
                    return False
        return True

    def to_array(self, attributes, arg):
        return [attributes.get(arg, None)]

    def init_fields(self, attributes):
        self.private_subnets = {}
        self.public_subnets = {}
        self.public_route_table_ids = {}
        self.private_route_table_ids = {}
        self.public_nat_gateway_ids = {}
        self.private_route_tables = {}
        self.network_acl_ids = {}
        self.network_acls = {}
        # self.dhcp_options_domain_name = {}

        return None

    def add_public_subnet(self, attributes):
        subnet_id = attributes.get('id')
        cidr_block = attributes.get('cidr_block')
        availability_zone = attributes.get('availability_zone')
        tags = attributes.get('tags', {})
        ipv6_cidr_block = attributes.get('ipv6_cidr_block')
        self.public_subnets[subnet_id] = {
            cidr_block: {
                'az': availability_zone,
                'ipv6_cidr_block': ipv6_cidr_block,
                'tags': tags,
                'route_tables': [],
                'nat_gateway': {}
            }
        }
        return self.public_subnets[subnet_id]

    def add_nat_gateway(self, attributes):
        nat_gateway_id = attributes.get('id')
        if nat_gateway_id not in self.public_nat_gateway_ids:
            nat_gateway_name = 'nat_gateway_' + \
                str(len(self.public_nat_gateway_ids))
            self.public_nat_gateway_ids[nat_gateway_id] = nat_gateway_name
        else:
            nat_gateway_name = self.public_nat_gateway_ids[nat_gateway_id]

        subnet_id = attributes.get('subnet_id')
        allocation_id = attributes.get('allocation_id')
        if 'allocations' not in self.public_subnets:
            self.public_subnets['allocations'] = {}
        self.public_subnets['allocations'][allocation_id] = [
            subnet_id, nat_gateway_name]

        for key in self.public_subnets[subnet_id].keys():
            self.public_subnets[subnet_id][key]['nat_gateway'][nat_gateway_name] = {'tags': attributes.get(
                'tags', {}), 'eip_tags': {}}
        return self.public_subnets[subnet_id]

    def add_network_acl(self, attributes):
        nacl_id = attributes.get('id')
        if nacl_id not in self.network_acl_ids:
            nacl_name = 'network_acl_' + \
                str(len(self.network_acl_ids))
            self.network_acl_ids[nacl_id] = nacl_name
        else:
            nacl_name = self.network_acl_ids[nacl_id]

        subnet_ids_ = attributes.get('subnet_ids')
        subnet_list_name = []
        for subnet_id in subnet_ids_:
            if subnet_id in self.public_subnets:
                for key in self.public_subnets[subnet_id].keys():
                    subnet_list_name.append(key)
            elif subnet_id in self.private_subnets:
                for key in self.private_subnets[subnet_id].keys():
                    subnet_list_name.append(key)
        self.network_acls[nacl_name] = {
            'subnet_ids': subnet_list_name, 'tags': attributes.get('tags', {}), 'ingress_rules': {}, 'egress_rules': {}}
        return {nacl_name: self.network_acls[nacl_name]}

    def get_network_acl_id(self, attributes, arg):
        nacl_id = attributes.get(arg)
        nacl_name = self.network_acl_ids[nacl_id]
        return nacl_name

    def get_network_acl_rule_id(self, attributes, arg):
        nacl_id = attributes.get(arg)
        nacl_name = self.network_acl_ids[nacl_id]
        return nacl_name+'_'+str(attributes.get('rule_number'))

    def add_network_acl_ingress_rule(self, attributes):
        nacl_id = attributes.get('network_acl_id')
        nacl_name = self.network_acl_ids[nacl_id]
        rule = {}
        # Rulenumber must be in range 1..32766
        if attributes.get('rule_number') < 32767:
            for k in ['rule_number', 'protocol', 'rule_action', 'cidr_block',
                      'icmp_code', 'icmp_type', 'ipv6_cidr_block', 'from_port', 'to_port']:
                val = attributes.get(k)
                if val not in [None, "", [], {}]:
                    rule[k] = val
            self.network_acls[nacl_name]['ingress_rules'][rule['rule_number']] = rule
        return {nacl_name: self.network_acls[nacl_name]}

    def add_network_acl_egress_rule(self, attributes):
        nacl_id = attributes.get('network_acl_id')
        nacl_name = self.network_acl_ids[nacl_id]
        rule = {}

        # Rulenumber must be in range 1..32766
        if attributes.get('rule_number') < 32767:
            for k in ['rule_number', 'protocol', 'rule_action', 'cidr_block',
                      'icmp_code', 'icmp_type', 'ipv6_cidr_block', 'from_port', 'to_port']:
                val = attributes.get(k)
                if val not in [None, "", [], {}]:
                    rule[k] = val
            self.network_acls[nacl_name]['egress_rules'][rule['rule_number']] = rule
        return {nacl_name: self.network_acls[nacl_name]}

    def add_eip(self, attributes):
        allocation_id = attributes.get('allocation_id')
        subnet_id, nat_gateway_name = self.public_subnets['allocations'][allocation_id]
        for key in self.public_subnets[subnet_id].keys():
            self.public_subnets[subnet_id][key]["nat_gateway"][nat_gateway_name]['eip_tags'] = attributes.get(
                'tags', {})
        return self.public_subnets[subnet_id]

    def add_public_route_table_association(self, attributes):
        route_table_id = attributes.get('route_table_id')
        if route_table_id not in self.public_route_table_ids:
            route_table_name = 'public_route_table_' + \
                str(len(self.public_route_table_ids))
            self.public_route_table_ids[route_table_id] = route_table_name
        else:
            route_table_name = self.public_route_table_ids[route_table_id]

        subnet_id = attributes.get('subnet_id')
        if 'association' not in self.public_subnets:
            self.public_subnets['association'] = {}
        for key in self.public_subnets[subnet_id].keys():
            self.public_subnets[subnet_id][key]['route_tables'].append(
                route_table_name)
        return self.public_subnets[subnet_id]

    def add_public_route_table(self, attributes):
        route_table_id = attributes.get('id')
        route_table_name = self.public_route_table_ids[route_table_id]
        tags = attributes.get('tags', {})
        tags = self.escape_dict_contents(tags)
        return {route_table_name: {"tags": tags}}

    def get_nat_gateway_index(self, attributes):
        nat_gateway_id = attributes.get('id')
        return self.public_nat_gateway_ids[nat_gateway_id]

    def get_eip_index(self, attributes):
        allocation_id = attributes.get('allocation_id')
        _, nat_gateway_name = self.public_subnets['allocations'][allocation_id]
        return nat_gateway_name

    def get_public_route_table_association_index(self, attributes, arg):
        route_table_id = attributes.get(arg)
        route_table_name = self.public_route_table_ids[route_table_id]
        subnet_id = attributes.get('subnet_id')
        for key in self.public_subnets[subnet_id].keys():
            return key+"-"+route_table_name

    def get_public_route_table_id(self, attributes, arg):
        route_table_id = attributes.get(arg)
        route_table_name = self.public_route_table_ids[route_table_id]
        return route_table_name

    def add_private_subnet(self, attributes):
        subnet_id = attributes.get('id')
        cidr_block = attributes.get('cidr_block')
        availability_zone = attributes.get('availability_zone')
        tags = attributes.get('tags', {})
        ipv6_cidr_block = attributes.get('ipv6_cidr_block')
        self.private_subnets[subnet_id] = {
            cidr_block: {
                'az': availability_zone,
                'ipv6_cidr_block': ipv6_cidr_block,
                'tags': tags,
                'route_tables': []
            }
        }
        return self.private_subnets[subnet_id]

    def add_private_route_table_association(self, attributes):
        route_table_id = attributes.get('route_table_id')
        if route_table_id not in self.private_route_table_ids:
            route_table_name = 'private_route_table_' + \
                str(len(self.private_route_table_ids))
            self.private_route_table_ids[route_table_id] = route_table_name
        else:
            route_table_name = self.private_route_table_ids[route_table_id]

        subnet_id = attributes.get('subnet_id')
        if 'association' not in self.private_subnets:
            self.private_subnets['association'] = {}
        for key in self.private_subnets[subnet_id].keys():
            self.private_subnets[subnet_id][key]['route_tables'].append(
                route_table_name)
        return self.private_subnets[subnet_id]

    def add_private_route_table(self, attributes):
        route_table_id = attributes.get('id')
        route_table_name = self.private_route_table_ids[route_table_id]
        tags = attributes.get('tags', {})
        tags = self.escape_dict_contents(tags)
        self.private_route_tables[route_table_name] = {
            "tags": tags, "nat_gateway_attached": ""}
        return {route_table_name: self.private_route_tables[route_table_name]}

    def add_nat_gateway_private_route(self, attributes):
        route_table_id = attributes.get('route_table_id')
        route_table_name = self.private_route_table_ids[route_table_id]
        nat_gateway_id = attributes.get('nat_gateway_id')
        nat_gateway_name = self.public_nat_gateway_ids[nat_gateway_id]

        self.private_route_tables[route_table_name]["nat_gateway_attached"] = nat_gateway_name
        return {route_table_name: self.private_route_tables[route_table_name]}

    def get_nat_gateway_private_route_id(self, attributes):
        route_table_id = attributes.get('route_table_id')
        route_table_name = self.private_route_table_ids[route_table_id]
        return route_table_name+"-0.0.0.0/0"

    def get_private_route_table_association_index(self, attributes):
        route_table_id = attributes.get('route_table_id')
        route_table_name = self.private_route_table_ids[route_table_id]
        subnet_id = attributes.get('subnet_id')
        for key in self.private_subnets[subnet_id].keys():
            return key+"-"+route_table_name

    def get_private_route_table_id(self, attributes, arg):
        route_table_id = attributes.get(arg)
        route_table_name = self.private_route_table_ids[route_table_id]
        return route_table_name

    def build_aws_network_acls(self, attributes, arg):
        key = attributes[arg]
        result = {key: {}}
        result[key]['subnet_ids'] = attributes.get('subnet_ids')
        result[key]['tags'] = attributes.get('tags')
        return result

    def build_aws_network_acl_rules(self, attributes, arg):
        key = attributes[arg]
        result = {key: {}}
        for k in ['rule_number', 'protocol', 'rule_action', 'cidr_block',
                  'icmp_code', 'icmp_type', 'ipv6_cidr_block', 'from_port', 'to_port']:
            val = attributes.get(k)
            if val not in [None, "", [], {}]:
                result[key][k] = val
        return result

    def build_aws_flow_logs(self, attributes, arg):
        key = attributes[arg]
        result = {key: {}}
        for k in ['log_destination', 'log_destination_type', 'log_format',
                  'iam_role_arn', 'traffic_type', 'max_aggregation_interval',
                  'destination_options',  'tags']:
            val = attributes.get(k)
            if isinstance(val, str):
                val = val.replace('${', '$${')
            result[key][k] = val
        return result

    def escape_dict_contents(self, data_dict):
        # convert data_dict to str
        data_str = json.dumps(data_dict)
        data_str = data_str.replace('${', '$${')
        # convert data_str back to dict
        result = json.loads(data_str)
        return result

    def bigger_than_zero(self, attributes, arg):
        value = attributes.get(arg, None)
        if value > 0:
            return value
        return None

    def format_ingress_rules(self, attributes):
        ingress_dict = attributes.get('ingress', [])
        formatted_ingress = []
        for ingress_rule in ingress_dict:
            ingress_rule['cidr_blocks'] = ','.join(ingress_rule['cidr_blocks'])
            ingress_rule['ipv6_cidr_blocks'] = ','.join(
                ingress_rule['ipv6_cidr_blocks'])
            ingress_rule['prefix_list_ids'] = ','.join(
                ingress_rule['prefix_list_ids'])
            ingress_rule['security_groups'] = ','.join(
                ingress_rule['security_groups'])
            formatted_ingress.append(ingress_rule)
        return formatted_ingress

    def format_egress_rules(self, attributes):
        egress_dict = attributes.get('egress', [])
        formatted_egress = []
        for egress_rule in egress_dict:
            egress_rule['cidr_blocks'] = ','.join(egress_rule['cidr_blocks'])
            egress_rule['ipv6_cidr_blocks'] = ','.join(
                egress_rule['ipv6_cidr_blocks'])
            egress_rule['prefix_list_ids'] = ','.join(
                egress_rule['prefix_list_ids'])
            egress_rule['security_groups'] = ','.join(
                egress_rule['security_groups'])
            formatted_egress.append(egress_rule)
        return formatted_egress

    def format_network_acl_rules(self, attributes, arg):
        input_dict = attributes.get(arg, [])
        formatted_input = []
        for input_rule in input_dict:
            # create a copy so as not to mutate the original rule
            input_rule = input_rule.copy()
            for key in ['cidr_block', 'ipv6_cidr_block', 'icmp_code', 'icmp_type']:
                if key in input_rule and input_rule[key] == "":
                    # remove the key-value pair from the dictionary
                    del input_rule[key]
                elif key in input_rule:
                    input_rule[key] = str(input_rule[key])
            formatted_input.append(input_rule)
        return formatted_input

    def is_network_acl_rule_egress(self, attributes, arg):
        return attributes.get('egress', False)

    def is_network_acl_rule_ingress(self, attributes, arg):
        return not attributes.get('egress', False)

    def join_aws_flow_log_iam_role_name(self, parent_attributes, child_attributes):
        flow_name = parent_attributes.get('iam_role_arn').split('/')[-1]
        iam_role_name = child_attributes.get('name')
        if flow_name == iam_role_name:
            return True
        return False

    def vpc(self):
        self.hcl.prepare_folder(os.path.join("generated", "vpc"))

        # aws_customer_gateway.this
        # aws_default_vpc.this
        # aws_egress_only_internet_gateway.this
        # aws_route.private_dns64_nat_gateway
        # aws_route.private_ipv6_egress
        # aws_route.public_internet_gateway_ipv6
        # aws_vpc_ipv4_cidr_block_association.this
        # aws_vpn_gateway.this
        # aws_vpn_gateway_attachment.this
        # aws_vpn_gateway_route_propagation.private
        # aws_vpn_gateway_route_propagation.public

        self.aws_vpc()

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'is_subnet_public': self.is_subnet_public,
            'is_subnet_private': self.is_subnet_private,
            'to_array': self.to_array,
            'bigger_than_zero': self.bigger_than_zero,
            'format_ingress_rules': self.format_ingress_rules,
            'format_egress_rules': self.format_egress_rules,
            'format_network_acl_rules': self.format_network_acl_rules,
            'init_fields': self.init_fields,
            'is_network_acl_rule_egress': self.is_network_acl_rule_egress,
            'is_network_acl_rule_ingress': self.is_network_acl_rule_ingress,
            'build_aws_network_acls': self.build_aws_network_acls,
            'build_aws_network_acl_rules': self.build_aws_network_acl_rules,
            'build_aws_flow_logs': self.build_aws_flow_logs,
            'join_aws_flow_log_iam_role_name': self.join_aws_flow_log_iam_role_name,
            'add_public_subnet': self.add_public_subnet,
            'add_nat_gateway': self.add_nat_gateway,
            'add_eip': self.add_eip,
            'add_public_route_table_association': self.add_public_route_table_association,
            'add_public_route_table': self.add_public_route_table,
            'get_public_route_table_association_index': self.get_public_route_table_association_index,
            'get_public_route_table_id': self.get_public_route_table_id,
            'add_private_subnet': self.add_private_subnet,
            'add_private_route_table_association': self.add_private_route_table_association,
            'add_private_route_table': self.add_private_route_table,
            'get_private_route_table_association_index': self.get_private_route_table_association_index,
            'get_private_route_table_id': self.get_private_route_table_id,
            'get_nat_gateway_index': self.get_nat_gateway_index,
            'get_eip_index': self.get_eip_index,
            'add_nat_gateway_private_route': self.add_nat_gateway_private_route,
            'get_nat_gateway_private_route_id': self.get_nat_gateway_private_route_id,
            'add_network_acl': self.add_network_acl,
            'add_network_acl_ingress_rule': self.add_network_acl_ingress_rule,
            'add_network_acl_egress_rule': self.add_network_acl_egress_rule,
            'get_network_acl_id': self.get_network_acl_id,
            'get_network_acl_rule_id': self.get_network_acl_rule_id,
            'get_dhcp_options_domain_name': self.get_dhcp_options_domain_name,




        }
        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "vpc.yaml"), functions)

        # exit()

        self.json_plan = self.hcl.json_plan

    def aws_vpc(self):
        print("Processing VPCs...")
        self.resource_list['aws_vpc'] = {}
        vpcs = self.ec2_client.describe_vpcs()["Vpcs"]
        for vpc in vpcs:
            is_default = vpc.get("IsDefault", False)
            if not is_default:
                vpc_id = vpc["VpcId"]
                print(f"  Processing VPC: {vpc_id}")
                attributes = {
                    "id": vpc_id,
                }
                self.hcl.process_resource(
                    "aws_vpc", vpc_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc'][vpc_id.replace(
                    "-", "_")] = attributes

                self.aws_subnet(vpc)  # pass the vpc
                self.aws_internet_gateway(vpc_id)  # pass the vpc_id
                self.aws_route_table(vpc_id)
                # call aws_default_route_table with vpc_id
                self.aws_default_route_table(vpc_id)
                # call aws_default_network_acl with vpc_id
                self.aws_default_network_acl(vpc_id)
                # call aws_default_security_group with vpc_id
                self.aws_default_security_group(vpc_id)
                # call aws_network_acl with vpc_id
                self.aws_network_acl(vpc_id)
                # call aws_flow_log with vpc_id
                self.aws_flow_log(vpc_id)
                # call aws_vpc_dhcp_options with vpc_id
                self.aws_vpc_dhcp_options_association(vpc_id)
                # Nat Gateway
                self.aws_nat_gateway(vpc_id)

    def aws_subnet(self, vpc):
        print("Processing Subnets...")
        self.resource_list['aws_subnet'] = {}

        vpc_id = vpc["VpcId"]

        subnets = self.ec2_client.describe_subnets()["Subnets"]
        for subnet in subnets:
            if subnet["VpcId"] == vpc_id:
                subnet_id = subnet["SubnetId"]
                print(f"    Processing Subnet: {subnet_id}")
                attributes = {
                    "id": subnet_id,
                    "vpc_id": vpc_id,
                    "cidr_block": subnet["CidrBlock"],
                    "availability_zone": subnet["AvailabilityZone"],
                }
                self.hcl.process_resource(
                    "aws_subnet", subnet_id.replace("-", "_"), attributes)
                self.resource_list['aws_subnet'][subnet_id.replace(
                    "-", "_")] = attributes

                self.aws_route_table_association(subnet_id)

    def aws_internet_gateway(self, vpc_id):
        print("Processing Internet Gateways...")
        self.resource_list['aws_internet_gateway'] = {}
        internet_gateways = self.ec2_client.describe_internet_gateways()[
            "InternetGateways"]

        for igw in internet_gateways:
            igw_id = igw["InternetGatewayId"]
            attached_vpc_id = igw["Attachments"][0]["VpcId"] if igw["Attachments"] else ""

            if attached_vpc_id == vpc_id:
                print(f"  Processing Internet Gateway: {igw_id}")

                attributes = {
                    "id": igw_id,
                    "vpc_id": attached_vpc_id,
                }
                self.hcl.process_resource(
                    "aws_internet_gateway", igw_id.replace("-", "_"), attributes)
                self.resource_list['aws_internet_gateway'][igw_id.replace(
                    "-", "_")] = attributes

                route_tables = self.ec2_client.describe_route_tables()[
                    "RouteTables"]

                for rt in route_tables:
                    for route in rt["Routes"]:
                        if route.get("GatewayId", "") == igw_id:  # match the GatewayId
                            # pass the route_table_id and the route
                            self.aws_route(rt["RouteTableId"], route)

    def aws_default_route_table(self, vpc_id):
        print("Processing Default Route Tables...")
        self.resource_list['aws_default_route_table'] = {}
        route_tables = self.ec2_client.describe_route_tables(
            Filters=[{"Name": "association.main", "Values": ["true"]},
                     {"Name": "vpc-id", "Values": [vpc_id]}]  # Filter for the given vpc_id
        )["RouteTables"]

        for route_table in route_tables:
            route_table_id = route_table["RouteTableId"]
            print(
                f"  Processing Default Route Table: {route_table_id} for VPC: {vpc_id}")

            attributes = {
                "id": route_table_id,
                "vpc_id": vpc_id,
            }
            self.hcl.process_resource(
                "aws_default_route_table", route_table_id.replace("-", "_"), attributes)
            self.resource_list['aws_default_route_table'][route_table_id.replace(
                "-", "_")] = attributes

    def aws_default_network_acl(self, vpc_id):
        print("Processing Default Network ACLs...")
        self.resource_list['aws_default_network_acl'] = {}
        network_acls = self.ec2_client.describe_network_acls(
            Filters=[{"Name": "default", "Values": ["true"]},
                     {"Name": "vpc-id", "Values": [vpc_id]}]  # Filter for the given vpc_id
        )["NetworkAcls"]
        for network_acl in network_acls:
            network_acl_id = network_acl["NetworkAclId"]
            default_network_acl_id = network_acl["NetworkAclId"]
            print(
                f"  Processing Default Network ACL: {network_acl_id} for VPC: {vpc_id}")

            attributes = {
                "id": network_acl_id,
                "vpc_id": vpc_id,
                "default_network_acl_id": default_network_acl_id,
            }
            self.hcl.process_resource(
                "aws_default_network_acl", network_acl_id.replace("-", "_"), attributes)
            self.resource_list['aws_default_network_acl'][network_acl_id.replace(
                "-", "_")] = attributes

    def aws_default_security_group(self, vpc_id):
        print("Processing Default Security Groups...")
        self.resource_list['aws_default_security_group'] = {}
        security_groups = self.ec2_client.describe_security_groups(
            Filters=[{"Name": "group-name", "Values": ["default"]},
                     {"Name": "vpc-id", "Values": [vpc_id]}]  # Filter for the given vpc_id
        )["SecurityGroups"]

        for security_group in security_groups:
            security_group_id = security_group["GroupId"]
            print(
                f"  Processing Default Security Group: {security_group_id} for VPC: {vpc_id}")

            attributes = {
                "id": security_group_id,
                "vpc_id": vpc_id,
            }
            self.hcl.process_resource(
                "aws_default_security_group", security_group_id.replace("-", "_"), attributes)
            self.resource_list['aws_default_security_group'][security_group_id.replace(
                "-", "_")] = attributes

    def aws_default_subnet(self):
        print("Processing Default Subnets...")
        self.resource_list['aws_default_subnet'] = {}
        subnets = self.ec2_client.describe_subnets(
            Filters=[{"Name": "default-for-az", "Values": ["true"]}]
        )["Subnets"]

        for subnet in subnets:
            vpc_id = subnet["VpcId"]
            subnet_id = subnet["SubnetId"]
            print(
                f"  Processing Default Subnet: {subnet_id} for VPC: {vpc_id}")

            attributes = {
                "id": subnet_id,
                "vpc_id": vpc_id,
                "cidr_block": subnet["CidrBlock"],
                "availability_zone": subnet["AvailabilityZone"],
            }
            self.hcl.process_resource(
                "aws_default_subnet", subnet_id.replace("-", "_"), attributes)
            self.resource_list['aws_default_subnet'][subnet_id.replace(
                "-", "_")] = attributes

    def aws_default_vpc(self):
        print("Processing Default VPCs...")
        self.resource_list['aws_default_vpc'] = {}
        vpcs = self.ec2_client.describe_vpcs(
            Filters=[{"Name": "isDefault", "Values": ["true"]}]
        )["Vpcs"]

        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            print(f"  Processing Default VPC: {vpc_id}")

            attributes = {
                "id": vpc_id,
            }
            self.hcl.process_resource(
                "aws_default_vpc", vpc_id.replace("-", "_"), attributes)
            self.resource_list['aws_default_vpc'][vpc_id.replace(
                "-", "_")] = attributes

    def aws_default_vpc_dhcp_options(self):
        print("Processing Default VPC DHCP Options...")
        self.resource_list['aws_default_vpc_dhcp_options'] = {}
        dhcp_options = self.ec2_client.describe_dhcp_options(
            Filters=[{"Name": "default", "Values": ["true"]}]
        )["DhcpOptions"]

        for dhcp_option in dhcp_options:
            dhcp_options_id = dhcp_option["DhcpOptionsId"]
            print(f"  Processing Default VPC DHCP Options: {dhcp_options_id}")

            attributes = {
                "id": dhcp_options_id,
            }
            self.hcl.process_resource(
                "aws_default_vpc_dhcp_options", dhcp_options_id.replace("-", "_"), attributes)
            self.resource_list['aws_default_vpc_dhcp_options'][dhcp_options_id.replace(
                "-", "_")] = attributes

    def aws_ec2_managed_prefix_list(self):
        print("Processing EC2 Managed Prefix Lists...")
        self.resource_list['aws_ec2_managed_prefix_list'] = {}
        prefix_lists = self.ec2_client.describe_managed_prefix_lists()[
            "PrefixLists"]

        for prefix_list in prefix_lists:
            prefix_list_id = prefix_list["PrefixListId"]
            print(f"  Processing EC2 Managed Prefix List: {prefix_list_id}")

            # Get the entries for the prefix list
            entries = self.ec2_client.get_managed_prefix_list_entries(
                PrefixListId=prefix_list_id)["Entries"]

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
            self.hcl.process_resource(
                "aws_ec2_managed_prefix_list", prefix_list_id.replace("-", "_"), attributes)
            self.resource_list['aws_ec2_managed_prefix_list'][prefix_list_id.replace(
                "-", "_")] = attributes

    def aws_ec2_network_insights_analysis(self):
        print("Processing EC2 Network Insights Analysis...")
        self.resource_list['aws_ec2_network_insights_analysis'] = {}
        network_insights_analyses = self.ec2_client.describe_network_insights_analyses()[
            "NetworkInsightsAnalyses"]

        for analysis in network_insights_analyses:
            analysis_id = analysis["NetworkInsightsAnalysisId"]
            print(f"  Processing EC2 Network Insights Analysis: {analysis_id}")

            attributes = {
                "id": analysis_id,
                "network_insights_path_id": analysis["NetworkInsightsPathId"],
                "status": analysis["Status"],
                "status_message": analysis.get("StatusMessage", ""),
            }
            self.hcl.process_resource(
                "aws_ec2_network_insights_analysis", analysis_id.replace("-", "_"), attributes)
            self.resource_list['aws_ec2_network_insights_analysis'][analysis_id.replace(
                "-", "_")] = attributes

    def aws_ec2_network_insights_path(self):
        print("Processing EC2 Network Insights Paths...")
        self.resource_list['aws_ec2_network_insights_path'] = {}
        network_insights_paths = self.ec2_client.describe_network_insights_paths()[
            "NetworkInsightsPaths"]

        for path in network_insights_paths:
            path_id = path["NetworkInsightsPathId"]
            print(f"  Processing EC2 Network Insights Path: {path_id}")

            attributes = {
                "id": path_id,
                "source": path["Source"],
                "destination": path["Destination"],
                "protocol": path.get("Protocol", ""),
            }
            self.hcl.process_resource(
                "aws_ec2_network_insights_path", path_id.replace("-", "_"), attributes)
            self.resource_list['aws_ec2_network_insights_path'][path_id.replace(
                "-", "_")] = attributes

    def aws_ec2_subnet_cidr_reservation(self):
        print("Processing Subnet CIDR Reservations...")
        self.resource_list['aws_ec2_subnet_cidr_reservation'] = {}
        subnets = self.ec2_client.describe_subnets()["Subnets"]

        for subnet in subnets:
            subnet_id = subnet["SubnetId"]
            cidr_reservations_response = self.ec2_client.get_subnet_cidr_reservations(
                SubnetId=subnet_id)

            # Process IPv4 CIDR reservations
            ipv4_cidr_reservations = cidr_reservations_response["SubnetIpv4CidrReservations"]
            for cidr_reservation in ipv4_cidr_reservations:
                reservation_id = cidr_reservation["CidrReservationId"]
                print(
                    f"  Processing IPv4 Subnet CIDR Reservation: {reservation_id} in Subnet: {subnet_id}")

                attributes = {
                    "id": reservation_id,
                    "subnet_id": subnet_id,
                    "cidr_block": cidr_reservation["Cidr"],
                }
                self.hcl.process_resource(
                    "aws_ec2_subnet_cidr_reservation", reservation_id.replace("-", "_"), attributes)
                self.resource_list['aws_ec2_subnet_cidr_reservation'][reservation_id.replace(
                    "-", "_")] = attributes

            # Process IPv6 CIDR reservations
            ipv6_cidr_reservations = cidr_reservations_response["SubnetIpv6CidrReservations"]
            for cidr_reservation in ipv6_cidr_reservations:
                reservation_id = cidr_reservation["CidrReservationId"]
                print(
                    f"  Processing IPv6 Subnet CIDR Reservation: {reservation_id} in Subnet: {subnet_id}")

                attributes = {
                    "id": reservation_id,
                    "subnet_id": subnet_id,
                    "cidr_block": cidr_reservation["Cidr"],
                }
                self.hcl.process_resource(
                    "aws_ec2_subnet_cidr_reservation", reservation_id.replace("-", "_"), attributes)
                self.resource_list['aws_ec2_subnet_cidr_reservation'][reservation_id.replace(
                    "-", "_")] = attributes

    def aws_ec2_traffic_mirror_filter(self):
        print("Processing EC2 Traffic Mirror Filters...")
        self.resource_list['aws_ec2_traffic_mirror_filter'] = {}
        traffic_mirror_filters = self.ec2_client.describe_traffic_mirror_filters()[
            "TrafficMirrorFilters"]

        for tm_filter in traffic_mirror_filters:
            tm_filter_id = tm_filter["TrafficMirrorFilterId"]
            print(f"  Processing EC2 Traffic Mirror Filter: {tm_filter_id}")

            attributes = {
                "id": tm_filter_id,
                "description": tm_filter.get("Description", ""),
            }
            self.hcl.process_resource(
                "aws_ec2_traffic_mirror_filter", tm_filter_id.replace("-", "_"), attributes)
            self.resource_list['aws_ec2_traffic_mirror_filter'][tm_filter_id.replace(
                "-", "_")] = attributes

    def aws_ec2_traffic_mirror_filter_rule(self):
        print("Processing EC2 Traffic Mirror Filter Rules...")
        self.resource_list['aws_ec2_traffic_mirror_filter_rule'] = {}
        traffic_mirror_filters = self.ec2_client.describe_traffic_mirror_filters()[
            "TrafficMirrorFilters"]

        for tm_filter in traffic_mirror_filters:
            tm_filter_id = tm_filter["TrafficMirrorFilterId"]

            # Describe the ingress and egress rules for the traffic mirror filter
            ingress_rules = self.ec2_client.describe_traffic_mirror_filter_rules(
                Filters=[{"Name": "traffic-mirror-filter-id",
                          "Values": [tm_filter_id]}],
                Direction="ingress"
            )["TrafficMirrorFilterRules"]

            egress_rules = self.ec2_client.describe_traffic_mirror_filter_rules(
                Filters=[{"Name": "traffic-mirror-filter-id",
                          "Values": [tm_filter_id]}],
                Direction="egress"
            )["TrafficMirrorFilterRules"]

            # Combine ingress and egress rules
            rules = ingress_rules + egress_rules

            for rule in rules:
                rule_id = rule["TrafficMirrorFilterRuleId"]
                print(
                    f"  Processing EC2 Traffic Mirror Filter Rule: {rule_id} for Filter: {tm_filter_id}")

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
                self.hcl.process_resource(
                    "aws_ec2_traffic_mirror_filter_rule", rule_id.replace("-", "_"), attributes)
                self.resource_list['aws_ec2_traffic_mirror_filter_rule'][rule_id.replace(
                    "-", "_")] = attributes

    def aws_ec2_traffic_mirror_session(self):
        print("Processing EC2 Traffic Mirror Sessions...")
        self.resource_list['aws_ec2_traffic_mirror_session'] = {}
        traffic_mirror_sessions = self.ec2_client.describe_traffic_mirror_sessions()[
            "TrafficMirrorSessions"]

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
            self.hcl.process_resource(
                "aws_ec2_traffic_mirror_session", tm_session_id.replace("-", "_"), attributes)
            self.resource_list['aws_ec2_traffic_mirror_session'][tm_session_id.replace(
                "-", "_")] = attributes

    def aws_ec2_traffic_mirror_target(self):
        print("Processing EC2 Traffic Mirror Targets...")
        self.resource_list['aws_ec2_traffic_mirror_target'] = {}
        traffic_mirror_targets = self.ec2_client.describe_traffic_mirror_targets()[
            "TrafficMirrorTargets"]

        for tm_target in traffic_mirror_targets:
            tm_target_id = tm_target["TrafficMirrorTargetId"]
            print(f"  Processing EC2 Traffic Mirror Target: {tm_target_id}")

            attributes = {
                "id": tm_target_id,
                "description": tm_target.get("Description", ""),
                "network_load_balancer_arn": tm_target.get("NetworkLoadBalancerArn", ""),
                "network_interface_id": tm_target.get("NetworkInterfaceId", ""),
            }
            self.hcl.process_resource(
                "aws_ec2_traffic_mirror_target", tm_target_id.replace("-", "_"), attributes)
            self.resource_list['aws_ec2_traffic_mirror_target'][tm_target_id.replace(
                "-", "_")] = attributes

    def aws_egress_only_internet_gateway(self):
        print("Processing Egress Only Internet Gateways...")
        self.resource_list['aws_egress_only_internet_gateway'] = {}
        egress_only_igws = self.ec2_client.describe_egress_only_internet_gateways()[
            "EgressOnlyInternetGateways"]

        for egress_only_igw in egress_only_igws:
            egress_only_igw_id = egress_only_igw["EgressOnlyInternetGatewayId"]
            print(
                f"  Processing Egress Only Internet Gateway: {egress_only_igw_id}")

            # Assuming there is only one attachment per egress-only internet gateway
            vpc_id = egress_only_igw["Attachments"][0]["VpcId"] if egress_only_igw["Attachments"] else ""

            attributes = {
                "id": egress_only_igw_id,
                "vpc_id": vpc_id,
            }
            self.hcl.process_resource(
                "aws_egress_only_internet_gateway", egress_only_igw_id.replace("-", "_"), attributes)
            self.resource_list['aws_egress_only_internet_gateway'][egress_only_igw_id.replace(
                "-", "_")] = attributes

    def aws_flow_log(self, vpc_id):
        print("Processing Flow Logs...")
        self.resource_list['aws_flow_log'] = {}
        flow_logs = self.ec2_client.describe_flow_logs()["FlowLogs"]

        for flow_log in flow_logs:
            # Filter out flow_logs not associated with the vpc_id
            if flow_log["ResourceId"] == vpc_id:
                flow_log_id = flow_log["FlowLogId"]
                print(f"  Processing Flow Log: {flow_log_id}")

                attributes = {
                    "id": flow_log_id,
                    "resource_id": flow_log["ResourceId"],
                    "traffic_type": flow_log.get("TrafficType", ""),
                    "log_destination_type": flow_log.get("LogDestinationType", ""),
                    "log_destination": flow_log.get("LogDestination", ""),
                    "log_group_name": flow_log.get("LogGroupName", ""),
                    "iam_role_arn": flow_log.get("DeliverLogsPermissionArn", ""),
                    "max_aggregation_interval": flow_log.get("MaxAggregationInterval", ""),
                }
                self.hcl.process_resource(
                    "aws_flow_log", flow_log_id.replace("-", "_"), attributes)
                self.resource_list['aws_flow_log'][flow_log_id.replace(
                    "-", "_")] = attributes
                # Check if the log destination type is 'cloudwatch-logs'
                if attributes["log_destination_type"] == "cloud-watch-logs":
                    # If so, process a CloudWatch Log Group
                    self.aws_cloudwatch_log_group(attributes["log_group_name"])

                # If IAM role ARN is provided, process the IAM role
                if attributes["iam_role_arn"]:
                    # Assuming the role ARN ends with the role name
                    role_name = attributes["iam_role_arn"]
                    self.aws_iam_role(role_name)

    def aws_iam_role(self, role_arn):
        # the role name is the last part of the ARN
        role_name = role_arn.split('/')[-1]

        role = self.iam_client.get_role(RoleName=role_name)
        print(f"Processing IAM Role: {role_name}")

        attributes = {
            "id": role_name,
            # "name": role['Role']['RoleName'],
            # "arn": role['Role']['Arn'],
            # "description": role['Role']['Description'],
            # "assume_role_policy": role['Role']['AssumeRolePolicyDocument'],
        }
        self.hcl.process_resource(
            "aws_iam_role", role_name.replace("-", "_"), attributes)

        # After processing the role, process the policies attached to it
        self.aws_iam_role_policy_attachment(role_name)

    def aws_iam_role_policy_attachment(self, role_name):
        print(
            f"Processing IAM Role Policy Attachment for Role: {role_name}...")
        self.resource_list['aws_iam_role_policy_attachment'] = {}

        try:
            attached_policies = self.iam_client.list_attached_role_policies(
                RoleName=role_name)
            for policy in attached_policies['AttachedPolicies']:
                policy_arn = policy['PolicyArn']
                id = f"{role_name}_{policy['PolicyName']}"
                attributes = {
                    "id": id,
                    "role": role_name,
                    "policy_arn": policy_arn
                }

                self.hcl.process_resource(
                    "aws_iam_role_policy_attachment", id.replace("-", "_"), attributes)
                self.resource_list['aws_iam_role_policy_attachment'][id.replace(
                    "-", "_")] = attributes

                # Call the aws_iam_policy function with the policy ARN
                self.aws_iam_policy(policy_arn)

                # Process only one policy for now
                return

        except self.iam_client.exceptions.NoSuchEntityException:
            print(f"  Role: {role_name} does not exist.")

    def aws_iam_policy(self, policy_arn):
        print(f"Processing IAM Policy: {policy_arn}...")
        self.resource_list['aws_iam_policy'] = {}

        try:
            policy = self.iam_client.get_policy(PolicyArn=policy_arn)
            attributes = {
                "id": policy['Policy']['Arn'],
                "arn": policy['Policy']['Arn'],
                "name": policy['Policy']['PolicyName'],
                # add more attributes as needed
            }

            self.hcl.process_resource(
                "aws_iam_policy", policy['Policy']['PolicyName'].replace("-", "_"), attributes)
            self.resource_list['aws_iam_policy'][policy['Policy']['PolicyName'].replace(
                "-", "_")] = attributes
        except self.iam_client.exceptions.NoSuchEntityException:
            print(f"  Policy: {policy_arn} does not exist.")

    def aws_cloudwatch_log_group(self, log_group_name):
        print(f"Processing CloudWatch Log Group: {log_group_name}...")
        self.resource_list['aws_cloudwatch_log_group'] = {}

        paginator = self.logs_client.get_paginator("describe_log_groups")
        for page in paginator.paginate(logGroupNamePrefix=log_group_name):
            for log_group in page["logGroups"]:
                if log_group["logGroupName"] == log_group_name:
                    print(
                        f"  Processing CloudWatch Log Group: {log_group_name}")

                    attributes = {
                        "id": log_group_name,
                        "name": log_group_name,
                    }

                    self.hcl.process_resource(
                        "aws_cloudwatch_log_group", log_group_name.replace("-", "_"), attributes)
                    self.resource_list['aws_cloudwatch_log_group'][log_group_name.replace(
                        "-", "_")] = attributes
                    return

        print(f"  Log group: {log_group_name} does not exist.")

    def aws_internet_gateway_attachment(self):
        print("Processing Internet Gateway Attachments...")
        self.resource_list['aws_internet_gateway_attachment'] = {}
        internet_gateways = self.ec2_client.describe_internet_gateways()[
            "InternetGateways"]

        for igw in internet_gateways:
            igw_id = igw["InternetGatewayId"]

            for attachment in igw["Attachments"]:
                vpc_id = attachment["VpcId"]
                print(
                    f"  Processing Internet Gateway Attachment: {igw_id} <-> {vpc_id}")

                attributes = {
                    "id": f"{igw_id}:{vpc_id}",
                    "internet_gateway_id": igw_id,
                    "vpc_id": vpc_id,
                }
                self.hcl.process_resource(
                    "aws_internet_gateway_attachment", f"{igw_id.replace('-', '_')}-{vpc_id.replace('-', '_')}", attributes)
                self.resource_list['aws_internet_gateway_attachment'][
                    f"{igw_id.replace('-', '_')}-{vpc_id.replace('-', '_')}"] = attributes

    def aws_main_route_table_association(self):
        print("Processing Main Route Table Associations...")
        self.resource_list['aws_main_route_table_association'] = {}
        route_tables = self.ec2_client.describe_route_tables()["RouteTables"]

        for rt in route_tables:
            rt_id = rt["RouteTableId"]
            vpc_id = rt["VpcId"]

            for assoc in rt["Associations"]:
                if assoc["Main"]:
                    assoc_id = assoc["RouteTableAssociationId"]
                    print(
                        f"  Processing Main Route Table Association: {assoc_id} for VPC: {vpc_id}")

                    attributes = {
                        "id": assoc_id,
                        "vpc_id": vpc_id,
                        "route_table_id": rt_id,
                    }
                    self.hcl.process_resource(
                        "aws_main_route_table_association", assoc_id.replace("-", "_"), attributes)
                    self.resource_list['aws_main_route_table_association'][assoc_id.replace(
                        "-", "_")] = attributes

    def aws_nat_gateway(self, vpc_id):
        print("Processing NAT Gateways for VPC: ", vpc_id)
        self.resource_list['aws_nat_gateway'] = {}

        # Describe all subnets for the given VPC
        subnets = self.ec2_client.describe_subnets(
            Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])['Subnets']

        # Process NAT gateways for each subnet
        for subnet in subnets:
            subnet_id = subnet['SubnetId']
            nat_gateways = self.ec2_client.describe_nat_gateways(
                Filters=[{'Name': 'subnet-id', 'Values': [subnet_id]}])["NatGateways"]

            # Sort the NAT gateways by CreateTime
            nat_gateways = sorted(
                nat_gateways, key=lambda ng: ng['CreateTime'])

            for nat_gw in nat_gateways:
                nat_gw_id = nat_gw["NatGatewayId"]
                nat_gw_state = nat_gw["State"]

                if nat_gw_state == "available":  # Add this condition
                    print(f"  Processing NAT Gateway: {nat_gw_id}")

                    attributes = {
                        "id": nat_gw_id,
                        "subnet_id": nat_gw["SubnetId"],
                        "allocation_id": nat_gw["NatGatewayAddresses"][0]["AllocationId"],
                        "network_interface_id": nat_gw["NatGatewayAddresses"][0]["NetworkInterfaceId"],
                        "private_ip": nat_gw["NatGatewayAddresses"][0]["PrivateIp"],
                        "public_ip": nat_gw["NatGatewayAddresses"][0]["PublicIp"],
                    }

                    self.hcl.process_resource(
                        "aws_nat_gateway", nat_gw_id.replace("-", "_"), attributes)
                    self.resource_list['aws_nat_gateway'][nat_gw_id.replace(
                        "-", "_")] = attributes

                    # Process associated EIPs
                    for address in nat_gw["NatGatewayAddresses"]:
                        self.aws_eip(address["AllocationId"])

                    route_tables = self.ec2_client.describe_route_tables()[
                        "RouteTables"]

                    for rt in route_tables:
                        for route in rt["Routes"]:
                            # match the NatGatewayId
                            if route.get("NatGatewayId", "") == nat_gw_id:
                                # pass the route_table_id and the route
                                self.aws_route(rt["RouteTableId"], route)

    def aws_eip(self, allocation_id):
        print("Processing Elastic IPs associated with NAT Gateway: ", allocation_id)

        eip = self.ec2_client.describe_addresses(
            AllocationIds=[allocation_id])["Addresses"][0]
        print(f"  Processing Elastic IP: {allocation_id}")

        attributes = {
            "id": allocation_id,
            "public_ip": eip["PublicIp"],
        }

        if "InstanceId" in eip:
            attributes["instance"] = eip["InstanceId"]

        # if "NetworkInterfaceId" in eip:
        #     attributes["network_interface"] = eip["NetworkInterfaceId"]
        #     # call aws_network_interface method for the associated network interface
        #     self.aws_network_interface(eip["NetworkInterfaceId"])

        if "PrivateIpAddress" in eip:
            attributes["private_ip"] = eip["PrivateIpAddress"]

        self.hcl.process_resource(
            "aws_eip", allocation_id.replace("-", "_"), attributes)

    def aws_network_acl(self, vpc_id):
        print("Processing Network ACLs...")
        self.resource_list['aws_network_acl'] = {}
        network_acls = self.ec2_client.describe_network_acls()["NetworkAcls"]

        for network_acl in network_acls:
            if not network_acl["IsDefault"] and network_acl["VpcId"] == vpc_id:
                network_acl_id = network_acl["NetworkAclId"]
                print(
                    f"  Processing Network ACL: {network_acl_id} for VPC: {vpc_id}")

                attributes = {
                    "id": network_acl_id,
                    "vpc_id": vpc_id,
                }
                self.hcl.process_resource(
                    "aws_network_acl", network_acl_id.replace("-", "_"), attributes)
                self.resource_list['aws_network_acl'][network_acl_id.replace(
                    "-", "_")] = attributes

                # call aws_network_acl_association with network_acl_id
                # self.aws_network_acl_association(network_acl_id)
                self.aws_network_acl_rule(network_acl_id)

    def aws_network_acl_association(self, network_acl_id):
        print("Processing Network ACL Associations...")
        self.resource_list['aws_network_acl_association'] = {}
        network_acls = self.ec2_client.describe_network_acls()["NetworkAcls"]

        for network_acl in network_acls:
            if network_acl["NetworkAclId"] == network_acl_id:
                for assoc in network_acl["Associations"]:
                    assoc_id = assoc["NetworkAclAssociationId"]
                    subnet_id = assoc["SubnetId"]
                    print(
                        f"  Processing Network ACL Association: {assoc_id} for Subnet: {subnet_id}")

                    attributes = {
                        "id": assoc_id,
                        "network_acl_id": network_acl_id,
                        "subnet_id": subnet_id,
                    }
                    self.hcl.process_resource(
                        "aws_network_acl_association", assoc_id.replace("-", "_"), attributes)
                    self.resource_list['aws_network_acl_association'][assoc_id.replace(
                        "-", "_")] = attributes

                # call aws_network_acl_rule with network_acl_id

    def aws_network_acl_rule(self, network_acl_id):
        print("Processing Network ACL Rules...")
        self.resource_list['aws_network_acl_rule'] = {}
        network_acls = self.ec2_client.describe_network_acls()["NetworkAcls"]

        for network_acl in network_acls:
            if network_acl["NetworkAclId"] == network_acl_id:
                for entry in network_acl["Entries"]:
                    rule_number = entry["RuleNumber"]
                    if rule_number == 32767:
                        continue
                    rule_action = entry["RuleAction"]
                    rule_egress = entry["Egress"]
                    print(
                        f"  Processing Network ACL Rule: {rule_number} for Network ACL: {network_acl_id}")

                    attributes = {
                        "id": f"{network_acl_id}-{rule_number}",
                        "network_acl_id": network_acl_id,
                        "rule_number": rule_number,
                        "protocol": entry["Protocol"],
                        "rule_action": rule_action,
                        "egress": rule_egress,
                        "cidr_block": entry.get("CidrBlock", ""),
                        "ipv6_cidr_block": entry.get("Ipv6CidrBlock", ""),
                    }
                    self.hcl.process_resource(
                        "aws_network_acl_rule", f"{network_acl_id.replace('-', '_')}-{rule_number}", attributes)
                    self.resource_list['aws_network_acl_rule'][
                        f"{network_acl_id.replace('-', '_')}-{rule_number}"] = attributes

    def aws_network_interface(self, network_interface_id):
        print("Processing Network Interface: ", network_interface_id)
        self.resource_list['aws_network_interface'] = {}
        network_interfaces = self.ec2_client.describe_network_interfaces(NetworkInterfaceIds=[network_interface_id])[
            "NetworkInterfaces"]

        for network_interface in network_interfaces:
            eni_id = network_interface["NetworkInterfaceId"]
            subnet_id = network_interface["SubnetId"]
            description = network_interface.get("Description", "")
            private_ips = [private_ip["PrivateIpAddress"]
                           for private_ip in network_interface["PrivateIpAddresses"]]
            print(f"  Processing Network Interface: {eni_id}")

            attributes = {
                "id": eni_id,
                "subnet_id": subnet_id,
                "description": description,
                "private_ips": private_ips,
            }

            self.hcl.process_resource(
                "aws_network_interface", eni_id.replace("-", "_"), attributes)
            self.resource_list['aws_network_interface'][eni_id.replace(
                "-", "_")] = attributes

    def aws_network_interface_attachment(self, network_interfaces):
        print("Processing Network Interface Attachments...")
        self.resource_list['aws_network_interface_attachment'] = {}

        for eni in network_interfaces:
            eni_id = eni["NetworkInterfaceId"]
            attachment = eni.get("Attachment")
            if attachment and "InstanceId" in attachment:
                attachment_id = attachment["AttachmentId"]
                instance_id = attachment["InstanceId"]
                device_index = attachment["DeviceIndex"]
                print(
                    f"  Processing Network Interface Attachment: {attachment_id} for ENI: {eni_id}")

                attributes = {
                    "id": attachment_id,
                    "instance_id": instance_id,
                    "network_interface_id": eni_id,
                    "device_index": device_index,
                }
                self.hcl.process_resource(
                    "aws_network_interface_attachment", attachment_id.replace("-", "_"), attributes)
                self.resource_list['aws_network_interface_attachment'][attachment_id.replace(
                    "-", "_")] = attributes

    def aws_network_interface_sg_attachment(self, network_interfaces):
        print("Processing Network Interface Security Group Attachments...")
        self.resource_list['aws_network_interface_sg_attachment'] = {}

        for eni in network_interfaces:
            eni_id = eni["NetworkInterfaceId"]

            for sg in eni["Groups"]:
                sg_id = sg["GroupId"]
                print(
                    f"  Processing Security Group Attachment for ENI: {eni_id} and SG: {sg_id}")

                attributes = {
                    "id": f"{eni_id}-{sg_id}",
                    "network_interface_id": eni_id,
                    "security_group_id": sg_id,
                }
                self.hcl.process_resource("aws_network_interface_sg_attachment",
                                          f"{eni_id.replace('-', '_')}-{sg_id.replace('-', '_')}", attributes)
                self.resource_list

    def aws_route_table(self, vpc_id):
        print("Processing Route Tables...")
        self.resource_list['aws_route_table'] = {}
        route_tables = self.ec2_client.describe_route_tables()["RouteTables"]

        for rt in route_tables:
            if rt['VpcId'] == vpc_id:
                # Ignore if it's the default route table
                associations = rt.get('Associations', [])
                if any(assoc.get('Main', False) for assoc in associations):
                    continue

                route_table_id = rt["RouteTableId"]
                print(
                    f"  Processing Route Table: {route_table_id} for VPC: {vpc_id}")

                attributes = {
                    "id": route_table_id,
                    "vpc_id": vpc_id,
                }
                self.hcl.process_resource(
                    "aws_route_table", route_table_id.replace("-", "_"), attributes)
                self.resource_list['aws_route_table'][route_table_id.replace(
                    "-", "_")] = attributes

                # self.aws_route(route_table_id)  # pass the route_table_id

    def aws_route(self, route_table_id, route):
        self.resource_list['aws_route'] = {}
        destination = route.get("DestinationCidrBlock",
                                route.get("DestinationIpv6CidrBlock", ""))
        if destination:
            if route.get("GatewayId", "") == "local":  # Ignoring local route
                return

            print(
                f"  Processing Route in Route Table: {route_table_id} for destination: {destination}")

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
            self.hcl.process_resource(
                "aws_route", f"{route_table_id.replace('-', '_')}-{destination.replace('/', '-')}", attributes)

            self.resource_list['aws_route'][
                f"{route_table_id.replace('-', '_')}-{destination.replace('/', '-')}"] = attributes

    def aws_route_table_association(self, subnet_id):
        print("Processing Route Table Associations...")
        self.resource_list['aws_route_table_association'] = {}
        route_tables = self.ec2_client.describe_route_tables()["RouteTables"]

        for rt in route_tables:
            route_table_id = rt["RouteTableId"]

            for assoc in rt["Associations"]:
                # check the subnet_id
                if not assoc.get("Main") and assoc["SubnetId"] == subnet_id:
                    assoc_id = assoc["RouteTableAssociationId"]
                    print(
                        f"  Processing Route Table Association: {assoc_id} for Route Table: {route_table_id}")

                    attributes = {
                        "id": assoc_id,
                        "route_table_id": route_table_id,
                        "subnet_id": subnet_id,
                    }
                    self.hcl.process_resource(
                        "aws_route_table_association", assoc_id.replace("-", "_"), attributes)
                    self.resource_list['aws_route_table_association'][assoc_id.replace(
                        "-", "_")] = attributes

    def aws_security_group(self):
        print("Processing Security Groups...")
        self.resource_list['aws_security_group'] = {}
        security_groups = self.ec2_client.describe_security_groups()[
            "SecurityGroups"]

        for sg in security_groups:
            sg_id = sg["GroupId"]
            vpc_id = sg["VpcId"]
            tags = sg.get("Tags", [])

            # Skip Elastic Beanstalk security groups
            if any(tag['Key'].startswith("elasticbeanstalk:") for tag in tags):
                print(
                    f"  Skipping Elastic Beanstalk Security Group: {sg_id} for VPC: {vpc_id}")
                continue

            print(f"  Processing Security Group: {sg_id} for VPC: {vpc_id}")

            attributes = {
                "id": sg_id,
                "vpc_id": vpc_id,
                "name": sg.get("GroupName", ""),
                "description": sg.get("Description", ""),
            }
            self.hcl.process_resource(
                "aws_security_group", sg_id.replace("-", "_"), attributes)
            self.resource_list['aws_security_group'][sg_id.replace(
                "-", "_")] = attributes

    def aws_vpc_dhcp_options(self, dhcp_options_id):
        print("Processing VPC DHCP Options...")
        self.resource_list['aws_vpc_dhcp_options'] = {}
        dhcp_options = self.ec2_client.describe_dhcp_options(
            DhcpOptionsIds=[dhcp_options_id])["DhcpOptions"][0]

        print(f"  Processing VPC DHCP Options: {dhcp_options_id}")

        attributes = {
            "id": dhcp_options_id,
            "tags": {tag["Key"]: tag["Value"] for tag in dhcp_options.get("Tags", [])},
        }
        for config in dhcp_options["DhcpConfigurations"]:
            key = config["Key"]
            values = [value["Value"] for value in config["Values"]]
            attributes[key.lower()] = values

        self.hcl.process_resource(
            "aws_vpc_dhcp_options", dhcp_options_id.replace("-", "_"), attributes)
        self.resource_list['aws_vpc_dhcp_options'][dhcp_options_id.replace(
            "-", "_")] = attributes

    def aws_vpc_dhcp_options_association(self, vpc_id):
        print("Processing VPC DHCP Options Associations...")
        self.resource_list['aws_vpc_dhcp_options_association'] = {}
        vpc = self.ec2_client.describe_vpcs(VpcIds=[vpc_id])["Vpcs"][0]
        dhcp_options_id = vpc["DhcpOptionsId"]
        if dhcp_options_id != "default":
            print(
                f"  Processing VPC DHCP Options Association: {dhcp_options_id} for VPC: {vpc_id}")

            assoc_id = f"{dhcp_options_id}-{vpc_id}"
            attributes = {
                "id": assoc_id,
                "vpc_id": vpc_id,
                "dhcp_options_id": dhcp_options_id,
            }
            self.hcl.process_resource(
                "aws_vpc_dhcp_options_association", assoc_id.replace("-", "_"), attributes)
            self.resource_list['aws_vpc_dhcp_options_association'][assoc_id.replace(
                "-", "_")] = attributes

            # Get the DHCP options details
            dhcp_options = self.ec2_client.describe_dhcp_options(
                DhcpOptionsIds=[dhcp_options_id])
            for option in dhcp_options['DhcpOptions']:
                for config in option['DhcpConfigurations']:
                    if config['Key'] == 'domain-name':
                        # save the domain name
                        self.dhcp_options_domain_name[assoc_id] = config['Values'][0]['Value']
                        break

            # self.aws_vpc_dhcp_options(dhcp_options_id)

    def aws_vpc_endpoint(self):
        print("Processing VPC Endpoints...")
        self.resource_list['aws_vpc_endpoint'] = {}
        vpc_endpoints = self.ec2_client.describe_vpc_endpoints()[
            "VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            vpc_id = endpoint["VpcId"]
            service_name = endpoint["ServiceName"]
            print(
                f"  Processing VPC Endpoint: {endpoint_id} for VPC: {vpc_id}")
            attributes = {
                "id": endpoint_id,
                "vpc_id": vpc_id,
                "service_name": service_name,
                "vpc_endpoint_type": endpoint["VpcEndpointType"],
                "private_dns_enabled": endpoint["PrivateDnsEnabled"],
                "subnet_ids": endpoint.get("SubnetIds", []),
                "policy": endpoint["PolicyDocument"],
            }
            self.hcl.process_resource(
                "aws_vpc_endpoint", endpoint_id.replace("-", "_"), attributes)
            self.resource_list['aws_vpc_endpoint'][endpoint_id.replace(
                "-", "_")] = attributes

    def aws_vpc_endpoint_connection_accepter(self):
        print("Processing VPC Endpoint Connection Accepters...")
        self.resource_list['aws_vpc_endpoint_connection_accepter'] = {}
        vpc_endpoints = self.ec2_client.describe_vpc_endpoints()[
            "VpcEndpoints"]

        for endpoint in vpc_endpoints:
            if endpoint["State"] == "pendingAcceptance":
                endpoint_id = endpoint["VpcEndpointId"]
                vpc_id = endpoint["VpcId"]
                service_name = endpoint["ServiceName"]
                print(
                    f"  Processing VPC Endpoint Connection Accepter: {endpoint_id} for VPC: {vpc_id}")

                accepter_id = f"{vpc_id}-{endpoint_id}"
                attributes = {
                    "id": accepter_id,
                    "vpc_endpoint_id": endpoint_id,
                    "vpc_id": vpc_id,
                    "service_name": service_name,
                }
                self.hcl.process_resource(
                    "aws_vpc_endpoint_connection_accepter", accepter_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_endpoint_connection_accepter'][accepter_id.replace(
                    "-", "_")] = attributes

    def aws_vpc_endpoint_connection_notification(self):
        print("Processing VPC Endpoint Connection Notifications...")
        self.resource_list['aws_vpc_endpoint_connection_notification'] = {}
        connection_notifications = self.ec2_client.describe_vpc_endpoint_connection_notifications()[
            "ConnectionNotificationSet"]

        for notification in connection_notifications:
            notification_id = notification["ConnectionNotificationId"]
            vpc_endpoint_id = notification["VpcEndpointId"]
            service_id = notification["ServiceId"]
            sns_topic_arn = notification["ConnectionNotificationArn"]
            print(
                f"  Processing VPC Endpoint Connection Notification: {notification_id}")

            attributes = {
                "id": notification_id,
                "vpc_endpoint_id": vpc_endpoint_id,
                "service_id": service_id,
                "sns_topic_arn": sns_topic_arn,
                "notification_type": notification["ConnectionNotificationType"],
                "state": notification["ConnectionNotificationState"],
            }
            self.hcl.process_resource(
                "aws_vpc_endpoint_connection_notification", notification_id.replace("-", "_"), attributes)
            self.resource_list['aws_vpc_endpoint_connection_notification'][notification_id.replace(
                "-", "_")] = attributes

    def aws_vpc_endpoint_policy(self):
        print("Processing VPC Endpoint Policies...")
        self.resource_list['aws_vpc_endpoint_policy'] = {}
        vpc_endpoints = self.ec2_client.describe_vpc_endpoints()[
            "VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            vpc_id = endpoint["VpcId"]
            service_name = endpoint["ServiceName"]
            policy_document = endpoint["PolicyDocument"]
            print(
                f"  Processing VPC Endpoint Policy: {endpoint_id} for VPC: {vpc_id}")

            attributes = {
                "id": endpoint_id,
                "vpc_endpoint_id": endpoint_id,
                "policy": policy_document,
            }
            self.hcl.process_resource(
                "aws_vpc_endpoint_policy", endpoint_id.replace("-", "_"), attributes)
            self.resource_list['aws_vpc_endpoint_policy'][endpoint_id.replace(
                "-", "_")] = attributes

    def aws_vpc_endpoint_route_table_association(self):
        print("Processing VPC Endpoint Route Table Associations...")
        self.resource_list['aws_vpc_endpoint_route_table_association'] = {}
        vpc_endpoints = self.ec2_client.describe_vpc_endpoints()[
            "VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            route_table_ids = endpoint.get("RouteTableIds", [])

            for route_table_id in route_table_ids:
                print(
                    f"  Processing VPC Endpoint Route Table Association: {endpoint_id} - {route_table_id}")

                assoc_id = f"{endpoint_id}-{route_table_id}"
                attributes = {
                    "id": assoc_id,
                    "vpc_endpoint_id": endpoint_id,
                    "route_table_id": route_table_id,
                }
                self.hcl.process_resource(
                    "aws_vpc_endpoint_route_table_association", assoc_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_endpoint_route_table_association'][assoc_id.replace(
                    "-", "_")] = attributes

    def aws_vpc_endpoint_security_group_association(self):
        print("Processing VPC Endpoint Security Group Associations...")
        self.resource_list['aws_vpc_endpoint_security_group_association'] = {}
        vpc_endpoints = self.ec2_client.describe_vpc_endpoints()[
            "VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            security_group_ids = [group["GroupId"]
                                  for group in endpoint.get("Groups", [])]

            for security_group_id in security_group_ids:
                print(
                    f"  Processing VPC Endpoint Security Group Association: {endpoint_id} - {security_group_id}")

                assoc_id = f"{endpoint_id}-{security_group_id}"
                attributes = {
                    "id": assoc_id,
                    "vpc_endpoint_id": endpoint_id,
                    "security_group_id": security_group_id,
                }
                self.hcl.process_resource(
                    "aws_vpc_endpoint_security_group_association", assoc_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_endpoint_security_group_association'][assoc_id.replace(
                    "-", "_")] = attributes

    def aws_vpc_endpoint_service(self):
        print("Processing VPC Endpoint Services...")
        self.resource_list['aws_vpc_endpoint_service'] = {}
        vpc_endpoint_services = self.ec2_client.describe_vpc_endpoint_services()[
            "ServiceDetails"]

        for service in vpc_endpoint_services:
            service_id = service["ServiceId"]
            service_name = service["ServiceName"]

            # Skip default AWS services
            if service_name.startswith('com.amazonaws') or service_name.startswith('aws.'):
                continue

            print(
                f"  Processing VPC Endpoint Service: {service_id} {service_name}")

            attributes = {
                "id": service_id,
                "service_name": service_name,
                "acceptance_required": service["AcceptanceRequired"],
                "availability_zones": service["AvailabilityZones"],
                "base_endpoint_dns_names": service["BaseEndpointDnsNames"],
                "service_type": service["ServiceType"][0]["ServiceType"],
            }
            self.hcl.process_resource(
                "aws_vpc_endpoint_service", service_id.replace("-", "_"), attributes)
            self.resource_list['aws_vpc_endpoint_service'][service_id.replace(
                "-", "_")] = attributes

    def aws_vpc_endpoint_service_allowed_principal(self):
        print("Processing VPC Endpoint Service Allowed Principals...")
        self.resource_list['aws_vpc_endpoint_service_allowed_principal'] = {}
        vpc_endpoint_services = self.ec2_client.describe_vpc_endpoint_service_configurations()[
            "ServiceConfigurations"]

        for service in vpc_endpoint_services:
            service_id = service["ServiceId"]
            allowed_principals = service.get("AllowedPrincipals", [])

            for principal in allowed_principals:
                print(
                    f"  Processing VPC Endpoint Service Allowed Principal: {principal} for Service: {service_id}")

                assoc_id = f"{service_id}-{principal}"
                attributes = {
                    "id": assoc_id,
                    "vpc_endpoint_service_id": service_id,
                    "principal_arn": principal,
                }
                self.hcl.process_resource(
                    "aws_vpc_endpoint_service_allowed_principal", assoc_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_endpoint_service_allowed_principal'][assoc_id.replace(
                    "-", "_")] = attributes

    def aws_vpc_endpoint_subnet_association(self):
        print("Processing VPC Endpoint Subnet Associations...")
        self.resource_list['aws_vpc_endpoint_subnet_association'] = {}
        vpc_endpoints = self.ec2_client.describe_vpc_endpoints()[
            "VpcEndpoints"]

        for endpoint in vpc_endpoints:
            endpoint_id = endpoint["VpcEndpointId"]
            subnet_ids = endpoint["SubnetIds"]

            for subnet_id in subnet_ids:
                print(
                    f"  Processing VPC Endpoint Subnet Association: {endpoint_id} - {subnet_id}")

                assoc_id = f"{endpoint_id}-{subnet_id}"
                attributes = {
                    "id": assoc_id,
                    "vpc_endpoint_id": endpoint_id,
                    "subnet_id": subnet_id,
                }
                self.hcl.process_resource(
                    "aws_vpc_endpoint_subnet_association", assoc_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_endpoint_subnet_association'][assoc_id.replace(
                    "-", "_")] = attributes

    def aws_vpc_ipv4_cidr_block_association(self):
        print("Processing VPC IPv4 CIDR Block Associations...")
        self.resource_list['aws_vpc_ipv4_cidr_block_association'] = {}
        vpcs = self.ec2_client.describe_vpcs()["Vpcs"]

        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            cidr_blocks = vpc["CidrBlockAssociationSet"]

            for cidr_block in cidr_blocks:
                assoc_id = cidr_block["AssociationId"]
                print(
                    f"  Processing VPC IPv4 CIDR Block Association: {assoc_id} for VPC: {vpc_id}")

                attributes = {
                    "id": assoc_id,
                    "vpc_id": vpc_id,
                    "cidr_block": cidr_block["CidrBlock"],
                }
                self.hcl.process_resource(
                    "aws_vpc_ipv4_cidr_block_association", assoc_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_ipv4_cidr_block_association'][assoc_id.replace(
                    "-", "_")] = attributes

    def aws_vpc_ipv6_cidr_block_association(self):
        print("Processing VPC IPv6 CIDR Block Associations...")
        self.resource_list['aws_vpc_ipv6_cidr_block_association'] = {}
        vpcs = self.ec2_client.describe_vpcs()["Vpcs"]

        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            ipv6_cidr_blocks = vpc.get("Ipv6CidrBlockAssociationSet", [])

            for ipv6_cidr_block in ipv6_cidr_blocks:
                assoc_id = ipv6_cidr_block["AssociationId"]
                print(
                    f"  Processing VPC IPv6 CIDR Block Association: {assoc_id} for VPC: {vpc_id}")

                attributes = {
                    "id": assoc_id,
                    "vpc_id": vpc_id,
                    "ipv6_cidr_block": ipv6_cidr_block["Ipv6CidrBlock"],
                }

                if "Ipv6Pool" in ipv6_cidr_block:
                    attributes["ipv6_ipam_pool_id"] = ipv6_cidr_block["Ipv6Pool"]

                self.hcl.process_resource(
                    "aws_vpc_ipv6_cidr_block_association", assoc_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_ipv6_cidr_block_association'][assoc_id.replace(
                    "-", "_")] = attributes

    def aws_vpc_peering_connection(self):
        print("Processing VPC Peering Connections...")
        self.resource_list['aws_vpc_peering_connection'] = {}
        vpc_peering_connections = self.ec2_client.describe_vpc_peering_connections()[
            "VpcPeeringConnections"]

        for peering_connection in vpc_peering_connections:
            peering_connection_id = peering_connection["VpcPeeringConnectionId"]
            print(
                f"  Processing VPC Peering Connection: {peering_connection_id}")

            attributes = {
                "id": peering_connection_id,
                "vpc_id": peering_connection["RequesterVpcInfo"]["VpcId"],
                "peer_vpc_id": peering_connection["AccepterVpcInfo"]["VpcId"],
                "peer_owner_id": peering_connection["AccepterVpcInfo"]["OwnerId"],
                "peer_region": peering_connection["AccepterVpcInfo"]["Region"],
            }
            self.hcl.process_resource(
                "aws_vpc_peering_connection", peering_connection_id.replace("-", "_"), attributes)
            self.resource_list['aws_vpc_peering_connection'][peering_connection_id.replace(
                "-", "_")] = attributes

    def aws_vpc_peering_connection_accepter(self):
        print("Processing VPC Peering Connection Accepters...")
        self.resource_list['aws_vpc_peering_connection_accepter'] = {}
        vpc_peering_connections = self.ec2_client.describe_vpc_peering_connections()[
            "VpcPeeringConnections"]

        for peering_connection in vpc_peering_connections:
            peering_connection_id = peering_connection["VpcPeeringConnectionId"]
            if peering_connection["Status"]["Code"] != "active":
                continue

            print(
                f"  Processing VPC Peering Connection Accepter: {peering_connection_id}")

            attributes = {
                "id": peering_connection_id,
                "vpc_peering_connection_id": peering_connection_id,
                "auto_accept": True,
            }
            self.hcl.process_resource(
                "aws_vpc_peering_connection_accepter", peering_connection_id.replace("-", "_"), attributes)
            self.resource_list['aws_vpc_peering_connection_accepter'][peering_connection_id.replace(
                "-", "_")] = attributes

    def aws_vpc_peering_connection_options(self):
        print("Processing VPC Peering Connection Options...")
        self.resource_list['aws_vpc_peering_connection_options'] = {}
        vpc_peering_connections = self.ec2_client.describe_vpc_peering_connections()[
            "VpcPeeringConnections"]

        for peering_connection in vpc_peering_connections:
            peering_connection_id = peering_connection["VpcPeeringConnectionId"]
            print(
                f"  Processing VPC Peering Connection Options: {peering_connection_id}")
            attributes = {
                "id": peering_connection_id,
                "vpc_peering_connection_id": peering_connection_id,
            }
            self.hcl.process_resource(
                "aws_vpc_peering_connection_options", peering_connection_id.replace("-", "_"), attributes)
            self.resource_list['aws_vpc_peering_connection_options'][peering_connection_id.replace(
                "-", "_")] = attributes

    def aws_vpc_security_group_egress_rule(self):
        print("Processing VPC Security Group Egress Rules...")
        self.resource_list['aws_vpc_security_group_egress_rule'] = {}
        security_group_rules = self.ec2_client.describe_security_group_rules()[
            "SecurityGroupRules"]

        for rule in security_group_rules:
            rule_id = rule["SecurityGroupRuleId"]
            is_egress = rule["IsEgress"]
            if is_egress:
                attributes = {
                    "id": rule_id,
                }
                self.hcl.process_resource(
                    "aws_vpc_security_group_egress_rule", rule_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_security_group_egress_rule'][rule_id.replace(
                    "-", "_")] = attributes

    def aws_vpc_security_group_ingress_rule(self):
        print("Processing VPC Security Group Ingress Rules...")
        self.resource_list['aws_vpc_security_group_ingress_rule'] = {}
        security_group_rules = self.ec2_client.describe_security_group_rules()[
            "SecurityGroupRules"]

        for rule in security_group_rules:
            rule_id = rule["SecurityGroupRuleId"]
            is_egress = rule["IsEgress"]
            if not is_egress:
                attributes = {
                    "id": rule_id,
                }
                self.hcl.process_resource(
                    "aws_vpc_security_group_ingress_rule", rule_id.replace("-", "_"), attributes)
                self.resource_list['aws_vpc_security_group_ingress_rule'][rule_id.replace(
                    "-", "_")] = attributes
