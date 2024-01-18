import os
from utils.hcl import HCL
import botocore

class CodeArtifact:
    def __init__(self, aws_clients, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id,hcl = None):
        self.aws_clients = aws_clients
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.aws_account_id = aws_account_id

        self.workspace_id = workspace_id
        self.modules = modules
        if hcl:
            self.hcl = hcl
        else:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}


        self.load_balancers = None
        self.listeners = {}

        functions = {}        

        self.hcl.functions.update(functions)


    def codeartifact(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_codeartifact_domain()

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate","../providers/aws/", {}, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

    def aws_codeartifact_domain(self, domain_name=None, ftstack=None):
        print("Processing CodeArtifact Domains")

        if domain_name:
            self.process_single_codeartifact_domain(domain_name, ftstack)
            return

        paginator = self.aws_clients.codeartifact_client.get_paginator('list_domains')
        for response in paginator.paginate():
            for domain in response["domains"]:
                domain_name = domain["name"]
                domain_arn = domain["arn"]
                self.process_single_codeartifact_domain(domain_name, ftstack)

                try:
                    policy = self.aws_clients.codeartifact_client.get_domain_permissions_policy(domain=domain_name)
                    if policy["policy"]:
                        document = policy["policy"]["document"]
                        self.aws_codeartifact_domain_permissions_policy(domain_arn)
                except botocore.exceptions.ClientError as error:
                    # Ignore ResourceNotFoundException and continue
                    pass

    def process_single_codeartifact_domain(self, domain_name, ftstack=None):
        resource_type = "aws_codeartifact_domain"
        domain_info = self.aws_clients.codeartifact_client.describe_domain(domain=domain_name)
        domain_arn = domain_info["domain"]["arn"]
        print(f"  Processing CodeArtifact Domain: {domain_name}")

        id = domain_arn
        attributes = {
            "id": id,
        }

        if not ftstack:
            ftstack = "code_artifact"
            # Retrieve and process domain tags if they exist
            domain_tags = self.aws_clients.codeartifact_client.list_tags_for_resource(resourceArn=domain_arn)
            for tag in domain_tags.get('Tags', []):
                if tag["Key"] == "ftstack":
                    ftstack = tag["Value"]
                    break

        self.hcl.process_resource(resource_type, id, attributes)
        self.hcl.add_stack(resource_type, id, ftstack)

        # Process repositories in the specified domain
        repositories = self.aws_clients.codeartifact_client.list_repositories_in_domain(domain=domain_name)
        for repository in repositories["repositories"]:
            repository_name = repository["name"]
            repository_arn = repository["arn"]
            self.aws_codeartifact_repository(domain_name, repository_arn, repository_name)
    
    def aws_codeartifact_repository(self, domain_name, repository_arn, repository_name):
        print("Processing CodeArtifact Repositories")
        resource_type = "aws_codeartifact_repository"

        # response = self.aws_clients.codeartifact_client.describe_repository(domain=domain_name, repository=repository_arn)
                                
        print(f"  Processing CodeArtifact Repository: {repository_arn}")

        # repository_arn = f"arn:aws:codeartifact:{self.region}:{self.aws_account_id}:repository/{repository_name}"
        id = repository_arn
        attributes = {
            "id": id,
        }
        
        self.hcl.process_resource(
            resource_type, id, attributes)
        
        policy = self.aws_clients.codeartifact_client.get_repository_permissions_policy(
            domain=domain_name, repository=repository_name)
        
        if policy["policy"]:
            self.aws_codeartifact_repository_permissions_policy(repository_arn)
            
    def aws_codeartifact_repository_permissions_policy(self, repository_arn):
        print("Processing CodeArtifact Repository Permissions Policy")
        resource_type = "aws_codeartifact_repository_permissions_policy"
        id = repository_arn
        attributes = {
            "id": id,
        }
        self.hcl.process_resource(resource_type, id, attributes)

    def aws_codeartifact_domain_permissions_policy(self, domain_name_arn):
        print("Processing CodeArtifact Domain Permissions Policy")
        resource_type = "aws_codeartifact_domain_permissions_policy"
        id = domain_name_arn
        attributes = {
            "id": id,
        }
        self.hcl.process_resource(resource_type, id, attributes)

