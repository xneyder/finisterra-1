# Finisterra

Finisterra is a Python script designed to automate the fetching and management of AWS resources across various services. It leverages the power of Boto3, the AWS SDK for Python, and concurrent executions to efficiently gather resources from specified AWS services.

## Features

- **Multi-Service Support:** Executes operations across a wide range of AWS services.
- **Parallel Execution:** Utilizes ThreadPoolExecutor for concurrent execution of AWS service operations.
- **CLI Options:** Easy-to-use command-line interface for specifying the provider and modules.
- **Environment Variable Support:** Configuration through environment variables for AWS credentials and settings.
- **Dynamic Resource Naming:** Automatically generates names for S3 buckets and DynamoDB tables based on the AWS account ID and region.
- **Rich Progress Display:** Utilizes the rich library for real-time progress visualization.

## Requirements

To run this script, you need the following:

- Python 3.x
- Boto3
- Click
- Rich
- An AWS account with the necessary permissions to access the resources and services the script interacts with.

## Installation

Before running the script, ensure you have all the required packages installed. You can install them using pip:

```
pip install requirements.txt
```

## Configuration

The script uses environment variables for configuration. Ensure these are set before running the script:

- AWS_ACCESS_KEY_ID: Your AWS access key ID.
- AWS_SECRET_ACCESS_KEY: Your AWS secret access key.
- AWS_SESSION_TOKEN: Your AWS session token (optional).
- AWS_PROFILE: Your AWS profile name (optional).
- AWS_REGION: The AWS region for the operations.
- MAX_PARALLEL: The maximum number of parallel operations (optional, defaults to 10).

## Usage

The script is executed from the command line with options to specify the provider (currently only aws is supported) and the module(s) to execute. The modules can be specified as a comma-separated list or "all" to execute operations for all supported modules.

```
python main.py --provider aws --module <module_name(s)>
```

### CLI Options

- --provider, -p: The cloud provider name (default: aws).
- --module, -m: The module name(s) to execute, separated by commas, or "all" for all modules. This is a required option.

## Supported Modules

The script can manage resources in the following AWS services:

- VPC
- ACM
- API Gateway
- Auto Scaling
- CloudMap
- CloudFront
- CloudWatch Logs
- DocumentDB
- DynamoDB
- EC2
- ECR
- ECS
- EKS
- ELBv2
- ElastiCache Redis
- Elastic Beanstalk
- IAM Role
- KMS
- Lambda
- RDS
- S3
- SNS
- SQS
- WAFv2
- Step Functions
- MSK
- Aurora
- Security Group
- VPC Endpoint
- Target Group
- Elasticsearch
- CodeArtifact
- Launch Template

## Contributing

Contributions are welcome! If you have suggestions for improving the script or adding new features, please feel free to submit a pull request or create an issue.
