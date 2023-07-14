import os
from utils.hcl import HCL
import json


class ECS:
    def __init__(self, ecs_client, logs_client, appautoscaling_client, iam_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.ecs_client = ecs_client
        self.logs_client = logs_client
        self.appautoscaling_client = appautoscaling_client
        self.iam_client = iam_client
        self.transform_rules = {
            "aws_ecs_task_definition": {
                "hcl_json_multiline": {"container_definitions": True}
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

    def cloudwatch_log_group_name(self, attributes):
        # The name is expected to be in the format /aws/ecs/{cluster_name}
        name = attributes.get('name')
        if name is not None:
            # split the string by '/' and take the last part as the cluster_name
            parts = name.split('/')
            if len(parts) > 2:
                return parts[-1]  # return 'cluster_name'
        # In case the name doesn't match the expected format, return None or you could return some default value
        return None

    def to_map(self, attributes, arg):
        if arg in attributes:
            if len(attributes[arg]) > 0:
                return attributes[arg][0]
        return None

    def aws_ecs_service_cluster_arn(self, attributes):
        return attributes.get('cluster')

    def get_field_from_attrs(self, attributes, arg):
        return attributes.get(arg)

    def get_arn(self, attributes):
        return attributes.get('arn')

    def get_network_field(self, attributes, field):
        if 'network_configuration' in attributes:
            network_configuration = attributes['network_configuration'][0]
            if field in network_configuration:
                return network_configuration[field]
        return None

    def check_subnet_ids(self, attributes):
        if 'network_configuration' in attributes:
            if len(attributes['network_configuration']) > 0:
                network_configuration = attributes['network_configuration'][0]
                if 'subnet_ids' in network_configuration:
                    return True
        return False

    def task_definition_id(self, attributes):
        # The name is expected to be in the format /aws/ecs/{cluster_name}
        arn = attributes.get('arn')
        if arn is not None:
            # split the string by '/' and take the last part as the cluster_arn
            return arn.split('/')[-1]
        return None

    def container_definitions(self, attributes):
        result = {}
        container_definitions_str = attributes.get(
            'container_definitions', '[]')
        try:
            container_definitions = json.loads(container_definitions_str)
        except json.JSONDecodeError:
            print("Error: container_definitions is not a valid JSON string")
            return result

        for container in container_definitions:
            result[container['name']] = container
        return result

    def task_definition_volume(self, attributes):
        result = {}
        volumes = attributes.get('volume')

        for volume in volumes:
            cleaned_volume = {k: v for k, v in volume.items() if v != []}
            result[cleaned_volume['name']] = cleaned_volume

        return result

    def tasks_iam_role_policies(self, attributes):
        result = {}
        policy_arn = attributes.get('policy_arn', "")
        if policy_arn != "":
            name = policy_arn.split('/')[-1]
            result[name] = policy_arn
        return result

    # def get_name_from_arn(self, attributes, arg):
    #     arn = attributes.get(arg)
    #     if arn is not None:
    #         # split the string by '/' and take the last part as the cluster_arn
    #         return arn.split('/')[-1]
    #     return None

    def ecs(self):
        self.hcl.prepare_folder(os.path.join("generated", "ecs"))

        self.aws_ecs_cluster()
        # self.aws_ecs_task_definition() # TO REMOVE COMMENT

        # self.aws_ecs_account_setting_default()
        # self.aws_ecs_capacity_provider()
        # self.aws_ecs_cluster_capacity_providers()
        # self.aws_ecs_service()
        # # self.aws_ecs_tag()
        # self.aws_ecs_task_definition()
        # if "gov" not in self.region:
        #     self.aws_ecs_task_set()

        self.hcl.refresh_state()

        functions = {
            'cloudwatch_log_group_name': self.cloudwatch_log_group_name,
            'to_map': self.to_map,
            'aws_ecs_service_cluster_arn': self.aws_ecs_service_cluster_arn,
            'check_subnet_ids': self.check_subnet_ids,
            'task_definition_id': self.task_definition_id,
            'container_definitions': self.container_definitions,
            'task_definition_volume': self.task_definition_volume,
            'get_arn': self.get_arn,
            'get_field_from_attrs': self.get_field_from_attrs,
            'tasks_iam_role_policies': self.tasks_iam_role_policies,
            # 'get_name_from_arn': self.get_name_from_arn,
        }

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "aws_ecs_cluster.yaml"), functions)

        exit()
        # self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_ecs_cluster(self):
        print("Processing ECS Clusters...")

        clusters_arns = self.ecs_client.list_clusters()["clusterArns"]
        clusters = self.ecs_client.describe_clusters(
            clusters=clusters_arns)["clusters"]

        for cluster in clusters:
            cluster_name = cluster["clusterName"]
            cluster_arn = cluster["clusterArn"]

            print(f"  Processing ECS Cluster: {cluster_name}")

            attributes = {
                "id": cluster_name,
                "name": cluster_name,
            }
            self.hcl.process_resource(
                "aws_ecs_cluster", cluster_name.replace("-", "_"), attributes)

            self.aws_cloudwatch_log_group(cluster_name)
            self.aws_ecs_cluster_capacity_providers(cluster_name)
            self.aws_ecs_capacity_provider(cluster_name)
            self.aws_ecs_service(cluster_name)

    def aws_cloudwatch_log_group(self, cluster_name):
        print("Processing CloudWatch Log Group for ECS Cluster...")

        # The log group name should match this format
        expected_log_group_name = f"/aws/ecs/{cluster_name}"

        # Fetch log groups
        log_groups = self.logs_client.describe_log_groups()['logGroups']

        for log_group in log_groups:
            log_group_name = log_group['logGroupName']
            if log_group_name == expected_log_group_name:
                print(
                    f"  Processing CloudWatch Log Group: {log_group_name} for ECS Cluster: {cluster_name}")

                # Prepare the attributes
                attributes = {
                    "id": log_group_name,
                    "name": log_group_name,
                    # "retention_in_days": log_group['retentionInDays'],
                    # # KMS key ID is optional and may not always be present
                    # "kms_key_id": log_group.get('kmsKeyId', '')
                }

                # Process the resource
                self.hcl.process_resource(
                    "aws_cloudwatch_log_group", cluster_name.replace("-", "_"), attributes)
                return  # End the function once we've found the matching log group

        print(
            f"  Warning: No matching CloudWatch Log Group found for ECS Cluster: {cluster_name}")

    def aws_ecs_cluster_capacity_providers(self, cluster_name):
        print("Processing ECS Cluster Capacity Providers for the specified cluster...")

        cluster_arns = self.ecs_client.list_clusters()["clusterArns"]
        clusters = self.ecs_client.describe_clusters(
            clusters=cluster_arns)["clusters"]

        for cluster in clusters:
            if cluster["clusterName"] == cluster_name:
                capacity_providers = cluster.get("capacityProviders", [])

                for provider in capacity_providers:
                    print(
                        f"  Processing ECS Cluster Capacity Provider: {provider} for Cluster: {cluster_name}")

                    resource_name = f"{cluster_name}-{provider}"
                    attributes = {
                        "id": cluster_name,
                        "capacity_provider": provider,
                    }
                    self.hcl.process_resource(
                        "aws_ecs_cluster_capacity_providers", resource_name.replace("-", "_"), attributes)
            else:
                print(f"Skipping cluster: {cluster['clusterName']}")

    def aws_ecs_capacity_provider(self, cluster_name):
        print(
            f"Processing ECS Capacity Providers for cluster: {cluster_name}...")

        cluster_arns = self.ecs_client.list_clusters()["clusterArns"]
        clusters = self.ecs_client.describe_clusters(
            clusters=cluster_arns)["clusters"]

        for cluster in clusters:
            if cluster['clusterName'] == cluster_name:
                capacity_providers = cluster.get('capacityProviders', [])

                for provider_name in capacity_providers:
                    provider_details = self.ecs_client.describe_capacity_providers(
                        capacityProviders=[provider_name])["capacityProviders"][0]

                    auto_scaling_group_provider = provider_details.get(
                        'autoScalingGroupProvider', None)

                    if auto_scaling_group_provider:
                        print(
                            f"  Processing ECS Capacity Provider: {provider_name}")

                        attributes = {
                            "id": provider_name,
                            "auto_scaling_group_arn": auto_scaling_group_provider['autoScalingGroupArn'],
                        }
                        self.hcl.process_resource(
                            "aws_ecs_capacity_provider", provider_name.replace("-", "_"), attributes)
                    else:
                        print(
                            f"Skipping provider: {provider_name} without auto scaling group")

            else:
                print(f"Skipping cluster: {cluster['clusterName']}")

    def aws_ecs_service(self, cluster_name):
        print(f"Processing ECS Services for cluster: {cluster_name}...")

        clusters_arns = self.ecs_client.list_clusters()["clusterArns"]
        clusters = self.ecs_client.describe_clusters(
            clusters=clusters_arns)["clusters"]

        for cluster in clusters:
            if cluster['clusterName'] == cluster_name:
                cluster_arn = cluster['clusterArn']

                paginator = self.ecs_client.get_paginator('list_services')
                for page in paginator.paginate(cluster=cluster_arn):
                    services_arns = page["serviceArns"]
                    services = self.ecs_client.describe_services(
                        cluster=cluster_arn, services=services_arns)["services"]

                    for service in services:
                        service_name = service["serviceName"]
                        service_arn = service["serviceArn"]
                        id = cluster_arn.split("/")[1] + "/" + service_name

                        print(f"  Processing ECS Service: {service_name}")

                        attributes = {
                            "id": id,
                            "arn": service_arn,
                            "name": service_name,
                            "cluster": cluster_arn,
                        }
                        self.hcl.process_resource(
                            "aws_ecs_service", service_name.replace("-", "_"), attributes)

                        self.aws_appautoscaling_target(
                            cluster_name, service_name)

                        return  # TO REMOVE
            else:
                print(f"Skipping cluster: {cluster['clusterName']}")

    def aws_ecs_task_definition(self):
        print("Processing ECS Task Definitions...")

        paginator = self.ecs_client.get_paginator(
            "list_task_definition_families")
        for page in paginator.paginate():
            task_definition_families = page["families"]
            for family in task_definition_families:
                if family != "publication-service":  # TO REMOVE
                    continue  # TO REMOVE
                latest_task_definition_arn = self.ecs_client.list_task_definitions(
                    familyPrefix=family, sort="DESC", maxResults=1
                )["taskDefinitionArns"][0]

                task_definition = self.ecs_client.describe_task_definition(
                    taskDefinition=latest_task_definition_arn)["taskDefinition"]

                print(
                    f"  Processing ECS Task Definition: {latest_task_definition_arn}")

                attributes = {
                    "id": latest_task_definition_arn,
                    "arn": latest_task_definition_arn,
                    "family": family,
                }
                self.hcl.process_resource(
                    "aws_ecs_task_definition", family.replace("-", "_"), attributes)

                # Process IAM roles for the task
                if task_definition.get('taskRoleArn'):
                    self.aws_iam_role(task_definition.get('taskRoleArn'))
                if task_definition.get('executionRoleArn'):
                    self.aws_iam_role(task_definition.get('executionRoleArn'))

    def aws_iam_role(self, role_arn):
        print(f"Processing IAM Role: {role_arn}...")

        role_name = role_arn.split('/')[-1]  # Extract role name from ARN

        try:
            role = self.iam_client.get_role(RoleName=role_name)['Role']

            print(f"  Processing IAM Role: {role['Arn']}")

            attributes = {
                "id": role['RoleName'],
            }
            self.hcl.process_resource(
                "aws_iam_role", role['RoleName'], attributes)
            # Process IAM role policy attachments for the role
            self.aws_iam_role_policy_attachment(role['RoleName'])
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

    def aws_appautoscaling_target(self, cluster_name, service_name):
        service_namespace = 'ecs'
        resource_id = f'service/{cluster_name}/{service_name}'
        print(
            f"Processing AppAutoScaling target for ECS service: {service_name} in cluster: {cluster_name}...")

        try:
            response = self.appautoscaling_client.describe_scalable_targets(
                ServiceNamespace=service_namespace,
                ResourceIds=[resource_id]
            )
            scalable_targets = response.get('ScalableTargets', [])

            if scalable_targets:
                # We expect only one target per service
                target = scalable_targets[0]
                print(f"  Processing ECS AppAutoScaling Target: {resource_id}")

                resource_name = f"{service_namespace}-{resource_id.replace('/', '-')}"
                attributes = {
                    "id": target['ScalableDimension'],
                    "resource_id": resource_id,
                    "service_namespace": service_namespace
                }
                self.hcl.process_resource(
                    "aws_appautoscaling_target", resource_name, attributes)

                # Processing scaling policies for the target
                self.aws_appautoscaling_policy(service_namespace, resource_id)

            else:
                print(
                    f"No AppAutoScaling target found for ECS service: {service_name} in cluster: {cluster_name}")

        except Exception as e:
            print(
                f"Error processing AppAutoScaling target for ECS service: {service_name} in cluster: {cluster_name}: {str(e)}")

    def aws_appautoscaling_policy(self, service_namespace, resource_id):
        print(
            f"Processing AppAutoScaling policies for resource: {resource_id}...")

        try:
            response = self.appautoscaling_client.describe_scaling_policies(
                ServiceNamespace=service_namespace,
                ResourceId=resource_id
            )
            scaling_policies = response.get('ScalingPolicies', [])

            for policy in scaling_policies:
                print(
                    f"  Processing AppAutoScaling Policy: {policy['PolicyName']} for resource: {resource_id}")

                resource_name = f"{service_namespace}-{resource_id.replace('/', '-')}-{policy['PolicyName']}"
                attributes = {
                    "id": policy['PolicyName'],
                    "resource_id": resource_id,
                    "service_namespace": service_namespace
                }
                self.hcl.process_resource(
                    "aws_appautoscaling_policy", resource_name, attributes)
        except Exception as e:
            print(
                f"Error processing AppAutoScaling policies for resource: {resource_id}: {str(e)}")

    def aws_ecs_account_setting_default(self):
        print("Processing ECS Account Setting Defaults...")

        settings = self.ecs_client.list_account_settings()["settings"]
        for setting in settings:
            name = setting["name"]
            value = setting["value"]

            print(f"  Processing ECS Account Setting Default: {name}")

            attributes = {
                "id": name,
                "value": value,
            }
            self.hcl.process_resource(
                "aws_ecs_account_setting_default", name.replace("-", "_"), attributes)

    def aws_ecs_tag(self):
        print("Processing ECS Tags...")

        # Process tags for ECS clusters
        clusters_arns = self.ecs_client.list_clusters()["clusterArns"]
        for cluster_arn in clusters_arns:
            cluster = self.ecs_client.describe_clusters(
                clusters=[cluster_arn])["clusters"][0]
            cluster_name = cluster["clusterName"]
            self.process_tags_for_resource(
                cluster_name, cluster_arn, "aws_ecs_tag")

            # Process tags for ECS services
            services_arns = self.ecs_client.list_services(
                cluster=cluster_arn)["serviceArns"]
            services = self.ecs_client.describe_services(
                cluster=cluster_arn, services=services_arns)["services"]
            for service in services:
                service_name = service["serviceName"]
                service_arn = service["serviceArn"]
                self.process_tags_for_resource(
                    service_name, service_arn, "aws_ecs_tag")

            # Process tags for ECS tasks and task definitions
            tasks_arns = self.ecs_client.list_tasks(
                cluster=cluster_arn)["taskArns"]
            tasks = self.ecs_client.describe_tasks(
                cluster=cluster_arn, tasks=tasks_arns)["tasks"]
            for task in tasks:
                task_arn = task["taskArn"]
                task_definition_arn = task["taskDefinitionArn"]
                self.process_tags_for_resource(
                    task_arn.split("/")[-1], task_arn, "aws_ecs_tag")
                self.process_tags_for_resource(task_definition_arn.split(
                    "/")[-1], task_definition_arn, "aws_ecs_tag")

    def process_tags_for_resource(self, resource_name, resource_arn, resource_type):
        tags = self.ecs_client.list_tags_for_resource(
            resourceArn=resource_arn)["tags"]
        for tag in tags:
            key = tag["key"]
            value = tag["value"]

            print(
                f"  Processing ECS Tag: {key}={value} for {resource_type}: {resource_name}")

            hcl_resource_name = f"{resource_name}-tag-{key}"
            id = resource_arn + "," + key
            attributes = {
                "id": id,
                "resource_arn": resource_arn,
                "key": key,
                "value": value,
            }
            self.hcl.process_resource(
                resource_type, hcl_resource_name.replace("-", "_"), attributes)

    def aws_ecs_task_set(self):
        print("Processing ECS Task Sets...")

        clusters_arns = self.ecs_client.list_clusters()["clusterArns"]
        for cluster_arn in clusters_arns:
            services_arns = self.ecs_client.list_services(
                cluster=cluster_arn)["serviceArns"]
            services = self.ecs_client.describe_services(
                cluster=cluster_arn, services=services_arns)["services"]

            for service in services:
                service_name = service["serviceName"]
                task_sets = self.ecs_client.list_task_sets(
                    cluster=cluster_arn, service=service_name)["taskSets"]

                for task_set_arn in task_sets:
                    task_set = self.ecs_client.describe_task_sets(
                        cluster=cluster_arn, service=service_name, taskSets=[task_set_arn])["taskSets"][0]
                    task_set_id = task_set["id"]

                    print(f"  Processing ECS Task Set: {task_set_id}")

                    attributes = {
                        "id": task_set_id,
                        "service": service_name,
                        "cluster": cluster_arn,
                        "task_definition": task_set["taskDefinition"],
                    }
                    self.hcl.process_resource(
                        "aws_ecs_task_set", task_set_id.replace("-", "_"), attributes)
