locals {
  role_name_2262633f2f = "test-spa-deep-linking"
}

module "aws_iam_role-test-spa-deep-linking" {
  source             = "github.com/finisterra-io/terraform-aws-modules.git//iam/modules/iam_role?ref=main"
  role_name          = local.role_name_2262633f2f
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
    "test-spa-deep-linking-logs" : module.aws_iam_policy-test-spa-deep-linking-logs.arn
  }
}
