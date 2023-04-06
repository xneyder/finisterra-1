resource "aws_s3_bucket" "config_bucket_169684386827" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "arn:aws:kms:us-east-1:169684386827:alias/aws/s3"
        sse_algorithm     = "aws:kms"
      }
      bucket_key_enabled = true
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "databeach_hackathon" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "dev_posthog_lambda_edge" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_billing_dev_us_east_1_cdn_logs" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  grant {
    id = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Description = "S3 bucket to host the apps CloudFront distribution logs."

    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_dev_us_east_1_app_assets" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    expiration {
      days                         = 30
      expired_object_delete_marker = false
    }
    prefix = "session_recordings/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Description = "S3 bucket to host PostHog Cloud app generated assets. DO NOT DELETE this bucket unless you know what you are doing."

    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = true
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_dev_us_east_1_cdn_logs" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  grant {
    id = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Description = "S3 bucket to host the apps CloudFront distribution logs."

    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_dev_us_east_1_flow_logs" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    expiration {
      days                         = 90
      expired_object_delete_marker = false
    }
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_dev_us_east_1_lb_logs" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    expiration {
      days                         = 90
      expired_object_delete_marker = false
    }
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_dev_us_east_1_loki" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Description = "S3 bucket to host PostHog Cloud loki logs."

    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_dev_us_east_1_msk_logs" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    expiration {
      days                         = 90
      expired_object_delete_marker = false
    }
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_dev_us_east_1_static_assets" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = true
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_cloud_terraform_dev_us_east_1" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Description = "Used for Terraform remote state configuration. DO NOT DELETE this bucket unless you know what you are doing."

    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = true
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "posthog_s3disk" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "test_vpc_pr_1378_flow_logs" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "xvello_export_test" {
  grant {
    id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

