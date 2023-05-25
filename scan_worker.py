import os
import json
from kafka import KafkaConsumer
from dotenv import load_dotenv
from typing import Dict
import sys
from providers.aws.Aws import Aws
from db.resource import upsert_resource
from db.scan import get_scan_by_id
from utils.git import create_pr_with_files


# Load environment variables from .env file
load_dotenv()

KAFKA_BROKER = os.environ.get("KAFKA_BROKER")
KAFKA_TOPIC = os.environ.get("KAFKA_TOPIC")


def main():
    # consumer = KafkaConsumer(
    #     KAFKA_TOPIC,
    #     bootstrap_servers=[KAFKA_BROKER],
    #     value_deserializer=lambda v: json.loads(v.decode('utf-8')),
    #     auto_offset_reset='earliest',
    #     group_id="gen_code_group",
    #     enable_auto_commit=False
    # )

    script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
    consumer = [{'idToken': 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkOWE1ZWY1YjEyNjIzYzkxNjcxYTcwOTNjYjMyMzMzM2NkMDdkMDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI0MTM2NTczNzg1Ny04azZnYnFwOXVtcWZ0dDA2ODNvcjQzMmZkbzNya291bi5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjQxMzY1NzM3ODU3LThrNmdicXA5dW1xZnR0MDY4M29yNDMyZmRvM3Jrb3VuLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAzNDM3MjQ5OTUxODU1NzYyNDg3IiwiaGQiOiJmaW5pc3RlcnJhLmlvIiwiZW1haWwiOiJkYW5pZWxAZmluaXN0ZXJyYS5pbyIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiNlo2VWctdlRwS1JZdktFblptMVRNUSIsImlhdCI6MTY4NDk1MTIxMSwiZXhwIjoxNjg0OTU0ODExfQ.ohmT2DRXyvfDbNjC4NaUOeArVgZ1eXHoC8vIzqFe4BM5h7zz3Lw1lWhLvQqp5QUwG8a3pbITUJ3D5M48_SO27Heu1db7FgozYMAYEsvMQlVn0B7hgsMDlt4rpwLIX6U2amGAO5R_WJOTivXQku4709hG84uaRHhmikvZviMo5XhjLGwmTvEyujI-iGkXKzL8N5y-OEZAUdFnAYEckEfnrE8DbEk_ChlXTPCp2EU89zqNWC8pdQge8hTP_wjFbldnTrn6FwBxzS_OJLhXy98d7LpOdMJp3Zgh5W7JRHsnryX8gZ25gJbym3NCnkODJP9R5L30nHkKf3AGZohvC9pV2g', 'provider_name': 'aws', 'scanId': 107}]

    for message in consumer:
        # task = message.value
        task = message
        provider_name = task['provider_name']

        if provider_name == 'aws':
            try:
                id_token = task['idToken']
                scan_id = task['scanId']

                # Get the scan with the given ID
                scan = get_scan_by_id(scan_id)
                if scan is None:
                    print(f"No scan found with ID {scan_id}")
                    continue

                # Extract the values you need
                organization_id = scan.organization.id
                role_arn = scan.workspace.awsAccount.roleArn
                aws_account_id = scan.workspace.awsAccount.id
                session_duration = scan.workspace.awsAccount.sessionDuration
                aws_region = scan.workspace.awsRegion
                workspace_id = scan.workspace.id
                provider_group_code = scan.workspace.providerGroup.code

                github_installation_id = scan.workspace.awsAccount.awsAccountGitRepos[
                    0].gitRepo.githubAccount.installationId
                git_repo_name = scan.workspace.awsAccount.awsAccountGitRepos[0].gitRepo.name
                # git_repo_path = f"{scan.workspace.awsAccount.awsAccountGitRepos[0].path}/finisterra/generated/aws/{scan.workspace.awsAccount.awsAccountId}/{aws_region}/{provider_group_code}"
                git_repo_path = f"finisterra/generated/aws/{scan.workspace.awsAccount.awsAccountId}/{aws_region}/{provider_group_code}"
                git_repo_branch = scan.workspace.awsAccount.awsAccountGitRepos[0].branch

                create_pr_with_files(github_installation_id=github_installation_id,
                                     git_repo_name=git_repo_name,
                                     local_path=os.path.join(
                                         script_dir, "generated", provider_group_code),
                                     git_repo_path=git_repo_path,
                                     git_repo_branch=provider_group_code,
                                     git_target_branch=git_repo_branch)

                exit()

                provider = Aws(script_dir)
                provider.set_boto3_session(
                    id_token, role_arn, session_duration, aws_region)

                if provider_group_code == 'vpc':
                    provider.vpc()
                    print("Processing VPC")
                else:
                    break

                for module, module_v in provider.resource_list.items():
                    for resource_type, resource_type_v in module_v.items():
                        for resource_name, resource_name_v in resource_type_v.items():
                            upsert_resource(
                                organization_id=organization_id,
                                workspace_id=workspace_id,
                                provider=provider_name,
                                aws_account_id=aws_account_id,
                                region=aws_region,
                                resource_type=resource_type,
                                resource_name=resource_name,
                                resource_id=resource_name_v["id"],
                                state_file="s3://my-bucket/state.tf",
                                scanned_state_file="s3://my-bucket/scanned_state.tf",
                                status="active",
                                autogenerated=True,
                                description=""
                            )

                create_pr_with_files(installation_id=github_installation_id,
                                     repo_id=git_repo_name,
                                     local_path=os.path.join(
                                         script_dir, "generated", provider_group_code),
                                     repo_path=git_repo_path,
                                     branch_name=provider_group_code,
                                     target_branch=git_repo_branch)

                print("Task processed and committed")
            except Exception as e:
                print("Error processing task:", e)
        else:
            print("Provider not supported")

        # consumer.commit()


if __name__ == "__main__":
    main()