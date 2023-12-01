import os
from utils.hcl import HCL
import json


class SECURITY_GROUP:
    def __init__(self, ec2_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl=None):
        self.ec2_client = ec2_client
        self.aws_account_id = aws_account_id
        self.workspace_id = workspace_id
        self.modules = modules
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.s3Bucket = s3Bucket
        self.dynamoDBTable = dynamoDBTable
        self.state_key = state_key
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, self.s3Bucket, self.dynamoDBTable, self.state_key, self.workspace_id, self.modules)
        else:
            self.hcl = hcl

        self.additional_data = {}

    def get_vpc_name(self, vpc_id):
        response = self.ec2_client.describe_vpcs(VpcIds=[vpc_id])
        
        # Check if 'Tags' key exists and if it has any tags
        if 'Tags' in response['Vpcs'][0] and response['Vpcs'][0]['Tags']:
            vpc_name = next(
                (tag['Value'] for tag in response['Vpcs'][0]['Tags'] if tag['Key'] == 'Name'), None)
        else:
            # If 'Tags' key doesn't exist or is empty, set vpc_name to None or a default value
            vpc_name = None

        return vpc_name

    def security_group(self):
        self.hcl.prepare_folder(os.path.join("generated", "security_group"))

        self.aws_security_group()

        self.hcl.refresh_state()
        functions = {}
        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "security_group.yaml"), functions, self.region, self.aws_account_id, {}, self.additional_data)

        self.json_plan = self.hcl.json_plan

    def aws_security_group(self, security_group_id=None, ftstack=None):
        resource_type = "aws_security_group"
        print("Processing Security Groups...")

        # Create a response dictionary to collect responses for all security groups
        response = self.ec2_client.describe_security_groups()

        for security_group in response["SecurityGroups"]:
            if security_group["GroupName"] == "default":
                continue

            # Process only the specified security group if security_group_id is provided
            if security_group_id and security_group["GroupId"] != security_group_id:
                continue

            # if security_group["GroupName"] != "launch-wizard-18":
            #     continue
            # if security_group["GroupId"] != "sg-058cbed90f9688f49":
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
            
            vpc_id = security_group.get("VpcId", "")

            id = security_group["GroupId"]

            attributes = {
                "id": id,
                "name": security_group["GroupName"],
                "description": security_group.get("Description", ""),
                "vpc_id": vpc_id,
                "owner_id": security_group.get("OwnerId", ""),
            }

            self.hcl.process_resource(
                resource_type, security_group["GroupId"].replace("-", "_"), attributes)
            if not ftstack:
                ftstack = "security_group"
            self.hcl.add_stack(resource_type, id, ftstack)
            
            self.aws_vpc_security_group_ingress_rule(security_group["GroupId"])
            self.aws_vpc_security_group_egress_rule(security_group["GroupId"])

            vpc_name = self.get_vpc_name(vpc_id)
            self.additional_data[vpc_id] = {
                "name": vpc_name,
            }

                
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
                }

                # Process the rule as needed, e.g., storing attributes or creating resources
                self.hcl.process_resource(
                    "aws_vpc_security_group_egress_rule", rule_id, attributes)   
