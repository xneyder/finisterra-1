import os
from utils.hcl import HCL
from providers.aws.iam_role import IAM_ROLE
from providers.aws.kms import KMS

class EKS:
    def __init__(self, eks_client, logs_client, ec2_client, iam_client, autoscaling_client, kms_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id,hcl = None):
        self.eks_client = eks_client
        self.logs_client = logs_client
        self.ec2_client = ec2_client
        self.iam_client = iam_client
        self.kms_client = kms_client
        self.autoscaling_client = autoscaling_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.modules = modules
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        else:
            self.hcl = hcl
        self.resource_list = {}
        self.aws_account_id = aws_account_id

        self.iam_role_instance = IAM_ROLE(iam_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)
        self.kms_instance = KMS(kms_client, iam_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)

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
        result[addon_name]['tags'] = attributes.get("tags")

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

    def join_node_group_launch_template(self, parent_attributes, child_attributes):
        node_launch_template_id=""
        launch_template =  parent_attributes.get("launch_template")
        if launch_template:
            node_launch_template_id = launch_template[0].get("id", "")
        launch_template_id = child_attributes.get("id", "")
        return node_launch_template_id == launch_template_id

    def join_node_group_autoscaling_schedule(self, parent_attributes, child_attributes):
        # Assuming parent_attributes contains a list of associated ASG names for the EKS node group.
        node_asg_names = parent_attributes.get("resources", {}).get(
            "autoScalingGroups", [{}])[0].get("name", "")

        # Assuming child_attributes contains the name of the ASG the schedule applies to.
        schedule_asg_name = child_attributes.get("autoscaling_group_name", "")

        return node_asg_names == schedule_asg_name

    def build_managed_node_groups(self, attributes):

        use_name_prefix = False
        node_group_name_prefix = attributes.get("node_group_name_prefix")
        if node_group_name_prefix:
            use_name_prefix = True
            if "-" in node_group_name_prefix:
                self.node_group_name = node_group_name_prefix.rsplit("-", 1)[0]
            else:
                self.node_group_name = node_group_name_prefix

        else:
            self.node_group_name = attributes.get("node_group_name")

        result = {self.node_group_name: {}}
        result[self.node_group_name]['use_name_prefix'] = use_name_prefix
        result[self.node_group_name]['subnet_ids'] = attributes.get(
            "subnet_ids")
        scaling_config = attributes.get("scaling_config")
        if scaling_config:
            result[self.node_group_name]['min_size'] = scaling_config[0].get("min_size")
            result[self.node_group_name]['max_size'] = scaling_config[0].get("max_size")
            result[self.node_group_name]['desired_size'] = scaling_config[0].get(
            "desired_size")        
        result[self.node_group_name]['ami_type'] = attributes.get("ami_type")
        result[self.node_group_name]['ami_release_version'] = attributes.get(
            "ami_release_version")
        result[self.node_group_name]['capacity_type'] = attributes.get(
            "capacity_type")
        result[self.node_group_name]['disk_size'] = attributes.get("disk_size")
        result[self.node_group_name]['force_update_version'] = attributes.get(
            "force_update_version")
        result[self.node_group_name]['instance_types'] = attributes.get(
            "instance_types")
        result[self.node_group_name]['labels'] = attributes.get("labels")
        tmp = attributes.get("remote_access")
        if tmp:
            result[self.node_group_name]['remote_access'] = attributes.get(
                "remote_access")[0]
        result[self.node_group_name]['taints'] = attributes.get("taint")
        result[self.node_group_name]['iam_role_arn'] = attributes.get("node_role_arn")

        if attributes.get("tags", {}) != {}:
            result[self.node_group_name]['tags'] = attributes.get("tags")
        tmp = attributes.get("update_config")
        if tmp:
            result[self.node_group_name]['update_config'] = attributes.get(
                "update_config")[0]
            # Remove the keys that are empty or 0
            result[self.node_group_name]['update_config'] = {k: v for k,
                                                             v in result[self.node_group_name]['update_config'].items() if v is not None and v != 0}
        result[self.node_group_name]['timeouts'] = attributes.get("timeouts")

        # Remove the keys that are empty
        result[self.node_group_name] = {k: v for k,
                                        v in result[self.node_group_name].items() if v is not None}
        
        #Get launch_template_version
        launch_template = attributes.get("launch_template")
        if launch_template:
            launch_template_version = launch_template[0].get("version")
            result[self.node_group_name]["launch_template_version"] = launch_template_version

        return result

    def build_block_device_mappings(self, block_device_mappings):
        result = {}
        for block_device in block_device_mappings:
            name = block_device.get("device_name")
            new_ebs={}
            
            for ebs in block_device.get("ebs", []):
                #remove any empty or null key
                for k,v in ebs.items():
                    if not v:
                        continue
                    elif k == "throughput":
                        if v == 0:
                            continue
                    elif k == "iops":
                        if v == 0:
                            continue
                    new_ebs[k] = v
            block_device["ebs"] = [new_ebs]
            #Remove the keys that are empty or null
            block_device = {k: v for k,
                            v in block_device.items() if v}
            result[name] = block_device
        return result

    def build_launch_templates(self, attributes):

        result = {self.node_group_name: {}}
        block_device_mappings = attributes.get("block_device_mappings")
        result[self.node_group_name]["block_device_mappings"] = self.build_block_device_mappings(
            block_device_mappings)
        result[self.node_group_name]["launch_template_tags"] = attributes.get(
            "tags")
        result[self.node_group_name]["tag_specifications"] = attributes.get("tag_specifications")
        tmp = attributes.get("name")
        if tmp:
            result[self.node_group_name]["launch_template_name"] = tmp
        tmp = attributes.get("ebs_optimized")
        if tmp:
            result[self.node_group_name]["ebs_optimized"] = tmp
        result[self.node_group_name]["key_name"] = attributes.get("key_name")
        result[self.node_group_name]["disable_api_termination"] = attributes.get(
            "disable_api_termination")
        result[self.node_group_name]["kernel_id"] = attributes.get("kernel_id")
        result[self.node_group_name]["ram_disk_id"] = attributes.get(
            "ram_disk_id")
        tmp = attributes.get("capacity_reservation_specification")
        if tmp:
            result[self.node_group_name]["capacity_reservation_specification"] = attributes.get(
                "capacity_reservation_specification")[0]
        tmp = attributes.get("cpu_options")
        if tmp:
            result[self.node_group_name]["cpu_options"] = attributes.get(
                "cpu_options")[0]
        tmp = attributes.get("credit_specification")
        if tmp:
            result[self.node_group_name]["credit_specification"] = attributes.get(
                "credit_specification")[0]
        tmp = attributes.get("elastic_gpu_specifications")
        if tmp:
            result[self.node_group_name]["elastic_gpu_specifications"] = attributes.get(
                "elastic_gpu_specifications")[0]
        tmp = attributes.get("elastic_inference_accelerator")
        if tmp:
            result[self.node_group_name]["elastic_inference_accelerator"] = attributes.get(
                "elastic_inference_accelerator")[0]
        tmp = attributes.get("enclave_options")
        if tmp:
            result[self.node_group_name]["enclave_options"] = attributes.get(
                "enclave_options")[0]
        tmp = attributes.get("instance_market_options")
        if tmp:
            result[self.node_group_name]["instance_market_options"] = attributes.get(
                "instance_market_options")[0]
        result[self.node_group_name]["license_specifications"] = attributes.get(
            "license_specifications")
        tmp = attributes.get("metadata_options")
        if tmp:
            #remove any empty or null keys
            result[self.node_group_name]["metadata_options"] = {k: v for k,
                                                                v in attributes.get("metadata_options")[0].items() if v}
        tmp = attributes.get("monitoring")
        if tmp:
            result[self.node_group_name]["enable_monitoring"] = tmp[0].get("enabled")
        tmp = attributes.get("network_interfaces")
        if tmp:
            new_val={}
            for k,v in tmp[0].items():
                if k == "interface_type" and not v:
                    continue
                if k == "private_ip_address" and not v:
                    continue
                new_val[k] = v
            result[self.node_group_name]["network_interfaces"] = [new_val]
            
        tmp = attributes.get("placement")
        if tmp:
            result[self.node_group_name]["placement"] = attributes.get("placement")[
                0]
        tmp = attributes.get("maintenance_options")
        if tmp:
            result[self.node_group_name]["maintenance_options"] = attributes.get(
                "maintenance_options")[0]
        tmp = attributes.get("private_dns_name_options")
        if tmp:
            result[self.node_group_name]["private_dns_name_options"] = attributes.get(
                "private_dns_name_options")[0]
        tmp = attributes.get("update_default_version")
        if tmp:
            result[self.node_group_name]["update_launch_template_default_version"] = tmp

        tmp = attributes.get("description")
        if tmp:
            result[self.node_group_name]["launch_template_description"] = tmp

        tmp = attributes.get("instance_type")
        if tmp:
            result[self.node_group_name]["instance_type"] = tmp
        
        tmp = attributes.get("user_data")
        if tmp:
            result[self.node_group_name]["user_data"] = tmp

        tmp = attributes.get("image_id")
        if tmp:
            result[self.node_group_name]["ami_id"] = tmp

        tmp = attributes.get("vpc_security_group_ids")
        if tmp:
            result[self.node_group_name]['vpc_security_group_ids'] = attributes.get(
                "vpc_security_group_ids")

        result[self.node_group_name]["use_custom_launch_template"] = True 
        
        # Remove the keys that are empty
        result[self.node_group_name] = {k: v for k,
                                        v in result[self.node_group_name].items() if v}
        return result

    def build_node_group_roles(self, attributes):
        result = {}
        result[self.node_group_name] = {}
        result[self.node_group_name]["iam_role_path"] = attributes.get("path")
        result[self.node_group_name]["iam_role_description"] = attributes.get(
            "description")
        result[self.node_group_name]["iam_role_tags"] = attributes.get("tags")

        # Remove the keys that are empty
        result[self.node_group_name] = {k: v for k,
                                        v in result[self.node_group_name].items() if v is not None}
        return result

    def build_node_group_role_policy_attachments(self, attributes):
        result = {}
        result[self.node_group_name] = {}
        policy_arn = attributes.get("policy_arn")
        if policy_arn:
            result[self.node_group_name]["iam_role_policy_attachments"] = {
                policy_arn: policy_arn}
        return result

    def build_node_group_autoscaling_schedules(self, attributes):
        result = {}
        result[self.node_group_name] = {}
        result[self.node_group_name]['schedules'] = {}
        result[self.node_group_name]['schedules']["min_size"] = attributes.get(
            "min_size")
        result[self.node_group_name]['schedules']["max_size"] = attributes.get(
            "max_size")
        result[self.node_group_name]['schedules']["desired_capacity"] = attributes.get(
            "desired_capacity")
        result[self.node_group_name]['schedules']["start_time"] = attributes.get(
            "start_time")
        result[self.node_group_name]['schedules']["end_time"] = attributes.get(
            "end_time")
        result[self.node_group_name]['schedules']["time_zone"] = attributes.get(
            "time_zone")

        # Remove the keys that are empty
        result[self.node_group_name]['schedules'] = {k: v for k,
                                                     v in result[self.node_group_name]['schedules'].items() if v is not None}

        return result

    def get_node_group_name(self, attributes):
        return self.node_group_name

    def eks(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_eks_cluster()


        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'build_cluster_addons': self.build_cluster_addons,
            'cloudwatch_log_group_name': self.cloudwatch_log_group_name,
            'join_ec2_tag_resource_id': self.join_ec2_tag_resource_id,
            'build_cluster_tags': self.build_cluster_tags,
            'join_eks_cluster_and_oidc_provider': self.join_eks_cluster_and_oidc_provider,
            'build_managed_node_groups': self.build_managed_node_groups,
            'join_node_group_launch_template': self.join_node_group_launch_template,
            'build_launch_templates': self.build_launch_templates,
            'build_node_group_roles': self.build_node_group_roles,
            'build_node_group_role_policy_attachments': self.build_node_group_role_policy_attachments,
            'join_node_group_autoscaling_schedule': self.join_node_group_autoscaling_schedule,
            'build_node_group_autoscaling_schedules': self.build_node_group_autoscaling_schedules,
            'get_node_group_name': self.get_node_group_name,
        }

        self.hcl.refresh_state()
        self.hcl.module_hcl_code("terraform.tfstate",
                                 os.path.join(os.path.dirname(os.path.abspath(__file__)), "eks.yaml"), functions, self.region, self.aws_account_id, {}, {})
        self.json_plan = self.hcl.json_plan

    def aws_eks_cluster(self):
        resource_name = 'aws_eks_cluster'
        print("Processing EKS Clusters...")

        clusters = self.eks_client.list_clusters()["clusters"]

        for cluster_name in clusters:
            cluster = self.eks_client.describe_cluster(name=cluster_name)[
                "cluster"]
            tags = cluster.get("tags", {})
            if tags.get("ftstack", "eks") != "eks":
                ftstack = "stack_"+tags.get("ftstack", "eks")
            
            # if cluster_name != "dev":
            #     continue

            print(f"  Processing EKS Cluster: {cluster_name}")
            id = cluster_name

            attributes = {
                "id": id,
            }
            self.hcl.process_resource(
                resource_name, cluster_name.replace("-", "_"), attributes)
            
            self.hcl.add_stack(resource_name, id, ftstack)
            
            #kms key
            if 'encryptionConfig' in cluster:
                self.kms_instance.aws_kms_key(cluster['encryptionConfig'][0]['provider']['keyArn'], ftstack)

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

            # eks node group
            self.aws_eks_node_group(cluster_name, ftstack)


    def aws_eks_addon(self, cluster_name):
        resource_name = 'aws_eks_addon'
        print(f"Processing EKS Add-ons for Cluster: {cluster_name}...")

        addons = self.eks_client.list_addons(
            clusterName=cluster_name)["addons"]

        for addon_name in addons:
            addon = self.eks_client.describe_addon(
                clusterName=cluster_name, addonName=addon_name)["addon"]
            print(
                f"  Processing EKS Add-on: {addon_name} for Cluster: {cluster_name}")

            id = cluster_name + ":" + addon_name
            attributes = {
                "id": id,
                "addon_name": addon_name,
                "cluster_name": cluster_name,
            }
            self.hcl.process_resource(
                resource_name, f"{cluster_name}-{addon_name}".replace("-", "_"), attributes)
            

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

    def aws_eks_node_group(self, cluster_name, ftstack):
        print("Processing EKS Node Groups...")

        clusters = self.eks_client.list_clusters()["clusters"]

        # Check if the provided cluster_name is in the list of clusters
        if cluster_name not in clusters:
            print(f"Cluster '{cluster_name}' not found!")
            return

        node_groups = self.eks_client.list_nodegroups(
            clusterName=cluster_name)["nodegroups"]

        for node_group_name in node_groups:
            node_group = self.eks_client.describe_nodegroup(
                clusterName=cluster_name, nodegroupName=node_group_name)["nodegroup"]
            print(
                f"  Processing EKS Node Group: {node_group_name} for Cluster: {cluster_name}")

            attributes = {
                "id": cluster_name + ":" + node_group_name,
                "node_group_name": node_group_name,
                "cluster_name": cluster_name,
            }
            self.hcl.process_resource(
                "aws_eks_node_group", f"{cluster_name}-{node_group_name}".replace("-", "_"), attributes)

            # If the node group has a launch template, process it
            if 'launchTemplate' in node_group and 'id' in node_group['launchTemplate']:
                self.aws_launch_template(node_group['launchTemplate']['id'])

            # Process IAM role associated with the EKS node group
            if 'nodeRole' in node_group:
                role_name = node_group['nodeRole'].split('/')[-1]
                self.iam_role_instance.aws_iam_role(role_name, ftstack)

            # Process Auto Scaling schedules for the node group's associated Auto Scaling group
            for asg in node_group.get('resources', {}).get('autoScalingGroups', []):
                self.aws_autoscaling_schedule(asg['name'])

    def aws_launch_template(self, launch_template_id):
        print("Processing AWS Launch Template...")

        # Describe the launch template using the provided ID
        response = self.ec2_client.describe_launch_templates(
            LaunchTemplateIds=[launch_template_id])

        # Check if we have the launch template in the response
        if 'LaunchTemplates' not in response or len(response['LaunchTemplates']) == 0:
            print(f"Launch template with ID '{launch_template_id}' not found!")
            return

        launch_template = response['LaunchTemplates'][0]

        print(
            f"  Processing Launch Template: {launch_template['LaunchTemplateName']} with ID: {launch_template_id}")

        attributes = {
            "id": launch_template_id,
            "name": launch_template['LaunchTemplateName'],
            "version": launch_template['DefaultVersionNumber'],
            # You can add other attributes from the launch_template as needed
        }

        self.hcl.process_resource(
            "aws_launch_template", f"{launch_template['LaunchTemplateName']}".replace("-", "_"), attributes)

    def aws_iam_role(self, role_arn):
        print(f"Processing IAM Role: {role_arn}...")

        role_name = role_arn.split('/')[-1]  # Extract role name from ARN

        # Ignore AWS service-linked roles
        if '/aws-service-role/' in role_arn:
            print(f"Ignoring service-linked role: {role_name}")
            return

        try:
            role = self.iam_client.get_role(RoleName=role_name)['Role']

            print(f"  Processing IAM Role: {role['Arn']}")

            attributes = {
                "id": role['RoleName'],
            }
            self.hcl.process_resource(
                "aws_iam_role", role['RoleName'], attributes)

            # Process IAM role policy attachments for the role
            self.aws_iam_role_policy_attachment(
                role['RoleName'])
        except Exception as e:
            print(f"Error processing IAM role: {role_name}: {str(e)}")

    def aws_iam_role_policy_attachment(self, role_name):
        print(
            f"Processing IAM Role Policy Attachments for role: {role_name}...")

        try:
            paginator = self.iam_client.get_paginator(
                'list_attached_role_policies')
            for page in paginator.paginate(RoleName=role_name):
                for policy in page['AttachedPolicies']:
                    print(
                        f"  Processing IAM Role Policy Attachment: {policy['PolicyName']} for role: {role_name}")

                    resource_name = f"{role_name}-{policy['PolicyName']}"
                    attributes = {
                        "id": f"{role_name}/{policy['PolicyArn']}",
                        "role": role_name,
                        "policy_arn": policy['PolicyArn']
                    }
                    self.hcl.process_resource(
                        "aws_iam_role_policy_attachment", resource_name, attributes)

        except Exception as e:
            print(
                f"Error processing IAM role policy attachments for role: {role_name}: {str(e)}")

    def aws_autoscaling_schedule(self, autoscaling_group_name):
        print(
            f"Processing Auto Scaling Schedules for Group: {autoscaling_group_name}...")

        try:
            # List all scheduled actions for the specified Auto Scaling group
            scheduled_actions = self.autoscaling_client.describe_scheduled_actions(
                AutoScalingGroupName=autoscaling_group_name)['ScheduledUpdateGroupActions']

            for action in scheduled_actions:
                print(
                    f"  Processing Auto Scaling Schedule: {action['ScheduledActionName']} for Group: {autoscaling_group_name}")

                attributes = {
                    "id": action['ScheduledActionName'],
                    "start_time": action.get('StartTime', ''),
                    "end_time": action.get('EndTime', ''),
                    # You can add more attributes as needed
                }
                self.hcl.process_resource(
                    "aws_autoscaling_schedule", action['ScheduledActionName'].replace("-", "_"), attributes)
        except Exception as e:
            print(
                f"Error processing Auto Scaling schedule for group {autoscaling_group_name}: {str(e)}")
