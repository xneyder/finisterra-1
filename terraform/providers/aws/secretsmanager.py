import os
from utils.hcl import HCL


class SECRETSMANAGER:
    def __init__(self, secretsmanager_client, script_dir, provider_name, schema_data, region):
        self.secretsmanager_client = secretsmanager_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def secretsmanager(self):
        self.hcl.prepare_folder(os.path.join("generated", "secretsmanager"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_secretsmanager_secret(self):
        print("Processing Secrets Manager Secrets...")

        paginator = self.secretsmanager_client.get_paginator("list_secrets")
        for page in paginator.paginate():
            for secret in page["SecretList"]:
                secret_id = secret["ARN"]
                secret_name = secret["Name"]
                print(f"  Processing Secrets Manager Secret: {secret_name}")

                attributes = {
                    "id": secret_id,
                    "name": secret_name,
                }
                self.hcl.process_resource(
                    "aws_secretsmanager_secret", secret_name.replace("-", "_"), attributes)

    def aws_secretsmanager_secret_policy(self):
        print("Processing Secrets Manager Secret Policies...")

        paginator = self.secretsmanager_client.get_paginator("list_secrets")
        for page in paginator.paginate():
            for secret in page["SecretList"]:
                secret_id = secret["ARN"]
                secret_name = secret["Name"]

                try:
                    policy_response = self.secretsmanager_client.get_resource_policy(
                        SecretId=secret_id)
                    policy = policy_response["ResourcePolicy"]
                    print(
                        f"  Processing Secrets Manager Secret Policy for Secret: {secret_name}")

                    attributes = {
                        "id": secret_id,
                        "secret_arn": secret_id,
                        "policy": policy,
                    }
                    self.hcl.process_resource(
                        "aws_secretsmanager_secret_policy", secret_name.replace("-", "_"), attributes)
                except self.secretsmanager_client.exceptions.ResourceNotFoundException:
                    print(f"  No policy found for Secret: {secret_name}")

    def aws_secretsmanager_secret_rotation(self):
        print("Processing Secrets Manager Secret Rotations...")

        paginator = self.secretsmanager_client.get_paginator("list_secrets")
        for page in paginator.paginate():
            for secret in page["SecretList"]:
                secret_id = secret["ARN"]
                secret_name = secret["Name"]

                try:
                    rotation_response = self.secretsmanager_client.describe_secret(
                        SecretId=secret_id)
                    rotation_enabled = rotation_response["RotationEnabled"]
                    if rotation_enabled:
                        rotation_lambda_arn = rotation_response["RotationLambdaARN"]
                        rotation_rules = rotation_response["RotationRules"]

                        print(
                            f"  Processing Secrets Manager Secret Rotation for Secret: {secret_name}")

                        attributes = {
                            "id": secret_id,
                            "secret_arn": secret_id,
                            "rotation_lambda_arn": rotation_lambda_arn,
                            "rotation_rules": {
                                "automatically_after_days": rotation_rules["AutomaticallyAfterDays"],
                            },
                        }
                        self.hcl.process_resource(
                            "aws_secretsmanager_secret_rotation", secret_name.replace("-", "_"), attributes)
                except KeyError:
                    print(f"  No rotation found for Secret: {secret_name}")

    def aws_secretsmanager_secret_version(self):
        print("Processing Secrets Manager Secret Versions...")

        paginator = self.secretsmanager_client.get_paginator("list_secrets")
        for page in paginator.paginate():
            for secret in page["SecretList"]:
                secret_id = secret["ARN"]
                secret_name = secret["Name"]

                version_paginator = self.secretsmanager_client.get_paginator(
                    "list_secret_version_ids")
                for version_page in version_paginator.paginate(SecretId=secret_id):
                    for version in version_page["Versions"]:
                        version_id = version["VersionId"]

                        if "AWSCURRENT" in version["VersionStages"]:
                            print(
                                f"  Processing Secrets Manager Secret Version: {version_id} for Secret: {secret_name}")

                            attributes = {
                                "id": f"{secret_id}|{version_id}",
                                "secret_id": secret_id,
                                "version_id": version_id,
                            }
                            self.hcl.process_resource(
                                "aws_secretsmanager_secret_version", f"{secret_name.replace('-', '_')}_version_{version_id.replace('-', '_')}", attributes)