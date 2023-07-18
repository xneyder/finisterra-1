import os
from utils.hcl import HCL


class DocDb:
    def __init__(self, docdb_client, ec2_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.docdb_client = docdb_client
        self.ec2_client = ec2_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}

    def build_dict_var(self, attributes, arg):
        key = attributes[arg]
        result = {key: {}}
        for k, v in attributes.items():
            if v is not None:
                result[key][k] = v
        return result

    def match_security_group(self, parent_attributes, child_attributes):
        child_security_group_id = child_attributes.get("id", None)
        for security_group in parent_attributes.get("vpc_security_group_ids", []):
            if security_group == child_security_group_id:
                return True
        return False

    def docdb(self):
        self.hcl.prepare_folder(os.path.join("generated", "docdb"))

        # aws_docdb_cluster.default
        # aws_docdb_cluster_instance.default
        # aws_docdb_cluster_parameter_group.default
        # aws_docdb_subnet_group.default
        # aws_security_group.default
        # aws_security_group_rule.allow_ingress_from_self
        # aws_security_group_rule.egress
        # aws_security_group_rule.ingress_cidr_blocks
        # aws_security_group_rule.ingress_security_groups
        # random_password.password

        # self.aws_docdb_cluster_snapshot() #disbale because it can be too long and not really needed for modules
        # self.aws_docdb_event_subscription()
        # self.aws_docdb_global_cluster()

        self.aws_docdb_cluster()

        functions = {
            'build_dict_var': self.build_dict_var,
            'match_security_group': self.match_security_group,
        }

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "docdb.yaml"), functions)

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

                    # Call aws_docdb_cluster_instance with db_cluster as an argument
                    self.aws_docdb_cluster_instance(db_cluster)

                    # Call aws_security_group with the list of VpcSecurityGroups
                    vpc_security_group_ids = [sg["VpcSecurityGroupId"]
                                              for sg in db_cluster.get("VpcSecurityGroups", [])]
                    self.aws_security_group(vpc_security_group_ids)

    def aws_docdb_cluster_instance(self, db_cluster):
        print("Processing DocumentDB Cluster Instances...")

        paginator = self.docdb_client.get_paginator("describe_db_instances")
        for page in paginator.paginate():
            for db_instance in page["DBInstances"]:
                if db_instance["Engine"] == "docdb" and db_instance["DBClusterIdentifier"] == db_cluster["DBClusterIdentifier"]:
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

                    # Call aws_docdb_cluster_parameter_group if db_instance's DBParameterGroupName matches parameter_group in DBClusterParameterGroups
                    if db_instance.get('DBParameterGroups'):
                        for param_group in db_instance['DBParameterGroups']:
                            if param_group.get('DBParameterGroupName'):
                                self.aws_docdb_cluster_parameter_group(
                                    param_group['DBParameterGroupName'])

                    # Call aws_docdb_subnet_group if DBSubnetGroup of db_instance matches subnet_group in DBSubnetGroups
                    if db_instance.get('DBSubnetGroup', {}).get('DBSubnetGroupName'):
                        self.aws_docdb_subnet_group(
                            db_instance['DBSubnetGroup']['DBSubnetGroupName'])

    def aws_docdb_cluster_parameter_group(self, parameter_group_name):
        print("Processing DocumentDB Cluster Parameter Groups...")

        paginator = self.docdb_client.get_paginator(
            "describe_db_cluster_parameter_groups")
        for page in paginator.paginate():
            for parameter_group in page["DBClusterParameterGroups"]:
                if parameter_group['DBClusterParameterGroupName'] == parameter_group_name:
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

    def aws_docdb_subnet_group(self, subnet_group_name):
        print("Processing DocumentDB Subnet Groups...")

        paginator = self.docdb_client.get_paginator(
            "describe_db_subnet_groups")
        for page in paginator.paginate():
            for subnet_group in page["DBSubnetGroups"]:
                if subnet_group['DBSubnetGroupName'] == subnet_group_name:
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
