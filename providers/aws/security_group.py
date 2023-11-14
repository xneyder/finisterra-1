import os
from utils.hcl import HCL
import json


class SECURITY_GROUP:
    def __init__(self, ec2_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.ec2_client = ec2_client
        self.aws_account_id = aws_account_id
        self.workspace_id = workspace_id
        self.modules = modules
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}
        self.security_group_rule_ids = []
        self.prefix_list_ids = []

    def aws_security_group_rule_import_id(self, attributes):
        security_group_id = attributes.get('security_group_id')
        type = attributes.get('type')
        protocol = attributes.get('protocol')
        from_port = attributes.get('from_port')
        to_port = attributes.get('to_port')
        cidr_blocks = attributes.get('cidr_blocks', [])
        source_security_group_id = attributes.get(
            'source_security_group_id', [])
        if not source_security_group_id:
            source_security_group_id = []
        if not cidr_blocks:
            cidr_blocks = []
        # print("===========")
        # print(attributes)
        source = "_".join(cidr_blocks+source_security_group_id)
        if source == "":
            # look for it on self.security_group_rule_ids
            for rule in self.security_group_rule_ids:
                if security_group_id == rule['security_group_id'] and type == rule['type'] and protocol == rule['protocol'] and from_port == rule['from_port'] and to_port == rule['to_port']:
                    # if rule['cidr_blocks']:
                    #     source = "_".join(rule['cidr_blocks'])
                    if rule.get('source_security_group_ids'):
                        source = "_".join(rule['source_security_group_ids'])
                    elif rule.get('prefix_list_ids'):
                        source = "_".join(rule['prefix_list_ids'])
                    elif rule.get('ipv6_cidr_blocks'):
                        source = "_".join(rule['ipv6_cidr_blocks'])
                    break
            # for rule in self.prefix_list_ids:
            #     if security_group_id == rule['security_group_id'] and type == rule['type'] and protocol == rule['protocol'] and from_port == rule['from_port'] and to_port == rule['to_port']:
            #         if rule['prefix_list_ids']:
            #             source = "_".join(rule['prefix_list_ids'])
            #         break
        return security_group_id+"_"+type+"_"+protocol+"_"+str(from_port)+"_"+str(to_port)+"_"+source

    def get_security_group_rules(self, attributes):
        key = attributes["id"]
        # rule=attributes
        # security_group_id = attributes.get('security_group_id')
        # protocol = attributes.get('protocol')
        # from_port = attributes.get('from_port')
        # to_port = attributes.get('to_port')
        # type = attributes.get('type')
        

        # description=""
        # ipv6_cidr_blocks=[]
        # for rule in self.security_group_rule_ids:
        #     # print("===========")
        #     # print(security_group_id)
        #     # print(type)
        #     # print(protocol)
        #     # print(from_port)
        #     # print(to_port)
        #     if security_group_id == rule['security_group_id'] and type == rule['type'] and protocol == rule['protocol'] and from_port == rule['from_port'] and to_port == rule['to_port']:
        #         description=rule['description']
        #         ipv6_cidr_blocks=rule.get('ipv6_cidr_blocks', [])

        result = {key: {}}
        for k in attributes.keys():
            if k not in ["from_port","to_port","ip_protocol","description","cidr_ipv4","cidr_ipv6","prefix_list_id","referenced_security_group_id","tags"]:
                continue
            val = attributes.get(k)
            if not val and val!=0:
                continue
            # if k == "id":
            #     result[key][0]["key"] = val
            # elif k == "description" and val == "":
            #     result[key][0]["description"] = description
            # elif k == "ipv6_cidr_blocks" and val == "":
            #     result[key][0]["ipv6_cidr_blocks"] = ipv6_cidr_blocks
            # else:
            result[key][k] = val
        return result
    
    def get_vpc_id(self, attributes, arg):
        vpc_name = self.get_vpc_name(attributes, arg)
        if vpc_name is None:
            return attributes.get(arg)
        else:
            return ""    

    def get_vpc_name(self, attributes, arg):
        vpc_id = attributes.get(arg)
        response = self.ec2_client.describe_vpcs(VpcIds=[vpc_id])
        vpc_name = next(
            (tag['Value'] for tag in response['Vpcs'][0]['Tags'] if tag['Key'] == 'Name'), None)
        return vpc_name

    def security_group(self):
        self.hcl.prepare_folder(os.path.join("generated", "security_group"))

        self.aws_security_group()

        self.hcl.refresh_state()

        # exit()

        functions = {
            'aws_security_group_rule_import_id': self.aws_security_group_rule_import_id,
            'get_vpc_name': self.get_vpc_name,
            'get_security_group_rules': self.get_security_group_rules,
        }

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "security_group.yaml"), functions, self.region, self.aws_account_id)

        self.json_plan = self.hcl.json_plan

    def aws_security_group(self):
        print("Processing Security Groups...")

        # Create a response dictionary to collect responses for all security groups
        response = self.ec2_client.describe_security_groups()

        for security_group in response["SecurityGroups"]:
            if security_group["GroupName"] == "default":
                continue

            # if security_group["GroupName"] != "launch-wizard-18":
            #     continue
            # if security_group["GroupId"] != "sg-0f47517b":
            #     continue

            is_elasticbeanstalk = any(tag['Key'].startswith(
                'elasticbeanstalk:') for tag in security_group.get('Tags', []))
            is_eks = any(tag['Key'].startswith('eks:')
                         for tag in security_group.get('Tags', []))

            if is_elasticbeanstalk or is_eks:
                print(
                    f"  Skipping Elastic Beanstalk or EKS AutoScaling Group: {security_group['GroupName']}")
                continue  # Skip this AutoScaling group and move to the next
            print(
                f"  Processing Security Group: {security_group['GroupName']}")

            attributes = {
                "id": security_group["GroupId"],
                "name": security_group["GroupName"],
                "description": security_group.get("Description", ""),
                "vpc_id": security_group.get("VpcId", ""),
                "owner_id": security_group.get("OwnerId", ""),
            }

            self.hcl.process_resource(
                "aws_security_group", security_group["GroupId"].replace("-", "_"), attributes)
            
            self.aws_vpc_security_group_ingress_rule(security_group["GroupId"])
            self.aws_vpc_security_group_egress_rule(security_group["GroupId"])

            # # Process egress rules
            # for rule in security_group.get('IpPermissionsEgress', []):
            #     self.aws_security_group_rule(
            #         'egress', security_group, rule)

            # # Process ingress rules
            # # print(security_group)
            # for rule in security_group.get('IpPermissions', []):
            #     # print(rule)
            #     self.aws_security_group_rule(
            #         'ingress', security_group, rule)
                
    def aws_vpc_security_group_ingress_rule(self, security_group_id):
        # Fetch security group rules
        response = self.ec2_client.describe_security_group_rules(
            Filters=[{'Name': 'group-id', 'Values': [security_group_id]}]
        )

        # Process each ingress rule
        for rule in response.get('SecurityGroupRules', []):
            # Filter for ingress rules
            if not rule.get('IsEgress', False):
                rule_id = rule['SecurityGroupRuleId']
                print(f"Processing VPC Security Group Ingress Rule {rule_id}...")

                attributes = {
                    "id": rule_id,
                    # "security_group_id": rule['GroupId'],
                    # "type": "ingress",
                    # "protocol": rule.get('IpProtocol', '-1'),  # '-1' stands for 'all'
                    # "from_port": rule.get('FromPort', 0),
                    # "to_port": rule.get('ToPort', 0),
                    # "cidr_blocks": rule.get('CidrIpv4', ''),
                    # "source_security_group_id": rule.get('ReferencedGroupInfo', {}).get('GroupId', '')
                }

                # Process the rule as needed, e.g., storing attributes or creating resources
                self.hcl.process_resource(
                    "aws_vpc_security_group_ingress_rule", rule_id, attributes)        

    def aws_vpc_security_group_egress_rule(self, security_group_id):
        # Fetch security group rules
        response = self.ec2_client.describe_security_group_rules(
            Filters=[{'Name': 'group-id', 'Values': [security_group_id]}]
        )

        # Process each egress rule
        for rule in response.get('SecurityGroupRules', []):
            # Filter for egress rules
            if rule.get('IsEgress', True):
                rule_id = rule['SecurityGroupRuleId']
                print(f"Processing VPC Security Group Egress Rule {rule_id}...")

                attributes = {
                    "id": rule_id,
                    # "security_group_id": rule['GroupId'],
                    # "type": "egress",
                    # "protocol": rule.get('IpProtocol', '-1'),  # '-1' stands for 'all'
                    # "from_port": rule.get('FromPort', 0),
                    # "to_port": rule.get('ToPort', 0),
                    # "cidr_blocks": rule.get('CidrIpv4', ''),
                    # "source_security_group_id": rule.get('ReferencedGroupInfo', {}).get('GroupId', '')
                }

                # Process the rule as needed, e.g., storing attributes or creating resources
                self.hcl.process_resource(
                    "aws_vpc_security_group_egress_rule", rule_id, attributes)   
                

    def aws_security_group_rule(self, rule_type, security_group, rule):
        cidr_blocks = [ip_range['CidrIp']
                       for ip_range in rule.get('IpRanges', [])]
        
        ipv6_cidr_blocks = [ip_range['CidrIpv6']
                       for ip_range in rule.get('Ipv6Ranges', [])]
        
        #Source security group ids
        source_security_group_ids = [sg['GroupId']
                                     for sg in rule.get('UserIdGroupPairs', [])]
        #prefix list ids
        prefix_list_ids = [prefix_list['PrefixListId']
                           for prefix_list in rule.get('PrefixListIds', [])]
        if cidr_blocks:
            source = "_".join(cidr_blocks)
            rule_id = security_group['GroupId']+"_"+rule_type+"_"+rule.get(
                'IpProtocol', '-1')+"_"+str(rule.get('FromPort', 0))+"_"+str(rule.get('ToPort', 0))+"_"+source
            print(f"Processing Security Groups Rule {rule_id}...")

            description=rule.get('IpRanges')[0].get('Description', "")

            attributes = {
                "id": rule_id,
                "type": rule_type,
                "description": description,
                "security_group_id": security_group['GroupId'],
                "protocol": rule.get('IpProtocol', '-1'),
                "from_port": rule.get('FromPort', 0),
                "to_port": rule.get('ToPort', 0),
            }
            attributes["cidr_blocks"]=cidr_blocks

        elif ipv6_cidr_blocks:
            source = "_".join(ipv6_cidr_blocks)
            rule_id = security_group['GroupId']+"_"+rule_type+"_"+rule.get(
                'IpProtocol', '-1')+"_"+str(rule.get('FromPort', 0))+"_"+str(rule.get('ToPort', 0))+"_"+source
            print(f"Processing Security Groups Rule {rule_id}...")

            description=rule.get('Ipv6Ranges')[0].get('Description', "")

            attributes = {
                "id": rule_id,
                "type": rule_type,
                "description": description,
                "security_group_id": security_group['GroupId'],
                "protocol": rule.get('IpProtocol', '-1'),
                "from_port": rule.get('FromPort', 0),
                "to_port": rule.get('ToPort', 0),
            }
            attributes["ipv6_cidr_blocks"]=ipv6_cidr_blocks

        elif source_security_group_ids:
            source = "_".join(source_security_group_ids)
            rule_id = security_group['GroupId']+"_"+rule_type+"_"+rule.get(
                'IpProtocol', '-1')+"_"+str(rule.get('FromPort', 0))+"_"+str(rule.get('ToPort', 0))+"_"+source
            print(f"Processing Security Groups Rule {rule_id}...")
            description=rule.get('UserIdGroupPairs')[0].get('Description', "")
            attributes = {
                "id": rule_id,
                "type": rule_type,
                "description": description,
                "security_group_id": security_group['GroupId'],
                "protocol": rule.get('IpProtocol', '-1'),
                "from_port": rule.get('FromPort', 0),
                "to_port": rule.get('ToPort', 0),
            }

            attributes["source_security_group_ids"]=source_security_group_ids
            # self.security_group_rule_ids.append(attributes)

        
        elif prefix_list_ids:
            source = "_".join(prefix_list_ids)
            rule_id = security_group['GroupId']+"_"+rule_type+"_"+rule.get(
                'IpProtocol', '-1')+"_"+str(rule.get('FromPort', 0))+"_"+str(rule.get('ToPort', 0))+"_"+source
            print(f"Processing Security Groups Rule {rule_id}...")
            description=rule.get('PrefixListIds')[0].get('Description', "")
            attributes = {
                "id": rule_id,
                "type": rule_type,
                "description": description,
                "security_group_id": security_group['GroupId'],
                "protocol": rule.get('IpProtocol', '-1'),
                "from_port": rule.get('FromPort', 0),
                "to_port": rule.get('ToPort', 0),
            }
            attributes["prefix_list_ids"]=prefix_list_ids
            # self.prefix_list_ids.append(attributes)
        # else:
        #     source=""
        #     print(rule)
        #     print(security_group)
        #     rule_id = security_group['GroupId']+"_"+rule_type+"_"+rule.get(
        #         'IpProtocol', '-1')+"_"+str(rule.get('FromPort', 0))+"_"+str(rule.get('ToPort', 0))+"_"+source
        #     print(f"Processing Security Groups Rule {rule_id}...")
        #     attributes = {
        #         "id": rule_id,
        #         "type": rule_type,
        #         # "description": description,
        #         "security_group_id": security_group['GroupId'],
        #         "protocol": rule.get('IpProtocol', '-1'),
        #         "from_port": rule.get('FromPort', 0),
        #         "to_port": rule.get('ToPort', 0),
        #     }
        self.hcl.process_resource(
            "aws_security_group_rule", rule_id.replace("-", "_"), attributes)
        self.security_group_rule_ids.append(attributes)
        