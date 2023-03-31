import os
from utils.hcl import HCL


class ElasticBeanstalk:
    def __init__(self, elasticbeanstalk_client, script_dir, provider_name, schema_data, region):
        self.elasticbeanstalk_client = elasticbeanstalk_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def elasticbeanstalk(self):
        self.hcl.prepare_folder(os.path.join("generated", "elasticbeanstalk"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_elastic_beanstalk_application(self):
        print("Processing Elastic Beanstalk Applications...")

        applications = self.elasticbeanstalk_client.describe_applications()[
            "Applications"]

        for app in applications:
            app_name = app["ApplicationName"]
            print(f"  Processing Elastic Beanstalk Application: {app_name}")

            attributes = {
                "id": app_name,
                "name": app_name,
                "description": app.get("Description", ""),
            }
            self.hcl.process_resource(
                "aws_elastic_beanstalk_application", app_name, attributes)

    def aws_elastic_beanstalk_application_version(self):
        print("Processing Elastic Beanstalk Application Versions...")

        applications = self.elasticbeanstalk_client.describe_applications()[
            "Applications"]

        for app in applications:
            app_name = app["ApplicationName"]
            versions = self.elasticbeanstalk_client.describe_application_versions(
                ApplicationName=app_name)["ApplicationVersions"]

            for version in versions:
                version_label = version["VersionLabel"]
                version_id = f"{app_name}-{version_label}"
                print(
                    f"  Processing Elastic Beanstalk Application Version: {version_id}")

                attributes = {
                    "id": version_id,
                    "application": app_name,
                    "name": version_label,
                    "description": version.get("Description", ""),
                }
                self.hcl.process_resource(
                    "aws_elastic_beanstalk_application_version", version_id, attributes)

    def aws_elastic_beanstalk_configuration_template(self):
        print("Processing Elastic Beanstalk Configuration Templates...")

        applications = self.elasticbeanstalk_client.describe_applications()[
            "Applications"]

        for app in applications:
            app_name = app["ApplicationName"]
            templates = self.elasticbeanstalk_client.describe_configuration_templates(
                ApplicationName=app_name)["ConfigurationTemplates"]

            for template_name in templates:
                template_id = f"{app_name}-{template_name}"
                print(
                    f"  Processing Elastic Beanstalk Configuration Template: {template_id}")

                attributes = {
                    "id": template_id,
                    "application": app_name,
                    "name": template_name,
                }
                self.hcl.process_resource(
                    "aws_elastic_beanstalk_configuration_template", template_id, attributes)

    def aws_elastic_beanstalk_environment(self):
        print("Processing Elastic Beanstalk Environments...")

        environments = self.elasticbeanstalk_client.describe_environments()[
            "Environments"]

        for env in environments:
            env_id = env["EnvironmentId"]
            print(f"  Processing Elastic Beanstalk Environment: {env_id}")

            attributes = {
                "id": env_id,
                "name": env["EnvironmentName"],
                "application": env["ApplicationName"],
                "cname_prefix": env.get("CNAMEPrefix", ""),
            }
            self.hcl.process_resource(
                "aws_elastic_beanstalk_environment", env_id, attributes)
