import os
from utils.hcl import HCL
from providers.aws.iam_role import IAM_ROLE

class Aurora:
    def __init__(self, rds_client, logs_client, iam_client, appautoscaling_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl=None):
        self.rds_client = rds_client
        self.logs_client = logs_client
        self.iam_client = iam_client
        self.appautoscaling_client = appautoscaling_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data

        self.region = region
        self.aws_account_id = aws_account_id

        self.workspace_id = workspace_id
        self.modules = modules
        self.s3Bucket = s3Bucket
        self.dynamoDBTable = dynamoDBTable
        self.state_key = state_key

        
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        else:
            self.hcl = hcl

        self.iam_role_instance = IAM_ROLE(iam_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)

        self.resource_list = {}
        self.aws_rds_cluster_attrs = {}

    def init_cluster_attributes(self, attributes):
        self.aws_rds_cluster_attrs = attributes
        return None

    def get_instance_identifier(self, attributes):
        return attributes.get("identifier", None)

    def build_instances(self, attributes):
        result = {}
        identifier = attributes.get("identifier", None)
        result['identifier'] = identifier
        attrs_list = [
            "copy_tags_to_snapshot",
            "preferred_maintenance_window",
            "tags",
        ]
        for attr in attrs_list:
            child_value = attributes.get(attr, None)
            parent_value = self.aws_rds_cluster_attrs.get(attr, None)
            if child_value != parent_value:
                result[attr] = child_value

        instance_class = attributes.get("instance_class", None)
        if instance_class:
            result["instance_class"] = instance_class

        performance_insights_enabled = attributes.get(
            "performance_insights_enabled", False)
        if performance_insights_enabled:
            result["performance_insights_enabled"] = performance_insights_enabled
            performance_insights_kms_key_id = attributes.get(
                "performance_insights_kms_key_id", None)
            if performance_insights_kms_key_id:
                result["performance_insights_kms_key_id"] = performance_insights_kms_key_id
            performance_insights_retention_period = attributes.get(
                "performance_insights_retention_period", None)
            if performance_insights_retention_period:
                result["performance_insights_retention_period"] = performance_insights_retention_period
        publicly_accessible = attributes.get("publicly_accessible", False)
        if publicly_accessible:
            result["publicly_accessible"] = publicly_accessible

        monitoring_interval = attributes.get("monitoring_interval", 0)
        if monitoring_interval != 0:
            result["monitoring_interval"] = monitoring_interval

        apply_immediately = attributes.get("apply_immediately", False)
        if apply_immediately:
            result["apply_immediately"] = apply_immediately

        auto_minor_version_upgrade = attributes.get(
            "auto_minor_version_upgrade", True)
        if not auto_minor_version_upgrade:
            result["auto_minor_version_upgrade"] = auto_minor_version_upgrade

        # availability_zone = attributes.get("availability_zone", None)
        # if availability_zone:
        #     result["availability_zone"] = availability_zone

        promotion_tier = attributes.get("promotion_tier", None)
        if promotion_tier:
            result["promotion_tier"] = promotion_tier
        return {identifier: result}

    def build_cluster_endpoint(self, attributes):
        result = {}
        identifier = attributes.get("cluster_endpoint_identifier", None)
        type = attributes.get("cluster_endpoint_type", None)
        if type:
            result["type"] = type
        excluded_members = attributes.get('excluded_members', [])
        if excluded_members:
            result['excluded_members'] = excluded_members
        static_members = attributes.get('static_members', [])
        if static_members:
            result['static_members'] = static_members
        tags = attributes.get('tags', {})
        if tags:
            result['tags'] = tags

        return {identifier: result}

    def build_cluster_role_association(self, attributes):
        result = {}

        role_arn = attributes.get("role_arn", None)
        feature_name = attributes.get("feature_name", None)
        if feature_name:
            result["feature_name"] = feature_name

        return {role_arn: result}

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

    def build_resource_id(self, attributes):
        resource_id = attributes.get("resource_id", None)
        return f"cluster:{resource_id}"

    def get_field_from_attrs(self, attributes, arg):
        try:
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

        except Exception as e:
            return None

    def aurora(self):
        self.hcl.prepare_folder(os.path.join("generated", "aurora"))

        self.aws_rds_cluster()

        # self.aws_security_group()
        # self.aws_security_group_rule()

        functions = {
            'init_cluster_attributes': self.init_cluster_attributes,
            'build_instances': self.build_instances,
            'get_instance_identifier': self.get_instance_identifier,
            'build_cluster_endpoint': self.build_cluster_endpoint,
            'build_cluster_role_association': self.build_cluster_role_association,
            'cloudwatch_log_group_name': self.cloudwatch_log_group_name,
            'get_log_group_name': self.get_log_group_name,
            'build_resource_id': self.build_resource_id,
            'get_field_from_attrs': self.get_field_from_attrs,


        }

        self.hcl.refresh_state()
        self.hcl.module_hcl_code("terraform.tfstate",
                                 os.path.join(os.path.dirname(os.path.abspath(__file__)), "aurora.yaml"), functions, self.region, self.aws_account_id, {}, {})
        self.json_plan = self.hcl.json_plan

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

    def aws_appautoscaling_target(self, cluster_arn):
        print(
            f"Processing AppAutoScaling Targets for Aurora Cluster ARN {cluster_arn}...")

        paginator = self.appautoscaling_client.get_paginator(
            "describe_scalable_targets")
        page_iterator = paginator.paginate(
            ServiceNamespace='kafka',
            ResourceIds=[cluster_arn]
        )

        for page in page_iterator:
            for target in page["ScalableTargets"]:
                target_id = target["ResourceId"]
                print(f"  Processing AppAutoScaling Target: {target_id}")

                attributes = {
                    "id": target_id,
                    "service_namespace": 'kafka',
                    "resource_id": cluster_arn
                    # Add other relevant details from 'target' as needed
                }

                self.hcl.process_resource(
                    "aws_appautoscaling_target", target_id, attributes)

    def aws_appautoscaling_policy(self, cluster_arn):
        print(
            f"Processing AppAutoScaling Policies for Aurora Cluster ARN {cluster_arn}...")

        paginator = self.appautoscaling_client.get_paginator(
            "describe_scaling_policies")
        page_iterator = paginator.paginate(
            ServiceNamespace='kafka',
            ResourceId=cluster_arn
        )

        for page in page_iterator:
            for policy in page["ScalingPolicies"]:
                policy_name = policy["PolicyName"]
                print(f"  Processing AppAutoScaling Policy: {policy_name}")

                attributes = {
                    "id": policy_name,
                    "service_namespace": 'kafka',
                    "resource_id": cluster_arn
                    # Add other relevant details from 'policy' as needed
                }

                self.hcl.process_resource(
                    "aws_appautoscaling_policy", policy_name, attributes)

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
                    "vpc_security_group_ids": [sg["VpcSecurityGroupId"] for sg in instance.get("VpcSecurityGroups", [])],
                    "db_subnet_group_name": instance["DBSubnetGroup"]["DBSubnetGroupName"] if instance.get("DBSubnetGroup") else None,
                    "apply_immediately": instance.get("ApplyImmediately", False),
                    "delete_automated_backups": instance.get("DeleteAutomatedBackups", False),
                    "skip_final_snapshot": instance.get("SkipFinalSnapshot", False),
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

        # Get all DB Proxies
        db_proxies_response = self.rds_client.describe_db_proxies()
        db_proxies = db_proxies_response.get('DBProxies', [])

        for db_proxy in db_proxies:
            db_proxy_name = db_proxy.get('DBProxyName')

            # Describe target groups for each DB Proxy
            target_groups_response = self.rds_client.describe_db_proxy_target_groups(
                DBProxyName=db_proxy_name)
            target_groups = target_groups_response.get('TargetGroups', [])

            for target_group in target_groups:
                target_group_name = target_group.get("DBProxyName")
                print(
                    f"  Processing DB Proxy Default Target Group: {target_group_name}")
                attributes = {
                    "id": target_group.get("TargetGroupArn"),
                    "name": target_group_name,
                    "db_proxy_name": target_group.get("DBProxyName"),
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

        # Get all DB Proxies
        db_proxies_response = self.rds_client.describe_db_proxies()
        db_proxies = db_proxies_response.get('DBProxies', [])

        for db_proxy in db_proxies:
            db_proxy_name = db_proxy.get('DBProxyName')

            # Get paginator for each DB Proxy
            paginator = self.rds_client.get_paginator(
                "describe_db_proxy_targets")

            for page in paginator.paginate(DBProxyName=db_proxy_name):
                for db_proxy_target in page.get("Targets", []):
                    target_arn = db_proxy_target["TargetArn"]
                    print(f"  Processing DB Proxy Target: {target_arn}")
                    attributes = {
                        "id": target_arn,
                        "db_proxy_name": db_proxy_target["DBProxyName"],
                        "target_group_name": db_proxy_target["TargetGroupName"],
                        # Some targets might not be associated with a DB instance
                        "db_instance_identifier": db_proxy_target.get("DbInstanceIdentifier", None),
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
                    "id": db_snapshot_id,
                    # "snapshot_identifier": db_snapshot_id,
                    # "db_instance_identifier": db_snapshot["DBInstanceIdentifier"],
                    # "snapshot_type": db_snapshot["SnapshotType"],
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

    def aws_rds_cluster(self):
        print("Processing RDS Clusters...")

        paginator = self.rds_client.get_paginator("describe_db_clusters")
        for page in paginator.paginate():
            for rds_cluster in page.get("DBClusters", []):
                engine = rds_cluster.get("Engine", "")
                if not engine.startswith("aurora"):
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

                parameter_group_name = rds_cluster.get(
                    "DBClusterParameterGroupName", "")
                self.aws_rds_cluster_instance(rds_cluster_id)
                self.aws_rds_cluster_parameter_group(parameter_group_name)
                self.aws_rds_cluster_endpoint(rds_cluster_id)
                self.aws_rds_cluster_role_association(rds_cluster_id)
                # Call AppAutoScaling related functions
                self.aws_appautoscaling_target(rds_cluster_id)
                self.aws_appautoscaling_policy(rds_cluster_id)

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

    def aws_rds_cluster_endpoint(self, cluster_id):
        print("Processing RDS Cluster Endpoints...")

        paginator = self.rds_client.get_paginator(
            "describe_db_cluster_endpoints")
        for page in paginator.paginate():
            for rds_cluster_endpoint in page.get("DBClusterEndpoints", []):
                if rds_cluster_endpoint["DBClusterIdentifier"] != cluster_id:
                    continue
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

    def aws_rds_cluster_instance(self, cluster_id):
        print("Processing RDS Cluster Instances...")

        paginator = self.rds_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for rds_instance in page.get("DBInstances", []):
                if rds_instance.get("DBClusterIdentifier") != cluster_id:
                    continue
                if "DBClusterIdentifier" in rds_instance and rds_instance["Engine"].startswith("aurora"):
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

                    # Extract the DBSubnetGroupName and call the aws_db_subnet_group function
                    db_subnet_group_name = rds_instance.get(
                        "DBSubnetGroupName", "")
                    if db_subnet_group_name:
                        self.aws_db_subnet_group(db_subnet_group_name)

                    # Extract the DBParameterGroupName and call the aws_db_parameter_group function
                    db_parameter_group_name = rds_instance.get(
                        "DBParameterGroupName", "")
                    if db_parameter_group_name:
                        self.aws_db_parameter_group(db_parameter_group_name)

                    monitoring_role_arn = rds_instance.get("MonitoringRoleArn")
                    if monitoring_role_arn:
                        role_name = monitoring_role_arn.split('/')[-1]
                        self.iam_role_instance.aws_iam_role(role_name)
                        # self.aws_iam_role(monitoring_role_arn)

                    # call aws_cloudwatch_log_group function with instance_id and each log export name as parameters
                    for log_export_name in rds_instance.get("EnabledCloudwatchLogsExports", []):
                        self.aws_cloudwatch_log_group(
                            instance_id, log_export_name)

    def aws_rds_cluster_parameter_group(self, parameter_group_name):
        print("Processing RDS Cluster Parameter Groups...")

        paginator = self.rds_client.get_paginator(
            "describe_db_cluster_parameter_groups")
        for page in paginator.paginate():
            for rds_cluster_parameter_group in page.get("DBClusterParameterGroups", []):
                if rds_cluster_parameter_group["DBClusterParameterGroupName"] != parameter_group_name:
                    continue
                parameter_group_id = rds_cluster_parameter_group["DBClusterParameterGroupName"]
                print(
                    f"  Processing RDS Cluster Parameter Group: {parameter_group_id}")
                attributes = {
                    "id": parameter_group_id,
                    # "name": parameter_group_id,
                    # "family": rds_cluster_parameter_group["DBParameterGroupFamily"],
                    # "description": rds_cluster_parameter_group["Description"],
                }
                self.hcl.process_resource(
                    "aws_rds_cluster_parameter_group", parameter_group_id.replace("-", "_"), attributes)

    def aws_rds_cluster_role_association(self, cluster_id):
        print("Processing RDS Cluster Role Associations...")

        paginator = self.rds_client.get_paginator("describe_db_clusters")
        for page in paginator.paginate():
            for rds_cluster in page.get("DBClusters", []):
                if rds_cluster["DBClusterIdentifier"] != cluster_id:
                    continue
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

    def aws_security_group(self, security_group_ids):
        print("Processing Security Groups...")

        # Create a response dictionary to collect responses for all security groups
        response = self.ec2_client.describe_security_groups(
            GroupIds=security_group_ids
        )

        for security_group in response["SecurityGroups"]:
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
                "aws_security_group", security_group["GroupName"].replace("-", "_"), attributes)

            # Process egress rules
            for rule in security_group.get('IpPermissionsEgress', []):
                self.aws_security_group_rule(
                    'egress', security_group, rule)

            # Process ingress rules
            for rule in security_group.get('IpPermissions', []):
                self.aws_security_group_rule(
                    'ingress', security_group, rule)

    def aws_security_group_rule(self, rule_type, security_group, rule):
        # Rule identifiers are often constructed by combining security group id, rule type, protocol, ports and security group references
        rule_id = f"{security_group['GroupId']}_{rule_type}_{rule.get('IpProtocol', 'all')}"
        print(f"Processing Security Groups Rule {rule_id}...")
        if rule.get('FromPort'):
            rule_id += f"_{rule['FromPort']}"
        if rule.get('ToPort'):
            rule_id += f"_{rule['ToPort']}"

        attributes = {
            "id": rule_id,
            "type": rule_type,
            "security_group_id": security_group['GroupId'],
            "protocol": rule.get('IpProtocol', '-1'),  # '-1' stands for 'all'
            "from_port": rule.get('FromPort', 0),
            "to_port": rule.get('ToPort', 0),
            "cidr_blocks": [ip_range['CidrIp'] for ip_range in rule.get('IpRanges', [])],
            "source_security_group_ids": [sg['GroupId'] for sg in rule.get('UserIdGroupPairs', [])]
        }

        self.hcl.process_resource(
            "aws_security_group_rule", rule_id.replace("-", "_"), attributes)

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

    def aws_appautoscaling_target(self, cluster_identifier):
        cluster_identifier = f"cluster:{cluster_identifier}"
        print(
            f"Processing AppAutoScaling Targets for Aurora Cluster ARN {cluster_identifier}...")

        paginator = self.appautoscaling_client.get_paginator(
            "describe_scalable_targets")
        page_iterator = paginator.paginate(
            ServiceNamespace='kafka',
            ResourceIds=[cluster_identifier]
        )

        for page in page_iterator:
            for target in page["ScalableTargets"]:
                target_id = target["ResourceId"]
                print(f"  Processing AppAutoScaling Target: {target_id}")

                attributes = {
                    "id": target_id,
                    "service_namespace": 'kafka',
                    "resource_id": cluster_identifier
                    # Add other relevant details from 'target' as needed
                }

                self.hcl.process_resource(
                    "aws_appautoscaling_target", target_id, attributes)

    def aws_appautoscaling_policy(self, cluster_identifier):
        cluster_identifier = f"cluster:{cluster_identifier}"
        print(
            f"Processing AppAutoScaling Policies for Aurora Cluster ARN {cluster_identifier}...")

        paginator = self.appautoscaling_client.get_paginator(
            "describe_scaling_policies")
        page_iterator = paginator.paginate(
            ServiceNamespace='kafka',
            ResourceId=cluster_identifier
        )

        for page in page_iterator:
            for policy in page["ScalingPolicies"]:
                policy_name = policy["PolicyName"]
                print(f"  Processing AppAutoScaling Policy: {policy_name}")

                attributes = {
                    "id": policy_name,
                    "service_namespace": 'kafka',
                    "resource_id": cluster_identifier
                    # Add other relevant details from 'policy' as needed
                }

                self.hcl.process_resource(
                    "aws_appautoscaling_policy", policy_name, attributes)
