import os
from utils.hcl import HCL


class RDS:
    def __init__(self, rds_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.rds_client = rds_client
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

    def rds(self):
        self.hcl.prepare_folder(os.path.join("generated", "rds"))

        self.aws_db_instance()

        # aws_cloudwatch_log_group
        # aws_iam_role.enhanced_monitoring
        # aws_iam_role_policy_attachment.enhanced_monitoring

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
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
                self.aws_db_option_group(instance.get('OptionGroupName'))
                self.aws_db_parameter_group(
                    instance.get('DBParameterGroupName'))
                self.aws_db_subnet_group(instance.get('DBSubnetGroupName'))
                arn = instance.get("DBInstanceArn")
                self.aws_db_instance_automated_backups_replication(arn)

    def aws_db_option_group(self, option_group_name):
        print("Processing DB Option Groups...")

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
        print("Processing DB Parameter Groups...")

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
        print("Processing DB Subnet Groups...")

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
        print("Processing DB Instance Automated Backups Replications...")

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

    # def aws_cloudwatch_log_group(self, log_group_name):
    #     print("Processing CloudWatch Log Groups...")

    #     paginator = self.cloudwatchlogs_client.get_paginator(
    #         'describe_log_groups')
    #     for page in paginator.paginate(logGroupNamePrefix=log_group_name):
    #         for log_group in page.get('logGroups', []):
    #             if log_group.get('logGroupName') == log_group_name:
    #                 print(f"  Processing Log Group: {log_group_name}")
    #                 attributes = {
    #                     "id": log_group_name,
    #                     "name": log_group_name,
    #                     "retention_in_days": log_group.get('retentionInDays'),
    #                     "arn": log_group.get('arn'),
    #                 }
    #                 self.hcl.process_resource(
    #                     "aws_cloudwatch_log_group", log_group_name.replace("-", "_"), attributes)
