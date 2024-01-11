import os
from utils.hcl import HCL
from providers.aws.iam_role import IAM_ROLE
from providers.aws.logs import Logs

class RDS:
    def __init__(self, rds_client, logs_client, iam_client, kms_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl=None):
        self.rds_client = rds_client
        self.logs_client = logs_client
        self.iam_client = iam_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.s3Bucket = s3Bucket
        self.dynamoDBTable = dynamoDBTable
        self.state_key = state_key

        self.region = region
        self.aws_account_id = aws_account_id

        self.workspace_id = workspace_id
        self.modules = modules
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        else:
            self.hcl = hcl
        
        self.iam_role_instance = IAM_ROLE(iam_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)
        self.logs_instance = Logs(logs_client, kms_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)

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
        
    def get_db_name(self, attributes, arg):
        replicate_source_db = attributes.get("replicate_source_db", None)
        if replicate_source_db:
            return None
        return attributes.get("db_name", None)
    
    def get_username(self, attributes, arg):
        replicate_source_db = attributes.get("replicate_source_db", None)
        if replicate_source_db:
            return None
        return attributes.get("username", None)

    def rds(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_db_instance()

        functions = {
            'cloudwatch_log_group_name': self.cloudwatch_log_group_name,
            'get_log_group_name': self.get_log_group_name,
            'get_db_name': self.get_db_name,
            'get_username': self.get_username,
        }

        self.hcl.refresh_state()
        config_file_list = ["rds.yaml","iam_role.yaml", "logs.yaml"]
        for index,config_file in enumerate(config_file_list):
            config_file_list[index] = os.path.join(os.path.dirname(os.path.abspath(__file__)),config_file )
        self.hcl.module_hcl_code("terraform.tfstate",config_file_list, functions, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

    def aws_db_instance(self):
        resource_type = "aws_db_instance"
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

                # if instance_id != "piwik-analytics":
                #     continue

                id = instance_id

                ftstack = "rds"
                try:
                    tags_response = self.rds_client.list_tags_for_resource(ResourceName=instance["DBInstanceArn"])
                    tags = tags_response.get('TagList', [])
                    for tag in tags:
                        if tag['Key'] == 'ftstack':
                            if tag['Value'] != 'rds':
                                ftstack = "stack_" + tag['Value']
                            break
                except Exception as e:
                    print("Error occurred: ", e)

                attributes = {
                    "id": instance_id,
                    "apply_immediately": False,
                    "delete_automated_backups": True,
                    "skip_final_snapshot": False,
                }
                self.hcl.process_resource(
                    resource_type, id, attributes)
                self.hcl.add_stack(resource_type, id, ftstack)

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
                self.aws_db_instance_automated_backups_replication(arn, ftstack)

                # call aws_cloudwatch_log_group function with instance_id and each log export name as parameters
                for log_export_name in instance.get("EnabledCloudwatchLogsExports", []):
                    self.logs_instance.aws_cloudwatch_log_group(f"/aws/rds/instance/{instance_id}/{log_export_name}", ftstack)
                    # self.aws_cloudwatch_log_group(instance_id, log_export_name)

                monitoring_role_arn = instance.get("MonitoringRoleArn")
                if monitoring_role_arn:
                    role_name = monitoring_role_arn.split('/')[-1]
                    self.iam_role_instance.aws_iam_role(role_name, ftstack)
                    # self.aws_iam_role(monitoring_role_arn)

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

    def aws_db_instance_automated_backups_replication(self, source_instance_arn, ftstack):
        resource_type = "aws_db_instance_automated_backups_replication"
        print(
            f"Processing DB Instance Automated Backups Replication {source_instance_arn}")

        paginator = self.rds_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for instance in page.get("DBInstances", []):
                if instance.get("ReadReplicaDBInstanceIdentifiers") and instance["DBInstanceArn"] == source_instance_arn:
                    if instance.get("Engine", None) not in ["mysql", "postgres"]:
                        continue
                    
                    # Fetching automated backup details
                    backups_paginator = self.rds_client.get_paginator("describe_db_instance_automated_backups")
                    backups_page = backups_paginator.paginate(DBInstanceIdentifier=instance["DBInstanceIdentifier"])

                    for backup_page in backups_page:
                        for backup in backup_page.get("DBInstanceAutomatedBackups", []):
                            automated_backup_arn = backup["DBInstanceAutomatedBackupsArn"]

                            source_instance_id = instance["DBInstanceIdentifier"]
                            for replica_id in instance["ReadReplicaDBInstanceIdentifiers"]:
                                print(
                                    f"  Processing DB Instance Automated Backups Replication for {source_instance_id} to {replica_id}")
                                id=automated_backup_arn
                                attributes = {
                                    "id": automated_backup_arn,
                                }
                                self.hcl.process_resource(resource_type, id, attributes)
                                self.hcl.add_stack(resource_type, id, ftstack)

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

            resource_name = f"{role_name}/{policy_name}"

            attributes = {
                "id": f"{role_name}/{policy['PolicyArn']}",
                "role": role_name,
                "policy_arn": policy['PolicyArn']
            }
            self.hcl.process_resource(
                "aws_iam_role_policy_attachment", resource_name.replace("-", "_"), attributes)
