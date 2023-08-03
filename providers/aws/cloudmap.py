import os
from utils.hcl import HCL


class Cloudmap:
    def __init__(self, cloudmap_client, route53_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, aws_partition):
        self.cloudmap_client = cloudmap_client
        self.route53_client = route53_client
        self.transform_rules = {
            "aws_service_discovery_service": {
                "hcl_keep_fields": {"dns_records.type": "ALL", "dns_config.namespace_id": "ALL"},
                "hcl_drop_fields": {"type": "DNS_HTTP"},
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

    def cloudmap(self):
        self.hcl.prepare_folder(os.path.join("generated", "cloudmap"))

        self.aws_service_discovery_http_namespace()
        self.aws_service_discovery_instance()
        self.aws_service_discovery_private_dns_namespace()
        self.aws_service_discovery_public_dns_namespace()
        self.aws_service_discovery_service()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_service_discovery_http_namespace(self):
        print("Processing AWS Service Discovery HTTP Namespaces...")

        paginator = self.cloudmap_client.get_paginator("list_namespaces")
        for page in paginator.paginate():
            for namespace in page["Namespaces"]:
                if namespace["Type"] == "HTTP":
                    namespace_id = namespace["Id"]
                    http_namespace = self.cloudmap_client.get_namespace(Id=namespace_id)[
                        "Namespace"]
                    print(
                        f"  Processing AWS Service Discovery HTTP Namespace: {namespace_id}")

                    attributes = {
                        "id": namespace_id,
                        "name": http_namespace["Name"],
                        "arn": http_namespace["Arn"],
                    }

                    self.hcl.process_resource(
                        "aws_service_discovery_http_namespace", namespace_id.replace("-", "_"), attributes)

    def aws_service_discovery_instance(self):
        print("Processing AWS Service Discovery Instances...")

        paginator = self.cloudmap_client.get_paginator("list_services")
        for page in paginator.paginate():
            for service in page["Services"]:
                service_id = service["Id"]
                instance_paginator = self.cloudmap_client.get_paginator(
                    "list_instances")
                for instance_page in instance_paginator.paginate(ServiceId=service_id):
                    for instance in instance_page["Instances"]:
                        instance_id = instance["Id"]
                        print(
                            f"  Processing AWS Service Discovery Instance: {instance_id}")

                        attributes = {
                            "id": instance_id,
                            "instance_id": instance_id,
                            "service_id": service_id,
                        }

                        if "Attributes" in instance:
                            attributes["attributes"] = instance["Attributes"]

                        self.hcl.process_resource(
                            "aws_service_discovery_instance", instance_id.replace("-", "_"), attributes)

    def aws_service_discovery_private_dns_namespace(self):
        print("Processing AWS Service Discovery Private DNS Namespaces...")

        paginator = self.cloudmap_client.get_paginator("list_namespaces")
        for page in paginator.paginate():
            for namespace in page["Namespaces"]:
                if namespace["Type"] == "DNS_PRIVATE":
                    namespace_id = namespace["Id"]
                    private_dns_namespace = self.cloudmap_client.get_namespace(Id=namespace_id)[
                        "Namespace"]
                    print(
                        f"  Processing AWS Service Discovery Private DNS Namespace: {namespace_id}")

                    # Get the hosted zone ID of the namespace
                    hosted_zone_id = private_dns_namespace["Properties"]["DnsProperties"]["HostedZoneId"]

                    # Get the VPC ID from the hosted zone
                    hosted_zone = self.route53_client.get_hosted_zone(
                        Id=hosted_zone_id)
                    vpc_id = hosted_zone["VPCs"][0]["VPCId"]

                    attributes = {
                        "id": namespace_id,
                        "name": private_dns_namespace["Name"],
                        "arn": private_dns_namespace["Arn"],
                        "vpc": vpc_id,
                    }

                    self.hcl.process_resource(
                        "aws_service_discovery_private_dns_namespace", namespace_id.replace("-", "_"), attributes)

    def aws_service_discovery_public_dns_namespace(self):
        print("Processing AWS Service Discovery Public DNS Namespaces...")

        paginator = self.cloudmap_client.get_paginator("list_namespaces")
        for page in paginator.paginate():
            for namespace in page["Namespaces"]:
                if namespace["Type"] == "DNS_PUBLIC":
                    namespace_id = namespace["Id"]
                    public_dns_namespace = self.cloudmap_client.get_namespace(Id=namespace_id)[
                        "Namespace"]
                    print(
                        f"  Processing AWS Service Discovery Public DNS Namespace: {namespace_id}")

                    attributes = {
                        "id": namespace_id,
                        "name": public_dns_namespace["Name"],
                        "arn": public_dns_namespace["Arn"],
                    }

                    self.hcl.process_resource(
                        "aws_service_discovery_public_dns_namespace", namespace_id.replace("-", "_"), attributes)

    def aws_service_discovery_service(self):
        print("Processing AWS Service Discovery Services...")

        paginator = self.cloudmap_client.get_paginator("list_services")
        for page in paginator.paginate():
            for service in page["Services"]:
                service_id = service["Id"]
                sd_service = self.cloudmap_client.get_service(Id=service_id)[
                    "Service"]
                print(
                    f"  Processing AWS Service Discovery Service: {service_id}")

                attributes = {
                    "id": service_id,
                    # "arn": sd_service["Arn"],
                    # "name": sd_service["Name"],
                    # "namespace_id": sd_service["NamespaceId"],
                }

                # if "DnsConfig" in sd_service:
                #     attributes["dns_config"] = sd_service["DnsConfig"]

                # if "HealthCheckConfig" in sd_service:
                #     attributes["health_check_config"] = sd_service["HealthCheckConfig"]

                # if "HealthCheckCustomConfig" in sd_service:
                #     attributes["health_check_custom_config"] = sd_service["HealthCheckCustomConfig"]

                self.hcl.process_resource(
                    "aws_service_discovery_service", service_id.replace("-", "_"), attributes)
