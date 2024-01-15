import os
from utils.hcl import HCL
import base64
from providers.aws.security_group import SECURITY_GROUP
from providers.aws.kms import KMS
from providers.aws.iam_role import IAM_ROLE

class EC2:
    def __init__(self, ec2_client, autoscaling_client,  iam_client, kms_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl = None):
        self.ec2_client = ec2_client
        self.iam_client = iam_client
        self.autoscaling_client = autoscaling_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.modules = modules
        self.kms_client = kms_client
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        else:
            self.hcl = hcl

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'get_device_index': self.get_device_index,
            'get_additional_ips_count': self.get_additional_ips_count,
            'ec2_init_fields': self.ec2_init_fields,
            'get_device_name': self.get_device_name,
            'get_device_name_list': self.get_device_name_list,
            'get_user_data': self.get_user_data,
            'get_public_ip_addresses': self.get_public_ip_addresses,
            "get_subnet_name_ec2": self.get_subnet_name_ec2,
            "get_subnet_id_ec2": self.get_subnet_id_ec2,
            "get_kms_key_id_ec2": self.get_kms_key_id_ec2,
            "get_kms_key_alias_ec2": self.get_kms_key_alias_ec2,
        }

        self.hcl.functions.update(functions)

        self.resource_list = {}
        self.aws_account_id = aws_account_id
        self.additional_ips_count = 0
        self.security_group_instance = SECURITY_GROUP(ec2_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)
        self.kms_instance = KMS(kms_client, iam_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)
        self.iam_role_instance = IAM_ROLE(iam_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)        

    def ec2_init_fields(self, attributes):
        self.additional_ips_count = 0

        return None
    
    def get_public_ip_addresses(self, attributes, arg):
        result ={}
        public_ip = attributes.get("public_ip")
        if public_ip is not None:
            tags = attributes.get("tags")
            result[public_ip] = {'tags': tags }
        return result
    
    def decode_base64(self, encoded_str):
        if encoded_str is not None:
            # Decode the base64 string
            decoded_bytes = base64.b64decode(encoded_str)
            # Convert the bytes to a string
            decoded_str = decoded_bytes.decode('utf-8')
            return decoded_str
        else:
            return "No data to decode."    
    
    def get_user_data(self, attributes, arg):
        instance_id = attributes.get(arg)
        response = self.ec2_client.describe_instance_attribute(
            InstanceId=instance_id, 
            Attribute='userData'
        )
        #decode base64 response["UserData"]["value"]  and return it
        if "UserData" in response:
            if "value" in response["UserData"]:
                return self.decode_base64(response["UserData"]["Value"])
        return None

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

    def get_device_index(self, attributes):
        return attributes.get("device_index", 0)-1
    
    def get_subnet_name_ec2(self, attributes, arg):
        subnet_id = attributes.get('subnet_id')
        subnet_name = ""
        response = self.ec2_client.describe_subnets(SubnetIds=[subnet_id])

        # Check if 'Subnets' key exists and it's not empty
        if not response or 'Subnets' not in response or not response['Subnets']:
            print(
                f"No subnet information found for Subnet ID: {subnet_id}")
            return ""

        # Extract the 'Tags' key safely using get
        subnet_tags = response['Subnets'][0].get('Tags', [])

        # Extract the subnet name from the tags
        subnet_name = next(
            (tag['Value'] for tag in subnet_tags if tag['Key'] == 'Name'), None)

        return subnet_name

    def get_subnet_id_ec2(self, attributes, arg):
        subnet_name = self.get_subnet_name_ec2(attributes, arg)
        if subnet_name:
            return ""
        else:
            return attributes.get("subnet_id")  

    def get_additional_ips_count(self, attributes):
        self.additional_ips_count += 1
        return self.additional_ips_count

    def get_device_name(self, attributes):
        volume_id = attributes.get("id")
        if not volume_id:
            return None

        response = self.ec2_client.describe_volumes(VolumeIds=[volume_id])

        # Check if the volume exists and has attachments
        if response["Volumes"] and response["Volumes"][0]["Attachments"]:
            return response["Volumes"][0]["Attachments"][0]["Device"]

        return None

    def get_device_name_list(self, attributes):
        volume_id = attributes.get("id")
        device_name = self.get_device_name(attributes)
        if not device_name:
            return None

        result = {}
        result[device_name] = {}

        volume_type = attributes.get("type")
        iops = attributes.get("iops")
        throughput = attributes.get("throughput")

        if volume_type != "gp2" and iops:
            result[device_name]["iops"] = iops

        if throughput and throughput != 0:
            result[device_name]["throughput"] = throughput

        # Add other fields conditionally if they are not empty or have a non-zero value
        for key in ["size", "tags", "encrypted", "kms_key_id", "type"]:
            value = attributes.get(key)
            if key == "kms_key_id":
                # Get the key alias if it exists using boto3
                if value:
                    kms_alias = self.get_kms_alias(value)
                    if kms_alias:
                        value = kms_alias
                        key = "kms_key_alias"
            if value:
                result[device_name][key] = value

        return result
    
    # def get_kms_alias(self, kms_key_id):
    #     value = ""
    #     response = self.kms_client.list_aliases()
    #     if 'Aliases' in response and response['Aliases']:
    #         for alias in response['Aliases']:
    #             if 'TargetKeyId' in alias:
    #                 if alias['TargetKeyId'] == kms_key_id.split('/')[-1]:
    #                     value = alias['AliasName']
    #                     break
    #     return value
    
    def get_kms_alias(self, kms_key_id):
        value = ""
        response = self.kms_client.list_aliases()
        aliases = response.get('Aliases', [])
        while 'NextMarker' in response:
            response = self.kms_client.list_aliases(Marker=response['NextMarker'])
            aliases.extend(response.get('Aliases', []))
        for alias in aliases:
            if 'TargetKeyId' in alias and alias['TargetKeyId'] == kms_key_id.split('/')[-1]:
                value = alias['AliasName']
                break
        return value    
    
    def get_kms_key_id_ec2(self, attributes, arg):
        root_block_device = attributes.get("root_block_device")
        if root_block_device:
            kms_key_id = root_block_device[0].get("kms_key_id")
            kms_key_alias =  self.get_kms_alias(kms_key_id)
            if not kms_key_alias:
                return kms_key_id
        return None
    
    def get_kms_key_alias_ec2(self, attributes, arg):
        kms_key_alias = None
        root_block_device = attributes.get("root_block_device")
        if root_block_device:
            kms_key_id = root_block_device[0].get("kms_key_id")
            if kms_key_id:
                kms_key_alias =  self.get_kms_alias(kms_key_id)
        return kms_key_alias

    def ec2(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_instance()

        self.hcl.refresh_state()

        config_file_list = ["ec2.yaml", "security_group.yaml", "kms.yaml", "iam_role.yaml"]
        for index,config_file in enumerate(config_file_list):
            config_file_list[index] = os.path.join(os.path.dirname(os.path.abspath(__file__)),config_file )
        self.hcl.module_hcl_code("terraform.tfstate",config_file_list, {}, self.region, self.aws_account_id, {}, {})

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

    def aws_eip(self, allocation_id):
        print(f"Processing Elastic IP: {allocation_id}")

        eips = self.ec2_client.describe_addresses(
            AllocationIds=[allocation_id])
        if not eips["Addresses"]:
            print(f"  No Elastic IP found for Allocation ID: {allocation_id}")
            return

        eip = eips["Addresses"][0]

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
        resource_type = "aws_instance"
        print("Processing EC2 Instances...")

        instances = self.ec2_client.describe_instances()
        for reservation in instances["Reservations"]:
            for instance in reservation["Instances"]:
                instance_id = instance["InstanceId"]

                if self.is_managed_by_auto_scaling_group(instance_id):
                    print(
                        f"  Skipping EC2 Instance (managed by Auto Scaling group): {instance_id}")
                    continue

                # Check if the instance has EKS related tags and skip if it does
                eks_tags = [tag for tag in instance.get(
                    "Tags", []) if tag["Key"].startswith("kubernetes.io/cluster/")]
                if eks_tags:
                    print(
                        f"  Skipping EC2 Instance (managed by EKS): {instance_id}")
                    continue

                # if instance_id != "i-054c8a833bfb263b0" and instance_id != 'i-0beb80c7c8c16ca96':
                if instance_id != "i-054c8a833bfb263b0":
                    continue

                print(f"  Processing EC2 Instance: {instance_id}")
                id = instance_id

                ftstack = "ec2"
                try:
                    tags_response = self.ec2_client.describe_tags(
                        Filters=[{'Name': 'resource-id', 'Values': [instance_id]}]
                    )
                    tags = tags_response.get('Tags', [])
                    for tag in tags:
                        if tag['Key'] == 'ftstack':
                            if tag['Value'] != 'ec2':
                                ftstack = "stack_"+tag['Value']
                            break
                except Exception as e:
                    print("Error occurred: ", e)                

                attributes = {
                    "id": id,
                    # "ami": instance.get("ImageId", None),
                    # "instance_type": instance.get("InstanceType", None),
                    # "availability_zone": instance.get("Placement", {}).get("AvailabilityZone", None),
                    # "key_name": instance.get("KeyName", None),
                    # "subnet_id": instance.get("SubnetId", None),
                    # "vpc_security_group_ids": [sg["GroupId"] for sg in instance.get("SecurityGroups", [])],
                }

                # Call root_block_device.kms_key_id
                if "RootDeviceName" in instance:
                    print("RootDeviceName: ", instance["RootDeviceName"])
                    
                    # Get the KMS key for the root device
                    response = self.ec2_client.describe_volumes(Filters=[{
                        'Name': 'attachment.instance-id',
                        'Values': [instance_id]
                    }])
                    for volume in response['Volumes']:
                        if volume['Attachments'][0]['Device'] == instance["RootDeviceName"]:
                            if 'KmsKeyId' in volume:
                                keyArn = volume['KmsKeyId']
                                self.kms_instance.aws_kms_key(keyArn, ftstack)

                if "IamInstanceProfile" in instance:
                    attributes["iam_instance_profile"] = instance["IamInstanceProfile"]["Arn"]
                    iam_instance_profile_id = instance["IamInstanceProfile"]["Arn"].split(
                        "/")[-1]  # Updated this line
                    self.aws_iam_instance_profile(iam_instance_profile_id, ftstack)


                self.hcl.process_resource(
                    resource_type, instance_id.replace("-", "_"), attributes)
                self.hcl.add_stack(resource_type, id, ftstack)

                # Process all EIPs associated with the instance
                eips_associated = self.ec2_client.describe_addresses(Filters=[{
                    'Name': 'instance-id',
                    'Values': [instance_id]
                }])
                for eip in eips_associated["Addresses"]:
                    self.aws_eip(eip["AllocationId"])

                # Process all EBS volumes associated with the instance
                for block_device in instance.get("BlockDeviceMappings", []):
                    volume_id = block_device["Ebs"]["VolumeId"]
                    self.aws_ebs_volume(volume_id)

                    # Process the volume attachment for the EBS volume
                    self.aws_volume_attachment(instance_id, block_device)

                    #Get the KMS key for the volume
                    response = self.ec2_client.describe_volumes(VolumeIds=[block_device["Ebs"]["VolumeId"]])
                    for volume in response['Volumes']:
                        if 'KmsKeyId' in volume:
                            keyArn = volume['KmsKeyId']
                            self.kms_instance.aws_kms_key(keyArn, ftstack)

                #find the securitu groups and call self.security_group_instance.aws_security_group(sg, ftstack)
                # print(instance.get("SecurityGroups", []))
                for sg in instance.get("SecurityGroups", []):
                    self.security_group_instance.aws_security_group(sg["GroupId"], ftstack)

                # disable for now until i know how to handle private and public ips
                # for ni in instance.get("NetworkInterfaces", []):
                #     self.aws_network_interface(ni["NetworkInterfaceId"])

                #     # Process the attachment details for the additional network interface
                #     self.aws_network_interface_attachment(instance_id, ni)

    def aws_iam_instance_profile(self, iam_instance_profile_id, ftstack=None):
        resource_type = "aws_iam_instance_profile"
        print(f"Processing IAM Instance Profile: {iam_instance_profile_id}")

        # Fetch the details of IAM Instance Profile using the IAM client
        response = self.iam_client.get_instance_profile(
            InstanceProfileName=iam_instance_profile_id)

        profile = response["InstanceProfile"]
        # id = profile["InstanceProfileName"]        
        # attributes = {
        #     "id": id,
        # }

        # self.hcl.process_resource(
        #     resource_type, iam_instance_profile_id.replace("-", "_"), attributes)
        
        # if not ftstack:
        #     ftstack = "ec2"
        #     try:
        #         tags = profile.get('Tags', [])
        #         for tag in tags:
        #             if tag['Key'] == 'ftstack':
        #                 ftstack = "stack_"+tag['Value']
        #                 break
        #     except Exception as e:
        #         print("Error occurred: ", e)
        
        # self.hcl.add_stack(resource_type, id, ftstack)

        # Process only the first associated role
        for role in profile["Roles"]:
            role_name=role["RoleName"]
            self.iam_role_instance.aws_iam_role(role_name, ftstack)



        # if profile["Roles"]:
        #     self.aws_iam_role(profile["Roles"][0]["Arn"])

    def aws_iam_role(self, role_arn):
        # the role name is the last part of the ARN
        role_name = role_arn.split('/')[-1]

        role = self.iam_client.get_role(RoleName=role_name)
        print(f"Processing IAM Role: {role_name}")

        attributes = {
            "id": role_name,
        }
        self.hcl.process_resource(
            "aws_iam_role", role_name.replace("-", "_"), attributes)

    def aws_ebs_volume(self, volume_id):
        print(f"Processing EBS Volume: {volume_id}")

        volume = self.ec2_client.describe_volumes(VolumeIds=[volume_id])

        if not volume["Volumes"]:
            print(f"  No EBS Volume found for Volume ID: {volume_id}")
            return

        vol = volume["Volumes"][0]

        attributes = {
            "id": vol["VolumeId"],
            "availability_zone": vol["AvailabilityZone"],
            "size": vol["Size"],
            "state": vol["State"],
            "type": vol["VolumeType"],
            "iops": vol["Iops"] if "Iops" in vol else None,
            "encrypted": vol["Encrypted"]
        }

        if "SnapshotId" in vol:
            attributes["snapshot_id"] = vol["SnapshotId"]

        self.hcl.process_resource(
            "aws_ebs_volume", volume_id.replace("-", "_"), attributes)

    def aws_volume_attachment(self, instance_id, block_device):
        device_name = block_device["DeviceName"]
        volume_id = block_device["Ebs"]["VolumeId"]

        print(
            f"Processing EBS Volume Attachment for Volume: {volume_id} on Instance: {instance_id}")

        attributes = {
            'id': f"{device_name}:{volume_id}:{instance_id}",
            "instance_id": instance_id,
            "volume_id": volume_id,
            "device_name": device_name
        }

        self.hcl.process_resource(
            "aws_volume_attachment", volume_id.replace("-", "_"), attributes)

    def aws_network_interface(self, network_interface_id):
        print(f"Processing Network Interface: {network_interface_id}")

        network_interface = self.ec2_client.describe_network_interfaces(
            NetworkInterfaceIds=[network_interface_id])

        if not network_interface["NetworkInterfaces"]:
            print(
                f"  No Network Interface found for ID: {network_interface_id}")
            return

        ni = network_interface["NetworkInterfaces"][0]

        attachment = ni.get("Attachment")
        if not attachment:
            print(
                f"  Skipping Detached Network Interface: {network_interface_id}")
            return
        if attachment["DeviceIndex"] == 0:
            print(
                f"  Skipping Primary Network Interface: {network_interface_id}")
            return

        attributes = {
            "id": ni["NetworkInterfaceId"],
            "subnet_id": ni["SubnetId"],
            "description": ni.get("Description", ""),
            "private_ip": ni["PrivateIpAddress"],
            "security_groups": [sg["GroupId"] for sg in ni["Groups"]],
        }

        if "Association" in ni and "PublicIp" in ni["Association"]:
            attributes["public_ip"] = ni["Association"]["PublicIp"]

        self.hcl.process_resource(
            "aws_network_interface", network_interface_id.replace("-", "_"), attributes)

    def aws_network_interface_attachment(self, instance_id, network_interface):
        print(
            f"Processing Network Interface Attachment for Network Interface: {network_interface['NetworkInterfaceId']} on Instance: {instance_id}")

        if network_interface["Attachment"]["DeviceIndex"] == 0:
            print(
                f"  Skipping Primary Network Interface: {network_interface['NetworkInterfaceId']}")
            return

        attributes = {
            "id": network_interface["Attachment"]["AttachmentId"],
            "instance_id": instance_id,
            "network_interface_id": network_interface["NetworkInterfaceId"],
            "device_index": network_interface["Attachment"]["DeviceIndex"],
        }

        self.hcl.process_resource(
            "aws_network_interface_attachment", network_interface["NetworkInterfaceId"].replace("-", "_"), attributes)

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
