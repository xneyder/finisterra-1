resource "aws_s3_bucket_versioning" "allogy_gov_bundles" {
  bucket = "allogy-gov-bundles"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_contents" {
  bucket = "allogy-gov-contents"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_creator_web_ui" {
  bucket = "allogy-gov-creator-web-ui"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_email" {
  bucket = "allogy-gov-email"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_instructor_web_ui" {
  bucket = "allogy-gov-instructor-web-ui"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_integration_test" {
  bucket = "allogy-gov-integration-test"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_integration_test_public" {
  bucket = "allogy-gov-integration-test-public"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_learner_web_ui" {
  bucket = "allogy-gov-learner-web-ui"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_learning_image" {
  bucket = "allogy-gov-learning-image"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_learning_image_distribution" {
  bucket = "allogy-gov-learning-image-distribution"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_learning_media" {
  bucket = "allogy-gov-learning-media"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_learning_media_distribution" {
  bucket = "allogy-gov-learning-media-distribution"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_learning_pdf" {
  bucket = "allogy-gov-learning-pdf"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_market_service" {
  bucket = "allogy-gov-market-service"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_person_images_scaled" {
  bucket = "allogy-gov-person-images-scaled"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_person_images_upload" {
  bucket = "allogy-gov-person-images-upload"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_tenant_admin_web_ui" {
  bucket = "allogy-gov-tenant-admin-web-ui"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_tenant_configurations" {
  bucket = "allogy-gov-tenant-configurations"
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_versioning" "allogy_gov_web_services" {
  bucket = "allogy-gov-web-services"
  versioning_configuration {
    status = "Suspended"
  }
}

