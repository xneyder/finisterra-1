import os
from utils.hcl import HCL


class Elasticache:
    def __init__(self, elasticache_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.elasticache_client = elasticache_client
        self.transform_rules = {
            "aws_elasticache_replication_group": {
                "hcl_keep_fields": {"description": True},
            },
            "aws_elasticache_cluster": {
                "hcl_keep_fields": {"engine": True},
            },
            "aws_elasticache_user": {
                "hcl_transform_fields": {
                    "engine": {'source': 'redis', 'target': 'REDIS'},
                },
                "hcl_drop_blocks": {"authentication_mode": {"type": "no-password"}},

            },
        }
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

    def elasticache(self):
        self.hcl.prepare_folder(os.path.join("generated", "elasticache"))

        # aws_cloudwatch_metric_alarm.cache_cpu
        # aws_cloudwatch_metric_alarm.cache_memory
        # aws_elasticache_parameter_group.default
        # aws_elasticache_replication_group.default
        # aws_elasticache_subnet_group.default

        self.aws_elasticache_cluster()
        self.aws_elasticache_global_replication_group()
        self.aws_elasticache_parameter_group()
        self.aws_elasticache_replication_group()
        self.aws_elasticache_subnet_group()
        self.aws_elasticache_user()
        self.aws_elasticache_user_group()
        self.aws_elasticache_user_group_association()

        functions = {}

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "elasticcache.yaml"), functions, self.region, self.aws_account_id)

        exit()

        self.json_plan = self.hcl.json_plan

    def aws_elasticache_cluster(self):
        print("Processing ElastiCache Clusters...")

        paginator = self.elasticache_client.get_paginator(
            "describe_cache_clusters")
        for page in paginator.paginate():
            for cluster in page["CacheClusters"]:
                print(
                    f"  Processing ElastiCache Cluster: {cluster['CacheClusterId']}")

                attributes = {
                    "id": cluster["CacheClusterId"],
                    "cache_cluster_id": cluster["CacheClusterId"],
                    "engine": cluster["Engine"],
                    "engine_version": cluster["EngineVersion"],
                    "num_cache_nodes": cluster["NumCacheNodes"],
                    "node_type": cluster["CacheNodeType"],
                }

                self.hcl.process_resource(
                    "aws_elasticache_cluster", cluster["CacheClusterId"].replace("-", "_"), attributes)

    def aws_elasticache_global_replication_group(self):
        print("Processing ElastiCache Global Replication Groups...")

        paginator = self.elasticache_client.get_paginator(
            "describe_global_replication_groups")
        for page in paginator.paginate():
            for global_replication_group in page["GlobalReplicationGroups"]:
                print(
                    f"  Processing ElastiCache Global Replication Group: {global_replication_group['GlobalReplicationGroupId']}")

                attributes = {
                    "id": global_replication_group["GlobalReplicationGroupId"],
                    "global_replication_group_id": global_replication_group["GlobalReplicationGroupId"],
                    "actual_engine_version": global_replication_group["ActualEngineVersion"],
                    "global_replication_group_description": global_replication_group["GlobalReplicationGroupDescription"],
                }

                self.hcl.process_resource(
                    "aws_elasticache_global_replication_group", global_replication_group["GlobalReplicationGroupId"].replace("-", "_"), attributes)

    def aws_elasticache_parameter_group(self):
        print("Processing ElastiCache Parameter Groups...")

        paginator = self.elasticache_client.get_paginator(
            "describe_cache_parameter_groups")
        for page in paginator.paginate():
            for parameter_group in page["CacheParameterGroups"]:
                print(
                    f"  Processing ElastiCache Parameter Group: {parameter_group['CacheParameterGroupName']}")

                attributes = {
                    "id": parameter_group["CacheParameterGroupName"],
                    "name": parameter_group["CacheParameterGroupName"],
                    "family": parameter_group["CacheParameterGroupFamily"],
                    "description": parameter_group["Description"],
                }

                self.hcl.process_resource(
                    "aws_elasticache_parameter_group", parameter_group["CacheParameterGroupName"].replace("-", "_"), attributes)

    def aws_elasticache_replication_group(self):
        print("Processing ElastiCache Replication Groups...")

        paginator = self.elasticache_client.get_paginator(
            "describe_replication_groups")
        for page in paginator.paginate():
            for replication_group in page["ReplicationGroups"]:
                print(
                    f"  Processing ElastiCache Replication Group: {replication_group['ReplicationGroupId']}")

                attributes = {
                    "id": replication_group["ReplicationGroupId"],
                    "replication_group_id": replication_group["ReplicationGroupId"],
                    "replication_group_description": replication_group["Description"],
                }

                if "CacheNodeType" in replication_group:
                    attributes["node_type"] = replication_group["CacheNodeType"]

                if "Engine" in replication_group:
                    attributes["engine"] = replication_group["Engine"]

                if "EngineVersion" in replication_group:
                    attributes["engine_version"] = replication_group["EngineVersion"]

                self.hcl.process_resource(
                    "aws_elasticache_replication_group", replication_group["ReplicationGroupId"].replace("-", "_"), attributes)

    def aws_elasticache_subnet_group(self):
        print("Processing ElastiCache Subnet Groups...")

        paginator = self.elasticache_client.get_paginator(
            "describe_cache_subnet_groups")
        for page in paginator.paginate():
            for subnet_group in page["CacheSubnetGroups"]:
                print(
                    f"  Processing ElastiCache Subnet Group: {subnet_group['CacheSubnetGroupName']}")

                attributes = {
                    "id": subnet_group["CacheSubnetGroupName"],
                    "name": subnet_group["CacheSubnetGroupName"],
                    "description": subnet_group["CacheSubnetGroupDescription"],
                    "subnet_ids": [subnet["SubnetIdentifier"] for subnet in subnet_group["Subnets"]],
                }

                self.hcl.process_resource(
                    "aws_elasticache_subnet_group", subnet_group["CacheSubnetGroupName"].replace("-", "_"), attributes)

    def aws_elasticache_user(self):
        print("Processing ElastiCache Users...")

        paginator = self.elasticache_client.get_paginator("describe_users")
        for page in paginator.paginate():
            for user in page["Users"]:
                print(f"  Processing ElastiCache User: {user['UserId']}")

                attributes = {
                    "id": user["UserId"],
                    "user_id": user["UserId"],
                    "user_name": user["UserName"],
                    "engine": user["Engine"],
                }

                if "AccessString" in user:
                    attributes["access_string"] = user["AccessString"]

                self.hcl.process_resource(
                    "aws_elasticache_user", user["UserId"].replace("-", "_"), attributes)

    def aws_elasticache_user_group(self):
        print("Processing ElastiCache User Groups...")

        paginator = self.elasticache_client.get_paginator(
            "describe_user_groups")
        for page in paginator.paginate():
            for user_group in page["UserGroups"]:
                print(
                    f"  Processing ElastiCache User Group: {user_group['UserGroupId']}")

                attributes = {
                    "id": user_group["UserGroupId"],
                    "user_group_id": user_group["UserGroupId"],
                    "engine": user_group["Engine"],
                    "user_ids": user_group["UserIds"],
                }

                self.hcl.process_resource(
                    "aws_elasticache_user_group", user_group["UserGroupId"].replace("-", "_"), attributes)

    def aws_elasticache_user_group_association(self):
        print("Processing ElastiCache User Group Associations...")

        paginator = self.elasticache_client.get_paginator(
            "describe_replication_groups")
        for page in paginator.paginate():
            for replication_group in page["ReplicationGroups"]:
                replication_group_id = replication_group["ReplicationGroupId"]

                if "UserGroupIds" in replication_group:
                    for user_group_id in replication_group["UserGroupIds"]:
                        print(
                            f"  Processing ElastiCache User Group Association: {replication_group_id} - {user_group_id}")

                        attributes = {
                            "id": f"{replication_group_id}:{user_group_id}",
                            "replication_group_id": replication_group_id,
                            "user_group_id": user_group_id,
                        }

                        self.hcl.process_resource(
                            "aws_elasticache_user_group_association", f"{replication_group_id}_{user_group_id}", attributes)
                else:
                    print(
                        f"  No User Group Associations found for ElastiCache Replication Group: {replication_group_id}")
