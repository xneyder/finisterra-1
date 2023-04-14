import os
from utils.hcl import HCL


class ECS:
    def __init__(self, ecs_client, script_dir, provider_name, schema_data, region):
        self.ecs_client = ecs_client
        self.transform_rules = {
            "aws_ecs_task_definition": {
                "hcl_json_multiline": {"container_definitions": True}
            },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def ecs(self):
        self.hcl.prepare_folder(os.path.join("generated", "ecs"))

        self.aws_ecs_account_setting_default()
        self.aws_ecs_capacity_provider()
        self.aws_ecs_cluster()
        self.aws_ecs_cluster_capacity_providers()
        self.aws_ecs_service()
        self.aws_ecs_tag()
        self.aws_ecs_task_definition()
        if "gov" not in self.region:
            self.aws_ecs_task_set()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

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

    def aws_ecs_capacity_provider(self):
        print("Processing ECS Capacity Providers...")

        capacity_providers = self.ecs_client.describe_capacity_providers()[
            "capacityProviders"]
        for provider in capacity_providers:
            provider_name = provider["name"]
            provider_arn = provider["capacityProviderArn"]

            print(f"  Processing ECS Capacity Provider: {provider_name}")

            attributes = {
                "id": provider_name,
            }
            self.hcl.process_resource(
                "aws_ecs_capacity_provider", provider_name.replace("-", "_"), attributes)

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

    def aws_ecs_cluster_capacity_providers(self):
        print("Processing ECS Cluster Capacity Providers...")

        clusters_arns = self.ecs_client.list_clusters()["clusterArns"]
        clusters = self.ecs_client.describe_clusters(
            clusters=clusters_arns)["clusters"]

        for cluster in clusters:
            cluster_name = cluster["clusterName"]
            cluster_arn = cluster["clusterArn"]
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

    def aws_ecs_service(self):
        print("Processing ECS Services...")

        clusters_arns = self.ecs_client.list_clusters()["clusterArns"]
        for cluster_arn in clusters_arns:
            services_arns = self.ecs_client.list_services(
                cluster=cluster_arn)["serviceArns"]
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

    def aws_ecs_task_definition(self):
        print("Processing ECS Task Definitions...")

        paginator = self.ecs_client.get_paginator(
            "list_task_definition_families")
        for page in paginator.paginate():
            task_definition_families = page["families"]
            for family in task_definition_families:
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
