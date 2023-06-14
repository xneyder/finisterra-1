import os
import json
import traceback
from kafka import KafkaConsumer
from dotenv import load_dotenv
from typing import Dict
import sys
from providers.aws.Aws import Aws
from db.run import get_run_by_id, update_run_status
from db.workspace import update_workspace
from utils.git import Git
from utils.terraform import Terraform


# Load environment variables from .env file
load_dotenv()

KAFKA_BROKER = os.environ.get("KAFKA_BROKER")
KAFKA_TOPIC = os.environ.get("RUN_KAFKA_TOPIC")


def main():
    consumer = KafkaConsumer(
        KAFKA_TOPIC,
        bootstrap_servers=KAFKA_BROKER.split(','),
        security_protocol='SSL',
        value_deserializer=lambda v: json.loads(v.decode('utf-8')),
        auto_offset_reset='earliest',
        group_id="gen_code_group",
        enable_auto_commit=False
    )

    script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))

    for message in consumer:
        task = message.value
        id_token = task['idToken']
        run_id = task['runId']

        # Get the run with the given ID
        run = get_run_by_id(run_id)
        if run is None:
            print(f"No run found with ID {run_id}")
            continue

        update_run_status(run_id, "IN_PROGRESS")
        provider_name = task['provider_name']
        if provider_name == 'aws':
            try:
                # Extract the values you need
                organization_id = run.organization.id
                role_arn = run.workspace.awsAccount.roleArn
                commit_hash = run.commitHash
                aws_account_id = run.workspace.awsAccount.id
                session_duration = run.workspace.awsAccount.sessionDuration
                aws_region = run.workspace.awsRegion
                workspace_id = run.workspace.id
                provider_group_code = run.workspace.providerGroup.code

                github_installation_id = run.workspace.awsAccount.awsAccountGitRepos[
                    0].gitRepo.githubAccount.installationId
                git_repo_id = run.workspace.awsAccount.awsAccountGitRepos[0].gitRepo.gitrepoId
                git_repo_path = run.workspace.gitPath
                s3Bucket = run.workspace.awsAccount.awsStateConfigs[0].s3Bucket
                dynamoDBTable = run.workspace.awsAccount.awsStateConfigs[0].dynamoDBTable
                git_repo_branch = run.workspace.awsAccount.awsAccountGitRepos[0].branch

                provider = Aws(script_dir, s3Bucket,
                               dynamoDBTable, run.workspace.stateKey)
                provider.set_boto3_session(
                    id_token, role_arn, session_duration, aws_region)

                local_path = os.path.join(
                    script_dir, "generated", provider_group_code)
                git_repo = Git(github_installation_id=github_installation_id,
                               git_repo_id=git_repo_id,
                               local_path=local_path,
                               git_repo_path=git_repo_path,
                               git_repo_branch=git_repo_path,
                               git_target_branch=git_repo_branch,
                               workspace_id=workspace_id)

                git_repo.checkout_commit(commit_hash)

                print("Running terraform plan ...")
                terraform = Terraform()
                json_plan = terraform.tf_plan(git_repo.destination_dir)

                update_run_status(run_id, "COMPLETED")

            except Exception as e:
                update_run_status(run_id, "FAILED")
                print("Error processing task:", e)
                traceback.print_exc()
        else:
            print("Provider not supported")

        consumer.commit()


if __name__ == "__main__":
    main()
