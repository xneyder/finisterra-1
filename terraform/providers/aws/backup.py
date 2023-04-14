import os
from utils.hcl import HCL


class Backup:
    def __init__(self, backup_client, script_dir, provider_name, schema_data, region):
        self.backup_client = backup_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def backup(self):
        self.hcl.prepare_folder(os.path.join("generated", "backup"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_backup_plan(self):
        print("Processing AWS Backup Plans...")

        paginator = self.backup_client.get_paginator("list_backup_plans")
        for page in paginator.paginate():
            for backup_plan in page["BackupPlansList"]:
                backup_plan_id = backup_plan["BackupPlanId"]
                plan = self.backup_client.get_backup_plan(
                    BackupPlanId=backup_plan_id)["BackupPlan"]
                print(f"  Processing AWS Backup Plan: {backup_plan_id}")

                attributes = {
                    "id": backup_plan_id,
                    "name": plan["BackupPlanName"],
                    "version": plan["VersionId"],
                    "arn": plan["BackupPlanArn"],
                    "rule": plan["Rules"],
                }
                self.hcl.process_resource(
                    "aws_backup_plan", backup_plan_id.replace("-", "_"), attributes)

    def aws_backup_vault(self):
        print("Processing AWS Backup Vaults...")

        paginator = self.backup_client.get_paginator("list_backup_vaults")
        for page in paginator.paginate():
            for backup_vault in page["BackupVaultList"]:
                backup_vault_name = backup_vault["BackupVaultName"]
                vault = self.backup_client.describe_backup_vault(
                    BackupVaultName=backup_vault_name)
                print(f"  Processing AWS Backup Vault: {backup_vault_name}")

                attributes = {
                    "id": backup_vault_name,
                    "name": vault["BackupVaultName"],
                    "arn": vault["BackupVaultArn"],
                    "recovery_points": vault["NumberOfRecoveryPoints"],
                }

                if "EncryptionKeyArn" in vault:
                    attributes["kms_key_arn"] = vault["EncryptionKeyArn"]

                self.hcl.process_resource(
                    "aws_backup_vault", backup_vault_name.replace("-", "_"), attributes)