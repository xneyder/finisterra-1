resource "aws_s3_bucket_server_side_encryption_configuration" "config_bucket_169684386827" {
  bucket = "config-bucket-169684386827"
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "arn:aws:kms:us-east-1:169684386827:alias/aws/s3"
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "databeach_hackathon" {
  bucket = "databeach-hackathon"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dev_posthog_lambda_edge" {
  bucket = "dev-posthog-lambda-edge"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_billing_dev_us_east_1_cdn_logs" {
  bucket = "posthog-cloud-billing-dev-us-east-1-cdn-logs"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_dev_us_east_1_app_assets" {
  bucket = "posthog-cloud-dev-us-east-1-app-assets"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_dev_us_east_1_cdn_logs" {
  bucket = "posthog-cloud-dev-us-east-1-cdn-logs"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_dev_us_east_1_flow_logs" {
  bucket = "posthog-cloud-dev-us-east-1-flow-logs"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_dev_us_east_1_lb_logs" {
  bucket = "posthog-cloud-dev-us-east-1-lb-logs"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_dev_us_east_1_loki" {
  bucket = "posthog-cloud-dev-us-east-1-loki"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_dev_us_east_1_msk_logs" {
  bucket = "posthog-cloud-dev-us-east-1-msk-logs"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_dev_us_east_1_static_assets" {
  bucket = "posthog-cloud-dev-us-east-1-static-assets"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_cloud_terraform_dev_us_east_1" {
  bucket = "posthog-cloud-terraform-dev-us-east-1"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "posthog_s3disk" {
  bucket = "posthog-s3disk"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "test_vpc_pr_1378_flow_logs" {
  bucket = "test-vpc-pr-1378-flow-logs"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "xvello_export_test" {
  bucket = "xvello-export-test"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

