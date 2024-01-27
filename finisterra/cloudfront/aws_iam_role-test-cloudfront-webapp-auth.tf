locals {
  role_name_5b83a6bf5c = "test-cloudfront-webapp-auth"
}

module "aws_iam_role-test-cloudfront-webapp-auth" {
  source             = "github.com/finisterra-io/terraform-aws-modules.git//iam/modules/iam_role?ref=main"
  role_name          = local.role_name_5b83a6bf5c
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com",
                    "edgelambda.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  max_session_duration = 3600
  path                 = "/"
  managed_policy_arns = {
    "test-cloudfront-webapp-auth-logs" : module.aws_iam_policy-test-cloudfront-webapp-auth-logs.arn
  }
}