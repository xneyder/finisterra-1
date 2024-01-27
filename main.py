import os
import click
import boto3

from providers.aws.Aws import Aws
from utils.git import Git
from utils.filesystem import create_root_terragrunt, create_gitignore_file


@click.command()
@click.argument('group_code')
def main(group_code):
    """Fetches AWS resources using boto3."""
    # Get AWS credentials from environment variables
    aws_access_key_id = os.getenv('AWS_ACCESS_KEY_ID')
    aws_secret_access_key = os.getenv('AWS_SECRET_ACCESS_KEY')
    aws_session_token = os.getenv('AWS_SESSION_TOKEN')
    aws_profile = os.getenv('AWS_PROFILE')
    aws_region = os.getenv('AWS_REGION')

    # Check if AWS_PROFILE is defined
    if aws_profile:
        # Create a session using the profile
        session = boto3.Session(profile_name=aws_profile)
    else:
        # Create a session using the credentials
        session = boto3.Session(
            aws_access_key_id=aws_access_key_id,
            aws_secret_access_key=aws_secret_access_key,
            aws_session_token=aws_session_token
        )

    # Get the account ID
    sts = session.client('sts')
    aws_account_id = sts.get_caller_identity()['Account']

    print("Fetching AWS resources using boto3...")

    script_dir = os.path.dirname(os.path.abspath(__file__))
    s3Bucket = f'ft-{aws_account_id}-{aws_region}-tfstate'
    dynamoDBTable = f'ft-{aws_account_id}-{aws_region}-tfstate-lock'
    stateKey = f'finisterra/generated/aws/{aws_account_id}/{aws_region}/{group_code}'

    provider = Aws(script_dir, s3Bucket, dynamoDBTable, stateKey, aws_account_id, aws_region)

    if group_code == 'vpc':
        provider.vpc()
    elif group_code == 'acm':
        provider.acm()
    elif group_code == 'apigateway':
        provider.apigateway()
    elif group_code == 'autoscaling':
        provider.autoscaling()
    elif group_code == 'cloudmap':
        provider.cloudmap()
    elif group_code == 'cloudfront':
        provider.cloudfront()
    elif group_code == 'logs':
        provider.logs()
    elif group_code == 'docdb':
        provider.docdb()
    elif group_code == 'dynamodb':
        provider.dynamodb()
    elif group_code == 'ec2':
        provider.ec2()
    elif group_code == 'ecr':
        provider.ecr()
    elif group_code == 'ecs':
        provider.ecs()
    elif group_code == 'eks':
        provider.eks()
    elif group_code == 'elbv2':
        provider.elbv2()
    elif group_code == 'elasticache_redis':
        provider.elasticache_redis()
    elif group_code == 'elasticbeanstalk':
        provider.elasticbeanstalk()
    elif group_code == 'iam':
        aws_region = "global"
        provider.iam_role()
    elif group_code == 'kms':
        provider.kms()
    elif group_code == 'aws_lambda':
        provider.aws_lambda()
    elif group_code == 'rds':
        provider.rds()
    elif group_code == 's3':
        provider.s3()
    elif group_code == 'sns':
        provider.sns()
    elif group_code == 'sqs':
        provider.sqs()
    elif group_code == 'wafv2':
        provider.wafv2()
    elif group_code == 'stepfunction':
        provider.stepfunction()
    elif group_code == 'msk':
        provider.msk()
    elif group_code == 'aurora':
        provider.aurora()
    elif group_code == 'security_group':
        provider.security_group()
    elif group_code == 'vpc_endpoint':
        provider.vpc_endpoint()
    elif group_code == 'target_group':
        provider.target_group()
    elif group_code == 'elasticsearch':
        provider.elasticsearch()
    elif group_code == 'codeartifact':
        provider.codeartifact()
    elif group_code == 'launchtemplate':
        provider.launchtemplate()
    else:
        print(f"Group code {group_code} not found.")
        exit()

    print("Finished processing AWS resources.")

    # TF_PLAN = os.environ.get("TF_PLAN", True)
    # if TF_PLAN:
    #     create_gitignore_file("./")
    #     stateKey = f'finisterra/generated/aws/{aws_account_id}/{aws_region}'
    #     create_root_terragrunt(s3Bucket, aws_region,
    #                         dynamoDBTable, stateKey, "./")

if __name__ == "__main__":
    main()
