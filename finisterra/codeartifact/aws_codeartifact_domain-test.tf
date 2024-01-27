locals {
  domain_9f86d08188 = "test"
}

module "aws_codeartifact_domain-test" {
  source          = "github.com/finisterra-io/terraform-aws-modules.git//code-artifact?ref=main"
  domain          = local.domain_9f86d08188
  encryption_key  = "arn:${local.aws_partition}:kms:${local.aws_region}:070252509141:key/e88f02c4-b77e-4150-9da3-b4bc01e156cf"
  policy_document = <<EOF
{
    "Statement": [
        {
            "Action": [
                "codeartifact:Describe*",
                "codeartifact:Get*",
                "codeartifact:List*",
                "codeartifact:Read*",
                "codeartifact:PublishPackageVersion"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:PrincipalOrgID": "o-fpugqag879"
                }
            },
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "*"
        }
    ],
    "Version": "2012-10-17"
}
EOF

  repositories = {
    "codeartifact_${local.domain_9f86d08188}" : {},
    "test" : {
      "policy_document" : "{\"Statement\":[{\"Action\":\"*\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Resource\":\"*\"}],\"Version\":\"2012-10-17\"}"
    }
  }
}
