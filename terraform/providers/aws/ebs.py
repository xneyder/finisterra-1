import os
from utils.hcl import HCL


class EBS:
    def __init__(self, ec2_client, script_dir, provider_name, schema_data, region):
        self.ec2_client = ec2_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def acm(self):
        self.hcl.prepare_folder(os.path.join("generated", "acm"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_ebs_default_kms_key(self):
        print("Processing EBS Default KMS Key...")

        default_kms_key = self.ec2_client.get_ebs_default_kms_key_id()[
            "KmsKeyId"]
        print(f"  Processing EBS Default KMS Key: {default_kms_key}")

        attributes = {
            "id": default_kms_key,
        }
        self.hcl.process_resource(
            "aws_ebs_default_kms_key", default_kms_key.replace("-", "_"), attributes)

    def aws_ebs_encryption_by_default(self):
        print("Processing EBS Encryption By Default...")

        encryption_by_default = self.ec2_client.get_ebs_encryption_by_default()[
            "EbsEncryptionByDefault"]

        attributes = {
            "id": "default",
            "enabled": encryption_by_default,
        }
        self.hcl.process_resource(
            "aws_ebs_encryption_by_default", "default", attributes)

    def aws_ebs_snapshot(self):
        print("Processing EBS Snapshots...")

        snapshots = self.ec2_client.describe_snapshots(OwnerIds=["self"])[
            "Snapshots"]

        for snapshot in snapshots:
            snapshot_id = snapshot["SnapshotId"]
            print(f"  Processing EBS Snapshot: {snapshot_id}")

            attributes = {
                "id": snapshot_id,
                "volume_id": snapshot["VolumeId"],
                "description": snapshot.get("Description", ""),
            }
            self.hcl.process_resource(
                "aws_ebs_snapshot", snapshot_id.replace("-", "_"), attributes)

    def aws_ebs_volume(self):
        print("Processing EBS Volumes...")

        volumes = self.ec2_client.describe_volumes()["Volumes"]

        for volume in volumes:
            volume_id = volume["VolumeId"]
            print(f"  Processing EBS Volume: {volume_id}")

            attributes = {
                "id": volume_id,
                "availability_zone": volume["AvailabilityZone"],
                "size": volume["Size"],
                "type": volume["VolumeType"],
                "encrypted": volume["Encrypted"],
                "kms_key_id": volume.get("KmsKeyId", ""),
            }
            self.hcl.process_resource(
                "aws_ebs_volume", volume_id.replace("-", "_"), attributes)

    def aws_snapshot_create_volume_permission(self):
        print("Processing Snapshot Create Volume Permissions...")

        snapshots = self.ec2_client.describe_snapshots(OwnerIds=["self"])[
            "Snapshots"]

        for snapshot in snapshots:
            snapshot_id = snapshot["SnapshotId"]
            permissions = self.ec2_client.describe_snapshot_attribute(
                SnapshotId=snapshot_id, Attribute="createVolumePermission"
            )["CreateVolumePermissions"]

            for permission in permissions:
                user_id = permission["UserId"]

                print(
                    f"  Processing Snapshot Create Volume Permission for Snapshot: {snapshot_id}, User ID: {user_id}")

                attributes = {
                    "id": f"{snapshot_id}-{user_id}",
                    "snapshot_id": snapshot_id,
                    "user_id": user_id,
                }
                self.hcl.process_resource(
                    "aws_snapshot_create_volume_permission", f"{snapshot_id}-{user_id}".replace(
                        "-", "_"), attributes
                )

    def aws_volume_attachment(self):
        print("Processing Volume Attachments...")

        volumes = self.ec2_client.describe_volumes()["Volumes"]

        for volume in volumes:
            volume_id = volume["VolumeId"]

            if "Attachments" in volume:
                for attachment in volume["Attachments"]:
                    instance_id = attachment["InstanceId"]
                    device_name = attachment["Device"]

                    print(
                        f"  Processing Volume Attachment: {volume_id} -> Instance: {instance_id}")

                    attachment_id = f"{volume_id}-{instance_id}"
                    attributes = {
                        "id": attachment_id,
                        "volume_id": volume_id,
                        "instance_id": instance_id,
                        "device_name": device_name,
                    }
                    self.hcl.process_resource(
                        "aws_volume_attachment", attachment_id.replace(
                            "-", "_"), attributes
                    )
