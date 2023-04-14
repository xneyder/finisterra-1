resource "aws_s3_bucket_policy" "allogy_gov_bundles" {
  bucket = "allogy-gov-bundles"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy learning cloudfront",
  "Statement": [
    {
      "Sid": "Allow get requests originating from cloudfront.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-bundles/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "pZx98hbtZcxk7EuKFEbj4Z3ox9BjebVwiFdPt2bZAWFVDJeGoF"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "allogy_gov_creator_web_ui" {
  bucket = "allogy-gov-creator-web-ui"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy example",
  "Statement": [
    {
      "Sid": "Allow get requests originating from www.example.com and example.com.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-creator-web-ui/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "cHKcfeREsgWFXLbqvGbmMfsMZffzkZD67FTpa3k4DbcMh4Ui7B"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "allogy_gov_instructor_web_ui" {
  bucket = "allogy-gov-instructor-web-ui"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy example",
  "Statement": [
    {
      "Sid": "Allow get requests originating from www.example.com and example.com.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-instructor-web-ui/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "Moxt7tJQapb2kT3c3N6oxuFrFuFUVd6gf4VqHVzU3XqF9Uw2M8"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "allogy_gov_learner_web_ui" {
  bucket = "allogy-gov-learner-web-ui"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy example",
  "Statement": [
    {
      "Sid": "Allow get requests originating from www.example.com and example.com.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-learner-web-ui/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "JKAGE2CvHkVTucHNnmxmhbpVnjWy22PLLR44WYVGUewaM2TY6j"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "allogy_gov_learning_image_distribution" {
  bucket = "allogy-gov-learning-image-distribution"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy learning distribution",
  "Statement": [
    {
      "Sid": "Allow get requests originating from cloudfront.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-learning-image-distribution/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "pZx98hbtZcxk7EuKFEbj4Z3ox9BjebVwiFdPt2bZAWFVDJeGoF"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "allogy_gov_learning_media_distribution" {
  bucket = "allogy-gov-learning-media-distribution"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy learning distribution",
  "Statement": [
    {
      "Sid": "Allow get requests originating from cloudfront.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "pZx98hbtZcxk7EuKFEbj4Z3ox9BjebVwiFdPt2bZAWFVDJeGoF"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "allogy_gov_market_service" {
  bucket = "allogy-gov-market-service"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy for cloudfront distribution",
  "Statement": [
    {
      "Sid": "Allow get requests originating from cloudfront.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-market-service/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "3GcnQmxGuKtxrvqJsrgvhNA8QYhbDT8ZngetJvgECwQQNAmmzR"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "allogy_gov_tenant_admin_web_ui" {
  bucket = "allogy-gov-tenant-admin-web-ui"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy example",
  "Statement": [
    {
      "Sid": "Allow get requests originating from www.example.com and example.com.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-tenant-admin-web-ui/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "MUxCxMV9QYpywpj42i7o2kCHBdT9xsrJ2697tEhVkQ79gL3Ycy"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "allogy_gov_tenant_configurations" {
  bucket = "allogy-gov-tenant-configurations"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "http referer policy for cloudfront",
  "Statement": [
    {
      "Sid": "Allow get requests originating from cloudfront.",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-tenant-configurations/*",
      "Condition": {
        "StringLike": {
          "aws:Referer": "bCwCPca3ERKGCRBQmWV6sKtD6vUjXRWpfTD6y3udN4AyNhVRoe"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "elasticbeanstalk_us_gov_west_1_050779347855" {
  bucket = "elasticbeanstalk-us-gov-west-1-050779347855"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "eb-58950a8c-feb6-11e2-89e0-0800277d041b",
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:DeleteBucket",
      "Resource": "arn:aws-us-gov:s3:::elasticbeanstalk-us-gov-west-1-050779347855"
    },
    {
      "Sid": "eb-af163bf3-d27b-4712-b795-d1e33e331ca4",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws-us-gov:iam::050779347855:role/services-gateway",
          "arn:aws-us-gov:iam::050779347855:role/web-app-gateway",
          "arn:aws-us-gov:iam::050779347855:role/web-app-book-service",
          "arn:aws-us-gov:iam::050779347855:role/web-app-form-service",
          "arn:aws-us-gov:iam::050779347855:role/internal-services-gateway",
          "arn:aws-us-gov:iam::050779347855:role/web-app-mobile-client-gateway",
          "arn:aws-us-gov:iam::050779347855:role/web-app-test-web-service",
          "arn:aws-us-gov:iam::050779347855:role/web-app-market-service",
          "arn:aws-us-gov:iam::050779347855:role/web-app-collaboration-person-service",
          "arn:aws-us-gov:iam::050779347855:role/web-app-dbt-clinician-web",
          "arn:aws-us-gov:iam::050779347855:role/web-app-identity-service"
        ]
      },
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::elasticbeanstalk-us-gov-west-1-050779347855",
        "arn:aws-us-gov:s3:::elasticbeanstalk-us-gov-west-1-050779347855/resources/environments/*"
      ]
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "vpc_flowlogs_050779347855_vpc_0bd9acb7990b4154d" {
  bucket = "vpc-flowlogs-050779347855-vpc-0bd9acb7990b4154d"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSLogDeliveryWrite",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws-us-gov:s3:::vpc-flowlogs-050779347855-vpc-0bd9acb7990b4154d/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Sid": "AWSLogDeliveryAclCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws-us-gov:s3:::vpc-flowlogs-050779347855-vpc-0bd9acb7990b4154d"
    }
  ]
}
EOF
}

