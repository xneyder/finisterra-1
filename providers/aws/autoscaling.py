import os
from utils.hcl import HCL


class AutoScaling:
    def __init__(self, autoscaling_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.autoscaling_client = autoscaling_client
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

    def autoscaling(self):
        self.hcl.prepare_folder(os.path.join("generated", "autoscaling"))

        self.aws_autoscaling_attachment()
        self.aws_autoscaling_group()
        self.aws_autoscaling_group_tag()
        self.aws_autoscaling_lifecycle_hook()
        self.aws_autoscaling_notification()
        self.aws_autoscaling_policy()
        self.aws_autoscaling_schedule()
        self.aws_launch_configuration()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
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
            print(f"  Processing AutoScaling Group: {as_group_name}")

            attributes = {
                "id": as_group_name,
                # "launch_configuration": as_group["LaunchConfigurationName"],
                # "availability_zones": as_group["AvailabilityZones"],
                # "desired_capacity": as_group["DesiredCapacity"],
                # "min_size": as_group["MinSize"],
                # "max_size": as_group["MaxSize"],
                # "health_check_type": as_group["HealthCheckType"],
                # "health_check_grace_period": as_group["HealthCheckGracePeriod"],
            }

            # if "LoadBalancerNames" in as_group:
            #     attributes["load_balancers"] = as_group["LoadBalancerNames"]

            # if "TargetGroupARNs" in as_group:
            #     attributes["target_group_arns"] = as_group["TargetGroupARNs"]

            # if "VPCZoneIdentifier" in as_group:
            #     attributes["vpc_zone_identifier"] = as_group["VPCZoneIdentifier"]

            self.hcl.process_resource(
                "aws_autoscaling_group", as_group_name.replace("-", "_"), attributes)

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

    def aws_autoscaling_policy(self):
        print("Processing AutoScaling Policies...")

        as_groups = self.autoscaling_client.describe_auto_scaling_groups()[
            "AutoScalingGroups"]

        for as_group in as_groups:
            as_group_name = as_group["AutoScalingGroupName"]
            policies = self.autoscaling_client.describe_policies(
                AutoScalingGroupName=as_group_name)["ScalingPolicies"]

            for policy in policies:
                policy_name = policy["PolicyName"]
                print(
                    f"  Processing AutoScaling Policy: {policy_name} for ASG: {as_group_name}")

                attributes = {
                    "id": policy_name,
                    "autoscaling_group_name": as_group_name,
                    "adjustment_type": policy["AdjustmentType"],
                    "scaling_adjustment": policy["ScalingAdjustment"],
                }

                if "Cooldown" in policy:
                    attributes["cooldown"] = policy["Cooldown"]

                if "MinAdjustmentStep" in policy:
                    attributes["min_adjustment_step"] = policy["MinAdjustmentStep"]

                if "EstimatedInstanceWarmup" in policy:
                    attributes["estimated_instance_warmup"] = policy["EstimatedInstanceWarmup"]

                self.hcl.process_resource(
                    "aws_autoscaling_policy", policy_name.replace("-", "_"), attributes)

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

    def aws_launch_configuration(self):
        print("Processing Launch Configurations...")

        paginator = self.autoscaling_client.get_paginator(
            "describe_launch_configurations")
        for page in paginator.paginate():
            launch_configurations = page["LaunchConfigurations"]

            for launch_configuration in launch_configurations:
                lc_name = launch_configuration["LaunchConfigurationName"]
                print(f"  Processing Launch Configuration: {lc_name}")

                attributes = {
                    "id": lc_name,
                    "name": lc_name,
                    "image_id": launch_configuration["ImageId"],
                    "instance_type": launch_configuration["InstanceType"],
                }

                if "KeyName" in launch_configuration:
                    attributes["key_name"] = launch_configuration["KeyName"]

                if "SecurityGroups" in launch_configuration:
                    attributes["security_groups"] = launch_configuration["SecurityGroups"]

                if "IamInstanceProfile" in launch_configuration:
                    attributes["iam_instance_profile"] = launch_configuration["IamInstanceProfile"]

                if "UserData" in launch_configuration:
                    attributes["user_data"] = launch_configuration["UserData"]

                self.hcl.process_resource(
                    "aws_launch_configuration", lc_name.replace("-", "_"), attributes)
