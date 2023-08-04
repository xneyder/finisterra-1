import os
from utils.hcl import HCL


class EKS:
    def __init__(self, eks_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.eks_client = eks_client
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

    def eks(self):
        self.hcl.prepare_folder(os.path.join("generated", "eks"))

        self.aws_eks_addon()
        self.aws_eks_cluster()
        self.aws_eks_fargate_profile()
        self.aws_eks_identity_provider_config()
        self.aws_eks_node_group()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_eks_addon(self):
        print("Processing EKS Add-ons...")

        clusters = self.eks_client.list_clusters()["clusters"]

        for cluster_name in clusters:
            addons = self.eks_client.list_addons(
                clusterName=cluster_name)["addons"]

            for addon_name in addons:
                addon = self.eks_client.describe_addon(
                    clusterName=cluster_name, addonName=addon_name)["addon"]
                print(
                    f"  Processing EKS Add-on: {addon_name} for Cluster: {cluster_name}")

                attributes = {
                    "id": cluster_name+":"+addon_name,
                    "addon_name": addon_name,
                    "cluster_name": cluster_name,
                }
                self.hcl.process_resource(
                    "aws_eks_addon", f"{cluster_name}-{addon_name}".replace("-", "_"), attributes)

    def aws_eks_cluster(self):
        print("Processing EKS Clusters...")

        clusters = self.eks_client.list_clusters()["clusters"]

        for cluster_name in clusters:
            cluster = self.eks_client.describe_cluster(name=cluster_name)[
                "cluster"]
            print(f"  Processing EKS Cluster: {cluster_name}")

            attributes = {
                "id": cluster_name,
                # "name": cluster_name,
                # "role_arn": cluster["roleArn"],
                # "vpc_config": {
                #     "subnet_ids": cluster["resourcesVpcConfig"]["subnetIds"],
                # },
            }
            self.hcl.process_resource(
                "aws_eks_cluster", cluster_name.replace("-", "_"), attributes)

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

    def aws_eks_identity_provider_config(self):
        print("Processing EKS Identity Provider Configs...")

        clusters = self.eks_client.list_clusters()["clusters"]

        for cluster_name in clusters:
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
