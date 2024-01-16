import boto3
import os

# Get AWS credentials from environment variables
aws_access_key_id = os.getenv('AWS_ACCESS_KEY_ID')
aws_secret_access_key = os.getenv('AWS_SECRET_ACCESS_KEY')
aws_session_token = os.getenv('AWS_SESSION_TOKEN')
aws_profile = os.getenv('AWS_PROFILE')

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

# Get the current region
region_name = session.region_name

# Check if region_name is None and get it from AWS_REGION
if region_name is None:
    region_name = os.getenv('AWS_REGION')

# Get the account ID
sts = session.client('sts')
account_id = sts.get_caller_identity()['Account']

module_list = [
    # 'vpc',
    # 'acm',
    # 'apigateway',
    # # 'apigatewayv2',
    # 'autoscaling',
    # # 'backup',
    # 'cloudmap',
    # 'cloudfront',
    # # 'cloudtrail',
    # # 'cloudwatch',
    # 'logs',
    # # 'cognito_idp',
    # # 'cognito_identity',
    # 'docdb',
    # 'dynamodb',
    # # 'ebs',
    # 'ec2',
    # 'ecr',
    # # 'ecr_public',
    # 'ecs',
    # # 'efs',
    # 'eks',
    # 'elbv2',
    # # 'elb',
    # 'elasticache_redis',
    # 'elasticbeanstalk',
    # 'guardduty',
    # 'iam',
    # 'kms',
    # 'aws_lambda',
    # # 'opensearch',
    # 'rds',
    # 's3',
    # # 'ssm',
    # # 'secretsmanager',
    # 'sns',
    # 'sqs',
    # 'wafv2',
    # 'stepfunction',
    # 'msk',
    # 'aurora',
    # 'security_group',
    'vpc_endpoint',
    # 'vpn_client',
    'target_group',
    'elasticsearch',
]

for module in module_list:
    print(f"========================== {module} ==========================")
    if os.system(f"python main.py {account_id} {region_name} {module}") != 0:
        print("Command execution failed. Quitting the script.")
        break
