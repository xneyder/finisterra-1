import os
from utils.hcl import HCL
import base64
import hashlib
import botocore


class KMS:
    def __init__(self, kms_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key):
        self.kms_client = kms_client

        self.transform_rules = {
            "aws_kms_key_policy": {
                "hcl_json_multiline": {"policy": True}
            },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key)
        self.resource_list = {}

    def kms(self):
        self.hcl.prepare_folder(os.path.join("generated", "kms"))

        self.aws_kms_alias()
        # self.aws_kms_ciphertext() # not needed as it not strored and it is just to encryopt data
        self.aws_kms_custom_key_store()
        self.aws_kms_external_key()
        self.aws_kms_grant()  # tf refresh gets stuck
        self.aws_kms_key()
        self.aws_kms_key_policy()
        self.aws_kms_replica_external_key()
        self.aws_kms_replica_key()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_kms_alias(self):
        print("Processing KMS Aliases...")
        aliases = self.kms_client.list_aliases()["Aliases"]

        for alias in aliases:
            alias_name = alias["AliasName"]
            target_key_id = alias.get("TargetKeyId", "")
            if not target_key_id:
                print(f"Skipping {alias_name} due to empty TargetKeyId")
                continue

            # Ignore KMS AWS managed keys
            # if target_key_id.startswith("alias/aws"):
            # continue
            print(f"  Processing KMS Alias: {alias_name}")

            attributes = {
                "id": alias_name,
                "name": alias_name,
                "target_key_id": target_key_id,
            }
            self.hcl.process_resource(
                "aws_kms_alias", alias_name.replace("-", "_"), attributes)

    def aws_kms_ciphertext(self, key_arns, plaintext_data):
        print("Processing KMS Ciphertexts...")

        for key_arn in key_arns:
            for data in plaintext_data:
                ciphertext = self.kms_client.encrypt(KeyId=key_arn, Plaintext=data)[
                    "CiphertextBlob"]
                b64_ciphertext = base64.b64encode(ciphertext).decode("utf-8")
                print(f"  Processing KMS Ciphertext for Key ARN: {key_arn}")

                attributes = {
                    "id": f"{key_arn}-{hashlib.sha1(data.encode('utf-8')).hexdigest()}",
                    "key_arn": key_arn,
                    "plaintext": data,
                    "ciphertext_base64": b64_ciphertext,
                }
                self.hcl.process_resource(
                    "aws_kms_ciphertext", f"kms_ciphertext_{attributes['id']}", attributes)

    def aws_kms_custom_key_store(self):
        print("Processing KMS Custom Key Stores...")
        custom_key_stores = self.kms_client.describe_custom_key_stores()[
            "CustomKeyStores"]

        for cks in custom_key_stores:
            cks_id = cks["CustomKeyStoreId"]
            print(f"  Processing KMS Custom Key Store: {cks_id}")

            attributes = {
                "id": cks_id,
                "custom_key_store_id": cks_id,
                "custom_key_store_name": cks["CustomKeyStoreName"],
                "cloudhsm_cluster_id": cks["CloudHsmClusterId"],
                "trust_anchor_certificate": cks["TrustAnchorCertificate"],
            }
            self.hcl.process_resource(
                "aws_kms_custom_key_store", cks_id.replace("-", "_"), attributes)

    def aws_kms_external_key(self):
        print("Processing KMS External Keys...")
        paginator = self.kms_client.get_paginator("list_keys")
        for page in paginator.paginate():
            for key in page["Keys"]:
                try:
                    key_id = key["KeyId"]
                    key_metadata = self.kms_client.describe_key(KeyId=key_id)[
                        "KeyMetadata"]

                    if key_metadata["Origin"] == "EXTERNAL":
                        print(f"  Processing KMS External Key: {key_id}")

                        attributes = {
                            "id": key_id,
                            "key_id": key_id,
                            "arn": key_metadata["Arn"],
                            "creation_date": key_metadata["CreationDate"].isoformat(),
                            "enabled": key_metadata["Enabled"],
                        }
                        self.hcl.process_resource(
                            "aws_kms_external_key", key_id.replace("-", "_"), attributes)
                except botocore.exceptions.ClientError as e:
                    print(f"  Error processing KMS Grant: {e}")

    def aws_kms_grant(self):
        print("Processing KMS Grants...")
        paginator = self.kms_client.get_paginator("list_keys")
        for page in paginator.paginate():
            for key in page["Keys"]:
                try:
                    key_id = key["KeyId"]
                    grants = self.kms_client.list_grants(KeyId=key_id)[
                        "Grants"]

                    for grant in grants:
                        grant_id = grant["GrantId"]
                        print(f"  Processing KMS Grant: {grant_id}")

                        attributes = {
                            "id": key_id+":"+grant_id,
                            # "grant_id": grant_id,
                            # "name": grant["Name"],
                            # "key_id": key_id,
                        }
                        self.hcl.process_resource(
                            "aws_kms_grant", grant_id.replace("-", "_"), attributes)
                except botocore.exceptions.ClientError as e:
                    print(f"  Error processing KMS Grant: {e}")

    def aws_kms_key(self):
        print("Processing KMS Keys...")
        paginator = self.kms_client.get_paginator("list_keys")
        for page in paginator.paginate():
            for key in page["Keys"]:
                try:
                    key_id = key["KeyId"]
                    key_metadata = self.kms_client.describe_key(KeyId=key_id)[
                        "KeyMetadata"]

                    print(f"  Processing KMS Key: {key_id}")

                    attributes = {
                        "id": key_id,
                        "key_id": key_id,
                        "arn": key_metadata["Arn"],
                        "creation_date": key_metadata["CreationDate"].isoformat(),
                        "enabled": key_metadata["Enabled"],
                        "key_usage": key_metadata["KeyUsage"],
                        "key_state": key_metadata["KeyState"],
                    }
                    self.hcl.process_resource(
                        "aws_kms_key", key_id.replace("-", "_"), attributes)
                except botocore.exceptions.ClientError as e:
                    print(f"  Error processing KMS Grant: {e}")

    def aws_kms_key_policy(self):
        print("Processing KMS Key Policies...")
        paginator = self.kms_client.get_paginator("list_keys")
        for page in paginator.paginate():
            for key in page["Keys"]:
                try:
                    key_id = key["KeyId"]
                    policy = self.kms_client.get_key_policy(
                        KeyId=key_id, PolicyName="default")["Policy"]

                    print(f"  Processing KMS Key Policy for Key: {key_id}")

                    attributes = {
                        "id": key_id,
                        "key_id": key_id,
                        "policy": policy,
                    }
                    self.hcl.process_resource(
                        "aws_kms_key_policy", key_id.replace("-", "_"), attributes)
                except botocore.exceptions.ClientError as e:
                    print(f"  Error processing KMS Grant: {e}")

    def aws_kms_replica_external_key(self):
        print("Processing KMS Replica External Keys...")
        paginator = self.kms_client.get_paginator("list_keys")
        for page in paginator.paginate():
            for key in page["Keys"]:
                try:
                    key_id = key["KeyId"]
                    key_metadata = self.kms_client.describe_key(KeyId=key_id)[
                        "KeyMetadata"]

                    if key_metadata["Origin"] == "EXTERNAL":
                        print(
                            f"  Processing KMS Replica External Key: {key_id}")

                        attributes = {
                            "id": key_id,
                            "key_id": key_id,
                            "arn": key_metadata["Arn"],
                            "creation_date": key_metadata["CreationDate"].isoformat(),
                            "enabled": key_metadata["Enabled"],
                            "key_usage": key_metadata["KeyUsage"],
                            "key_state": key_metadata["KeyState"],
                        }
                        self.hcl.process_resource(
                            "aws_kms_replica_external_key", key_id.replace("-", "_"), attributes)
                except botocore.exceptions.ClientError as e:
                    print(f"  Error processing KMS Grant: {e}")

    def aws_kms_replica_key(self):
        print("Processing KMS Replica Keys...")
        paginator = self.kms_client.get_paginator("list_keys")
        for page in paginator.paginate():
            for key in page["Keys"]:
                try:
                    key_id = key["KeyId"]
                    key_metadata = self.kms_client.describe_key(KeyId=key_id)[
                        "KeyMetadata"]

                    if key_metadata["MultiRegion"] == True:
                        print(
                            f"  Processing Multi-Region KMS Replica Key: {key_id}")

                        attributes = {
                            "id": key_id,
                            "key_id": key_id,
                            "arn": key_metadata["Arn"],
                            "creation_date": key_metadata["CreationDate"].isoformat(),
                            "enabled": key_metadata["Enabled"],
                            "key_usage": key_metadata["KeyUsage"],
                            "key_state": key_metadata["KeyState"],
                            "multi_region": key_metadata["MultiRegion"],
                        }
                        self.hcl.process_resource(
                            "aws_kms_replica_key", key_id.replace("-", "_"), attributes)
                except botocore.exceptions.ClientError as e:
                    print(f"  Error processing KMS Replica Key: {e}")
