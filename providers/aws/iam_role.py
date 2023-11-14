import os
from utils.hcl import HCL
import json


class IAM_ROLE:
    def __init__(self, iam_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl=None):
        self.iam_client = iam_client
        self.aws_account_id = aws_account_id
        self.workspace_id = workspace_id
        self.modules = modules
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.resource_list = {}
        self.s3Bucket = s3Bucket
        self.dynamoDBTable = dynamoDBTable
        self.state_key = state_key
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                                self.script_dir, self.transform_rules, self.region, self.s3Bucket, self.dynamoDBTable, self.state_key, self.workspace_id, self.modules)
        else:
            self.hcl = hcl

    def iam(self):        
        self.hcl.prepare_folder(os.path.join("generated", "iam_role"))

        self.aws_iam_role()
        self.hcl.refresh_state()

        functions = {}

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "iam_role.yaml"), functions, self.region, self.aws_account_id)

        self.json_plan = self.hcl.json_plan

    def aws_iam_role(self, role_name=None):
        print("Processing IAM Roles...")
        paginator = self.iam_client.get_paginator("list_roles")

        for page in paginator.paginate():
            for role in page["Roles"]:
                current_role_name = role["RoleName"]
                role_path = role["Path"]


                # Ignore roles managed or created by AWS
                if role_path.startswith("/aws-service-role/") or "AWS-QuickSetup" in current_role_name:
                    print(f"  Skipping IAM Role: {current_role_name}")
                    continue

                # Process only the specified role if role_name is provided
                if role_name and current_role_name != role_name:
                    continue

                # if current_role_name != 'ae-dev-aws-load-balancer-controller@kube-system-use1':
                #     continue

                print(f"  Processing IAM Role: {current_role_name}")

                attributes = {
                    "id": current_role_name,
                    "name": current_role_name,
                    "assume_role_policy": json.dumps(role["AssumeRolePolicyDocument"]),
                    "description": role.get("Description"),
                    "path": role_path,
                }
                self.hcl.process_resource("aws_iam_role", current_role_name, attributes)

                # Call aws_iam_role_policy_attachment for the current role_name
                self.aws_iam_role_policy_attachment(current_role_name)

                # Now call aws_iam_instance_profile for the current role_name
                self.aws_iam_instance_profile(current_role_name)

    def aws_iam_instance_profile(self, role_name):
        print("Processing IAM Instance Profiles...")
        paginator = self.iam_client.get_paginator("list_instance_profiles")

        for page in paginator.paginate():
            for instance_profile in page["InstanceProfiles"]:
                # Check if any of the associated roles match the role_name
                associated_roles = [role["RoleName"]
                                    for role in instance_profile["Roles"]]
                if role_name not in associated_roles:
                    # If the current instance profile's roles do not include the filtered role name, skip it.
                    continue

                instance_profile_name = instance_profile["InstanceProfileName"]
                print(
                    f"  Processing IAM Instance Profile: {instance_profile_name} for role {role_name}")

                attributes = {
                    "id": instance_profile_name,
                    "name": instance_profile_name,
                    "path": instance_profile["Path"],
                    "role": role_name,
                }
                self.hcl.process_resource(
                    "aws_iam_instance_profile", instance_profile_name, attributes)

    def aws_iam_role_policy_attachment(self, role_name):
        print(f"Processing IAM Role Policy Attachments for {role_name}...")

        policy_paginator = self.iam_client.get_paginator(
            "list_attached_role_policies")

        for policy_page in policy_paginator.paginate(RoleName=role_name):
            for policy in policy_page["AttachedPolicies"]:
                policy_arn = policy["PolicyArn"]
                print(
                    f"  Processing IAM Role Policy Attachment: {role_name} - {policy_arn}")

                attributes = {
                    "id": f"{role_name}/{policy_arn}",
                    "role": role_name,
                    "policy_arn": policy_arn,
                }
                self.hcl.process_resource(
                    "aws_iam_role_policy_attachment", f"{role_name}_{policy_arn.split(':')[-1]}", attributes)
                
                self.aws_iam_policy(policy_arn)

    def aws_iam_policy(self, policy_arn):
        policy_name = policy_arn.split('/')[-1]
        # Ignore AWS managed policies and policies with '/service-role/' in the ARN
        if policy_arn.startswith('arn:aws:iam::aws:policy/') or '/service-role/' in policy_arn:
            return

        # if policy_name != "DenyCannedPublicACL":
        #     continue

        print(f"  Processing IAM Policy: {policy_name}")
        attributes = {
            "id": policy_arn,
            "arn": policy_arn,
            "name": policy_name,
        }
        self.hcl.process_resource(
            "aws_iam_policy", policy_name, attributes)
