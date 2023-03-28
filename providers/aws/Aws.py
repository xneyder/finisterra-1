import os
import boto3
import os
import subprocess
import shutil
import json
from utils.hcl import HCL
from providers.aws.vpc import VPC
from providers.aws.route53 import Route53
from utils.filesystem import create_version_file

class Aws:
    def __init__(self, script_dir):
        self.aws_access_key_id = os.getenv("AWS_ACCESS_KEY_ID")
        self.aws_secret_access_key = os.getenv("AWS_SECRET_ACCESS_KEY")
        self.aws_session_token = os.getenv("AWS_SESSION_TOKEN")
        self.region = os.getenv("AWS_REGION")

        if self.aws_access_key_id and self.aws_secret_access_key and self.region:
            self.session = boto3.Session(
                aws_access_key_id=self.aws_access_key_id,
                aws_secret_access_key=self.aws_secret_access_key,
                aws_session_token=self.aws_session_token,
                region_name=self.region,
            )
        else:
            print("AWS credentials not found in environment variables.")
            exit()

        self.provider_name = "registry.terraform.io/hashicorp/aws"
        self.script_dir = script_dir
        self.schema_data=self.load_provider_schema()

    def create_folder(self,folder):
        if not os.path.exists(folder):
            os.makedirs(folder)
            print(f"Folder '{folder}' has been created.")
        else:
            print(f"Folder '{folder}' already exists.")
    
    def load_provider_schema(self):
        self.create_folder(os.path.join("tmp"))
        os.chdir(os.path.join("tmp"))
        create_version_file()
        print("Initializing Terraform...")
        subprocess.run(["terraform", "init"], check=True)
        print("Loading provider schema...")
        temp_file='terraform_providers_schema.json'
        # Load the provider schema using the terraform cli
        output = open(temp_file, 'w')
        subprocess.run(["terraform", "providers", "schema",
                    "-json"], check=True, stdout=output)
        with open(temp_file, "r") as schema_file:
            schema_data = json.load(schema_file)
        # remove the temporary file
        os.chdir(self.script_dir)
        shutil.rmtree(os.path.join("tmp"))
        return schema_data

    def route53(self):
        Route53(self.session, self.script_dir, self.provider_name, self.schema_data, self.region).route53()

    def vpc(self):
        VPC(self.session, self.script_dir, self.provider_name, self.schema_data, self.region).vpc()

