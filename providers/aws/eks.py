import os
from utils.hcl import HCL


class EKS:
    def __init__(self, eks_client, logs_client, ec2_client, iam_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.eks_client = eks_client
        self.logs_client = logs_client
        self.ec2_client = ec2_client
        self.iam_client = iam_client
        self.transform_rules = {
            "aws_eks_node_group": {
                "hcl_drop_fields": {"update_config.max_unavailable_percentage": 0, "update_config.max_unavailable_percentage": 0},
                "hcl_keep_fields": {
                    "launch_template.name": True,
                    "launch_template.version": True,
                },
            },
            "aws_eks_cluster": {
                "hcl_drop_fields": {"vpc_config.cluster_security_group_id": "ALL",
                                    "vpc_config.vpc_id": "ALL",
                                    },
            },

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
        self.aws_account_id = aws_account_id

    def get_field_from_attrs(self, attributes, arg):
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

    def build_cluster_addons(self, attributes):

        addon_name = attributes.get("addon_name")
        result = {}
        result[addon_name] = {}
        result[addon_name]['name'] = addon_name
        result[addon_name]['addon_version'] = attributes.get("addon_version")
        result[addon_name]['configuration_values'] = attributes.get(
            "configuration_values")
        result[addon_name]['preserve'] = attributes.get("preserve")
        result[addon_name]['resolve_conflicts'] = attributes.get(
            "resolve_conflicts")
        result[addon_name]['service_account_role_arn'] = attributes.get(
            "service_account_role_arn")

        # Remove the keys that are empty
        result[addon_name] = {k: v for k,
                              v in result[addon_name].items() if v is not None}
        return result

    def cloudwatch_log_group_name(self, attributes):
        # The name is expected to be in the format /aws/ecs/{cluster_name}
        name = attributes.get('name')
        if name is not None:
            # split the string by '/' and take the last part as the cluster_name
            parts = name.split('/')
            if len(parts) > 3:
                return parts[3]  # return 'cluster_name'
        # In case the name doesn't match the expected format, return None or you could return some default value
        return None

    def build_cluster_tags(self, attributes):
        key = attributes.get("key")
        value = attributes.get("value")
        return {key: value}

    def join_ec2_tag_resource_id(self, parent_attributes, child_attributes):
        vpc_config = parent_attributes.get("vpc_config")
        if vpc_config:
            cluster_security_group_id = vpc_config[0].get(
                "cluster_security_group_id")
        resource_id = child_attributes.get("resource_id")
        if cluster_security_group_id == resource_id:
            return True
        return False

    def join_eks_cluster_and_oidc_provider(self, parent_attributes, child_attributes):
        # Extract the expected OIDC issuer URL from the EKS cluster's attributes
        identity = parent_attributes.get("identity", [])
        if len(identity) == 0:
            return False

        expected_oidc_url = identity[0].get("oidc", [{}])[0].get("issuer", "")

        # Extract the URL for the OIDC provider from its attributes
        provider_url = child_attributes.get("url", "")

        # Check if the OIDC provider URL matches the one from the EKS cluster
        return provider_url == expected_oidc_url.replace("https://", "")

    def eks(self):
        self.hcl.prepare_folder(os.path.join("generated", "eks"))

        self.aws_eks_cluster()


# aws_ec2_tag
# aws_cloudwatch_log_group
# aws_security_group
# aws_security_group_rule
# aws_iam_openid_connect_provider
# aws_iam_role
# aws_iam_role_policy_attachment
# aws_iam_role_policy_attachment
# aws_iam_role_policy_attachment
# aws_iam_policy
# kubernetes_config_map
# kubernetes_config_map_v1_data

        # self.aws_eks_fargate_profile()
        # self.aws_eks_node_group()

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'build_cluster_addons': self.build_cluster_addons,
            'cloudwatch_log_group_name': self.cloudwatch_log_group_name,
            'join_ec2_tag_resource_id': self.join_ec2_tag_resource_id,
            'build_cluster_tags': self.build_cluster_tags,
            'join_eks_cluster_and_oidc_provider': self.join_eks_cluster_and_oidc_provider,
        }

        self.hcl.refresh_state()
        self.hcl.module_hcl_code("terraform.tfstate",
                                 os.path.join(os.path.dirname(os.path.abspath(__file__)), "eks.yaml"), functions, self.region, self.aws_account_id)
        self.json_plan = self.hcl.json_plan

    def aws_eks_cluster(self):
        print("Processing EKS Clusters...")

        clusters = self.eks_client.list_clusters()["clusters"]

        for cluster_name in clusters:
            cluster = self.eks_client.describe_cluster(name=cluster_name)[
                "cluster"]
            print(f"  Processing EKS Cluster: {cluster_name}")

            attributes = {
                "id": cluster_name,
            }
            self.hcl.process_resource(
                "aws_eks_cluster", cluster_name.replace("-", "_"), attributes)

            # Call aws_eks_addon for each cluster
            self.aws_eks_addon(cluster_name)

            # Call aws_eks_identity_provider_config for each cluster
            self.aws_eks_identity_provider_config(cluster_name)

            # Determine the log group name based on a naming convention
            log_group_name = f"/aws/eks/{cluster_name}/cluster"

            # Call aws_cloudwatch_log_group for each cluster's associated log group
            self.aws_cloudwatch_log_group(log_group_name)

            # Extract the security group ID
            security_group_id = cluster["resourcesVpcConfig"]["clusterSecurityGroupId"]
            self.aws_ec2_tag(security_group_id)

            # oidc irsa
            self.aws_iam_openid_connect_provider(cluster_name)

    def aws_eks_addon(self, cluster_name):
        print(f"Processing EKS Add-ons for Cluster: {cluster_name}...")

        addons = self.eks_client.list_addons(
            clusterName=cluster_name)["addons"]

        for addon_name in addons:
            addon = self.eks_client.describe_addon(
                clusterName=cluster_name, addonName=addon_name)["addon"]
            print(
                f"  Processing EKS Add-on: {addon_name} for Cluster: {cluster_name}")

            attributes = {
                "id": cluster_name + ":" + addon_name,
                "addon_name": addon_name,
                "cluster_name": cluster_name,
            }
            self.hcl.process_resource(
                "aws_eks_addon", f"{cluster_name}-{addon_name}".replace("-", "_"), attributes)

    def aws_iam_openid_connect_provider(self, cluster_name):
        print(
            f"Processing IAM OpenID Connect Providers for Cluster: {cluster_name}...")

        # Get cluster details to retrieve OIDC issuer URL
        cluster = self.eks_client.describe_cluster(name=cluster_name)[
            "cluster"]
        expected_oidc_url = cluster.get("identity", {}).get(
            "oidc", {}).get("issuer", "")

        expected_oidc_url = expected_oidc_url.replace("https://", "")

        # Ensure OIDC URL exists for the cluster
        if not expected_oidc_url:
            print(
                f"  Warning: No OIDC issuer URL found for Cluster: {cluster_name}")
            return

        # List the OIDC identity providers in the AWS account
        oidc_providers = self.iam_client.list_open_id_connect_providers().get(
            "OpenIDConnectProviderList", [])

        for provider in oidc_providers:
            provider_arn = provider["Arn"]

            # Describe the specific OIDC provider using its ARN
            oidc_provider = self.iam_client.get_open_id_connect_provider(
                OpenIDConnectProviderArn=provider_arn
            )

            # Extract the URL for the OIDC provider. This typically serves as a unique identifier.
            provider_url = oidc_provider.get("Url", "")

            # Check if this OIDC provider URL matches the one from the EKS cluster
            if provider_url != expected_oidc_url:
                continue  # Skip if it doesn't match

            print(
                f"  Processing IAM OpenID Connect Provider: {provider_url} for Cluster: {cluster_name}")

            attributes = {
                "id": provider_arn,  # Using the ARN as the unique identifier
                "url": provider_url
            }

            # Convert the provider ARN to a more suitable format for your naming convention if necessary
            resource_name = provider_arn.split(
                ":")[-1].replace(":", "_").replace("-", "_")

            self.hcl.process_resource(
                "aws_iam_openid_connect_provider", resource_name, attributes
            )

    def aws_eks_fargate_profile(self):
        print("Processing EKS Fargate Profiles...")

        clusters = self.eks_client.list_clusters()["clusters"]

        for cluster_name in clusters:
            fargate_profiles = self.eks_client.list_fargate_profiles(clusterName=cluster_name)[
                "fargateProfileNames"]

            for profile_name in fargate_profiles:
                fargate_profile = self.eks_client.describe_fargate_profile(
                    clusterName=cluster_name, fargateProfileName=profile_name)["fargateProfile"]
                print(
                    f"  Processing EKS Fargate Profile: {profile_name} for Cluster: {cluster_name}")

                attributes = {
                    "id": fargate_profile["fargateProfileArn"],
                    "fargate_profile_name": profile_name,
                    "cluster_name": cluster_name,
                }
                self.hcl.process_resource(
                    "aws_eks_fargate_profile", f"{cluster_name}-{profile_name}".replace("-", "_"), attributes)

    def aws_eks_identity_provider_config(self, cluster_name):
        print(
            f"Processing EKS Identity Provider Configs for Cluster: {cluster_name}...")

        identity_provider_configs = self.eks_client.list_identity_provider_configs(
            clusterName=cluster_name)["identityProviderConfigs"]

        for config in identity_provider_configs:
            config_name = config["name"]
            config_type = config["type"]
            print(
                f"  Processing EKS Identity Provider Config: {config_name} for Cluster: {cluster_name}")

            attributes = {
                "id": f"{cluster_name}:{config_name}",
                "name": config_name,
                "cluster_name": cluster_name,
            }
            self.hcl.process_resource(f"aws_eks_{config_type.lower()}_identity_provider_config",
                                      f"{cluster_name}-{config_name}".replace("-", "_"), attributes)

    def aws_cloudwatch_log_group(self, log_group_name):
        print(f"Processing CloudWatch Log Group...")

        paginator = self.logs_client.get_paginator('describe_log_groups')

        for page in paginator.paginate():
            for log_group in page['logGroups']:
                if log_group['logGroupName'] == log_group_name:
                    print(
                        f"  Processing CloudWatch Log Group: {log_group_name}")

                    # Prepare the attributes
                    attributes = {
                        "id": log_group_name,
                        "name": log_group_name,
                    }

                    # Process the resource
                    self.hcl.process_resource(
                        "aws_cloudwatch_log_group", log_group_name.replace("/", "_"), attributes)
                    return  # End the function once we've found the matching log group

        print(
            f"  Warning: No matching CloudWatch Log Group found: {log_group_name}")

    def aws_ec2_tag(self, resource_id):
        print(f"Processing EC2 Tags for Resource ID: {resource_id}")

        # Fetch the tags for the specified resource
        response = self.ec2_client.describe_tags(
            Filters=[
                {
                    'Name': 'resource-id',
                    'Values': [resource_id]
                }
            ]
        )

        # Extract tags from the response
        tags = response.get('Tags', [])

        # Process each tag
        for tag in tags:
            key = tag.get('Key')
            if key == "Name":
                continue
            value = tag.get('Value')

            # Prepare the attributes
            attributes = {
                "id": f"{resource_id},{key}",
                "key": key,
                "value": value,
                "resource_id": resource_id
            }

            # Process the resource
            self.hcl.process_resource("aws_ec2_tag",
                                      f"{resource_id}-{key}".replace("-", "_"),
                                      attributes)

            print(
                f"  Prepared tag for Resource {resource_id} with {key} = {value}")

    def aws_eks_node_group(self):
        print("Processing EKS Node Groups...")

        clusters = self.eks_client.list_clusters()["clusters"]

        for cluster_name in clusters:
            node_groups = self.eks_client.list_nodegroups(
                clusterName=cluster_name)["nodegroups"]

            for node_group_name in node_groups:
                node_group = self.eks_client.describe_nodegroup(
                    clusterName=cluster_name, nodegroupName=node_group_name)["nodegroup"]
                print(
                    f"  Processing EKS Node Group: {node_group_name} for Cluster: {cluster_name}")

                attributes = {
                    "id": cluster_name+":"+node_group_name,
                    "node_group_name": node_group_name,
                    "cluster_name": cluster_name,
                }
                self.hcl.process_resource(
                    "aws_eks_node_group", f"{cluster_name}-{node_group_name}".replace("-", "_"), attributes)
