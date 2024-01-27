locals {
  bucket_3688b8cadf = "coast-sandbox-${local.aws_region}-070252509141-log-bucket"
}

module "aws_s3_bucket-coast-sandbox-us-east-1-070252509141-log-bucket_3688b8cadf" {
  source               = "github.com/finisterra-io/terraform-aws-modules.git//s3?ref=main"
  attach_public_policy = true
  bucket               = local.bucket_3688b8cadf
  tags = {
    "Environment" : "sandbox",
    "Name" : "${local.bucket_3688b8cadf}",
    "Terraform" : "true"
  }
  server_side_encryption_configuration = {
    "rule" : {
      "apply_server_side_encryption_by_default" : {
        "kms_master_key_id" : "",
        "sse_algorithm" : "AES256"
      },
      "bucket_key_enabled" : false
    }
  }
  request_payer = "BucketOwner"
  attach_policy = true
  policy        = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowTLSRequestsOnly",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:${local.aws_partition}:s3:::${local.bucket_3688b8cadf}",
                "arn:${local.aws_partition}:s3:::${local.bucket_3688b8cadf}/*"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        },
        {
            "Sid": "S3PolicyStmt-DO-NOT-MODIFY-1642515132690",
            "Effect": "Allow",
            "Principal": {
                "Service": "logging.s3.amazonaws.com"
            },
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Resource": "arn:${local.aws_partition}:s3:::${local.bucket_3688b8cadf}/*"
        },
        {
            "Sid": "AWSLogDeliveryWrite",
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:${local.aws_partition}:s3:::${local.bucket_3688b8cadf}/*",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "070252509141",
                    "s3:x-amz-acl": "bucket-owner-full-control"
                },
                "ArnLike": {
                    "aws:SourceArn": "arn:${local.aws_partition}:logs:${local.aws_region}:070252509141:*"
                }
            }
        },
        {
            "Sid": "AWSLogDeliveryCheck",
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": [
                "s3:GetBucketAcl",
                "s3:ListBucket"
            ],
            "Resource": "arn:${local.aws_partition}:s3:::${local.bucket_3688b8cadf}",
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "070252509141"
                },
                "ArnLike": {
                    "aws:SourceArn": "arn:${local.aws_partition}:logs:${local.aws_region}:070252509141:*"
                }
            }
        }
    ]
}
EOF

}
