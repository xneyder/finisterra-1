import os
import json
import traceback
from kafka import KafkaConsumer
from dotenv import load_dotenv
from typing import Dict
import sys
from providers.aws.Aws import Aws
from db.scan import get_scan_by_id, update_scan_status
from db.workspace import update_workspace
from utils.git import Git
from utils.terraform import Terraform
import shutil
from db.terraform_module_instance import get_terraform_modules_by_workspace_id
import re
from collections import OrderedDict


# Load environment variables from .env file
load_dotenv()

KAFKA_BROKER = os.environ.get("KAFKA_BROKER")
KAFKA_TOPIC = os.environ.get("SCAN_KAFKA_TOPIC")


def get_variables_from_terraform_file(file_path):
    with open(file_path, 'r') as file:
        data = file.read()
        variable_names = re.findall(r'variable\s+"([^"]+)"', data)
    return variable_names


def main():
    consumer_kwargs = {
        "bootstrap_servers": KAFKA_BROKER.split(','),
        "value_deserializer": lambda v: json.loads(v.decode('utf-8')),
        "auto_offset_reset": 'earliest',
        "group_id": KAFKA_TOPIC,
        "max_poll_records": 1,
        "enable_auto_commit": False,
        "max_poll_interval_ms":  1800000  # 30 minutes in milliseconds

    }

    kafka_ssl = os.getenv('KAFKA_SSL')
    if kafka_ssl and kafka_ssl.lower() == 'true':
        consumer_kwargs["security_protocol"] = 'SSL'

    consumer = KafkaConsumer(KAFKA_TOPIC, **consumer_kwargs)

    script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))

    for message in consumer:
        task = message.value
        id_token = task['idToken']
        scan_id = task['scanId']

        # Get the scan with the given ID
        scan = get_scan_by_id(scan_id)
        if scan is None:
            print(f"No scan found with ID {scan_id}")
            continue

        update_scan_status(scan_id, "IN_PROGRESS")
        provider_name = task['provider_name']
        if provider_name == 'aws':
            try:
                # Extract the values you need
                role_arn = scan.workspace.awsAccount.roleArn
                session_duration = scan.workspace.awsAccount.sessionDuration
                aws_region = scan.workspace.awsRegion
                workspace_id = scan.workspace.id
                provider_group_code = scan.workspace.providerGroup.code

                github_installation_id = scan.workspace.awsAccount.awsAccountGitRepos[
                    0].gitRepo.githubAccount.installationId
                git_repo_id = scan.workspace.awsAccount.awsAccountGitRepos[0].gitRepo.gitrepoId
                git_repo_path = scan.workspace.gitPath
                s3Bucket = scan.workspace.awsAccount.awsStateConfigs[0].s3Bucket
                dynamoDBTable = scan.workspace.awsAccount.awsStateConfigs[0].dynamoDBTable
                git_repo_branch = scan.workspace.awsAccount.awsAccountGitRepos[0].branch

                os.chdir(script_dir)
                local_path = os.path.join(
                    script_dir, "generated", provider_group_code)
                git_repo = Git(github_installation_id=github_installation_id,
                               git_repo_id=git_repo_id,
                               local_path=local_path,
                               git_repo_path=git_repo_path,
                               git_repo_branch=git_repo_path,
                               git_target_branch=git_repo_branch,
                               workspace_id=workspace_id)

                # Get modules in workspace
                modules = OrderedDict()
                db_modules = get_terraform_modules_by_workspace_id(
                    workspace_id)
                for db_module in db_modules:
                    module_local_path = os.path.join(
                        git_repo.clone_dir, db_module.gitPath)
                    os.chdir(module_local_path)
                    variables_path = os.path.join(
                        module_local_path, 'variables.tf')
                    if os.path.exists(variables_path):
                        variable_names = get_variables_from_terraform_file(
                            variables_path)
                        module_variables = OrderedDict()
                        for variable_name in variable_names:
                            resource_name, field_name = '-'.join(
                                variable_name.split('-')[:-1]), variable_name.split('-')[-1]
                            if resource_name not in module_variables:
                                module_variables[resource_name] = OrderedDict()
                            module_variables[resource_name][field_name] = ""
                        modules[db_module.name] = module_variables
                    else:
                        print(
                            f"No variables.tf found for module {db_module.name}")

                provider = Aws(script_dir, s3Bucket,
                               dynamoDBTable, scan.workspace.stateKey, workspace_id, modules)

                provider.set_boto3_session(
                    id_token, role_arn, session_duration, aws_region)

                if provider_group_code == 'vpc':
                    provider.vpc()
                elif provider_group_code == 'acm':
                    provider.acm()
                elif provider_group_code == 'apigateway':
                    provider.apigateway()
                elif provider_group_code == 'apigatewayv2':
                    provider.apigatewayv2()
                elif provider_group_code == 'autoscaling':
                    provider.autoscaling()
                elif provider_group_code == 'backup':
                    provider.backup()
                elif provider_group_code == 'cloudmap':
                    provider.cloudmap()
                elif provider_group_code == 'cloudfront':  # no in gov cloud
                    provider.cloudfront()
                elif provider_group_code == 'cloudtrail':
                    provider.cloudtrail()
                elif provider_group_code == 'cloudwatch':
                    provider.cloudwatch()
                elif provider_group_code == 'logs':
                    provider.logs()
                elif provider_group_code == 'cognito_idp':
                    provider.cognito_idp()
                elif provider_group_code == 'cognito_identity':
                    provider.cognito_identity()
                elif provider_group_code == 'docdb':
                    provider.docdb()
                elif provider_group_code == 'dynamodb':
                    provider.dynamodb()
                elif provider_group_code == 'ebs':
                    provider.ebs()
                elif provider_group_code == 'ec2':
                    provider.ec2()
                elif provider_group_code == 'ecr':
                    provider.ecr()
                elif provider_group_code == 'ecr_public':
                    provider.ecr_public()
                elif provider_group_code == 'ecs':
                    provider.ecs()
                elif provider_group_code == 'efs':
                    provider.efs()
                elif provider_group_code == 'eks':
                    provider.eks()
                elif provider_group_code == 'elbv2':
                    provider.elbv2()
                elif provider_group_code == 'elb':
                    provider.elb()
                elif provider_group_code == 'elasticache':
                    provider.elasticache()
                elif provider_group_code == 'elasticbeanstalk':
                    provider.elasticbeanstalk()
                elif provider_group_code == 'es':
                    provider.es()
                elif provider_group_code == 'guardduty':
                    provider.guardduty()
                elif provider_group_code == 'iam':
                    provider.iam()
                elif provider_group_code == 'DISABLED---kms':  # FIXME: This is not working
                    provider.kms()
                elif provider_group_code == 'DISABLED---aws_lambda':  # FIXME: I can not get the code location
                    provider.aws_lambda()
                elif provider_group_code == 'opensearch':
                    provider.opensearch()
                elif provider_group_code == 'rds':
                    provider.rds()
                elif provider_group_code == 's3':
                    provider.s3()
                elif provider_group_code == 'sns':
                    provider.sns()
                elif provider_group_code == 'sqs':
                    provider.sqs()
                elif provider_group_code == 'DISABLED---ssm':  # FIXME: Check how to handle the insecure values
                    provider.ssm()
                elif provider_group_code == 'DISABLED---secretsmanager':  # FIXME: Check how to handle the insecure values
                    provider.secretsmanager()
                elif provider_group_code == 'vpn_client':
                    provider.vpn_client()
                elif provider_group_code == 'wafv2':
                    provider.wafv2()
                elif provider_group_code == 'route53':
                    provider.route53()
                else:
                    update_scan_status(scan_id, "FAILED")
                    break

                print("Running terraform plan to see the main branch drifts ...")

                print("Copying Terraform init files...")
                temp_dir = os.path.join(script_dir, "tmp", ".terraform")
                shutil.copytree(temp_dir, os.path.join(
                    git_repo.destination_dir, ".terraform"))

                terraform = Terraform()
                json_plan_main = terraform.tf_plan(
                    git_repo.destination_dir, True)

                # Do PR
                git_repo.create_pr_with_files()

                print("Running terraform plan to see the updated branch drifts ...")
                json_plan_branch = terraform.tf_plan(
                    git_repo.destination_dir, True)

                # Update the terraformPlan field of the workspace
                update_workspace(
                    workspace_id, json_plan_main, provider.json_plan, json_plan_branch, git_repo.pr_url)

                if git_repo.merged:
                    print("Uploading state file because the PR was merged")
                    provider.upload_file_to_s3(
                        local_path, "terraform.tfstate", "terraform.tfstate")

                if os.path.exists(git_repo.clone_dir):
                    print(f"Removing cloned repo {git_repo.clone_dir}")
                    shutil.rmtree(git_repo.clone_dir)

                print("Uploading scanned state file")
                provider.upload_file_to_s3(
                    local_path, "terraform.tfstate", "terraform.tfstate_scanned")

                update_scan_status(scan_id, "COMPLETED")

                print("Task processed and committed")
            except Exception as e:
                update_scan_status(scan_id, "FAILED")
                print("Error processing task:", e)
                traceback.print_exc()
                consumer.commit()
        else:
            print("Provider not supported")

        consumer.commit()


if __name__ == "__main__":
    main()
