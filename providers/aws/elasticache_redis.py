import os
from utils.hcl import HCL
from providers.aws.security_group import SECURITY_GROUP

class ElasticacheRedis:
    def __init__(self, elasticache_client, ec2_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.elasticache_client = elasticache_client
        self.ec2_client = ec2_client
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

        self.processed_subnet_groups = set()
        self.processed_parameter_groups = set()
        self.processed_security_groups = set()

        self.security_group_instance = SECURITY_GROUP(ec2_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)

    def match_security_group(self, parent_attributes, child_attributes):
        child_security_group_id = child_attributes.get("id", None)
        for security_group in parent_attributes.get("security_group_ids", []):
            if security_group == child_security_group_id:
                return True
        return False

    def auto_minor_version_upgrade(self, attributes):
        auto_minor_version_upgrade = attributes.get(
            "auto_minor_version_upgrade", None)
        if auto_minor_version_upgrade:
            return bool(auto_minor_version_upgrade)
        return None

    def build_dict_var(self, attributes, arg):
        key = attributes[arg]
        result = {key: {}}
        for k, v in attributes.items():
            if v is not None:
                result[key][k] = v
        return result

    def get_subnet_names(self, attributes, arg):
        subnet_ids = attributes.get(arg)
        subnet_names = []
        for subnet_id in subnet_ids:
            response = self.ec2_client.describe_subnets(SubnetIds=[subnet_id])

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

    def get_subnet_ids(self, attributes, arg):
        subnet_names = self.get_subnet_names(attributes, arg)
        if subnet_names:
            return ""
        else:
            return attributes.get(arg)

    def get_vpc_name(self, attributes, arg):
        vpc_id = attributes.get(arg)
        response = self.ec2_client.describe_vpcs(VpcIds=[vpc_id])

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

    def get_vpc_id(self, attributes, arg):
        vpc_name = self.get_vpc_name(attributes, arg)
        if vpc_name is None:
            return attributes.get(arg)
        else:
            return ""
        
    def get_security_group_names(self, attributes, arg):
        security_group_ids = attributes.get(arg)
        result=[]
        for security_group_id in security_group_ids:
            response = self.ec2_client.describe_security_groups(GroupIds=[security_group_id])
            if not response or 'SecurityGroups' not in response or not response['SecurityGroups']:
                # Handle this case as required, for example:
                print(f"No security group information found for Security Group ID: {security_group_id}")
                continue
            #just get the security group name and not the Name tag
            security_group_name = response['SecurityGroups'][0].get('GroupName', None)
            if security_group_name is None:
                print(f"No 'name found for Security Group ID: {security_group_id}")
            else:
                result.append(security_group_name)
        return result
        
    def get_vpc_name_by_subnet(self, attributes, arg):
        subnet_ids = attributes.get("subnet_ids")
        if subnet_ids:
            subnet_id = subnet_ids[0]
            #get the vpc id for the subnet_id
            response = self.ec2_client.describe_subnets(SubnetIds=[subnet_id])
            if not response or 'Subnets' not in response or not response['Subnets']:
                # Handle this case as required, for example:
                print(f"No subnet information found for Subnet ID: {subnet_id}")
                return None
            vpc_id = response['Subnets'][0].get('VpcId', None)

        response = self.ec2_client.describe_vpcs(VpcIds=[vpc_id])

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

    def get_vpc_id_by_subnet(self, attributes, arg):
        vpc_name = self.get_vpc_name_by_subnet(attributes, arg)
        if vpc_name is None:
            return attributes.get(arg)
        else:
            return ""        

    def get_security_group_rules(self, attributes, arg):
        key = attributes[arg]
        result = {key: {}}
        for k in ['type', 'description', 'from_port', 'to_port', 'protocol', 'cidr_blocks']:
            val = attributes.get(k)
            if isinstance(val, str):
                val = val.replace('${', '$${')
            result[key][k] = val
        return result

    def aws_security_group_rule_import_id(self, attributes):
        security_group_id = attributes.get('security_group_id')
        type = attributes.get('type')
        protocol = attributes.get('protocol')
        from_port = attributes.get('from_port')
        to_port = attributes.get('to_port')
        cidr_blocks = attributes.get('cidr_blocks')
        source = "_".join(cidr_blocks)
        return security_group_id+"_"+type+"_"+protocol+"_"+str(from_port)+"_"+str(to_port)+"_"+source

    def elasticache_redis(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        # aws_cloudwatch_metric_alarm.cache_cpu
        # aws_cloudwatch_metric_alarm.cache_memory
        # aws_elasticache_parameter_group.default
        # aws_elasticache_replication_group.default
        # aws_elasticache_subnet_group.default

        # self.aws_elasticache_cluster()
        # self.aws_elasticache_global_replication_group()
        self.aws_elasticache_replication_group()
        # self.aws_elasticache_user()
        # self.aws_elasticache_user_group()
        # self.aws_elasticache_user_group_association()

        functions = {
            # 'match_security_group': self.match_security_group,
            'auto_minor_version_upgrade': self.auto_minor_version_upgrade,
            'build_dict_var': self.build_dict_var,
            'get_subnet_names': self.get_subnet_names,
            'get_vpc_name': self.get_vpc_name,
            'get_vpc_name_by_subnet': self.get_vpc_name_by_subnet,
            # 'get_security_group_rules': self.get_security_group_rules,
            'get_subnet_ids': self.get_subnet_ids,
            'get_vpc_id': self.get_vpc_id,
            'get_vpc_id_by_subnet': self.get_vpc_id_by_subnet,
            'get_security_group_names': self.get_security_group_names,
            # 'aws_security_group_rule_import_id': self.aws_security_group_rule_import_id,
        }

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "elasticcache_redis.yaml"), functions, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan


    def aws_elasticache_replication_group(self):
        resource_type = "aws_elasticache_replication_group"
        print("Processing ElastiCache Replication Groups...")

        paginator = self.elasticache_client.get_paginator("describe_replication_groups")
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
                    tags_response = self.elasticache_client.list_tags_for_resource(ResourceName=replication_group["ARN"])
                    tags = tags_response.get('TagList', [])
                    for tag in tags:
                        if tag['Key'] == 'ftstack':
                            ftstack = tag['Value']
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
                    cache_cluster = self.elasticache_client.describe_cache_clusters(
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

        response = self.elasticache_client.describe_cache_parameter_groups(
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

        response = self.elasticache_client.describe_cache_subnet_groups(
            CacheSubnetGroupName=group_name)

        for subnet_group in response["CacheSubnetGroups"]:
            attributes = {
                "id": subnet_group["CacheSubnetGroupName"],
                "name": subnet_group["CacheSubnetGroupName"],
                "description": subnet_group["CacheSubnetGroupDescription"],
                "subnet_ids": [subnet["SubnetIdentifier"] for subnet in subnet_group["Subnets"]],
            }

            self.hcl.process_resource(
                "aws_elasticache_subnet_group", subnet_group["CacheSubnetGroupName"].replace("-", "_"), attributes)

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
    # def aws_elasticache_user(self):
    #     print("Processing ElastiCache Users...")

    #     paginator = self.elasticache_client.get_paginator("describe_users")
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

    #     paginator = self.elasticache_client.get_paginator(
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

    #     paginator = self.elasticache_client.get_paginator(
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
