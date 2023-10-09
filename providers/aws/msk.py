import os
from utils.hcl import HCL


class MSK:
    def __init__(self, msk_client, ec2_client, appautoscaling_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.msk_client = msk_client
        self.ec2_client = ec2_client
        self.appautoscaling_client = appautoscaling_client
        self.aws_account_id = aws_account_id
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

    def get_server_properties(self, attributes, arg):
        server_properties_str = attributes.get(arg)

        if not server_properties_str:
            return None

        properties = {}
        lines = server_properties_str.split("\n")
        for line in lines:
            line = line.strip()  # Removing leading and trailing spaces
            if "=" in line:
                # Split only on the first equals sign
                key, value = line.split("=", 1)
                properties[key.strip()] = value.strip()

        return properties

    def get_subnet_names(self, attributes, arg):
        subnet_ids = self.get_field_from_attrs(
            attributes, 'broker_node_group_info.client_subnets')
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
            return self.get_field_from_attrs(attributes, 'broker_node_group_info.client_subnets')

    def get_vpc_id_internal(self, attributes):
        sg_ids = self.get_field_from_attrs(
            attributes, 'broker_node_group_info.security_groups')

        if not sg_ids:
            return None

        # Get the first security group ID
        first_sg_id = sg_ids[0]

        # Describe the security group to get its VPC ID
        response = self.ec2_client.describe_security_groups(GroupIds=[
                                                            first_sg_id])

        # Extract and return the VPC ID
        vpc_id = response["SecurityGroups"][0]["VpcId"]
        return vpc_id

    def get_vpc_name(self, attributes):
        vpc_id = self.get_vpc_id_internal(attributes)
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

    def get_vpc_id(self, attributes):
        vpc_name = self.get_vpc_name(attributes)
        if vpc_name is None:
            return self.get_vpc_id_internal(attributes)
        else:
            return ""

    def join_configuration(self, parent_attributes, child_attributes):
        configuration_arn = child_attributes.get('arn')
        cluster_configuration = self.get_field_from_attrs(
            parent_attributes, 'configuration_info.arn')
        if configuration_arn == cluster_configuration:
            return True
        return False

    def match_security_group(self, parent_attributes, child_attributes):
        child_security_group_id = child_attributes.get("id", None)
        security_groups = self.get_field_from_attrs(
            parent_attributes, "broker_node_group_info.security_groups")
        for security_group in security_groups:
            if security_group == child_security_group_id:
                return True
        return False

    def get_public_access_enabled(self, attributes, arg):
        public_access_type = self.get_field_from_attrs(attributes, arg)
        if public_access_type == "SERVICE_PROVIDED_EIPS":
            return True
        return False

    def get_security_group_names(self, attributes, arg):
        security_group_ids = self.get_field_from_attrs(attributes, arg)
        security_group_names = []

        for security_group_id in security_group_ids:
            response = self.ec2_client.describe_security_groups(
                GroupIds=[security_group_id])
            security_group = response['SecurityGroups'][0]

            security_group_name = security_group.get('GroupName')
            # Just to be extra safe, if GroupName is somehow missing, fall back to the security group ID
            if not security_group_name:
                security_group_name = security_group_id

            security_group_names.append(security_group_name)

        return security_group_names

    def aws_security_group_rule_import_id(self, attributes):
        security_group_id = attributes.get('security_group_id')
        type = attributes.get('type')
        protocol = attributes.get('protocol')
        from_port = attributes.get('from_port')
        to_port = attributes.get('to_port')
        cidr_blocks = attributes.get('cidr_blocks')
        source = "_".join(cidr_blocks)
        return security_group_id+"_"+type+"_"+protocol+"_"+str(from_port)+"_"+str(to_port)+"_"+source

    def get_security_group_rules(self, attributes, arg):
        key = attributes.get(arg)
        result = {key: {}}
        for k in ['type', 'description', 'from_port', 'to_port', 'protocol', 'cidr_blocks']:
            val = attributes.get(k)
            if isinstance(val, str):
                val = val.replace('${', '$${')
            result[key][k] = val
        return result

    def msk(self):
        self.hcl.prepare_folder(os.path.join("generated", "msk"))

        self.aws_msk_cluster()

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'get_subnet_names': self.get_subnet_names,
            'get_subnet_ids': self.get_subnet_ids,
            'join_configuration': self.join_configuration,
            'match_security_group': self.match_security_group,
            'get_server_properties': self.get_server_properties,
            'get_public_access_enabled': self.get_public_access_enabled,
            'get_vpc_name': self.get_vpc_name,
            'get_vpc_id': self.get_vpc_id,
            'get_security_group_names': self.get_security_group_names,
            'aws_security_group_rule_import_id': self.aws_security_group_rule_import_id,
            'get_security_group_rules': self.get_security_group_rules,

        }

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate",
                                 os.path.join(os.path.dirname(os.path.abspath(__file__)), "msk.yaml"), functions, self.region, self.aws_account_id)

        self.json_plan = self.hcl.json_plan

    def aws_msk_cluster(self):
        print("Processing MSK Clusters...")

        # Pagination for list_clusters, if applicable
        paginator = self.msk_client.get_paginator("list_clusters")
        page_iterator = paginator.paginate()

        for page in page_iterator:
            for cluster_info in page["ClusterInfoList"]:
                cluster_arn = cluster_info["ClusterArn"]
                cluster_name = cluster_info["ClusterName"]
                print(f"  Processing MSK Cluster: {cluster_name}")

                attributes = {
                    "id": cluster_arn,
                    "arn": cluster_arn,
                    "name": cluster_name,
                }

                self.hcl.process_resource(
                    "aws_msk_cluster", cluster_name, attributes)

                # Extracting the Security Group IDs for the MSK Cluster
                cluster_details = self.msk_client.describe_cluster(
                    ClusterArn=cluster_arn
                )

                sg_ids = cluster_details["ClusterInfo"]["BrokerNodeGroupInfo"]["SecurityGroups"]

                # Calling aws_security_group function with the extracted SG IDs
                self.aws_security_group(sg_ids)

                self.aws_msk_configuration(cluster_arn)
                self.aws_msk_scram_secret_association(cluster_arn)
                self.aws_appautoscaling_target(cluster_arn)
                self.aws_appautoscaling_policy(cluster_arn)

    def aws_msk_scram_secret_association(self, cluster_arn):
        print(
            f"Processing SCRAM Secret Associations for Cluster {cluster_arn}...")

        # Not all MSK methods might support pagination, so ensure this one does.
        secrets = self.msk_client.list_scram_secrets(
            ClusterArn=cluster_arn
        )

        for secret in secrets.get("SecretArnList", []):
            print(f"  Processing SCRAM Secret: {secret}")

            attributes = {
                "id": secret,
                "arn": secret,
                "cluster_arn": cluster_arn,
                'get_vpc_name': self.get_vpc_name,
                'get_vpc_id': self.get_vpc_id,
            }

            self.hcl.process_resource(
                "aws_msk_scram_secret_association", secret, attributes)

    def aws_appautoscaling_target(self, cluster_arn):
        print(
            f"Processing AppAutoScaling Targets for MSK Cluster ARN {cluster_arn}...")

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
            f"Processing AppAutoScaling Policies for MSK Cluster ARN {cluster_arn}...")

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

    def aws_msk_configuration(self, cluster_arn):
        print(f"Processing MSK Configuration for Cluster {cluster_arn}...")

        cluster_details = self.msk_client.describe_cluster(
            ClusterArn=cluster_arn
        )

        configuration_arn = cluster_details["ClusterInfo"]["CurrentBrokerSoftwareInfo"]["ConfigurationArn"]

        # Get the configuration details using the configuration ARN
        configuration = self.msk_client.describe_configuration(
            Arn=configuration_arn
        )

        config_name = configuration["Name"]

        print(f"  Processing MSK Configuration: {config_name}")

        attributes = {
            "id": configuration_arn,
            "arn": configuration_arn,
            "name": config_name,
        }

        self.hcl.process_resource(
            "aws_msk_configuration", config_name, attributes)

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