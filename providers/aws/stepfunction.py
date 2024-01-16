import os
from utils.hcl import HCL


class StepFunction:
    def __init__(self, sfn_client, iam_client, logs_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.sfn_client = sfn_client
        self.iam_client = iam_client
        self.logs_client = logs_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.aws_account_id = aws_account_id
        
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}
        self.resource_roles = {}
        self.resource_log_groups = {}

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'join_role': self.join_role,
            'join_log_group': self.join_log_group,
            'get_role_name_from_arn': self.get_role_name_from_arn,
            'to_list': self.to_list,
        }

        self.hcl.functions.update(functions)        

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

    def get_role_name_from_arn(self, attributes, arg):
        arn = attributes.get(arg, None)
        return arn.split('/')[-1] if arn else None

    def join_role(self, parent_attributes, child_attributes):
        id = parent_attributes.get("id")
        role = child_attributes.get("arn")
        if id in self.resource_roles:
            if self.resource_roles[id] == role:
                return True
        return False

    def join_log_group(self, parent_attributes, child_attributes):
        id = parent_attributes.get("id")
        log_group = child_attributes.get("name")
        if id in self.resource_log_groups:
            if self.resource_log_groups[id] == log_group:
                return True
        return False

    def to_list(self, attributes, arg):
        return [attributes.get(arg)]

    def stepfunction(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_sfn_state_machine()

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate","../providers/aws/", {}, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

    def aws_sfn_state_machine(self):
        resource_type = "aws_sfn_state_machine"
        print("Processing State Machines...")

        paginator = self.sfn_client.get_paginator("list_state_machines")
        for page in paginator.paginate():
            for state_machine_summary in page["stateMachines"]:
                print(f"  Processing State Machine: {state_machine_summary['name']}")

                # if state_machine_summary['name'] != 'FormSubmission':
                #     continue

                # Call describe_state_machine to get detailed info, including roleArn
                state_machine = self.sfn_client.describe_state_machine(
                    stateMachineArn=state_machine_summary['stateMachineArn']
                )

                role_arn = state_machine.get('roleArn', None)
                state_machine_arn = state_machine["stateMachineArn"]

                ftstack = "stepfunction"
                try:
                    tags_response = self.sfn_client.list_tags_for_resource(resourceArn=state_machine_arn)
                    tags = tags_response.get('tags', [])
                    for tag in tags:
                        if tag['key'] == 'ftstack':
                            if tag['value'] != 'stepfunction':
                                ftstack = "stack_"+tag['value']
                            break
                except Exception as e:
                    print("Error occurred: ", e)

                attributes = {
                    "id": state_machine_arn,
                    "name": state_machine["name"],
                    "definition": state_machine["definition"],
                    "role_arn": role_arn,
                }

                self.hcl.process_resource(
                    resource_type, state_machine_arn, attributes)
                
                self.hcl.add_stack(resource_type, state_machine_arn, ftstack)


                # Check if roleArn exists before proceeding
                if role_arn:
                    # Call aws_iam_role with state_machine as an argument
                    self.resource_roles[state_machine["stateMachineArn"]] = role_arn
                    self.aws_iam_role(role_arn)
                else:
                    print(
                        f"No IAM role associated with State Machine: {state_machine['name']}")

                # Process CloudWatch Log Group
                log_group = "/aws/vendedlogs/states/"+state_machine["name"]
                self.resource_log_groups[state_machine["stateMachineArn"]] = log_group

                self.aws_cloudwatch_log_group(log_group)

    def aws_iam_role(self, role_arn, aws_iam_policy=False):
        print(f"Processing IAM Role: {role_arn}...")

        role_name = role_arn.split('/')[-1]  # Extract role name from ARN

        try:
            role = self.iam_client.get_role(RoleName=role_name)['Role']

            print(f"  Processing IAM Role: {role['Arn']}")

            attributes = {
                "id": role['RoleName'],
            }
            self.hcl.process_resource(
                "aws_iam_role", role['RoleName'], attributes)
            # Process IAM role policy attachments for the role
            self.aws_iam_role_policy_attachment(
                role['RoleName'], aws_iam_policy)
        except Exception as e:
            print(f"Error processing IAM role: {role_name}: {str(e)}")

    def aws_iam_role_policy_attachment(self, role_name, aws_iam_policy=False):
        print(
            f"Processing IAM Role Policy Attachments for role: {role_name}...")

        try:
            paginator = self.iam_client.get_paginator(
                'list_attached_role_policies')
            for page in paginator.paginate(RoleName=role_name):
                for policy in page['AttachedPolicies']:
                    print(
                        f"  Processing IAM Role Policy Attachment: {policy['PolicyName']} for role: {role_name}")

                    resource_name = f"{role_name}-{policy['PolicyName']}"
                    attributes = {
                        "id": f"{role_name}/{policy['PolicyArn']}",
                        "role": role_name,
                        "policy_arn": policy['PolicyArn']
                    }
                    self.hcl.process_resource(
                        "aws_iam_role_policy_attachment", resource_name, attributes)

                    if aws_iam_policy:
                        self.aws_iam_policy(policy['PolicyArn'])

        except Exception as e:
            print(
                f"Error processing IAM role policy attachments for role: {role_name}: {str(e)}")

    def aws_iam_policy(self, role_arn):
        print(f"Processing IAM Policy for Role {role_arn}...")
        role_name = role_arn.split("/")[-1]

        list_policies = self.iam_client.list_role_policies(
            RoleName=role_name)
        for policy_name in list_policies["PolicyNames"]:
            policy_document = self.iam_client.get_role_policy(
                RoleName=role_name, PolicyName=policy_name)

            attributes = {
                "id": f"{role_name}:{policy_name}",
                "name": policy_name,
                "path": "/",
                "description": "Policy for " + role_name,
                "policy": policy_document["PolicyDocument"],
            }

            self.hcl.process_resource(
                "aws_iam_policy", policy_name.replace("-", "_"), attributes)

    # def aws_iam_policy_attachment(self, role_arn):
    #     print(f"Processing IAM Policy Attachment for Role {role_arn}...")
    #     role_name = role_arn.split("/")[-1]

    #     list_attached_policies = self.iam_client.list_attached_role_policies(
    #         RoleName=role_name)
    #     for policy in list_attached_policies["AttachedPolicies"]:
    #         attributes = {
    #             "id": f"{role_name}:{policy['PolicyName']}",
    #             "name": policy["PolicyName"],
    #             "roles": [role_name],
    #             "policy_arn": policy["PolicyArn"],
    #         }

    #         self.hcl.process_resource(
    #             "aws_iam_policy_attachment", policy["PolicyName"].replace("-", "_"), attributes)
    #         #  self.aws_iam_policy(policy["PolicyArn"])

    def aws_cloudwatch_log_group(self, log_group_name):
        print(f"Processing CloudWatch Log Group {log_group_name}...")

        log_groups = self.logs_client.describe_log_groups(
            logGroupNamePrefix=log_group_name)
        for log_group in log_groups["logGroups"]:
            if log_group["logGroupName"] == log_group_name:
                attributes = {
                    "id": log_group["logGroupName"],
                    # "name": log_group["logGroupName"],
                    # "retention_in_days": log_group["retentionInDays"],
                    # "arn": log_group["arn"],
                }

                self.hcl.process_resource(
                    "aws_cloudwatch_log_group", log_group["logGroupName"].replace("-", "_"), attributes)
