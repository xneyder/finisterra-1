resource "aws_opensearch_domain_policy" "shared_01" {
  access_policies = <<EOF
{
  "Statement": [
    {
      "Action": "es:*",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws-us-gov:iam::050779347855:root"
      },
      "Resource": "arn:aws-us-gov:es:*:050779347855:domain/shared-01/*"
    },
    {
      "Action": "es:ESHttpGet",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Resource": "arn:aws-us-gov:es:*:050779347855:domain/shared-01/*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
  domain_name     = "shared-01"
}

resource "aws_opensearch_domain_policy" "shared_02" {
  access_policies = <<EOF
{
  "Statement": [
    {
      "Action": "es:*",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws-us-gov:iam::050779347855:root"
      },
      "Resource": "arn:aws-us-gov:es:*:050779347855:domain/shared-02/*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
  domain_name     = "shared-02"
}

