import os
import click
import boto3

from providers.aws.Aws import Aws
from utils.git import Git
from utils.filesystem import create_root_terragrunt, create_gitignore_file


@click.command()
@click.argument('aws_account_id')
@click.argument('aws_region')
@click.argument('group_code')
def main(aws_account_id, aws_region, group_code):
    """Fetches AWS resources using boto3."""
    print("Fetching AWS resources using boto3...")

    script_dir = os.path.dirname(os.path.abspath(__file__))
    s3Bucket = f'ft-{aws_account_id}-{aws_region}-tfstate'
    dynamoDBTable = f'ft-{aws_account_id}-{aws_region}-tfstate-lock'
    stateKey = f'finisterra/generated/aws/{aws_account_id}/{aws_region}/{group_code}'

    provider = Aws(script_dir, s3Bucket, dynamoDBTable, stateKey, None, [])
    provider.aws_account_id = aws_account_id
    provider.aws_region = aws_region
    provider.session = boto3.Session()

    if group_code == 'vpc':
        provider.vpc()
    elif group_code == 'acm':
        provider.acm()
    elif group_code == 'apigateway':
        provider.apigateway()
    elif group_code == 'apigatewayv2':
        provider.apigatewayv2()
    elif group_code == 'autoscaling':
        provider.autoscaling()
    elif group_code == 'backup':
        provider.backup()
    elif group_code == 'cloudmap':
        provider.cloudmap()
    elif group_code == 'cloudfront':  # no in gov cloud
        provider.cloudfront()
    elif group_code == 'cloudtrail':
        provider.cloudtrail()
    elif group_code == 'cloudwatch':
        provider.cloudwatch()
    elif group_code == 'logs':
        provider.logs()
    elif group_code == 'cognito_idp':
        provider.cognito_idp()
    elif group_code == 'cognito_identity':
        provider.cognito_identity()
    elif group_code == 'docdb':
        provider.docdb()
    elif group_code == 'dynamodb':
        provider.dynamodb()
    elif group_code == 'ebs':
        provider.ebs()
    elif group_code == 'ec2':
        provider.ec2()
    elif group_code == 'ecr':
        provider.ecr()
    elif group_code == 'ecr_public':
        provider.ecr_public()
    elif group_code == 'ecs':
        provider.ecs()
    elif group_code == 'efs':
        provider.efs()
    elif group_code == 'eks':
        provider.eks()
    elif group_code == 'elbv2':
        provider.elbv2()
    elif group_code == 'elb':
        provider.elb()
    elif group_code == 'elasticache_redis':
        provider.elasticache_redis()
    # elif group_code == 'elasticache_memcached':
    #     provider.elasticache_memcached()
    elif group_code == 'elasticbeanstalk':
        provider.elasticbeanstalk()
    elif group_code == 'es':
        provider.es()
    elif group_code == 'guardduty':
        provider.guardduty()
    # elif group_code == 'iam_policy':
    #     aws_region = "global"
    #     provider.iam_policy()
    elif group_code == 'iam':
        aws_region = "global"
        provider.iam_role()
    elif group_code == 'kms':
        provider.kms()
    elif group_code == 'aws_lambda':
        provider.aws_lambda()
    elif group_code == 'opensearch':
        provider.opensearch()
    elif group_code == 'rds':
        provider.rds()
    elif group_code == 's3':
        provider.s3()
    elif group_code == 'sns':
        provider.sns()
    elif group_code == 'sqs':
        provider.sqs()
    elif group_code == 'ssm':  # FIXME: Check how to handle the insecure values
        provider.ssm()
    elif group_code == 'secretsmanager':  # FIXME: Check how to handle the insecure values
        provider.secretsmanager()
    elif group_code == 'vpn_client':
        provider.vpn_client()
    elif group_code == 'wafv2':
        provider.wafv2()
    elif group_code == 'route53':
        provider.route53()
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
    else:
        print(f"Group code {group_code} not found.")
        exit()

    print("Finished processing AWS resources.")

    create_gitignore_file("./")

    stateKey = f'finisterra/generated/aws/{aws_account_id}/{aws_region}'

    create_root_terragrunt(s3Bucket, aws_region,
                           dynamoDBTable, stateKey, "./")


if __name__ == "__main__":
    main()
