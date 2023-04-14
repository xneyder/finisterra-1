resource "aws_s3_bucket_ownership_controls" "allogy_gov_cloudformation_files" {
  bucket = "allogy-gov-cloudformation-files"
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_ownership_controls" "allogy_govcloud_import" {
  bucket = "allogy-govcloud-import"
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

