import os
import boto3
import os
import subprocess
import shutil
import json
from utils.hcl import HCL
from utils.filesystem import create_version_file
from providers.aws.vpc import VPC
from providers.aws.route53 import Route53
from providers.aws.acm import ACM
from providers.aws.cloudfront import CloudFront
from providers.aws.s3 import S3
from providers.aws.iam import IAM
from providers.aws.ec2 import EC2


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
            self.profile = os.getenv("AWS_PROFILE")
            if self.profile:
                self.session = boto3.Session(profile_name=self.profile)
                if self.session._session.full_config['profiles'][self.profile]['mfa_serial']:
                    print(
                        "AWS credentials not found in environment variables using profile with MFA profile.")
                    mfa_serial = self.session._session.full_config['profiles']['ae-dev']['mfa_serial']
                    mfa_token = input('Please enter your 6 digit MFA code:')
                    sts = self.session.client('sts')
                    self.MFA_validated_token = sts.get_session_token(
                        SerialNumber=mfa_serial, TokenCode=mfa_token)
            else:
                print(
                    "AWS credentials not found in environment")
                exit()

        self.provider_name = "registry.terraform.io/hashicorp/aws"
        self.script_dir = script_dir
        self.schema_data = self.load_provider_schema()

    def create_folder(self, folder):
        if not os.path.exists(folder):
            os.makedirs(folder)
            print(f"Folder '{folder}' has been created.")
        else:
            print(f"Folder '{folder}' already exists.")

    def load_provider_schema(self):
        # Remove these comments
        # self.create_folder(os.path.join("tmp"))
        os.chdir(os.path.join("tmp"))
        # create_version_file()
        # print("Initializing Terraform...")
        # subprocess.run(["terraform", "init"], check=True)

        print("Loading provider schema...")
        temp_file = 'terraform_providers_schema.json'
        # Remove these comments
        # output = open(temp_file, 'w')
        # subprocess.run(["terraform", "providers", "schema",
        #                 "-json"], check=True, stdout=output)
        with open(temp_file, "r") as schema_file:
            schema_data = json.load(schema_file)

        # remove the temporary file

        # Remove these comments
        # os.chdir(self.script_dir)
        # shutil.rmtree(os.path.join("tmp"))
        return schema_data

    def route53(self):
        route53_client = self.session.client(
            "route53", region_name=self.region)
        Route53(route53_client, self.script_dir, self.provider_name,
                self.schema_data, self.region).route53()

    def vpc(self):
        ec2_client = self.session.client("ec2", region_name=self.region)
        # ec2_client = self.session.client('ec2',
        #                                   aws_session_token=self.MFA_validated_token[
        #                                       'Credentials']['SessionToken'],
        #                                   aws_secret_access_key=self.MFA_validated_token[
        #                                       'Credentials']['SecretAccessKey'],
        #                                   aws_access_key_id=self.MFA_validated_token[
        #                                       'Credentials']['AccessKeyId'],
        #                                   region_name=self.region
        #                                   )
        VPC(ec2_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).vpc()

    def s3(self):
        s3_client = self.session.client(
            "s3", region_name=self.region)
        S3(s3_client, self.script_dir, self.provider_name,
           self.schema_data, self.region).s3()

    def iam(self):
        iam_client = self.session.client(
            "iam", region_name=self.region)
        IAM(iam_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).iam()

    def acm(self):
        acm_client = self.session.client(
            "acm", region_name=self.region)
        ACM(acm_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).acm()

    def cloudfront(self):
        cloudfront_client = self.session.client(
            "cloudfront", region_name=self.region)
        CloudFront(cloudfront_client, self.script_dir, self.provider_name,
                   self.schema_data, self.region).cloudfront()

    def ec2(self):
        ec2_client = self.session.client(
            "ec2", region_name=self.region)
        autoscaling_client = self.session.client(
            "autoscaling", region_name=self.region)
        EC2(ec2_client, autoscaling_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).ec2()
