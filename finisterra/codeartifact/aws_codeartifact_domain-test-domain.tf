locals {
  domain_552e6899c5 = "test-domain"
}

module "aws_codeartifact_domain-test-domain" {
  source               = "github.com/finisterra-io/terraform-aws-modules.git//code-artifact?ref=main"
  domain               = local.domain_552e6899c5
  encryption_key_alias = "alias/aws/codeartifact"
  policy_document      = <<EOF
{
    "Statement": [
        {
            "Action": [
                "codeartifact:Describe*",
                "codeartifact:Get*",
                "codeartifact:List*",
                "codeartifact:Read*"
            ],
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "*"
        }
    ],
    "Version": "2012-10-17"
}
EOF

  repositories = {
    "test-repository" : {}
  }
}
