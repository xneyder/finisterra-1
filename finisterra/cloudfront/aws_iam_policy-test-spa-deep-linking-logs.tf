locals {
  policy_name_3871bac9cc = "test-spa-deep-linking-logs"
}

module "aws_iam_policy-test-spa-deep-linking-logs" {
  source           = "github.com/finisterra-io/terraform-aws-modules.git//iam/modules/iam_policy?ref=main"
  policy_documents = <<EOF
{
    "Statement": [
        {
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:${local.aws_partition}:logs:*:070252509141:log-group:/aws/lambda/${local.aws_region}.test-spa-deep-linking:*:*",
                "arn:${local.aws_partition}:logs:*:070252509141:log-group:/aws/lambda/${local.aws_region}.test-spa-deep-linking:*"
            ],
            "Sid": ""
        }
    ],
    "Version": "2012-10-17"
}
EOF

  policy_name = local.policy_name_3871bac9cc
  path        = "/"
}
