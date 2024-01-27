locals {
  role_name_4151a55ad0 = "cognito_auth_sandbox-role"
}

module "aws_iam_role-cognito_auth_sandbox-role" {
  source             = "github.com/finisterra-io/terraform-aws-modules.git//iam/modules/iam_role?ref=main"
  role_name          = local.role_name_4151a55ad0
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAwsToAssumeRole",
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
  inline_policies = [
    {
      "name" : "cognito_auth_sandboxat-edge",
      "policy" : "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Action\":[\"logs:PutLogEvents\",\"logs:CreateLogStream\",\"logs:CreateLogGroup\"],\"Effect\":\"Allow\",\"Resource\":\"*\",\"Sid\":\"\"}]}"
    }
  ]
  path = "/"
  tags = {
    "Environment" : "sandbox",
    "Terraform" : "true"
  }
  managed_policy_arns = {
    "cognito_auth_sandbox-ssm-policy" : module.aws_iam_policy-cognito_auth_sandbox-ssm-policy.arn
  }
}
