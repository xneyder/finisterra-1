import os
import boto3
import os
import re
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
from providers.aws.ebs import EBS
from providers.aws.ecr import ECR
from providers.aws.ecr_public import ECR_PUBLIC
from providers.aws.ecs import ECS
from providers.aws.efs import EFS
from providers.aws.eks import EKS
from providers.aws.autoscaling import AutoScaling
from providers.aws.vpn_client import VpnClient
from providers.aws.docdb import DocDb
from providers.aws.opensearch import Opensearch
from providers.aws.es import ES
from providers.aws.elasticache import Elasticache
from providers.aws.dynamodb import Dynamodb
from providers.aws.cognito_identity import CognitoIdentity
from providers.aws.cognito_idp import CognitoIDP
from providers.aws.logs import Logs
from providers.aws.cloudwatch import Cloudwatch
from providers.aws.cloudtrail import Cloudtrail
from providers.aws.cloudmap import Cloudmap
from providers.aws.backup import Backup
from providers.aws.guardduty import Guardduty
from providers.aws.apigateway import Apigateway
from providers.aws.apigatewayv2 import Apigatewayv2
from providers.aws.wafv2 import Wafv2
from providers.aws.secretsmanager import Secretsmanager
from providers.aws.ssm import SSM
from providers.aws.sqs import SQS
from providers.aws.sns import SNS
from providers.aws.rds import RDS
from providers.aws.aws_lambda import AwsLambda
from providers.aws.kms import KMS
from providers.aws.elasticbeanstalk import ElasticBeanstalk
from providers.aws.elb import ELB
from providers.aws.elbv2 import ELBV2


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

    def extract_arns_from_state_file(self, file_path):
        with open(file_path, 'r') as file:
            state_data = json.load(file)

        id_mapping = {}
        resources = state_data.get('resources', [])

        for resource in resources:
            resource_type = resource.get('type', '')
            instances = resource.get('instances', [])

            for instance in instances:
                attributes = instance.get('attributes', {})
                arn = attributes.get('arn', '')

                if arn:
                    id_mapping[arn] = {'resource_type': resource_type, 'type': 'arn', 'id': instance.get('attributes').get('id')}

        return id_mapping

    def process_terraform_state_files(self, folder_path):
        id_ro_resource_type = {}

        for root, _, files in os.walk(folder_path):
            for file_name in files:
                if file_name.endswith('.tfstate'):
                    file_path = os.path.join(root, file_name)
                    id_mapping = self.extract_arns_from_state_file(file_path)
                    id_ro_resource_type.update(id_mapping)

        return id_ro_resource_type

    
    def extract_arns(self, value, resource_type, field, attributes_id, result):
        arn_pattern = re.compile(r'^arn:aws[a-zA-Z-]*:([a-zA-Z0-9-_]+):[a-z0-9-]*:[0-9]{12}:[a-zA-Z0-9-_/]+')

        if isinstance(value, list):
            for item in value:
                if arn_pattern.match(str(item)):
                    result.append({
                        "resource_type": resource_type,
                        "field": field,
                        "value": item,
                        "id": attributes_id
                    })
        elif isinstance(value, dict):
            for nested_field, nested_value in value.items():
                self.extract_arns(nested_value, resource_type, f"{field}.{nested_field}", attributes_id, result)
        elif arn_pattern.match(str(value)):
            result.append({
                "resource_type": resource_type,
                "field": field,
                "value": value,
                "id": attributes_id
            })

    def arns_from_state_file(self,file_path):
        with open(file_path, 'r') as file:
            state_data = json.load(file)

        resources = state_data.get('resources', [])
        result = []

        for resource in resources:
            resource_type = resource.get('type', '')
            instances = resource.get('instances', [])

            for instance in instances:
                attributes = instance.get('attributes', {})
                attributes_id = attributes.get('id', '')

                for field, value in attributes.items():
                    self.extract_arns(value, resource_type, field, attributes_id, result)

        return result

    def process_and_collect_arns(self,folder_path):
        all_arns = []

        for root, _, files in os.walk(folder_path):
            for file_name in files:
                if file_name.endswith('.tfstate'):
                    file_path = os.path.join(root, file_name)
                    all_arns.extend(self.arns_from_state_file(file_path))

        return all_arns
    
    def find_children(self, current_arn, collected_arns, id_ro_resource_type, relations, visited):
        if current_arn not in id_ro_resource_type or current_arn in visited:
            return

        visited.add(current_arn)
        parent_resource_type = id_ro_resource_type[current_arn]['resource_type']

        for arn_info in collected_arns:
            value = arn_info['value']
            if value == current_arn and arn_info['resource_type'] != parent_resource_type:
                if current_arn not in relations:
                    relations[current_arn] = {
                        "parent": {
                            "id": id_ro_resource_type[current_arn]['id'],
                            "resource_type": parent_resource_type,
                        },
                        "children": []
                    }

                child = {
                    "id": arn_info['id'],
                    "resource_type": arn_info['resource_type'],
                    "field": arn_info['field'],
                    "value": arn_info['value']
                }

                relations[current_arn]['children'].append(child)

                # Recursively find children of the current child
                self.find_children(child['value'], collected_arns, id_ro_resource_type, relations, visited)

    def compare_arns(self, collected_arns, id_ro_resource_type):
        relations = {}
        visited = set()

        for arn_info in collected_arns:
            value = arn_info['value']
            self.find_children(value, collected_arns, id_ro_resource_type, relations, visited)

        return relations



    def display_relations(self, relations):
        for arn, relation in relations.items():
            print("Parent:")
            print(f"ARN: {arn}")
            print("  ID:", relation['parent']['id'])
            print("  Resource Type:", relation['parent']['resource_type'])
            print("Children:")
            for child in relation['children']:
                print("  ID:", child['id'])
                print("  Resource Type:", child['resource_type'])
                print("  Field:", child['field'])
                print("  Value:", child['value'])
                print()

    def relations(self):
        tffiles_folder = os.path.join(self.script_dir, "generated")
        id_ro_resource_type = self.process_terraform_state_files(tffiles_folder)
        # print("ARN to Resource Name mapping:")
        # print(json.dumps(id_ro_resource_type, indent=2))

        collected_arns = self.process_and_collect_arns(tffiles_folder)
        # print("ARN information collected:")
        # print(json.dumps(collected_arns, indent=2))

        relations=self.compare_arns(collected_arns, id_ro_resource_type)
        self.display_relations(relations)



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

    def ebs(self):
        ec2_client = self.session.client(
            "ec2", region_name=self.region)
        autoscaling_client = self.session.client(
            "autoscaling", region_name=self.region)
        EBS(ec2_client, autoscaling_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).ebs()

    def ecr(self):
        ecr_client = self.session.client(
            "ecr", region_name=self.region)
        ECR(ecr_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).ecr()

    def ecr_public(self):
        ecr_public_client = self.session.client(
            "ecr-public", region_name=self.region)
        ECR_PUBLIC(ecr_public_client, self.script_dir, self.provider_name,
                   self.schema_data, self.region).ecr_public()

    def ecs(self):
        ecs_client = self.session.client(
            "ecs", region_name=self.region)
        ECS(ecs_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).ecs()

    def efs(self):
        efs_client = self.session.client(
            "efs", region_name=self.region)
        EFS(efs_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).efs()

    def eks(self):
        eks_client = self.session.client(
            "eks", region_name=self.region)
        EKS(eks_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).eks()

    def autoscaling(self):
        autoscaling_client = self.session.client(
            "autoscaling", region_name=self.region)

        AutoScaling(autoscaling_client, self.script_dir, self.provider_name,
                    self.schema_data, self.region).autoscaling()

    def vpn_client(self):
        ec2_client = self.session.client(
            "ec2", region_name=self.region)

        VpnClient(ec2_client, self.script_dir, self.provider_name,
                  self.schema_data, self.region).vpn_client()

    def docdb(self):
        docdb_client = self.session.client(
            "docdb", region_name=self.region)

        DocDb(docdb_client, self.script_dir, self.provider_name,
              self.schema_data, self.region).docdb()

    def opensearch(self):
        opensearch_client = self.session.client(
            "opensearch", region_name=self.region)

        Opensearch(opensearch_client, self.script_dir, self.provider_name,
                   self.schema_data, self.region).opensearch()

    def es(self):
        es_client = self.session.client(
            "es", region_name=self.region)

        ES(es_client, self.script_dir, self.provider_name,
           self.schema_data, self.region).es()

    def elasticache(self):
        elasticache_client = self.session.client(
            "elasticache", region_name=self.region)

        Elasticache(elasticache_client, self.script_dir, self.provider_name,
                    self.schema_data, self.region).elasticache()

    def dynamodb(self):
        dynamodb_client = self.session.client(
            "dynamodb", region_name=self.region)

        sts_client = self.session.client(
            "sts", region_name=self.region)
        
        account_id = sts_client.get_caller_identity()['Account']

        Dynamodb(dynamodb_client, account_id, self.script_dir, self.provider_name,
                 self.schema_data, self.region).dynamodb()

    def cognito_identity(self):
        cognito_identity_client = self.session.client(
            "cognito-identity", region_name=self.region)

        CognitoIdentity(cognito_identity_client, self.script_dir, self.provider_name,
                        self.schema_data, self.region).cognito_identity()

    def cognito_idp(self):
        cognito_idp_client = self.session.client(
            "cognito-idp", region_name=self.region)

        CognitoIDP(cognito_idp_client, self.script_dir, self.provider_name,
                   self.schema_data, self.region).cognito_idp()

    def logs(self):
        logs_client = self.session.client(
            "logs", region_name=self.region)

        Logs(logs_client, self.script_dir, self.provider_name,
             self.schema_data, self.region).logs()

    def cloudwatch(self):
        cloudwatch_client = self.session.client(
            "cloudwatch", region_name=self.region)

        Cloudwatch(cloudwatch_client, self.script_dir, self.provider_name,
                   self.schema_data, self.region).cloudwatch()

    def cloudtrail(self):
        cloudtrail_client = self.session.client(
            "cloudtrail", region_name=self.region)

        Cloudtrail(cloudtrail_client, self.script_dir, self.provider_name,
                   self.schema_data, self.region).cloudtrail()

    def cloudmap(self):
        cloudmap_client = self.session.client(
            "servicediscovery", region_name=self.region)

        route53_client = self.session.client(
            "route53", region_name=self.region)

        Cloudmap(cloudmap_client, route53_client, self.script_dir, self.provider_name,
                 self.schema_data, self.region).cloudmap()

    def backup(self):
        backup_client = self.session.client(
            "backup", region_name=self.region)

        Backup(backup_client, self.script_dir, self.provider_name,
               self.schema_data, self.region).backup()

    def guardduty(self):
        guardduty_client = self.session.client(
            "guardduty", region_name=self.region)

        Guardduty(guardduty_client, self.script_dir, self.provider_name,
                  self.schema_data, self.region).guardduty()

    def apigateway(self):
        apigateway_client = self.session.client(
            "apigateway", region_name=self.region)

        Apigateway(apigateway_client, self.script_dir, self.provider_name,
                   self.schema_data, self.region).apigateway()

    def apigatewayv2(self):
        apigatewayv2_client = self.session.client(
            "apigatewayv2", region_name=self.region)

        Apigatewayv2(apigatewayv2_client, self.script_dir, self.provider_name,
                     self.schema_data, self.region).apigatewayv2()

    def wafv2(self):
        wafv2_client = self.session.client(
            "wafv2", region_name=self.region)

        elbv2_client = self.session.client(
            "elbv2", region_name=self.region)

        Wafv2(wafv2_client, elbv2_client, self.script_dir, self.provider_name,
              self.schema_data, self.region).wafv2()

    def secretsmanager(self):
        secretsmanager_client = self.session.client(
            "secretsmanager", region_name=self.region)

        Secretsmanager(secretsmanager_client, self.script_dir, self.provider_name,
                       self.schema_data, self.region).secretsmanager()

    def ssm(self):
        ssm_client = self.session.client(
            "ssm", region_name=self.region)

        SSM(ssm_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).ssm()

    def sqs(self):
        sqs_client = self.session.client(
            "sqs", region_name=self.region)

        SQS(sqs_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).sqs()

    def sns(self):
        sns_client = self.session.client(
            "sns", region_name=self.region)

        SNS(sns_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).sns()

    def rds(self):
        rds_client = self.session.client(
            "rds", region_name=self.region)

        RDS(rds_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).rds()

    def aws_lambda(self):
        lambda_client = self.session.client(
            "lambda", region_name=self.region)

        AwsLambda(lambda_client, self.script_dir, self.provider_name,
                  self.schema_data, self.region).aws_lambda()

    def kms(self):
        kms_client = self.session.client(
            "kms", region_name=self.region)

        KMS(kms_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).kms()

    def elasticbeanstalk(self):
        elasticbeanstalk_client = self.session.client(
            "elasticbeanstalk", region_name=self.region)

        ElasticBeanstalk(elasticbeanstalk_client, self.script_dir, self.provider_name,
                         self.schema_data, self.region).elasticbeanstalk()

    def elb(self):
        elb_client = self.session.client(
            "elb", region_name=self.region)

        ELB(elb_client, self.script_dir, self.provider_name,
            self.schema_data, self.region).elb()

    def elbv2(self):
        elbv2_client = self.session.client(
            "elbv2", region_name=self.region)

        ELBV2(elbv2_client, self.script_dir, self.provider_name,
              self.schema_data, self.region).elbv2()
