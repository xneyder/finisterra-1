resource "aws_s3_bucket_public_access_block" "allogy_gov_cloudformation_files" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "allogy-gov-cloudformation-files"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "allogy_govcloud_import" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "allogy-govcloud-import"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "aws_glue_assets_050779347855_us_gov_west_1" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "aws-glue-assets-050779347855-us-gov-west-1"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "aws_glue_scripts_050779347855_us_gov_west_1" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "aws-glue-scripts-050779347855-us-gov-west-1"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "aws_glue_temporary_050779347855_us_gov_west_1" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = "aws-glue-temporary-050779347855-us-gov-west-1"
  ignore_public_acls      = true
  restrict_public_buckets = true
}

