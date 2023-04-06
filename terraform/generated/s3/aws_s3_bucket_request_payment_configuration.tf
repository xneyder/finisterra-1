resource "aws_s3_bucket_request_payment_configuration" "config_bucket_169684386827" {
  bucket = "config-bucket-169684386827"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "databeach_hackathon" {
  bucket = "databeach-hackathon"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "dev_posthog_lambda_edge" {
  bucket = "dev-posthog-lambda-edge"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_billing_dev_us_east_1_cdn_logs" {
  bucket = "posthog-cloud-billing-dev-us-east-1-cdn-logs"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_dev_us_east_1_app_assets" {
  bucket = "posthog-cloud-dev-us-east-1-app-assets"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_dev_us_east_1_cdn_logs" {
  bucket = "posthog-cloud-dev-us-east-1-cdn-logs"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_dev_us_east_1_flow_logs" {
  bucket = "posthog-cloud-dev-us-east-1-flow-logs"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_dev_us_east_1_lb_logs" {
  bucket = "posthog-cloud-dev-us-east-1-lb-logs"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_dev_us_east_1_loki" {
  bucket = "posthog-cloud-dev-us-east-1-loki"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_dev_us_east_1_msk_logs" {
  bucket = "posthog-cloud-dev-us-east-1-msk-logs"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_dev_us_east_1_static_assets" {
  bucket = "posthog-cloud-dev-us-east-1-static-assets"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_cloud_terraform_dev_us_east_1" {
  bucket = "posthog-cloud-terraform-dev-us-east-1"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "posthog_s3disk" {
  bucket = "posthog-s3disk"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "test_vpc_pr_1378_flow_logs" {
  bucket = "test-vpc-pr-1378-flow-logs"
  payer  = "BucketOwner"
}

resource "aws_s3_bucket_request_payment_configuration" "xvello_export_test" {
  bucket = "xvello-export-test"
  payer  = "BucketOwner"
}

