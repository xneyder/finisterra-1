import os
from utils.hcl import HCL


class RDS:
    def __init__(self, rds_client, logs_client, iam_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.rds_client = rds_client
        self.logs_client = logs_client
        self.iam_client = iam_client
        self.transform_rules = {
            "aws_db_parameter_group": {
                "hcl_keep_fields": {"parameter.name": True},
            },
            # "aws_db_instance": {
            #     "hcl_transform_fields": {
            #         "apply_immediately": {'source': None, 'target': False},
            #         "skip_final_snapshot": {'source': None, 'target': False},
            #     },
            #     # "hcl_keep_fields": {"delete_automated_backups": True},
            # },
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

    def cloudwatch_log_group_name(self, attributes):
        parts = attributes.get('name').split('/')
        if len(parts) >= 5 and parts[:4] == ['', 'aws', 'rds', 'instance']:
            return parts[4]
        else:
            return None

    def get_log_group_name(self, attributes):
        parts = attributes.get('name').split('/')
        if len(parts) >= 5 and parts[:4] == ['', 'aws', 'rds', 'instance']:
            return parts[-1]
        else:
            return None

    def rds(self):
        self.hcl.prepare_folder(os.path.join("generated", "rds"))

        self.aws_db_instance()

        functions = {
            'cloudwatch_log_group_name': self.cloudwatch_log_group_name,
            'get_log_group_name': self.get_log_group_name
        }

        self.hcl.refresh_state()
        self.hcl.module_hcl_code("terraform.tfstate",
                                 os.path.join(os.path.dirname(os.path.abspath(__file__)), "rds.yaml"), functions)
        exit()
        # self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_db_instance(self):
        print("Processing DB Instances...")

        paginator = self.rds_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for instance in page.get("DBInstances", []):
                # Skip instances that belong to a cluster
                if instance.get("DBClusterIdentifier") is not None:
                    continue

                if instance.get("Engine", None) not in ["mysql", "postgres"]:
                    continue
                instance_id = instance["DBInstanceIdentifier"]
                print(f"  Processing DB Instance: {instance_id}")

                # Call the related functions with the respective group names

                attributes = {
                    "id": instance_id,
                }
                self.hcl.process_resource(
                    "aws_db_instance", instance_id.replace("-", "_"), attributes)

                db_option_group_name = instance.get(
                    'OptionGroupMemberships', [{}])[0].get('OptionGroupName', None)
                if db_option_group_name is not None:
                    self.aws_db_option_group(db_option_group_name)

                db_parameter_group_name = instance.get(
                    'DBParameterGroups', [{}])[0].get('DBParameterGroupName', None)
                if db_parameter_group_name is not None:
                    self.aws_db_parameter_group(db_parameter_group_name)

                db_subnet_group_name = instance.get(
                    'DBSubnetGroup', {}).get('DBSubnetGroupName', None)
                if db_subnet_group_name is not None:
                    self.aws_db_subnet_group(db_subnet_group_name)

                arn = instance.get("DBInstanceArn")
                self.aws_db_instance_automated_backups_replication(arn)

                # call aws_cloudwatch_log_group function with instance_id and each log export name as parameters
                for log_export_name in instance.get("EnabledCloudwatchLogsExports", []):
                    self.aws_cloudwatch_log_group(instance_id, log_export_name)

                monitoring_role_arn = instance.get("MonitoringRoleArn")
                if monitoring_role_arn:
                    self.aws_iam_role(monitoring_role_arn)

    def aws_db_option_group(self, option_group_name):
        print(f"Processing DB Option Group {option_group_name}")
        if option_group_name.startswith("default"):
            return

        paginator = self.rds_client.get_paginator("describe_option_groups")
        for page in paginator.paginate():
            for option_group in page.get("OptionGroupsList", []):
                # Skip the option group if it's not the given one
                if option_group["OptionGroupName"] != option_group_name:
                    continue

                print(f"  Processing DB Option Group: {option_group_name}")
                attributes = {
                    "id": option_group_name,
                    "name": option_group_name,
                    "engine_name": option_group["EngineName"],
                    "major_engine_version": option_group["MajorEngineVersion"],
                    "option_group_description": option_group["OptionGroupDescription"],
                }
                self.hcl.process_resource(
                    "aws_db_option_group", option_group_name.replace("-", "_"), attributes)

    def aws_db_parameter_group(self, parameter_group_name):
        print(f"Processing DB Parameter Group {parameter_group_name}")
        if parameter_group_name.startswith("default"):
            return

        paginator = self.rds_client.get_paginator(
            "describe_db_parameter_groups")
        for page in paginator.paginate():
            for parameter_group in page.get("DBParameterGroups", []):
                # Skip the parameter group if it's not the given one
                if parameter_group["DBParameterGroupName"] != parameter_group_name:
                    continue

                print(
                    f"  Processing DB Parameter Group: {parameter_group_name}")
                attributes = {
                    "id": parameter_group_name,
                    "name": parameter_group_name,
                    "family": parameter_group["DBParameterGroupFamily"],
                    "description": parameter_group["Description"],
                }
                self.hcl.process_resource(
                    "aws_db_parameter_group", parameter_group_name.replace("-", "_"), attributes)

    def aws_db_subnet_group(self, db_subnet_group_name):
        print(f"Processing DB Subnet Groups {db_subnet_group_name}")
        if db_subnet_group_name.startswith("default"):
            return

        paginator = self.rds_client.get_paginator("describe_db_subnet_groups")
        for page in paginator.paginate():
            for db_subnet_group in page.get("DBSubnetGroups", []):
                # Skip the subnet group if it's not the given one
                if db_subnet_group["DBSubnetGroupName"] != db_subnet_group_name:
                    continue

                print(f"  Processing DB Subnet Group: {db_subnet_group_name}")
                attributes = {
                    "id": db_subnet_group_name,
                }
                self.hcl.process_resource(
                    "aws_db_subnet_group", db_subnet_group_name.replace("-", "_"), attributes)

    def aws_db_instance_automated_backups_replication(self, source_instance_arn):
        print(
            f"Processing DB Instance Automated Backups Replication {source_instance_arn}")

        paginator = self.rds_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for instance in page.get("DBInstances", []):
                if instance.get("ReadReplicaDBInstanceIdentifiers") and instance["DBInstanceArn"] == source_instance_arn:
                    if instance.get("Engine", None) not in ["mysql", "postgres"]:
                        continue
                    source_instance_id = instance["DBInstanceIdentifier"]
                    for replica_id in instance["ReadReplicaDBInstanceIdentifiers"]:
                        print(
                            f"  Processing DB Instance Automated Backups Replication for {source_instance_id} to {replica_id}")
                        attributes = {
                            "id": f"{source_instance_id}-{replica_id}",
                            "source_db_instance_identifier": source_instance_id,
                            "replica_db_instance_identifier": replica_id,
                        }
                        self.hcl.process_resource("aws_db_instance_automated_backups_replication",
                                                  f"{source_instance_id}-{replica_id}".replace("-", "_"), attributes)

    def aws_cloudwatch_log_group(self, instance_id, log_export_name):
        print(
            f"Processing CloudWatch Log Group: {log_export_name} for DB Instance: {instance_id}")

        # assuming the log group name has prefix /aws/rds/instance/{instance_id}/{log_export_name}
        log_group_name_prefix = f"/aws/rds/instance/{instance_id}/{log_export_name}"

        response = self.logs_client.describe_log_groups(
            logGroupNamePrefix=log_group_name_prefix)

        while True:
            for log_group in response.get('logGroups', []):
                log_group_name = log_group.get('logGroupName')
                if log_group_name.startswith(log_group_name_prefix):
                    print(f"  Processing Log Group: {log_group_name}")
                    attributes = {
                        "id": log_group_name,
                        "name": log_group_name,
                        "retention_in_days": log_group.get('retentionInDays'),
                        "arn": log_group.get('arn'),
                    }
                    self.hcl.process_resource(
                        "aws_cloudwatch_log_group", log_group_name.replace("-", "_"), attributes)

            if 'nextToken' in response:
                response = self.logs_client.describe_log_groups(
                    logGroupNamePrefix=log_group_name_prefix, nextToken=response['nextToken'])
            else:
                break

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
        attached_policies = self.iam_client.list_attached_role_policies(
            RoleName=role_name)

        for policy in attached_policies['AttachedPolicies']:
            policy_name = policy['PolicyName']
            print(
                f"Processing IAM Role Policy Attachment: {policy_name} for Role: {role_name}")

            attributes = {
                "id": f"{role_name}/{policy['PolicyArn']}",
                "role": role_name,
                "policy_arn": policy['PolicyArn']
            }
            self.hcl.process_resource(
                "aws_iam_role_policy_attachment", policy_name.replace("-", "_"), attributes)
