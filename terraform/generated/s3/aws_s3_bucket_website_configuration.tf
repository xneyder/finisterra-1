resource "aws_s3_bucket_website_configuration" "allogy_gov_bundles" {
  bucket = "allogy-gov-bundles"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "allogy_gov_creator_web_ui" {
  bucket = "allogy-gov-creator-web-ui"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "allogy_gov_instructor_web_ui" {
  bucket = "allogy-gov-instructor-web-ui"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "allogy_gov_learner_web_ui" {
  bucket = "allogy-gov-learner-web-ui"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "allogy_gov_learning_image_distribution" {
  bucket = "allogy-gov-learning-image-distribution"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "allogy_gov_learning_media_distribution" {
  bucket = "allogy-gov-learning-media-distribution"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "allogy_gov_market_service" {
  bucket = "allogy-gov-market-service"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "allogy_gov_tenant_admin_web_ui" {
  bucket = "allogy-gov-tenant-admin-web-ui"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "allogy_gov_tenant_configurations" {
  bucket = "allogy-gov-tenant-configurations"
  index_document {
    suffix = "index.html"
  }
}

