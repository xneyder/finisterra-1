resource "aws_s3_bucket_public_access_block" "config_bucket_169684386827" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "config-bucket-169684386827"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_billing_dev_us_east_1_cdn_logs" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-cloud-billing-dev-us-east-1-cdn-logs"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_dev_us_east_1_app_assets" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-cloud-dev-us-east-1-app-assets"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_dev_us_east_1_cdn_logs" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-cloud-dev-us-east-1-cdn-logs"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_dev_us_east_1_flow_logs" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-cloud-dev-us-east-1-flow-logs"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_dev_us_east_1_lb_logs" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-cloud-dev-us-east-1-lb-logs"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_dev_us_east_1_loki" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-cloud-dev-us-east-1-loki"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_dev_us_east_1_msk_logs" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-cloud-dev-us-east-1-msk-logs"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_dev_us_east_1_static_assets" {
  block_public_acls       = false
  block_public_policy     = false
  bucket                  = "posthog-cloud-dev-us-east-1-static-assets"
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "posthog_cloud_terraform_dev_us_east_1" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-cloud-terraform-dev-us-east-1"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "posthog_s3disk" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "posthog-s3disk"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "xvello_export_test" {
  block_public_acls       = false
  block_public_policy     = false
  bucket                  = "xvello-export-test"
  ignore_public_acls      = false
  restrict_public_buckets = false
}

