import os
from utils.hcl import HCL
from providers.aws.security_group import SECURITY_GROUP

class ElasticacheRedis:
    def __init__(self, aws_clients, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id,hcl = None):
        self.aws_clients = aws_clients
        self.transform_rules = {
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.aws_account_id = aws_account_id

        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name)

        self.hcl.region = region
        self.hcl.account_id = aws_account_id


        self.processed_subnet_groups = set()
        self.processed_parameter_groups = set()
        self.processed_security_groups = set()

        self.security_group_instance = SECURITY_GROUP(self.aws_clients, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)


    def get_subnet_names(self, subnet_ids):
        subnet_names = []
        for subnet_id in subnet_ids:
            response = self.aws_clients.ec2_client.describe_subnets(SubnetIds=[subnet_id])

            # Check if 'Subnets' key exists and it's not empty
            if not response or 'Subnets' not in response or not response['Subnets']:
                print(
                    f"No subnet information found for Subnet ID: {subnet_id}")
                continue

            # Extract the 'Tags' key safely using get
            subnet_tags = response['Subnets'][0].get('Tags', [])

            # Extract the subnet name from the tags
            subnet_name = next(
                (tag['Value'] for tag in subnet_tags if tag['Key'] == 'Name'), None)

            if subnet_name:
                subnet_names.append(subnet_name)
            else:
                print(f"No 'Name' tag found for Subnet ID: {subnet_id}")

        return subnet_names

    def get_vpc_name(self, vpc_id):
        response = self.aws_clients.ec2_client.describe_vpcs(VpcIds=[vpc_id])

        if not response or 'Vpcs' not in response or not response['Vpcs']:
            # Handle this case as required, for example:
            print(f"No VPC information found for VPC ID: {vpc_id}")
            return None

        vpc_tags = response['Vpcs'][0].get('Tags', [])
        vpc_name = next((tag['Value']
                        for tag in vpc_tags if tag['Key'] == 'Name'), None)

        if vpc_name is None:
            print(f"No 'Name' tag found for VPC ID: {vpc_id}")

        return vpc_name
        
    def ec_redis_get_vpc_name_by_subnet(self, subnet_ids):
        vpc_id = ""
        vpc_name = ""
        if subnet_ids:
            subnet_id = subnet_ids[0]
            #get the vpc id for the subnet_id
            response = self.aws_clients.ec2_client.describe_subnets(SubnetIds=[subnet_id])
            if not response or 'Subnets' not in response or not response['Subnets']:
                # Handle this case as required, for example:
                print(f"No subnet information found for Subnet ID: {subnet_id}")
                return None
            vpc_id = response['Subnets'][0].get('VpcId', None)

            if vpc_id:
                vpc_name = self.get_vpc_name(vpc_id)

        return vpc_id, vpc_name

    def elasticache_redis(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_elasticache_replication_group()
        self.hcl.refresh_state()

        self.hcl.request_tf_code()
        # self.hcl.module_hcl_code("terraform.tfstate","../providers/aws/", {}, self.region, self.aws_account_id)



    def aws_elasticache_replication_group(self):
        resource_type = "aws_elasticache_replication_group"
        print("Processing ElastiCache Replication Groups...")

        paginator = self.aws_clients.elasticache_client.get_paginator("describe_replication_groups")
        for page in paginator.paginate():
            for replication_group in page["ReplicationGroups"]:                
                # Skip the groups that are not Redis
                if "Engine" in replication_group and replication_group["Engine"] != "redis":
                    continue

                # if replication_group['ReplicationGroupId'] != "bpu-replication-group":
                #     continue

                print(f"  Processing ElastiCache Replication Group: {replication_group['ReplicationGroupId']}")
                id = replication_group["ReplicationGroupId"]

                ftstack = "elasticache_redis"
                try:
                    tags_response = self.aws_clients.elasticache_client.list_tags_for_resource(ResourceName=replication_group["ARN"])
                    tags = tags_response.get('TagList', [])
                    for tag in tags:
                        if tag['Key'] == 'ftstack':
                            if tag['Value'] != 'elasticache_redis':
                                ftstack = "stack_"+tag['Value']
                            break
                except Exception as e:
                    print("Error occurred: ", e)

                attributes = {
                    "id": id,
                    "replication_group_id": replication_group["ReplicationGroupId"],
                    "replication_group_description": replication_group["Description"],
                }

                self.hcl.process_resource(
                    resource_type, id, attributes)
                
                self.hcl.add_stack(resource_type, id, ftstack)

                # Process the member Cache Clusters
                for cache_cluster_id in replication_group["MemberClusters"]:
                    cache_cluster = self.aws_clients.elasticache_client.describe_cache_clusters(
                        CacheClusterId=cache_cluster_id)["CacheClusters"][0]

                    if "CacheSubnetGroupName" in cache_cluster and not cache_cluster["CacheSubnetGroupName"].startswith("default") and cache_cluster["CacheSubnetGroupName"] not in self.processed_subnet_groups:
                        self.aws_elasticache_subnet_group(
                            cache_cluster["CacheSubnetGroupName"])
                        self.processed_subnet_groups.add(
                            cache_cluster["CacheSubnetGroupName"])

                    if "CacheParameterGroup" in cache_cluster and "CacheParameterGroupName" in cache_cluster["CacheParameterGroup"] and not cache_cluster["CacheParameterGroup"]["CacheParameterGroupName"].startswith("default") and cache_cluster["CacheParameterGroup"]["CacheParameterGroupName"] not in self.processed_parameter_groups:
                        self.aws_elasticache_parameter_group(
                            cache_cluster["CacheParameterGroup"]["CacheParameterGroupName"])
                        self.processed_parameter_groups.add(
                            cache_cluster["CacheParameterGroup"]["CacheParameterGroupName"])

                    # Processing Security Groups
                    if "SecurityGroups" in cache_cluster:
                        for sg in cache_cluster["SecurityGroups"]:
                            if sg['Status'] == 'active' and sg['SecurityGroupId'] not in self.processed_security_groups:
                                # self.aws_security_group(
                                #     [sg['SecurityGroupId']])
                                self.security_group_instance.aws_security_group(sg['SecurityGroupId'], ftstack)
                                self.processed_security_groups.add(
                                    sg['SecurityGroupId'])


    def aws_elasticache_parameter_group(self, group_name):
        print(f"    Processing ElastiCache Parameter Group: {group_name}...")

        response = self.aws_clients.elasticache_client.describe_cache_parameter_groups(
            CacheParameterGroupName=group_name)

        for parameter_group in response["CacheParameterGroups"]:

            attributes = {
                "id": parameter_group["CacheParameterGroupName"],
                "name": parameter_group["CacheParameterGroupName"],
                "family": parameter_group["CacheParameterGroupFamily"],
                "description": parameter_group["Description"],
            }

            self.hcl.process_resource(
                "aws_elasticache_parameter_group", parameter_group["CacheParameterGroupName"].replace("-", "_"), attributes)

    def aws_elasticache_subnet_group(self, group_name):
        print(f"    Processing ElastiCache Subnet Group: {group_name}...")

        response = self.aws_clients.elasticache_client.describe_cache_subnet_groups(
            CacheSubnetGroupName=group_name)

        for subnet_group in response["CacheSubnetGroups"]:
            id = subnet_group["CacheSubnetGroupName"]
            attributes = {
                "id": id,
                "name": subnet_group["CacheSubnetGroupName"],
                "description": subnet_group["CacheSubnetGroupDescription"],
                "subnet_ids": [subnet["SubnetIdentifier"] for subnet in subnet_group["Subnets"]],
            }

            self.hcl.process_resource(
                "aws_elasticache_subnet_group", id, attributes)
            
            subnet_ids = [subnet["SubnetIdentifier"] for subnet in subnet_group["Subnets"]]
            subnet_names = self.get_subnet_names(subnet_ids)
            if subnet_names:
                self.hcl.add_additional_data("aws_elasticache_subnet_group", id, "subnet_names",  subnet_names)

            vpc_id, vpc_name = self.ec_redis_get_vpc_name_by_subnet(subnet_ids)
            if vpc_id:
                self.hcl.add_additional_data("aws_elasticache_subnet_group", id, "vpc_id",  vpc_id)
            if vpc_name:
                self.hcl.add_additional_data("aws_elasticache_subnet_group", id, "vpc_name",  vpc_name)

    # def aws_elasticache_user(self):
    #     print("Processing ElastiCache Users...")

    #     paginator = self.aws_clients.elasticache_client.get_paginator("describe_users")
    #     for page in paginator.paginate():
    #         for user in page["Users"]:
    #             print(f"  Processing ElastiCache User: {user['UserId']}")

    #             attributes = {
    #                 "id": user["UserId"],
    #                 "user_id": user["UserId"],
    #                 "user_name": user["UserName"],
    #                 "engine": user["Engine"],
    #             }

    #             if "AccessString" in user:
    #                 attributes["access_string"] = user["AccessString"]

    #             self.hcl.process_resource(
    #                 "aws_elasticache_user", user["UserId"].replace("-", "_"), attributes)

    # def aws_elasticache_user_group(self):
    #     print("Processing ElastiCache User Groups...")

    #     paginator = self.aws_clients.elasticache_client.get_paginator(
    #         "describe_user_groups")
    #     for page in paginator.paginate():
    #         for user_group in page["UserGroups"]:
    #             print(
    #                 f"  Processing ElastiCache User Group: {user_group['UserGroupId']}")

    #             attributes = {
    #                 "id": user_group["UserGroupId"],
    #                 "user_group_id": user_group["UserGroupId"],
    #                 "engine": user_group["Engine"],
    #                 "user_ids": user_group["UserIds"],
    #             }

    #             self.hcl.process_resource(
    #                 "aws_elasticache_user_group", user_group["UserGroupId"].replace("-", "_"), attributes)

    # def aws_elasticache_user_group_association(self):
    #     print("Processing ElastiCache User Group Associations...")

    #     paginator = self.aws_clients.elasticache_client.get_paginator(
    #         "describe_replication_groups")
    #     for page in paginator.paginate():
    #         for replication_group in page["ReplicationGroups"]:
    #             replication_group_id = replication_group["ReplicationGroupId"]

    #             if "UserGroupIds" in replication_group:
    #                 for user_group_id in replication_group["UserGroupIds"]:
    #                     print(
    #                         f"  Processing ElastiCache User Group Association: {replication_group_id} - {user_group_id}")

    #                     attributes = {
    #                         "id": f"{replication_group_id}:{user_group_id}",
    #                         "replication_group_id": replication_group_id,
    #                         "user_group_id": user_group_id,
    #                     }

    #                     self.hcl.process_resource(
    #                         "aws_elasticache_user_group_association", f"{replication_group_id}_{user_group_id}", attributes)
    #             else:
    #                 print(
    #                     f"  No User Group Associations found for ElastiCache Replication Group: {replication_group_id}")
