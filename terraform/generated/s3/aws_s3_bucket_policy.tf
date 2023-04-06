resource "aws_s3_bucket_policy" "config_bucket_169684386827" {
  bucket = "config-bucket-169684386827"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSConfigBucketPermissionsCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::config-bucket-169684386827",
      "Condition": {
        "StringEquals": {
          "AWS:SourceAccount": "169684386827"
        }
      }
    },
    {
      "Sid": "AWSConfigBucketExistenceCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::config-bucket-169684386827",
      "Condition": {
        "StringEquals": {
          "AWS:SourceAccount": "169684386827"
        }
      }
    },
    {
      "Sid": "AWSConfigBucketDelivery",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::config-bucket-169684386827/AWSLogs/169684386827/Config/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control",
          "AWS:SourceAccount": "169684386827"
        }
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "databeach_hackathon" {
  bucket = "databeach-hackathon"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::169684386827:user/airbyte-hackathon"
      },
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::databeach-hackathon/*",
        "arn:aws:s3:::databeach-hackathon"
      ]
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "posthog_cloud_dev_us_east_1_flow_logs" {
  bucket = "posthog-cloud-dev-us-east-1-flow-logs"
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
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-flow-logs/AWSLogs/*"
    },
    {
      "Sid": "AWSLogDeliveryAclCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-flow-logs"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "posthog_cloud_dev_us_east_1_lb_logs" {
  bucket = "posthog-cloud-dev-us-east-1-lb-logs"
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
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-lb-logs/*",
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
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-lb-logs"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "posthog_cloud_dev_us_east_1_msk_logs" {
  bucket = "posthog-cloud-dev-us-east-1-msk-logs"
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
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-msk-logs/AWSLogs/*",
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
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-msk-logs"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "posthog_cloud_dev_us_east_1_static_assets" {
  bucket = "posthog-cloud-dev-us-east-1-static-assets"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E1B7VDM292C403"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-static-assets/*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "posthog_s3disk" {
  bucket = "posthog-s3disk"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::169684386827:user/s3disk"
      },
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::posthog-s3disk/*",
        "arn:aws:s3:::posthog-s3disk"
      ]
    }
  ]
}
EOF
}

