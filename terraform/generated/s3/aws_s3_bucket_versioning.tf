resource "aws_s3_bucket_versioning" "posthog_cloud_dev_us_east_1_app_assets" {
  bucket = "posthog-cloud-dev-us-east-1-app-assets"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "posthog_cloud_dev_us_east_1_static_assets" {
  bucket = "posthog-cloud-dev-us-east-1-static-assets"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "posthog_cloud_terraform_dev_us_east_1" {
  bucket = "posthog-cloud-terraform-dev-us-east-1"
  versioning_configuration {
    status = "Enabled"
  }
}

