def aws_docdb_cluster(self):
    print("Processing DocumentDB Clusters...")

    paginator = self.docdb_client.get_paginator("describe_db_clusters")
    for page in paginator.paginate():
        for db_cluster in page["DBClusters"]:
            print(
                f"  Processing DocumentDB Cluster: {db_cluster['DBClusterIdentifier']}")

            attributes = {
                "id": db_cluster["DBClusterIdentifier"],
                "cluster_identifier": db_cluster["DBClusterIdentifier"],
                "engine": db_cluster["Engine"],
                "engine_version": db_cluster["EngineVersion"],
                "status": db_cluster["Status"],
                "db_subnet_group": db_cluster["DBSubnetGroup"],
                "vpc_security_group_ids": db_cluster["VpcSecurityGroups"],
                "storage_encrypted": db_cluster["StorageEncrypted"],
                "kms_key_id": db_cluster["KmsKeyId"],
                "availability_zones": db_cluster["AvailabilityZones"],
                "port": db_cluster["Port"],
                "master_username": db_cluster["MasterUsername"],
            }
            self.hcl.process_resource(
                "aws_docdb_cluster", db_cluster["DBClusterIdentifier"].replace("-", "_"), attributes)


def aws_docdb_cluster_instance(self):
    print("Processing DocumentDB Cluster Instances...")

    paginator = self.docdb_client.get_paginator("describe_db_instances")
    for page in paginator.paginate():
        for db_instance in page["DBInstances"]:
            if db_instance["Engine"] == "docdb":
                print(
                    f"  Processing DocumentDB Cluster Instance: {db_instance['DBInstanceIdentifier']}")

                attributes = {
                    "id": db_instance["DBInstanceIdentifier"],
                    "instance_identifier": db_instance["DBInstanceIdentifier"],
                    "cluster_identifier": db_instance["DBClusterIdentifier"],
                    "instance_class": db_instance["DBInstanceClass"],
                    "availability_zone": db_instance["AvailabilityZone"],
                    "engine": db_instance["Engine"],
                    "engine_version": db_instance["EngineVersion"],
                    "status": db_instance["DBInstanceStatus"],
                    "port": db_instance["DbInstancePort"],
                }
                self.hcl.process_resource(
                    "aws_docdb_cluster_instance", db_instance["DBInstanceIdentifier"].replace("-", "_"), attributes)


def aws_docdb_cluster_parameter_group(self):
    print("Processing DocumentDB Cluster Parameter Groups...")

    paginator = self.docdb_client.get_paginator(
        "describe_db_cluster_parameter_groups")
    for page in paginator.paginate():
        for parameter_group in page["DBClusterParameterGroups"]:
            print(
                f"  Processing DocumentDB Cluster Parameter Group: {parameter_group['DBClusterParameterGroupName']}")

            attributes = {
                "id": parameter_group["DBClusterParameterGroupName"],
                "name": parameter_group["DBClusterParameterGroupName"],
                "family": parameter_group["DBParameterGroupFamily"],
                "description": parameter_group["Description"],
            }
            self.hcl.process_resource("aws_docdb_cluster_parameter_group",
                                      parameter_group["DBClusterParameterGroupName"].replace("-", "_"), attributes)


def aws_docdb_cluster_snapshot(self):
    print("Processing DocumentDB Cluster Snapshots...")

    paginator = self.docdb_client.get_paginator(
        "describe_db_cluster_snapshots")
    for page in paginator.paginate():
        for snapshot in page["DBClusterSnapshots"]:
            print(
                f"  Processing DocumentDB Cluster Snapshot: {snapshot['DBClusterSnapshotIdentifier']}")

            attributes = {
                "id": snapshot["DBClusterSnapshotIdentifier"],
                "snapshot_identifier": snapshot["DBClusterSnapshotIdentifier"],
                "cluster_identifier": snapshot["DBClusterIdentifier"],
                "snapshot_type": snapshot["SnapshotType"],
                "engine": snapshot["Engine"],
                "engine_version": snapshot["EngineVersion"],
                "port": snapshot["Port"],
                "status": snapshot["Status"],
                "availability_zone": snapshot["AvailabilityZone"],
            }
            self.hcl.process_resource(
                "aws_docdb_cluster_snapshot", snapshot["DBClusterSnapshotIdentifier"].replace("-", "_"), attributes)


def aws_docdb_event_subscription(self):
    print("Processing DocumentDB Event Subscriptions...")

    paginator = self.docdb_client.get_paginator("describe_event_subscriptions")
    for page in paginator.paginate():
        for subscription in page["EventSubscriptionsList"]:
            print(
                f"  Processing DocumentDB Event Subscription: {subscription['CustSubscriptionId']}")

            attributes = {
                "id": subscription["CustSubscriptionId"],
                "name": subscription["CustSubscriptionId"],
                "sns_topic_arn": subscription["CustomerAwsId"],
                "source_type": subscription["SourceType"],
                "event_categories": subscription["EventCategoriesList"],
                "enabled": subscription["Enabled"],
            }
            self.hcl.process_resource(
                "aws_docdb_event_subscription", subscription["CustSubscriptionId"].replace("-", "_"), attributes)


def aws_docdb_global_cluster(self):
    print("Processing DocumentDB Global Clusters...")

    paginator = self.docdb_client.get_paginator("describe_db_clusters")
    for page in paginator.paginate():
        for cluster in page["DBClusters"]:
            if "GlobalClusterIdentifier" in cluster:
                print(
                    f"  Processing DocumentDB Global Cluster: {cluster['GlobalClusterIdentifier']}")

                attributes = {
                    "id": cluster["GlobalClusterIdentifier"],
                    "global_cluster_identifier": cluster["GlobalClusterIdentifier"],
                    "source_db_cluster_identifier": cluster["DBClusterIdentifier"],
                    "engine": cluster["Engine"],
                    "engine_version": cluster["EngineVersion"],
                    "deletion_protection": cluster["DeletionProtection"],
                }
                self.hcl.process_resource(
                    "aws_docdb_global_cluster", cluster["GlobalClusterIdentifier"].replace("-", "_"), attributes)


def aws_docdb_subnet_group(self):
    print("Processing DocumentDB Subnet Groups...")

    paginator = self.docdb_client.get_paginator("describe_db_subnet_groups")
    for page in paginator.paginate():
        for subnet_group in page["DBSubnetGroups"]:
            print(
                f"  Processing DocumentDB Subnet Group: {subnet_group['DBSubnetGroupName']}")

            attributes = {
                "id": subnet_group["DBSubnetGroupArn"],
                "name": subnet_group["DBSubnetGroupName"],
                "description": subnet_group["DBSubnetGroupDescription"],
                "subnet_ids": [subnet["SubnetIdentifier"] for subnet in subnet_group["Subnets"]],
            }

            if "Tags" in subnet_group:
                attributes["tags"] = {tag["Key"]: tag["Value"]
                                      for tag in subnet_group["Tags"]}

            self.hcl.process_resource(
                "aws_docdb_subnet_group", subnet_group["DBSubnetGroupName"].replace("-", "_"), attributes)
