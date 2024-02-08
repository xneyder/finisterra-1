import os
import click
import boto3

from providers.aws.Aws import Aws
from utils.auth import auth


@click.command()
@click.option('--provider', '-p', default="aws", help='Provider name')
@click.option('--module', '-m', required=True, help='Module name')
def main(provider, module):
    auth()
    if provider == "aws":
        # Get AWS credentials from environment variables
        aws_access_key_id = os.getenv('AWS_ACCESS_KEY_ID')
        aws_secret_access_key = os.getenv('AWS_SECRET_ACCESS_KEY')
        aws_session_token = os.getenv('AWS_SESSION_TOKEN')
        aws_profile = os.getenv('AWS_PROFILE')
        # Check if AWS_REGION is defined
        aws_region = os.getenv('AWS_REGION')
        if not aws_region:
            print("AWS_REGION environment variable is not defined.")
            exit()

        # Check if AWS_PROFILE is defined
        if aws_profile:
            # Create a session using the profile
            session = boto3.Session(profile_name=aws_profile)
        else:
            # Create a session using the credentials
            session = boto3.Session(
                aws_access_key_id=aws_access_key_id,
                aws_secret_access_key=aws_secret_access_key,
                aws_session_token=aws_session_token,
                region_name=aws_region
            )

        # Get the account ID
        sts = session.client('sts')
        aws_account_id = sts.get_caller_identity()['Account']

        print("Fetching AWS resources using boto3...")

        script_dir = os.path.dirname(os.path.abspath(__file__))
        s3Bucket = f'ft-{aws_account_id}-{aws_region}-tfstate'
        dynamoDBTable = f'ft-{aws_account_id}-{aws_region}-tfstate-lock'
        stateKey = f'finisterra/generated/aws/{aws_account_id}/{aws_region}/{module}'

        provider = Aws(script_dir, s3Bucket, dynamoDBTable, stateKey, aws_account_id, aws_region)

        if module == 'vpc':
            provider.vpc()
        elif module == 'acm':
            provider.acm()
        elif module == 'apigateway':
            provider.apigateway()
        elif module == 'autoscaling':
            provider.autoscaling()
        elif module == 'cloudmap':
            provider.cloudmap()
        elif module == 'cloudfront':
            provider.cloudfront()
        elif module == 'logs':
            provider.logs()
        elif module == 'docdb':
            provider.docdb()
        elif module == 'dynamodb':
            provider.dynamodb()
        elif module == 'ec2':
            provider.ec2()
        elif module == 'ecr':
            provider.ecr()
        elif module == 'ecs':
            provider.ecs()
        elif module == 'eks':
            provider.eks()
        elif module == 'elbv2':
            provider.elbv2()
        elif module == 'elasticache_redis':
            provider.elasticache_redis()
        elif module == 'elasticbeanstalk':
            provider.elasticbeanstalk()
        elif module == 'iam':
            aws_region = "global"
            provider.iam_role()
        elif module == 'kms':
            provider.kms()
        elif module == 'aws_lambda':
            provider.aws_lambda()
        elif module == 'rds':
            provider.rds()
        elif module == 's3':
            provider.s3()
        elif module == 'sns':
            provider.sns()
        elif module == 'sqs':
            provider.sqs()
        elif module == 'wafv2':
            provider.wafv2()
        elif module == 'stepfunction':
            provider.stepfunction()
        elif module == 'msk':
            provider.msk()
        elif module == 'aurora':
            provider.aurora()
        elif module == 'security_group':
            provider.security_group()
        elif module == 'vpc_endpoint':
            provider.vpc_endpoint()
        elif module == 'target_group':
            provider.target_group()
        elif module == 'elasticsearch':
            provider.elasticsearch()
        elif module == 'codeartifact':
            provider.codeartifact()
        elif module == 'launchtemplate':
            provider.launchtemplate()
        else:
            print(f"Group code {module} not found.")
            exit()

        print("Finished processing AWS resources.")

if __name__ == "__main__":
    main()
