import os
from utils.hcl import HCL


class AutoScaling:
    def __init__(self, autoscaling_client, cloudwatch_client, ec2_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.autoscaling_client = autoscaling_client
        self.cloudwatch_client = cloudwatch_client
        self.transform_rules = {
            "aws_autoscaling_policy": {
                "hcl_drop_fields": {"min_adjustment_magnitude": 0},
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
        self.user_data = {}
        self.ec2_client = ec2_client

        functions = {
            'build_autoscaling_policies': self.build_autoscaling_policies,
            'join_launch_configuration': self.join_launch_configuration,
            'join_launch_template': self.join_launch_template,
            'get_field_from_attrs': self.get_field_from_attrs,
            'build_aws_cloudwatch_metric_alarms': self.build_aws_cloudwatch_metric_alarms,
            'get_user_data': self.get_user_data,
            'get_subnet_ids': self.get_subnet_ids,
            'get_subnet_names': self.get_subnet_names,
            'get_security_group_names': self.get_security_group_names,
        }

        self.hcl.functions.update(functions)

    def get_user_data(self, attributes):
        name = attributes.get("name")
        return self.user_data.get(name)

    def get_security_group_names(self, attributes, arg):
        security_group_ids = attributes.get(arg)
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

    def build_autoscaling_policies(self, attributes):
        result = {}
        name = attributes.get("name")
        if not name:
            return result

        policy_details = {}
        attribute_keys = ["policy_type",
                          "scaling_adjustment", "adjustment_type", "cooldown"]

        for key in attribute_keys:
            value = attributes.get(key)
            if value or value == 0:
                policy_details[key] = value

        if not policy_details:
            return result

        result[name] = policy_details

        return result

    def build_aws_cloudwatch_metric_alarms(self, attributes):
        result = {}
        alarm_name = attributes.get("alarm_name")
        if not alarm_name:
            return result

        alarm_details = {}

        attribute_keys = ["comparison_operator", "evaluation_periods", "metric_name", "namespace", "period", "statistic", "extended_statistic",
                          "threshold", "treat_missing_data", "ok_actions", "insufficient_data_actions", "dimensions", "alarm_description", "alarm_actions", "tags"]

        for key in attribute_keys:
            value = attributes.get(key)
            if value or value == 0:
                alarm_details[key] = value

        if not alarm_details:
            return result

        result[alarm_name] = alarm_details

        return result

    def join_launch_configuration(self, parent_attributes, child_attributes):
        name = child_attributes.get('name')
        launch_configuration = parent_attributes.get('launch_configuration')

        if name == launch_configuration:
            return True

        return False

    def join_launch_template(self, parent_attributes, child_attributes):
        name = child_attributes.get('name')
        launch_template = parent_attributes.get('launch_template')

        if name == launch_template['id']:
            return True

        return False

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

    def get_subnet_names(self, attributes, arg):
        subnet_ids = attributes.get(arg)
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
            return attributes.get(arg)

    def autoscaling(self):
        self.hcl.prepare_folder(os.path.join("generated", "autoscaling"))

        self.aws_autoscaling_group()
        # self.aws_autoscaling_attachment()
        # self.aws_autoscaling_group_tag()
        # self.aws_autoscaling_lifecycle_hook()
        # self.aws_autoscaling_notification()
        # self.aws_autoscaling_policy()
        # self.aws_autoscaling_schedule()

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate","../providers/aws/", {}, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

    def aws_autoscaling_attachment(self):
        print("Processing AutoScaling Attachments...")

        as_groups = self.autoscaling_client.describe_auto_scaling_groups()[
            "AutoScalingGroups"]

        for as_group in as_groups:
            as_group_name = as_group["AutoScalingGroupName"]

            for elb_name in as_group.get("LoadBalancerNames", []):
                print(
                    f"  Processing AutoScaling Attachment: ELB {elb_name} -> ASG: {as_group_name}")

                resource_name = f"{as_group_name}-{elb_name}-attachment"
                attributes = {
                    "id": as_group_name,
                    "elb": elb_name,
                }
                self.hcl.process_resource(
                    "aws_autoscaling_attachment", resource_name.replace("-", "_"), attributes)

    def aws_autoscaling_group(self):
        print("Processing AutoScaling Groups...")

        as_groups = self.autoscaling_client.describe_auto_scaling_groups()[
            "AutoScalingGroups"]

        for as_group in as_groups:
            as_group_name = as_group["AutoScalingGroupName"]

            # Check tags to determine if this group is controlled by Elastic Beanstalk or EKS
            is_elasticbeanstalk = any(tag['Key'].startswith(
                'elasticbeanstalk:') for tag in as_group.get('Tags', []))
            is_eks = any(tag['Key'].startswith('eks:')
                         for tag in as_group.get('Tags', []))

            if is_elasticbeanstalk or is_eks:
                print(
                    f"  Skipping Elastic Beanstalk or EKS AutoScaling Group: {as_group_name}")
                continue  # Skip this AutoScaling group and move to the next

            print(f"  Processing AutoScaling Group: {as_group_name}")

            attributes = {
                "id": as_group_name,
            }

            self.hcl.process_resource(
                "aws_autoscaling_group", as_group_name.replace("-", "_"), attributes)

            # Here we call the policy processing for this specific group
            self.aws_autoscaling_policy(as_group_name)

            # Check if the AutoScaling group uses a Launch Configuration or Launch Template
            if "LaunchConfigurationName" in as_group:
                lc_name = as_group["LaunchConfigurationName"]
                # Call the method for processing Launch Configurations
                self.aws_launch_configuration(id=lc_name)

            elif "LaunchTemplate" in as_group:
                lt_info = as_group["LaunchTemplate"]
                if "LaunchTemplateId" in lt_info:  # It's possible to have 'LaunchTemplateName' instead of 'LaunchTemplateId'
                    lt_id = lt_info["LaunchTemplateId"]
                    # Call the method for processing Launch Templates
                    self.aws_launch_template(id=lt_id)

    def aws_autoscaling_group_tag(self):
        print("Processing AutoScaling Group Tags...")

        as_groups = self.autoscaling_client.describe_auto_scaling_groups()[
            "AutoScalingGroups"]

        for as_group in as_groups:
            as_group_name = as_group["AutoScalingGroupName"]

            for tag in as_group.get("Tags", []):
                key = tag["Key"]
                value = tag["Value"]

                print(
                    f"  Processing AutoScaling Group Tag: {key}={value} for ASG: {as_group_name}")

                resource_name = f"{as_group_name}-tag-{key}"
                attributes = {
                    "id": as_group_name+","+key,
                    "key": key,
                    "value": value,
                }
                self.hcl.process_resource(
                    "aws_autoscaling_group_tag", resource_name.replace("-", "_"), attributes)

    def aws_autoscaling_lifecycle_hook(self):
        print("Processing AutoScaling Lifecycle Hooks...")

        as_groups = self.autoscaling_client.describe_auto_scaling_groups()[
            "AutoScalingGroups"]

        for as_group in as_groups:
            as_group_name = as_group["AutoScalingGroupName"]
            hooks = self.autoscaling_client.describe_lifecycle_hooks(
                AutoScalingGroupName=as_group_name)["LifecycleHooks"]

            for hook in hooks:
                hook_name = hook["LifecycleHookName"]
                print(
                    f"  Processing AutoScaling Lifecycle Hook: {hook_name} for ASG: {as_group_name}")

                resource_name = f"{hook_name}".replace(
                    "-", "_")

                attributes = {
                    "id": hook_name,
                    "autoscaling_group_name": as_group_name,
                    # "lifecycle_transition": hook["LifecycleTransition"],
                    # "role_arn": hook["RoleARN"],
                }

                if "NotificationTargetARN" in hook:
                    attributes["notification_target_arn"] = hook["NotificationTargetARN"]

                if "HeartbeatTimeout" in hook:
                    attributes["heartbeat_timeout"] = hook["HeartbeatTimeout"]

                if "DefaultResult" in hook:
                    attributes["default_result"] = hook["DefaultResult"]

                self.hcl.process_resource(
                    "aws_autoscaling_lifecycle_hook", resource_name, attributes)

    def aws_autoscaling_notification(self):
        print("Processing AutoScaling Notifications...")

        as_groups = self.autoscaling_client.describe_auto_scaling_groups()[
            "AutoScalingGroups"]

        notification_types = [
            "autoscaling:EC2_INSTANCE_LAUNCH",
            "autoscaling:EC2_INSTANCE_TERMINATE",
            "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
            "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
        ]

        for as_group in as_groups:
            as_group_name = as_group["AutoScalingGroupName"]
            sns_topic_arns = self.get_sns_topic_arns_for_autoscaling_group(
                as_group_name)

            if not sns_topic_arns:
                print(
                    f"  No SNS topic found for ASG: {as_group_name}. Skipping AutoScaling Notifications.")
                continue

            for sns_topic_arn in sns_topic_arns:
                print(
                    f"  Processing AutoScaling Notification for ASG: {as_group_name} with SNS Topic: {sns_topic_arn}")

                resource_name = f"{as_group_name}-notification-{sns_topic_arn.split(':')[-1]}"
                attributes = {
                    "id": resource_name,
                    "group_names": [as_group_name],
                    "notifications": notification_types,
                    "topic_arn": sns_topic_arn,
                }
                self.hcl.process_resource(
                    "aws_autoscaling_notification", resource_name.replace("-", "_"), attributes)

    def get_sns_topic_arns_for_autoscaling_group(self, as_group_name):
        response = self.autoscaling_client.describe_notification_configurations(
            AutoScalingGroupNames=[as_group_name])
        sns_topic_arns = [config['TopicARN']
                          for config in response['NotificationConfigurations']]
        return sns_topic_arns

    def aws_autoscaling_policy(self, as_group_name):
        print(f"Processing AutoScaling Policies for group: {as_group_name}")

        # Retrieving policies for the specified AutoScaling group
        try:
            response = self.autoscaling_client.describe_policies(
                AutoScalingGroupName=as_group_name)
        except Exception as e:
            print(
                f"Error retrieving policies for AutoScaling group {as_group_name}: {str(e)}")
            return

        policies = response.get("ScalingPolicies", [])
        if not policies:
            print(f"No policies found for AutoScaling group: {as_group_name}")
            return

        for policy in policies:
            policy_name = policy["PolicyName"]
            print(f"  Processing AutoScaling Policy: {policy_name}")

            attributes = {
                "id": policy_name,
                "autoscaling_group_name": as_group_name,
                "adjustment_type": policy["AdjustmentType"],
                "scaling_adjustment": policy["ScalingAdjustment"],
                # ... other attributes you plan to process
            }

            # Optional attributes that may or may not be present in the policy
            if "Cooldown" in policy:
                attributes["cooldown"] = policy["Cooldown"]

            if "MinAdjustmentStep" in policy:
                attributes["min_adjustment_step"] = policy["MinAdjustmentStep"]

            if "EstimatedInstanceWarmup" in policy:
                attributes["estimated_instance_warmup"] = policy["EstimatedInstanceWarmup"]

            # If there are other optional attributes, continue your checks here

            # Process the attributes with your custom function
            self.hcl.process_resource(
                "aws_autoscaling_policy", policy_name.replace("-", "_"), attributes)

            if 'Alarms' in policy:
                for alarm in policy['Alarms']:
                    alarm_name = alarm['AlarmName']
                    self.aws_cloudwatch_metric_alarm(alarm_name)

    def aws_autoscaling_schedule(self):
        print("Processing AutoScaling Schedules...")

        as_groups = self.autoscaling_client.describe_auto_scaling_groups()[
            "AutoScalingGroups"]

        for as_group in as_groups:
            as_group_name = as_group["AutoScalingGroupName"]
            scheduled_actions = self.autoscaling_client.describe_scheduled_actions(
                AutoScalingGroupName=as_group_name)["ScheduledUpdateGroupActions"]

            for action in scheduled_actions:
                action_name = action["ScheduledActionName"]
                print(
                    f"  Processing AutoScaling Schedule: {action_name} for ASG: {as_group_name}")

                attributes = {
                    "id": action_name,
                    "name": action_name,
                    "autoscaling_group_name": as_group_name,
                    "desired_capacity": action["DesiredCapacity"],
                    "min_size": action["MinSize"],
                    "max_size": action["MaxSize"],
                }

                if "StartTime" in action:
                    attributes["start_time"] = action["StartTime"].strftime(
                        "%Y-%m-%dT%H:%M:%SZ")

                if "EndTime" in action:
                    attributes["end_time"] = action["EndTime"].strftime(
                        "%Y-%m-%dT%H:%M:%SZ")

                if "Recurrence" in action:
                    attributes["recurrence"] = action["Recurrence"]

                self.hcl.process_resource(
                    "aws_autoscaling_schedule", action_name.replace("-", "_"), attributes)

    def aws_launch_template(self, id):
        print(f"Processing Launch Template: {id}")

        try:
            response = self.ec2_client.describe_launch_templates(
                LaunchTemplateIds=[id])
        except Exception as e:
            print(f"Error retrieving Launch Template {id}: {str(e)}")
            return

        launch_templates = response.get("LaunchTemplates", [])
        if not launch_templates:
            print(f"No launch template found with ID: {id}")
            return

        launch_template = launch_templates[0]
        lt_name = launch_template["LaunchTemplateName"]
        print(f"  Processing specific Launch Template: {lt_name}")

        default_version = launch_template.get("DefaultVersionNumber")
        try:
            response_version = self.ec2_client.describe_launch_template_versions(
                LaunchTemplateId=id,
                Versions=[str(default_version)]
            )
        except Exception as e:
            print(
                f"Error retrieving version details for Launch Template {lt_name}: {str(e)}")
            return

        lt_data = response_version["LaunchTemplateVersions"][0]["LaunchTemplateData"]

        attributes = {
            "id": lt_name,
            "image_id": lt_data.get("ImageId", ""),
            "instance_type": lt_data.get("InstanceType", ""),
            # continue adding all other relevant details you need from lt_data
        }

        # If you have optional data that might not be present in every launch template,
        # you can add checks before including them in the 'attributes' dictionary.
        if "KeyName" in lt_data:
            attributes["key_name"] = lt_data["KeyName"]

        if "SecurityGroupIds" in lt_data:
            attributes["security_group_ids"] = lt_data["SecurityGroupIds"]

        if "UserData" in lt_data:
            attributes["user_data"] = lt_data["UserData"]
            self.user_data[lt_name] = attributes["user_data"]

        # more conditional attribute assignments...

        self.hcl.process_resource(
            "aws_launch_template", lt_name.replace("-", "_"), attributes)

    def aws_launch_configuration(self, id):
        print(f"Processing Launch Configuration: {id}")

        try:
            response = self.autoscaling_client.describe_launch_configurations(
                LaunchConfigurationNames=[id])
        except Exception as e:
            print(f"Error retrieving Launch Configuration {id}: {str(e)}")
            return

        launch_configurations = response.get("LaunchConfigurations", [])
        if not launch_configurations:
            print(f"No launch configuration found with name: {id}")
            return

        launch_configuration = launch_configurations[0]
        lc_name = launch_configuration["LaunchConfigurationName"]
        print(f"  Processing specific Launch Configuration: {lc_name}")

        attributes = {
            "id": lc_name,
            "image_id": launch_configuration.get("ImageId", ""),
            "instance_type": launch_configuration.get("InstanceType", ""),
            # continue adding all other relevant details you need from launch_configuration
        }

        # If you have optional data that might not be present in every launch configuration,
        # you can add checks before including them in the 'attributes' dictionary.
        if "KeyName" in launch_configuration:
            attributes["key_name"] = launch_configuration["KeyName"]

        if "SecurityGroups" in launch_configuration:
            attributes["security_groups"] = launch_configuration["SecurityGroups"]

        if "UserData" in launch_configuration:
            attributes["user_data"] = launch_configuration["UserData"]

            self.user_data[lc_name] = attributes["user_data"]

        # more conditional attribute assignments...

        self.hcl.process_resource(
            "aws_launch_configuration", lc_name.replace("-", "_"), attributes)

    def aws_cloudwatch_metric_alarm(self, alarm_name):
        print(f"Processing CloudWatch Metric Alarm: {alarm_name}")

        try:
            # Retrieve specific alarm
            alarm = self.cloudwatch_client.describe_alarms(
                AlarmNames=[alarm_name])
        except Exception as e:
            print(f"Error retrieving CloudWatch Alarm {alarm_name}: {str(e)}")
            return  # Exiting the function because there was an error retrieving the alarm

        if not alarm['MetricAlarms']:
            print(f"No alarm data found for: {alarm_name}")
            return  # Exiting the function because no alarm data was returned

        # Since we expect a specific alarm, we take the first element
        metric_alarm = alarm['MetricAlarms'][0]
        print(
            f"  Retrieved details for CloudWatch Metric Alarm: {metric_alarm['AlarmName']}")

        attributes = {
            "id": metric_alarm['AlarmName'],
            "metric_name": metric_alarm['MetricName'],
            "namespace": metric_alarm['Namespace'],
        }

        self.hcl.process_resource("aws_cloudwatch_metric_alarm",
                                  metric_alarm['AlarmName'].replace("-", "_"), attributes)
