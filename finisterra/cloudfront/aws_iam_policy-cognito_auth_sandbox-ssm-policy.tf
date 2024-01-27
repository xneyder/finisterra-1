locals {
  policy_name_7145933ebb = "cognito_auth_sandbox-ssm-policy"
}

module "aws_iam_policy-cognito_auth_sandbox-ssm-policy" {
  source           = "github.com/finisterra-io/terraform-aws-modules.git//iam/modules/iam_policy?ref=main"
  policy_documents = <<EOF
{
    "Statement": [
        {
            "Action": [
                "ssm:GetParameter",
                "secretsmanager:GetSecretValue"
            ],
            "Effect": "Allow",
            "Resource": "arn:${local.aws_partition}:ssm:${local.aws_region}:070252509141:parameter/cognito_client_secret_sandbox",
            "Sid": "AccessParams"
        }
    ],
    "Version": "2012-10-17"
}
EOF

  policy_name        = local.policy_name_7145933ebb
  policy_description = "Gives the lambda cognito_auth_sandbox access to params from SSM"
  path               = "/"
  tags = {
    "Environment" : "sandbox",
    "Terraform" : "true"
  }
}
