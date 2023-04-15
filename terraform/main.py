import os
import sys

from providers.aws.Aws import Aws


def main():
    print("Fetching AWS resources using boto3...")

    # provider.iam()
    # provider.vpc()
    # provider.route53()
    # provider.s3()
    # provider.acm()
    # provider.cloudfront()
    # provider.ec2()
    # provider.ebs()
    # provider.ecr()
    # provider.ecr_public()
    # provider.ecs()
    # provider.efs()
    # provider.eks()
    # provider.autoscaling()
    # provider.vpn_client()
    # provider.docdb()
    # provider.opensearch()
    # provider.es()
    # provider.elasticache()
    # provider.dynamodb()
    # provider.cognito_identity()
    # provider.cognito_idp()
    # provider.logs()
    # provider.cloudwatch()
    provider.cloudtrail()

    print("Finished processing AWS resources.")


if __name__ == "__main__":
    provider = Aws(os.path.dirname(os.path.abspath(sys.argv[0])))
    main()
