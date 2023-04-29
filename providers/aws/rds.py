import os
from utils.hcl import HCL


class RDS:
    def __init__(self, rds_client, script_dir, provider_name, schema_data, region):
        self.rds_client = rds_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def rds(self):
        self.hcl.prepare_folder(os.path.join("generated", "rds"))

        self.aws_db_cluster_snapshot()
        self.aws_db_event_subscription()
        self.aws_db_instance()
        self.aws_db_instance_automated_backups_replication()
        self.aws_db_instance_role_association()
        self.aws_db_option_group()
        self.aws_db_parameter_group()

        if "gov" not in self.region:
            self.aws_db_proxy()
            self.aws_db_proxy_default_target_group()
            self.aws_db_proxy_endpoint()
            self.aws_db_proxy_target()
            self.aws_rds_export_task()

        # self.aws_db_security_group() #deprecated
        self.aws_db_snapshot()
        self.aws_db_snapshot_copy()
        self.aws_db_subnet_group()
        self.aws_rds_cluster()
        self.aws_rds_cluster_activity_stream()
        self.aws_rds_cluster_endpoint()
        self.aws_rds_cluster_instance()
        self.aws_rds_cluster_parameter_group()
        self.aws_rds_cluster_role_association()
        self.aws_rds_global_cluster()
        self.aws_rds_reserved_instance()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_db_cluster_snapshot(self):
        print("Processing DB Cluster Snapshots...")

        paginator = self.rds_client.get_paginator(
            "describe_db_cluster_snapshots")
        for page in paginator.paginate():
            for snapshot in page.get("DBClusterSnapshots", []):
                if snapshot["Engine"] in ["mysql", "postgres"]:
                    snapshot_id = snapshot["DBClusterSnapshotIdentifier"]
                    print(f"  Processing DB Cluster Snapshot: {snapshot_id}")

                    attributes = {
                        "id": snapshot_id,
                    }
                    self.hcl.process_resource(
                        "aws_db_cluster_snapshot", snapshot_id.replace("-", "_"), attributes)

    def aws_db_event_subscription(self):
        print("Processing DB Event Subscriptions...")

        paginator = self.rds_client.get_paginator(
            "describe_event_subscriptions")
        for page in paginator.paginate():
            for subscription in page.get("EventSubscriptionsList", []):
                subscription_id = subscription["CustSubscriptionId"]
                print(f"  Processing DB Event Subscription: {subscription_id}")

                attributes = {
                    "id": subscription_id,
                    "name": subscription_id,
                    "sns_topic_arn": subscription["SnsTopicArn"],
                    "source_type": subscription["SourceType"],
                    "event_categories": subscription["EventCategoriesList"],
                    "enabled": subscription["Enabled"],
                }
                self.hcl.process_resource(
                    "aws_db_event_subscription", subscription_id.replace("-", "_"), attributes)

    def aws_db_instance(self):
        print("Processing DB Instances...")

        paginator = self.rds_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for instance in page.get("DBInstances", []):
                if instance.get("Engine", None) not in ["mysql", "postgres"]:
                    continue
                instance_id = instance["DBInstanceIdentifier"]
                print(f"  Processing DB Instance: {instance_id}")

                attributes = {
                    "id": instance_id,
                    "identifier": instance_id,
                    "allocated_storage": instance.get("AllocatedStorage", None),
                    "engine": instance.get("Engine", None),
                    "engine_version": instance.get("EngineVersion", None),
                    "instance_class": instance.get("DBInstanceClass", None),
                    "name": instance.get("DBName", None),
                    "username": instance.get("MasterUsername", None),
                    "vpc_security_group_ids": [sg["VpcSecurityGroupId"] for sg in instance.get("VpcSecurityGroups", None)],
                    "db_subnet_group_name": instance["DBSubnetGroup"]["DBSubnetGroupName"] if instance.get("DBSubnetGroup") else None,
                }
                self.hcl.process_resource(
                    "aws_db_instance", instance_id.replace("-", "_"), attributes)

    def aws_db_instance_automated_backups_replication(self):
        print("Processing DB Instance Automated Backups Replications...")

        paginator = self.rds_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for instance in page.get("DBInstances", []):
                if instance.get("ReadReplicaDBInstanceIdentifiers"):
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

    def aws_db_instance_role_association(self):
        print("Processing DB Instance Role Associations...")

        paginator = self.rds_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for instance in page.get("DBInstances", []):
                if instance.get("Engine", None) not in ["mysql", "postgres"]:
                    continue
                instance_id = instance["DBInstanceIdentifier"]
                associated_roles = instance.get("AssociatedRoles", [])
                for role in associated_roles:
                    role_arn = role["RoleArn"]
                    print(
                        f"  Processing DB Instance Role Association for {instance_id} with Role ARN {role_arn}")
                    attributes = {
                        "id": f"{instance_id}-{role_arn}",
                        "db_instance_identifier": instance_id,
                        "feature_name": role["FeatureName"],
                        "role_arn": role_arn,
                    }
                    self.hcl.process_resource(
                        "aws_db_instance_role_association", f"{instance_id}-{role_arn}".replace("-", "_"), attributes)

    def aws_db_option_group(self):
        print("Processing DB Option Groups...")

        paginator = self.rds_client.get_paginator("describe_option_groups")
        for page in paginator.paginate():
            for option_group in page.get("OptionGroupsList", []):
                option_group_name = option_group["OptionGroupName"]
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

    def aws_db_parameter_group(self):
        print("Processing DB Parameter Groups...")

        paginator = self.rds_client.get_paginator(
            "describe_db_parameter_groups")
        for page in paginator.paginate():
            for parameter_group in page.get("DBParameterGroups", []):
                parameter_group_name = parameter_group["DBParameterGroupName"]
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

    def aws_db_proxy(self):
        print("Processing DB Proxies...")

        paginator = self.rds_client.get_paginator("describe_db_proxies")
        for page in paginator.paginate():
            for db_proxy in page.get("DBProxies", []):
                db_proxy_name = db_proxy["DBProxyName"]
                print(f"  Processing DB Proxy: {db_proxy_name}")
                attributes = {
                    "id": db_proxy["DBProxyArn"],
                    "name": db_proxy_name,
                    "engine_family": db_proxy["EngineFamily"],
                    "auth": db_proxy["Auth"],
                    "role_arn": db_proxy["RoleArn"],
                }
                self.hcl.process_resource(
                    "aws_db_proxy", db_proxy_name.replace("-", "_"), attributes)

    def aws_db_proxy_default_target_group(self):
        print("Processing DB Proxy Default Target Groups...")

        paginator = self.rds_client.get_paginator(
            "describe_db_proxy_target_groups")
        for page in paginator.paginate():
            for target_group in page.get("TargetGroups", []):
                target_group_name = target_group["DBProxyName"]
                print(
                    f"  Processing DB Proxy Default Target Group: {target_group_name}")
                attributes = {
                    "id": target_group["TargetGroupArn"],
                    "name": target_group_name,
                    "db_proxy_name": target_group["DBProxyName"],
                }
                self.hcl.process_resource(
                    "aws_db_proxy_default_target_group", target_group_name.replace("-", "_"), attributes)

    def aws_db_proxy_endpoint(self):
        print("Processing DB Proxy Endpoints...")

        paginator = self.rds_client.get_paginator(
            "describe_db_proxy_endpoints")
        for page in paginator.paginate():
            for db_proxy_endpoint in page.get("DBProxyEndpoints", []):
                db_proxy_endpoint_name = db_proxy_endpoint["DBProxyEndpointName"]
                print(
                    f"  Processing DB Proxy Endpoint: {db_proxy_endpoint_name}")
                attributes = {
                    "id": db_proxy_endpoint["DBProxyEndpointArn"],
                    "name": db_proxy_endpoint_name,
                    "db_proxy_name": db_proxy_endpoint["DBProxyName"],
                    "vpc_subnet_ids": db_proxy_endpoint["VpcSubnetIds"],
                }
                self.hcl.process_resource(
                    "aws_db_proxy_endpoint", db_proxy_endpoint_name.replace("-", "_"), attributes)

    def aws_db_proxy_target(self):
        print("Processing DB Proxy Targets...")

        paginator = self.rds_client.get_paginator("describe_db_proxy_targets")
        for page in paginator.paginate():
            for db_proxy_target in page.get("Targets", []):
                target_arn = db_proxy_target["TargetArn"]
                print(f"  Processing DB Proxy Target: {target_arn}")
                attributes = {
                    "id": target_arn,
                    "db_proxy_name": db_proxy_target["DBProxyName"],
                    "target_group_name": db_proxy_target["TargetGroupName"],
                    "db_instance_identifier": db_proxy_target["DbInstanceIdentifier"],
                }
                self.hcl.process_resource("aws_db_proxy_target", target_arn.replace(
                    ":", "_").replace("-", "_"), attributes)

    # def aws_db_security_group(self):
    #     print("Processing DB Security Groups...")

    #     paginator = self.rds_client.get_paginator(
    #         "describe_db_security_groups")
    #     for page in paginator.paginate():
    #         for db_security_group in page.get("DBSecurityGroups", []):
    #             db_security_group_name = db_security_group["DBSecurityGroupName"]
    #             print(
    #                 f"  Processing DB Security Group: {db_security_group_name}")
    #             attributes = {
    #                 "id": db_security_group["DBSecurityGroupArn"],
    #                 "name": db_security_group_name,
    #                 "description": db_security_group["DBSecurityGroupDescription"],
    #             }
    #             self.hcl.process_resource(
    #                 "aws_db_security_group", db_security_group_name.replace("-", "_"), attributes)

    def aws_db_snapshot(self):
        print("Processing DB Snapshots...")

        paginator = self.rds_client.get_paginator("describe_db_snapshots")
        for page in paginator.paginate():
            for db_snapshot in page.get("DBSnapshots", []):
                db_snapshot_id = db_snapshot["DBSnapshotIdentifier"]
                print(f"  Processing DB Snapshot: {db_snapshot_id}")
                attributes = {
                    "id": db_snapshot["DBSnapshotArn"],
                    "snapshot_identifier": db_snapshot_id,
                    "db_instance_identifier": db_snapshot["DBInstanceIdentifier"],
                    "snapshot_type": db_snapshot["SnapshotType"],
                }
                self.hcl.process_resource(
                    "aws_db_snapshot", db_snapshot_id.replace("-", "_"), attributes)

    def aws_db_snapshot_copy(self):
        print("Processing DB Snapshot Copies...")

        paginator = self.rds_client.get_paginator("describe_db_snapshots")
        for page in paginator.paginate():
            for db_snapshot in page.get("DBSnapshots", []):
                if "SourceRegion" in db_snapshot:
                    db_snapshot_id = db_snapshot["DBSnapshotIdentifier"]
                    print(f"  Processing DB Snapshot Copy: {db_snapshot_id}")
                    attributes = {
                        "id": db_snapshot["DBSnapshotArn"],
                        "snapshot_identifier": db_snapshot_id,
                        "source_db_snapshot_identifier": db_snapshot["SourceDBSnapshotIdentifier"],
                        "source_region": db_snapshot["SourceRegion"],
                    }
                    self.hcl.process_resource(
                        "aws_db_snapshot_copy", db_snapshot_id.replace("-", "_"), attributes)

    def aws_db_subnet_group(self):
        print("Processing DB Subnet Groups...")

        paginator = self.rds_client.get_paginator("describe_db_subnet_groups")
        for page in paginator.paginate():
            for db_subnet_group in page.get("DBSubnetGroups", []):
                db_subnet_group_name = db_subnet_group["DBSubnetGroupName"]
                print(f"  Processing DB Subnet Group: {db_subnet_group_name}")
                attributes = {
                    "id": db_subnet_group["DBSubnetGroupArn"],
                    "name": db_subnet_group_name,
                    "description": db_subnet_group["DBSubnetGroupDescription"],
                    "subnet_ids": [subnet["SubnetIdentifier"] for subnet in db_subnet_group["Subnets"]],
                }
                self.hcl.process_resource(
                    "aws_db_subnet_group", db_subnet_group_name.replace("-", "_"), attributes)

    def aws_rds_cluster(self):
        print("Processing RDS Clusters...")

        paginator = self.rds_client.get_paginator("describe_db_clusters")
        for page in paginator.paginate():
            for rds_cluster in page.get("DBClusters", []):
                engine = rds_cluster.get("Engine", "")
                if engine not in ["mysql", "postgres"]:
                    continue
                rds_cluster_id = rds_cluster["DBClusterIdentifier"]
                print(f"  Processing RDS Cluster: {rds_cluster_id}")
                attributes = {
                    "id": rds_cluster["DBClusterArn"],
                    "cluster_identifier": rds_cluster_id,
                    "engine": engine,
                    "engine_version": rds_cluster["EngineVersion"],
                    "master_username": rds_cluster["MasterUsername"],
                    "database_name": rds_cluster.get("DatabaseName"),
                    "port": rds_cluster["Port"],
                }
                self.hcl.process_resource(
                    "aws_rds_cluster", rds_cluster_id.replace("-", "_"), attributes)

    def aws_rds_cluster_activity_stream(self):
        print("Processing RDS Cluster Activity Streams...")

        paginator = self.rds_client.get_paginator("describe_db_clusters")
        for page in paginator.paginate():
            for rds_cluster in page.get("DBClusters", []):
                engine = rds_cluster.get("Engine", "")
                if engine not in ["mysql", "postgres"]:
                    continue

                rds_cluster_id = rds_cluster["DBClusterIdentifier"]
                activity_stream_mode = rds_cluster.get(
                    "ActivityStreamMode", "disabled")
                if activity_stream_mode != "disabled":
                    print(
                        f"  Processing RDS Cluster Activity Stream: {rds_cluster_id}")
                    attributes = {
                        "id": rds_cluster["DBClusterArn"],
                        "cluster_identifier": rds_cluster_id,
                        "activity_stream_mode": activity_stream_mode,
                        "activity_stream_kms_key_id": rds_cluster["ActivityStreamKmsKeyId"],
                    }
                    self.hcl.process_resource(
                        "aws_rds_cluster_activity_stream", rds_cluster_id.replace("-", "_"), attributes)

    def aws_rds_cluster_endpoint(self):
        print("Processing RDS Cluster Endpoints...")

        paginator = self.rds_client.get_paginator(
            "describe_db_cluster_endpoints")
        for page in paginator.paginate():
            for rds_cluster_endpoint in page.get("DBClusterEndpoints", []):
                if "DBClusterEndpointIdentifier" in rds_cluster_endpoint:
                    endpoint_id = rds_cluster_endpoint["DBClusterEndpointIdentifier"]
                    print(f"  Processing RDS Cluster Endpoint: {endpoint_id}")
                    attributes = {
                        "id": rds_cluster_endpoint["DBClusterEndpointArn"],
                        "endpoint_identifier": endpoint_id,
                        "cluster_identifier": rds_cluster_endpoint["DBClusterIdentifier"],
                        "endpoint_type": rds_cluster_endpoint["EndpointType"],
                        "custom_endpoint_type": rds_cluster_endpoint.get("CustomEndpointType"),
                    }
                    self.hcl.process_resource(
                        "aws_rds_cluster_endpoint", endpoint_id.replace("-", "_"), attributes)

    def aws_rds_cluster_instance(self):
        print("Processing RDS Cluster Instances...")

        paginator = self.rds_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for rds_instance in page.get("DBInstances", []):
                if "DBClusterIdentifier" in rds_instance and rds_instance["Engine"] in ["mysql", "postgres"]:
                    instance_id = rds_instance["DBInstanceIdentifier"]
                    print(f"  Processing RDS Cluster Instance: {instance_id}")
                    attributes = {
                        "id": rds_instance["DBInstanceArn"],
                        "instance_identifier": instance_id,
                        "cluster_identifier": rds_instance["DBClusterIdentifier"],
                        "instance_class": rds_instance["DBInstanceClass"],
                        "engine": rds_instance["Engine"],
                    }
                    self.hcl.process_resource(
                        "aws_rds_cluster_instance", instance_id.replace("-", "_"), attributes)

    def aws_rds_cluster_parameter_group(self):
        print("Processing RDS Cluster Parameter Groups...")

        paginator = self.rds_client.get_paginator(
            "describe_db_cluster_parameter_groups")
        for page in paginator.paginate():
            for rds_cluster_parameter_group in page.get("DBClusterParameterGroups", []):
                parameter_group_id = rds_cluster_parameter_group["DBClusterParameterGroupName"]
                print(
                    f"  Processing RDS Cluster Parameter Group: {parameter_group_id}")
                attributes = {
                    "id": rds_cluster_parameter_group["DBClusterParameterGroupArn"],
                    "name": parameter_group_id,
                    "family": rds_cluster_parameter_group["DBParameterGroupFamily"],
                    "description": rds_cluster_parameter_group["Description"],
                }
                self.hcl.process_resource(
                    "aws_rds_cluster_parameter_group", parameter_group_id.replace("-", "_"), attributes)

    def aws_rds_cluster_role_association(self):
        print("Processing RDS Cluster Role Associations...")

        paginator = self.rds_client.get_paginator("describe_db_clusters")
        for page in paginator.paginate():
            for rds_cluster in page.get("DBClusters", []):
                engine = rds_cluster.get("Engine", "")
                if engine not in ["mysql", "postgres"]:
                    continue

                cluster_id = rds_cluster["DBClusterIdentifier"]
                for associated_role in rds_cluster.get("AssociatedRoles", []):
                    role_arn = associated_role["RoleArn"]
                    role_name = role_arn.split("/")[-1]
                    association_id = f"{cluster_id}-{role_name}"
                    print(
                        f"  Processing RDS Cluster Role Association: {association_id}")
                    attributes = {
                        "id": association_id,
                        "cluster_identifier": cluster_id,
                        "role_arn": role_arn,
                    }
                    self.hcl.process_resource(
                        "aws_rds_cluster_role_association", association_id.replace("-", "_"), attributes)

    def aws_rds_export_task(self):
        print("Processing RDS Export Tasks...")

        paginator = self.rds_client.get_paginator("describe_export_tasks")
        for page in paginator.paginate():
            for export_task in page.get("ExportTasks", []):
                export_task_id = export_task["ExportTaskIdentifier"]
                print(f"  Processing RDS Export Task: {export_task_id}")
                attributes = {
                    "id": export_task_id,
                    "source_arn": export_task["SourceArn"],
                    "export_task_identifier": export_task_id,
                    "s3_bucket": export_task["S3Bucket"],
                    "s3_prefix": export_task["S3Prefix"],
                    "iam_role_arn": export_task["IamRoleArn"],
                    "kms_key_id": export_task["KmsKeyId"],
                    "export_only": export_task["ExportOnly"],
                }
                self.hcl.process_resource(
                    "aws_rds_export_task", export_task_id.replace("-", "_"), attributes)

    def aws_rds_global_cluster(self):
        print("Processing RDS Global Clusters...")

        paginator = self.rds_client.get_paginator("describe_global_clusters")
        for page in paginator.paginate():
            for global_cluster in page.get("GlobalClusters", []):
                global_cluster_id = global_cluster["GlobalClusterIdentifier"]
                print(f"  Processing RDS Global Cluster: {global_cluster_id}")
                attributes = {
                    "id": global_cluster["GlobalClusterArn"],
                    "global_cluster_identifier": global_cluster_id,
                    "engine": global_cluster["Engine"],
                    "engine_version": global_cluster["EngineVersion"],
                    "deletion_protection": global_cluster["DeletionProtection"],
                }
                self.hcl.process_resource(
                    "aws_rds_global_cluster", global_cluster_id.replace("-", "_"), attributes)

    def aws_rds_reserved_instance(self):
        print("Processing RDS Reserved Instances...")

        paginator = self.rds_client.get_paginator(
            "describe_reserved_db_instances")
        for page in paginator.paginate():
            for reserved_instance in page.get("ReservedDBInstances", []):
                reserved_instance_id = reserved_instance["ReservedDBInstanceId"]
                print(
                    f"  Processing RDS Reserved Instance: {reserved_instance_id}")
                attributes = {
                    "id": reserved_instance_id,
                    "db_instance_class": reserved_instance["DBInstanceClass"],
                    "duration": reserved_instance["Duration"],
                    "fixed_price": reserved_instance["FixedPrice"],
                    "instance_count": reserved_instance["DBInstanceCount"],
                    "start_time": reserved_instance["StartTime"].strftime("%Y-%m-%dT%H:%M:%SZ"),
                    "usage_price": reserved_instance["UsagePrice"],
                    "currency_code": reserved_instance["CurrencyCode"],
                    "offering_type": reserved_instance["OfferingType"],
                    "product_description": reserved_instance["ProductDescription"],
                }
                self.hcl.process_resource(
                    "aws_rds_reserved_instance", reserved_instance_id.replace("-", "_"), attributes)
