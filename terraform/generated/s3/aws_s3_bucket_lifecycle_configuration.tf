resource "aws_s3_bucket_lifecycle_configuration" "posthog_cloud_billing_dev_us_east_1_cdn_logs" {
  bucket = "posthog-cloud-billing-dev-us-east-1-cdn-logs"
  rule {
    filter {
    }
    id     = "logs"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "posthog_cloud_dev_us_east_1_app_assets" {
  bucket = "posthog-cloud-dev-us-east-1-app-assets"
  rule {
    expiration {
      days = 30
    }
    filter {
      prefix = "session_recordings/"
    }
    id     = "session_recordings"
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "posthog_cloud_dev_us_east_1_cdn_logs" {
  bucket = "posthog-cloud-dev-us-east-1-cdn-logs"
  rule {
    filter {
    }
    id     = "logs"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "posthog_cloud_dev_us_east_1_flow_logs" {
  bucket = "posthog-cloud-dev-us-east-1-flow-logs"
  rule {
    expiration {
      days = 90
    }
    filter {
    }
    id     = "rotate-items-to-cold-storage"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "posthog_cloud_dev_us_east_1_lb_logs" {
  bucket = "posthog-cloud-dev-us-east-1-lb-logs"
  rule {
    expiration {
      days = 90
    }
    filter {
    }
    id     = "rotate-items-to-cold-storage"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "posthog_cloud_dev_us_east_1_loki" {
  bucket = "posthog-cloud-dev-us-east-1-loki"
  rule {
    filter {
    }
    id     = "session_recordings"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "posthog_cloud_dev_us_east_1_msk_logs" {
  bucket = "posthog-cloud-dev-us-east-1-msk-logs"
  rule {
    expiration {
      days = 90
    }
    filter {
    }
    id     = "rotate-items-to-cold-storage"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}

