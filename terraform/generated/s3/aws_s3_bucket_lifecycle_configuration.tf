resource "aws_s3_bucket_lifecycle_configuration" "vpc_flowlogs_050779347855_vpc_0bd9acb7990b4154d" {
  bucket = "vpc-flowlogs-050779347855-vpc-0bd9acb7990b4154d"
  rule {
    filter {
    }
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

resource "aws_s3_bucket_lifecycle_configuration" "vpc_flowlogs_050779347855_vpc_0f662451df9954b4c" {
  bucket = "vpc-flowlogs-050779347855-vpc-0f662451df9954b4c"
  rule {
    filter {
    }
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

