import os
from utils.hcl import HCL
import botocore
import re
from providers.aws.security_group import SECURITY_GROUP
from providers.aws.iam_role import IAM_ROLE

class ElasticBeanstalk:
    def __init__(self, elasticbeanstalk_client, iam_client, autoscaling_client, ec2_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl=None):
        self.elasticbeanstalk_client = elasticbeanstalk_client
        self.iam_client = iam_client
        self.autoscaling_client = autoscaling_client
        self.ec2_client = ec2_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.s3Bucket = s3Bucket
        self.dynamoDBTable = dynamoDBTable
        self.state_key = state_key
        self.aws_account_id = aws_account_id
        
        self.workspace_id = workspace_id
        self.modules = modules
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        else:
            self.hcl = hcl
        self.resource_list = {}
        self.service_roles = {}
        self.ec2_roles = {}
        self.insatce_profiles = {}
        self.security_groups = {}

        self.security_group_instance = SECURITY_GROUP(ec2_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)
        self.iam_role_instance = IAM_ROLE(iam_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)

    # def init_fields(self, attributes):
    #     self.service_roles = {}
    #     self.ec2_roles = {}
    #     self.insatce_profiles = {}
    #     return None

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

    def build_dict_var(self, attributes, arg):
        key = attributes[arg]
        result = {key: {}}
        for k, v in attributes.items():
            if v is not None:
                result[key][k] = v
        return result

    def join_sg(self, parent_attributes, child_attributes):
        env_id = parent_attributes.get("id")
        sg_id = child_attributes.get("id")
        # print(role, env_id, self.ec2_roles)
        if env_id in self.security_groups:
            if self.security_groups[env_id] == sg_id:
                return True
        return False

    def join_service_iam_role(self, parent_attributes, child_attributes):
        env_id = parent_attributes.get("id")
        role = child_attributes.get("name")
        if env_id in self.service_roles:
            if self.service_roles[env_id] == role:
                return True
        return False

    def join_ec2_iam_role(self, parent_attributes, child_attributes):
        env_id = parent_attributes.get("id")
        role = child_attributes.get("name")
        # print(role, env_id, self.ec2_roles)
        if env_id in self.ec2_roles:
            if self.ec2_roles[env_id] == role:
                return True
        return False

    def join_ec2_instance_profile(self, parent_attributes, child_attributes):
        env_id = parent_attributes.get("id")
        name = child_attributes.get("name")
        # print(role, env_id, self.ec2_roles)
        if env_id in self.insatce_profiles:
            if self.insatce_profiles[env_id] == name:
                return True
        return False

    def to_list(self, attributes, arg):
        return [attributes.get(arg)]

    def elasticbeanstalk(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        # self.aws_elastic_beanstalk_application()
        self.aws_elastic_beanstalk_environment()

        functions = {
            # 'init_fields': self.init_fields,
            'get_field_from_attrs': self.get_field_from_attrs,
            'to_list': self.to_list,
            'join_service_iam_role': self.join_service_iam_role,
            'join_ec2_iam_role': self.join_ec2_iam_role,
            'join_ec2_instance_profile': self.join_ec2_instance_profile,
            'join_sg': self.join_sg,
            'build_dict_var': self.build_dict_var,
        }

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "elasticbeanstalk.yaml"), functions, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

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

                source_bundle = version.get("SourceBundle")
                bucket = ""
                bucket_key = ""

                if source_bundle:
                    bucket = source_bundle.get("S3Bucket", "")
                    key = source_bundle.get("S3Key", "")

                attributes = {
                    "id": version_id,
                    "application": app_name,
                    "name": version_label,
                    "description": version.get("Description", ""),
                    "bucket": bucket,
                    "key": key
                }
                self.hcl.process_resource(
                    "aws_elastic_beanstalk_application_version", version_id, attributes)

    def aws_elastic_beanstalk_configuration_template(self):
        print("Processing Elastic Beanstalk Configuration Templates...")

        applications = self.elasticbeanstalk_client.describe_applications()[
            "Applications"]

        for app in applications:
            app_name = app["ApplicationName"]
            environments = self.elasticbeanstalk_client.describe_environments(
                ApplicationName=app_name)["Environments"]
            templates = {}

            for env in environments:
                try:
                    env_name = env["EnvironmentName"]
                    options = self.elasticbeanstalk_client.describe_configuration_options(
                        ApplicationName=app_name, EnvironmentName=env_name)["Options"]

                    for option in options:
                        namespace = option["Namespace"]
                        name = option.get("OptionName")
                        value = option.get("Value")
                        if namespace.startswith("aws:elasticbeanstalk:"):
                            template_name = namespace.split(":")[-1]
                            if template_name not in templates:
                                templates[template_name] = {
                                    "id": f"{app_name}-{template_name}",
                                    "application": app_name,
                                    "name": template_name,
                                    "options": {},
                                }
                            templates[template_name]["options"][name] = value
                except botocore.exceptions.ClientError as e:
                    print(f"  Error processing KMS Grant: {e}")

                for template_name, template in templates.items():
                    template_id = template["id"]
                    print(
                        f"  Processing Elastic Beanstalk Configuration Template: {template_id}")

                    attributes = {
                        "id": template_id,
                        "application": app_name,
                        "name": template_name,
                        "options": template["options"],
                    }
                    self.hcl.process_resource(
                        "aws_elastic_beanstalk_configuration_template", template_id, attributes)

    def aws_elastic_beanstalk_environment(self):
        resource_type = "aws_elastic_beanstalk_environment"
        print("Processing Elastic Beanstalk Environments...")

        environments = self.elasticbeanstalk_client.describe_environments()["Environments"]

        for env in environments:
            env_id = env["EnvironmentId"]

            # if env_id != "e-asi52zmcu8":
            #     continue
            print(f"  Processing Elastic Beanstalk Environment: {env_id}")
            id = env_id

            ftstack = "beanstalk"
            try:
                tags_response = self.elasticbeanstalk_client.list_tags_for_resource(
                    ResourceArn=env["EnvironmentArn"]
                )
                tags = tags_response.get('ResourceTags', [])
                for tag in tags:
                    if tag['Key'] == 'ftstack':
                        if tag['Value'] != 'beanstalk':
                            ftstack = "stack_"+tag['Value']
                        break
            except Exception as e:
                print("Error occurred: ", e)

            attributes = {
                "id": id,
                "name": env["EnvironmentName"],
                "application": env["ApplicationName"],
                "cname_prefix": env.get("CNAMEPrefix", ""),
            }
            self.hcl.process_resource(
                resource_type, id, attributes)
            
            self.hcl.add_stack(resource_type, id, ftstack)

            # Retrieve the environment configuration details
            config_settings = self.elasticbeanstalk_client.describe_configuration_settings(
                ApplicationName=env["ApplicationName"],
                EnvironmentName=env["EnvironmentName"]
            )

            # Process the Service Role
            service_role = None
            for option_setting in config_settings['ConfigurationSettings'][0]['OptionSettings']:
                if option_setting['OptionName'] == 'ServiceRole':
                    service_role = option_setting['Value']

            # Process IAM roles
            if service_role:
                self.service_roles[env_id] = service_role
                self.iam_role_instance.aws_iam_role(service_role, ftstack)

            # Process the EC2 Role
            ec2_instance_profile = None
            for option_setting in config_settings['ConfigurationSettings'][0]['OptionSettings']:
                if option_setting['OptionName'] == 'IamInstanceProfile':
                    ec2_instance_profile = option_setting['Value']

            if ec2_instance_profile:
                self.insatce_profiles[env_id] = ec2_instance_profile
                # self.aws_iam_instance_profile(ec2_instance_profile)
                instance_profile = self.iam_client.get_instance_profile(
                    InstanceProfileName=ec2_instance_profile)
                ec2_role = instance_profile['InstanceProfile']['Roles'][0]['Arn']
                self.ec2_roles[env_id] = ec2_role.split('/')[-1]
                self.iam_role_instance.aws_iam_role(ec2_role, ftstack)
                # self.aws_iam_role(ec2_role)

            # Identify the Auto Scaling Group associated with the Elastic Beanstalk environment
            auto_scaling_groups = self.autoscaling_client.describe_auto_scaling_groups()

            for group in auto_scaling_groups['AutoScalingGroups']:
                # The Elastic Beanstalk environment name is part of the Auto Scaling Group name
                if re.search(env_id, group['AutoScalingGroupName']):
                    auto_scaling_group = group
                    break

            # Get the Launch Configuration or Launch Template associated with the Auto Scaling Group
            if 'LaunchConfigurationName' in auto_scaling_group:
                launch_config_name = auto_scaling_group['LaunchConfigurationName']
                launch_config = self.autoscaling_client.describe_launch_configurations(
                    LaunchConfigurationNames=[launch_config_name]
                )['LaunchConfigurations'][0]

                security_group_ids = launch_config['SecurityGroups']
            elif 'LaunchTemplate' in auto_scaling_group:
                launch_template_id = auto_scaling_group['LaunchTemplate']['LaunchTemplateId']
                launch_template_version = self.ec2_client.describe_launch_template_versions(
                    LaunchTemplateId=launch_template_id
                )['LaunchTemplateVersions'][0]['LaunchTemplateData']

                security_group_ids = launch_template_version['NetworkInterfaces'][0]['Groups']

            # Process security groups
            if security_group_ids:
                self.security_groups[env_id] = security_group_ids[0]
                for sg in security_group_ids:
                    self.security_group_instance.aws_security_group(sg, ftstack)
                # self.aws_security_group(security_group_ids)

