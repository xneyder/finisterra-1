import os
from utils.hcl import HCL
import json


class ECR_PUBLIC:
    def __init__(self, ecr_public_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, aws_partition):
        self.ecr_public_client = ecr_public_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}

    def ecr_public(self):
        self.hcl.prepare_folder(os.path.join("generated", "ecr_public"))

        if "gov" not in self.region:
            self.aws_ecrpublic_repository()  # -
            self.aws_ecrpublic_repository_policy()  # -

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_ecrpublic_repository(self):
        print("Processing ECR Public Repositories...")

        repositories = self.ecr_public_client.describe_repositories()[
            "repositories"]
        for repo in repositories:
            repository_name = repo["repositoryName"]
            repository_arn = repo["repositoryArn"]

            print(f"  Processing ECR Public Repository: {repository_name}")

            attributes = {
                "id": repository_name,
            }
            self.hcl.process_resource(
                "aws_ecrpublic_repository", repository_name.replace("-", "_"), attributes)

    def aws_ecrpublic_repository_policy(self):
        print("Processing ECR Public Repository Policies...")

        repositories = self.ecr_public_client.describe_repositories()[
            "repositories"]
        for repo in repositories:
            repository_name = repo["repositoryName"]
            repository_arn = repo["repositoryArn"]

            try:
                policy = self.ecr_public_client.get_repository_policy(
                    repositoryName=repository_name)
            except self.ecr_public_client.exceptions.RepositoryPolicyNotFoundException:
                continue

            policy_text = json.loads(policy["policyText"])

            print(
                f"  Processing ECR Public Repository Policy for: {repository_name}")

            attributes = {
                "id": repository_name,
                "policy": json.dumps(policy_text, indent=2),
            }
            self.hcl.process_resource("aws_ecrpublic_repository_policy",
                                      f"{repository_name}_policy".replace("-", "_"), attributes)
