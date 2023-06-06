import os
from utils.hcl import HCL


class EC2:
    def __init__(self, ec2_client, autoscaling_client,  script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key):
        self.ec2_client = ec2_client
        self.autoscaling_client = autoscaling_client
        self.transform_rules = {
            "aws_instance": {
                "hcl_keep_fields": {"instance_type": True,
                                    "ami": True,
                                    "launch_template.name": True,
                                    },
            },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key)
        self.resource_list = {}

    def ec2(self):
        self.hcl.prepare_folder(os.path.join("generated", "ec2"))

        self.aws_ami()
        self.aws_ami_launch_permission()
        self.aws_ec2_capacity_reservation()
        self.aws_ec2_host()
        # self.aws_ec2_serial_console_access()  # no api in boto3
        # self.aws_ec2_tag()  # Blocking now because is long running
        self.aws_eip()
        self.aws_eip_association()
        self.aws_instance()
        self.aws_key_pair()
        self.aws_launch_template()
        self.aws_placement_group()
        if "gov" not in self.region:
            self.aws_spot_datafeed_subscription()
        self.aws_spot_fleet_request()
        self.aws_spot_instance_request()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_ami(self):
        print("Processing AMIs...")

        images = self.ec2_client.describe_images(Owners=["self"])["Images"]

        for image in images:
            image_id = image["ImageId"]
            print(f"  Processing AMI: {image_id}")

            attributes = {
                "id": image_id,
                "name": image["Name"],
                "description": image.get("Description", ""),
                "architecture": image["Architecture"],
                "virtualization_type": image["VirtualizationType"],
            }
            self.hcl.process_resource(
                "aws_ami", image_id.replace("-", "_"), attributes
            )

    def aws_ami_launch_permission(self):
        print("Processing AMI Launch Permissions...")

        images = self.ec2_client.describe_images(Owners=["self"])["Images"]

        for image in images:
            image_id = image["ImageId"]

            launch_permissions = self.ec2_client.describe_image_attribute(
                ImageId=image_id, Attribute="launchPermission")["LaunchPermissions"]

            for permission in launch_permissions:
                user_id = permission["UserId"]
                print(
                    f"  Processing Launch Permission for AMI: {image_id}, User: {user_id}")

                attributes = {
                    "id": f"{image_id}-{user_id}",
                    "image_id": image_id,
                    "user_id": user_id,
                }
                self.hcl.process_resource(
                    "aws_ami_launch_permission", attributes["id"].replace(
                        "-", "_"), attributes
                )

    def aws_ec2_capacity_reservation(self):
        print("Processing EC2 Capacity Reservations...")

        capacity_reservations = self.ec2_client.describe_capacity_reservations()[
            "CapacityReservations"]

        for reservation in capacity_reservations:
            reservation_id = reservation["CapacityReservationId"]
            print(f"  Processing EC2 Capacity Reservation: {reservation_id}")

            attributes = {
                "id": reservation_id,
                "availability_zone": reservation["AvailabilityZone"],
                "instance_type": reservation["InstanceType"],
                "instance_platform": reservation["InstancePlatform"],
                "instance_count": reservation["TotalInstanceCount"],
                "tenancy": reservation["Tenancy"],
                "ebs_optimized": reservation["EbsOptimized"],
                "end_date_type": reservation["EndDateType"],
                "ephemeral_storage": reservation["EphemeralStorage"],
                "instance_match_criteria": reservation["InstanceMatchCriteria"],
            }
            if "EndDate" in reservation:
                attributes["end_date"] = reservation["EndDate"].isoformat

    def aws_ec2_host(self):
        print("Processing EC2 Dedicated Hosts...")

        hosts = self.ec2_client.describe_hosts()["Hosts"]

        for host in hosts:
            host_id = host["HostId"]
            print(f"  Processing EC2 Dedicated Host: {host_id}")

            attributes = {
                "id": host_id,
                "availability_zone": host["AvailabilityZone"],
                "instance_type": host["InstanceType"],
                "auto_placement": host["AutoPlacement"],
                "host_recovery": host["HostRecovery"],
            }
            if "Arn" in host:
                attributes["arn"] = host["Arn"]

            self.hcl.process_resource(
                "aws_ec2_host", host_id.replace("-", "_"), attributes
            )

    # def aws_ec2_serial_console_access(self):
    #     print("Processing EC2 Serial Console Access...")

    #     serial_console_access = self.ec2_client.describe_serial_console_access()
    #     status = serial_console_access["SerialConsoleAccess"]["Status"]

    #     attributes = {
    #         "status": status,
    #     }

    #     self.hcl.process_resource(
    #         "aws_ec2_serial_console_access", "serial_console_access", attributes
    #     )

    def aws_ec2_tag(self):
        print("Processing EC2 Tags...")

        resources = self.ec2_client.describe_tags()
        for resource in resources["Tags"]:
            resource_id = resource["ResourceId"]
            resource_type = resource["ResourceType"]
            key = resource["Key"]
            value = resource["Value"]

            tag_id = f"{resource_id},{key}"
            print(f"  Processing EC2 Tag: {tag_id}")

            attributes = {
                "id": tag_id,
                "resource_id": resource_id,
                "key": key,
                "value": value,
            }
            self.hcl.process_resource(
                "aws_ec2_tag", tag_id.replace("-", "_"), attributes)

    def aws_eip(self):
        print("Processing Elastic IPs...")

        eips = self.ec2_client.describe_addresses()
        for eip in eips["Addresses"]:
            allocation_id = eip["AllocationId"]
            print(f"  Processing Elastic IP: {allocation_id}")

            attributes = {
                "id": allocation_id,
                "public_ip": eip["PublicIp"],
            }

            if "InstanceId" in eip:
                attributes["instance"] = eip["InstanceId"]

            if "NetworkInterfaceId" in eip:
                attributes["network_interface"] = eip["NetworkInterfaceId"]

            if "PrivateIpAddress" in eip:
                attributes["private_ip"] = eip["PrivateIpAddress"]

            self.hcl.process_resource(
                "aws_eip", allocation_id.replace("-", "_"), attributes)

    def aws_eip_association(self):
        print("Processing Elastic IP Associations...")

        eips = self.ec2_client.describe_addresses()
        for eip in eips["Addresses"]:
            if "AssociationId" in eip:
                association_id = eip["AssociationId"]
                print(f"  Processing Elastic IP Association: {association_id}")

                attributes = {
                    "id": association_id,
                    "allocation_id": eip["AllocationId"],
                }

                if "InstanceId" in eip:
                    attributes["instance_id"] = eip["InstanceId"]

                if "NetworkInterfaceId" in eip:
                    attributes["network_interface_id"] = eip["NetworkInterfaceId"]

                if "PrivateIpAddress" in eip:
                    attributes["private_ip_address"] = eip["PrivateIpAddress"]

                self.hcl.process_resource(
                    "aws_eip_association", association_id.replace("-", "_"), attributes)

    def is_managed_by_auto_scaling_group(self, instance_id):
        response = self.autoscaling_client.describe_auto_scaling_instances(InstanceIds=[
                                                                           instance_id])
        return bool(response["AutoScalingInstances"])

    def aws_instance(self):
        print("Processing EC2 Instances...")

        instances = self.ec2_client.describe_instances()
        for reservation in instances["Reservations"]:
            for instance in reservation["Instances"]:
                instance_id = instance["InstanceId"]

                if self.is_managed_by_auto_scaling_group(instance_id):
                    print(
                        f"  Skipping EC2 Instance (managed by Auto Scaling group): {instance_id}")
                    continue

                print(f"  Processing EC2 Instance: {instance_id}")

                attributes = {
                    "id": instance_id,
                    "ami": instance.get("ImageId", None),
                    "instance_type": instance.get("InstanceType", None),
                    "availability_zone": instance.get("Placement", None).get("AvailabilityZone", None),
                    "key_name": instance.get("KeyName", None),
                    "subnet_id": instance.get("SubnetId", None),
                    "vpc_security_group_ids": [sg["GroupId"] for sg in instance["SecurityGroups"]],
                }

                if "IamInstanceProfile" in instance:
                    attributes["iam_instance_profile"] = instance["IamInstanceProfile"]["Arn"]

                if "UserData" in instance:
                    attributes["user_data"] = instance["UserData"]

                self.hcl.process_resource(
                    "aws_instance", instance_id.replace("-", "_"), attributes)

    def aws_key_pair(self):
        print("Processing EC2 Key Pairs...")

        key_pairs = self.ec2_client.describe_key_pairs(
            IncludePublicKey=True)["KeyPairs"]
        for key_pair in key_pairs:
            key_pair_name = key_pair["KeyName"]
            print(f"  Processing Key Pair: {key_pair_name}")

            attributes = {
                "id": key_pair_name,
                "public_key": key_pair["PublicKey"],
                # "key_name": key_pair_name,
                # "fingerprint": key_pair["KeyFingerprint"],
            }
            self.hcl.process_resource(
                "aws_key_pair", key_pair_name.replace("-", "_"), attributes)

    def aws_launch_template(self):
        print("Processing EC2 Launch Templates...")

        launch_templates = self.ec2_client.describe_launch_templates()[
            "LaunchTemplates"]
        for launch_template in launch_templates:
            launch_template_id = launch_template["LaunchTemplateId"]
            print(f"  Processing Launch Template: {launch_template_id}")

            attributes = {
                "id": launch_template_id,
                "name": launch_template.get("LaunchTemplateName", None),
                "arn": launch_template.get("LaunchTemplateArn", None),
                "default_version": launch_template.get("DefaultVersionNumber", None),
                "latest_version": launch_template.get("LatestVersionNumber", None),
            }
            self.hcl.process_resource(
                "aws_launch_template", launch_template_id.replace("-", "_"), attributes)

    def aws_placement_group(self):
        print("Processing EC2 Placement Groups...")

        placement_groups = self.ec2_client.describe_placement_groups()[
            "PlacementGroups"]
        for placement_group in placement_groups:
            placement_group_name = placement_group["GroupName"]
            print(f"  Processing Placement Group: {placement_group_name}")

            attributes = {
                "id": placement_group_name,
                "name": placement_group_name,
                "strategy": placement_group["Strategy"],
            }
            self.hcl.process_resource(
                "aws_placement_group", placement_group_name.replace("-", "_"), attributes)

    def aws_spot_datafeed_subscription(self):
        print("Processing EC2 Spot Datafeed Subscriptions...")

        try:
            spot_datafeed_subscription = self.ec2_client.describe_spot_datafeed_subscription()
            subscription = spot_datafeed_subscription["SpotDatafeedSubscription"]

            bucket_id = subscription["Bucket"]
            print(f"  Processing Spot Datafeed Subscription: {bucket_id}")

            attributes = {
                "id": subscription["OwnerId"],
                "bucket": bucket_id,
                "prefix": subscription.get("Prefix", ""),
            }
            self.hcl.process_resource(
                "aws_spot_datafeed_subscription", bucket_id.replace("-", "_"), attributes)
        except self.ec2_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] == "InvalidSpotDatafeed.NotFound":
                print("  No Spot Datafeed Subscriptions found")
            else:
                raise

    def aws_spot_fleet_request(self):
        print("Processing EC2 Spot Fleet Requests...")

        spot_fleet_requests = self.ec2_client.describe_spot_fleet_requests()[
            "SpotFleetRequestConfigs"]
        for spot_fleet_request in spot_fleet_requests:
            request_id = spot_fleet_request["SpotFleetRequestId"]
            print(f"  Processing Spot Fleet Request: {request_id}")

            attributes = {
                "id": request_id,
                "spot_price": spot_fleet_request["SpotPrice"],
                "iam_fleet_role": spot_fleet_request["IamFleetRole"],
                "target_capacity": spot_fleet_request["TargetCapacity"],
            }
            self.hcl.process_resource(
                "aws_spot_fleet_request", request_id.replace("-", "_"), attributes)

    def aws_spot_instance_request(self):
        print("Processing EC2 Spot Instance Requests...")

        spot_instance_requests = self.ec2_client.describe_spot_instance_requests()[
            "SpotInstanceRequests"]
        for spot_instance_request in spot_instance_requests:
            request_id = spot_instance_request["SpotInstanceRequestId"]
            print(f"  Processing Spot Instance Request: {request_id}")

            attributes = {
                "id": request_id,
                "spot_price": spot_instance_request["SpotPrice"],
                "instance_type": spot_instance_request["LaunchSpecification"]["InstanceType"],
                "availability_zone_group": spot_instance_request.get("AvailabilityZoneGroup", ""),
            }
            self.hcl.process_resource(
                "aws_spot_instance_request", request_id.replace("-", "_"), attributes)
