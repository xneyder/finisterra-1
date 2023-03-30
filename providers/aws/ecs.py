import os
from utils.hcl import HCL


class ECS:
    def __init__(self, ecs_client, script_dir, provider_name, schema_data, region):
        self.ecs_client = ecs_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def ecs(self):
        self.hcl.prepare_folder(os.path.join("generated", "ecs"))

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
                "name": name,
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
                "name": provider_name,
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
                "arn": cluster_arn,
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
                    "cluster": cluster_name,
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

                print(f"  Processing ECS Service: {service_name}")

                attributes = {
                    "arn": service_arn,
                    "name": service_name,
                    "cluster": cluster_arn,
                }
                self.hcl.process_resource(
                    "aws_ecs_service", service_name.replace("-", "_"), attributes)

    def aws_ecs_tag(self):
        print("Processing ECS Tags...")

        clusters_arns = self.ecs_client.list_clusters()["clusterArns"]
        for cluster_arn in clusters_arns:
            services_arns = self.ecs_client.list_services(
                cluster=cluster_arn)["serviceArns"]
            services = self.ecs_client.describe_services(
                cluster=cluster_arn, services=services_arns)["services"]

            for service in services:
                service_name = service["serviceName"]
                service_arn = service["serviceArn"]
                tags = service["tags"]

                for tag in tags:
                    key = tag["key"]
                    value = tag["value"]

                    print(
                        f"  Processing ECS Tag: {key}={value} for Service: {service_name}")

                    resource_name = f"{service_name}-tag-{key}"
                    attributes = {
                        "resource_arn": service_arn,
                        "key": key,
                        "value": value,
                    }
                    self.hcl.process_resource(
                        "aws_ecs_tag", resource_name.replace("-", "_"), attributes)

    def aws_ecs_task_definition(self):
        print("Processing ECS Task Definitions...")

        paginator = self.ecs_client.get_paginator("list_task_definitions")
        for page in paginator.paginate():
            task_definition_arns = page["taskDefinitionArns"]
            task_definitions = self.ecs_client.describe_task_definitions(
                taskDefinitionArns=task_definition_arns)["taskDefinitions"]

            for task_definition in task_definitions:
                task_definition_arn = task_definition["taskDefinitionArn"]
                family = task_definition["family"]

                print(f"  Processing ECS Task Definition: {family}")

                attributes = {
                    "arn": task_definition_arn,
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
