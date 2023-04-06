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
    provider.cloudfront()

    print("Finished processing AWS resources.")


if __name__ == "__main__":
    provider = Aws(os.path.dirname(os.path.abspath(sys.argv[0])))
    main()
