resource "aws_s3_bucket_ownership_controls" "xvello_export_test" {
  bucket = "xvello-export-test"
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

