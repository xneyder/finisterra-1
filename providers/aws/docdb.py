import os
from utils.hcl import HCL


class DocDb:
    def __init__(self, docdb_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key):
        self.docdb_client = docdb_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key)
        self.resource_list = {}

    def docdb(self):
        self.hcl.prepare_folder(os.path.join("generated", "docdb"))

        self.aws_docdb_cluster()
        self.aws_docdb_cluster_instance()
        self.aws_docdb_cluster_parameter_group()
        self.aws_docdb_cluster_snapshot()
        self.aws_docdb_event_subscription()
        self.aws_docdb_global_cluster()
        self.aws_docdb_subnet_group()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_docdb_cluster(self):
        print("Processing DocumentDB Clusters...")

        paginator = self.docdb_client.get_paginator("describe_db_clusters")
        for page in paginator.paginate():
            for db_cluster in page["DBClusters"]:
                if db_cluster["Engine"] == "docdb":
                    print(
                        f"  Processing DocumentDB Cluster: {db_cluster['DBClusterIdentifier']}")

                    attributes = {
                        "id": db_cluster["DBClusterIdentifier"],
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
                        "instance_identifier": db_instance.get("DBInstanceIdentifier", None),
                        "cluster_identifier": db_instance.get("DBClusterIdentifier", None),
                        "instance_class": db_instance.get("DBInstanceClass", None),
                        "availability_zone": db_instance.get("AvailabilityZone", None),
                        "engine": db_instance.get("Engine", None),
                        "engine_version": db_instance.get("EngineVersion", None),
                        "status": db_instance.get("DBInstanceStatus", None),
                        "port": db_instance.get("DbInstancePort", None),
                    }
                    self.hcl.process_resource(
                        "aws_docdb_cluster_instance", db_instance["DBInstanceIdentifier"].replace("-", "_"), attributes)

    def aws_docdb_cluster_parameter_group(self):
        print("Processing DocumentDB Cluster Parameter Groups...")

        paginator = self.docdb_client.get_paginator(
            "describe_db_cluster_parameter_groups")
        for page in paginator.paginate():
            for parameter_group in page["DBClusterParameterGroups"]:
                # Check if it's a DocumentDB parameter group
                if "docdb" in parameter_group["DBParameterGroupFamily"]:
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
                if snapshot["Engine"] == "docdb":
                    print(
                        f"  Processing DocumentDB Cluster Snapshot: {snapshot['DBClusterSnapshotIdentifier']}")

                    attributes = {
                        "id": snapshot["DBClusterSnapshotIdentifier"],
                        "snapshot_identifier": snapshot.get("DBClusterSnapshotIdentifier", None),
                        "cluster_identifier": snapshot.get("DBClusterIdentifier", None),
                        "snapshot_type": snapshot.get("SnapshotType", None),
                        "engine": snapshot.get("Engine", None),
                        "engine_version": snapshot.get("EngineVersion", None),
                        "port": snapshot.get("Port", None),
                        "status": snapshot.get("Status", None),
                        "availability_zone": snapshot.get("AvailabilityZone", None),
                    }
                    self.hcl.process_resource(
                        "aws_docdb_cluster_snapshot", snapshot["DBClusterSnapshotIdentifier"].replace("-", "_"), attributes)

    def aws_docdb_event_subscription(self):
        print("Processing DocumentDB Event Subscriptions...")

        paginator = self.docdb_client.get_paginator(
            "describe_event_subscriptions")
        for page in paginator.paginate():
            for subscription in page["EventSubscriptionsList"]:
                print(
                    f"  Processing DocumentDB Event Subscription: {subscription['CustSubscriptionId']}")

                attributes = {
                    "id": subscription["CustSubscriptionId"],
                    "name": subscription.get("CustSubscriptionId", None),
                    "sns_topic_arn": subscription.get("CustomerAwsId", None),
                    "source_type": subscription.get("SourceType", None),
                    "event_categories": subscription.get("EventCategoriesList", None),
                    "enabled": subscription.get("Enabled", None),
                }
                self.hcl.process_resource(
                    "aws_docdb_event_subscription", subscription["CustSubscriptionId"].replace("-", "_"), attributes)

    def aws_docdb_global_cluster(self):
        print("Processing DocumentDB Global Clusters...")

        paginator = self.docdb_client.get_paginator("describe_db_clusters")
        for page in paginator.paginate():
            for cluster in page["DBClusters"]:
                if "GlobalClusterIdentifier" in cluster and cluster["Engine"] == "docdb":
                    print(
                        f"  Processing DocumentDB Global Cluster: {cluster['GlobalClusterIdentifier']}")

                    attributes = {
                        "id": cluster["GlobalClusterIdentifier"],
                        "global_cluster_identifier": cluster.get("GlobalClusterIdentifier", None),
                        "source_db_cluster_identifier": cluster.get("DBClusterIdentifier", None),
                        "engine": cluster.get("Engine", None),
                        "engine_version": cluster.get("EngineVersion", None),
                        "deletion_protection": cluster.get("DeletionProtection", None),
                    }
                    self.hcl.process_resource(
                        "aws_docdb_global_cluster", cluster["GlobalClusterIdentifier"].replace("-", "_"), attributes)

    def aws_docdb_subnet_group(self):
        print("Processing DocumentDB Subnet Groups...")

        paginator = self.docdb_client.get_paginator(
            "describe_db_subnet_groups")
        for page in paginator.paginate():
            for subnet_group in page["DBSubnetGroups"]:
                # Check if it's a DocumentDB subnet group
                if "DocumentDB" in subnet_group.get("DBSubnetGroupDescription", ""):
                    print(
                        f"  Processing DocumentDB Subnet Group: {subnet_group['DBSubnetGroupName']}")

                    attributes = {
                        "id": subnet_group["DBSubnetGroupName"],
                        "name": subnet_group.get("DBSubnetGroupName", None),
                        "description": subnet_group.get("DBSubnetGroupDescription", None),
                        "subnet_ids": [subnet['SubnetIdentifier'] for subnet in subnet_group.get("Subnets", [])],
                        "arn": subnet_group.get("DBSubnetGroupArn", None),
                    }
                    self.hcl.process_resource(
                        "aws_docdb_subnet_group", subnet_group["DBSubnetGroupName"].replace("-", "_"), attributes)
