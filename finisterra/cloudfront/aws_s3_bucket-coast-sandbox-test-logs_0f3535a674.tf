locals {
  bucket_0f3535a674 = "coast-sandbox-test-logs"
}

module "aws_s3_bucket-coast-sandbox-test-logs_0f3535a674" {
  source               = "github.com/finisterra-io/terraform-aws-modules.git//s3?ref=main"
  attach_public_policy = true
  bucket               = local.bucket_0f3535a674
  versioning = {
    "status" : "Suspended"
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
}
