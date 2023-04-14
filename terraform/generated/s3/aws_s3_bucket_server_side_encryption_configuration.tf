resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_bundles" {
  bucket = "allogy-gov-bundles"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_cloudformation_files" {
  bucket = "allogy-gov-cloudformation-files"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_contents" {
  bucket = "allogy-gov-contents"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_creator_web_ui" {
  bucket = "allogy-gov-creator-web-ui"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_email" {
  bucket = "allogy-gov-email"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_instructor_web_ui" {
  bucket = "allogy-gov-instructor-web-ui"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_integration_test" {
  bucket = "allogy-gov-integration-test"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_integration_test_public" {
  bucket = "allogy-gov-integration-test-public"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_learner_web_ui" {
  bucket = "allogy-gov-learner-web-ui"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_learning_image" {
  bucket = "allogy-gov-learning-image"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_learning_image_distribution" {
  bucket = "allogy-gov-learning-image-distribution"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_learning_media" {
  bucket = "allogy-gov-learning-media"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_learning_media_distribution" {
  bucket = "allogy-gov-learning-media-distribution"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_learning_pdf" {
  bucket = "allogy-gov-learning-pdf"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_market_service" {
  bucket = "allogy-gov-market-service"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_person_images_scaled" {
  bucket = "allogy-gov-person-images-scaled"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_person_images_upload" {
  bucket = "allogy-gov-person-images-upload"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_tenant_admin_web_ui" {
  bucket = "allogy-gov-tenant-admin-web-ui"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_tenant_configurations" {
  bucket = "allogy-gov-tenant-configurations"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_gov_web_services" {
  bucket = "allogy-gov-web-services"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "allogy_govcloud_import" {
  bucket = "allogy-govcloud-import"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_glue_assets_050779347855_us_gov_west_1" {
  bucket = "aws-glue-assets-050779347855-us-gov-west-1"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_glue_scripts_050779347855_us_gov_west_1" {
  bucket = "aws-glue-scripts-050779347855-us-gov-west-1"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_glue_temporary_050779347855_us_gov_west_1" {
  bucket = "aws-glue-temporary-050779347855-us-gov-west-1"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cf_templates_1bohskxf0k9l4_us_gov_west_1" {
  bucket = "cf-templates-1bohskxf0k9l4-us-gov-west-1"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elasticbeanstalk_us_gov_west_1_050779347855" {
  bucket = "elasticbeanstalk-us-gov-west-1-050779347855"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "vpc_flowlogs_050779347855_vpc_0bd9acb7990b4154d" {
  bucket = "vpc-flowlogs-050779347855-vpc-0bd9acb7990b4154d"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "vpc_flowlogs_050779347855_vpc_0f662451df9954b4c" {
  bucket = "vpc-flowlogs-050779347855-vpc-0f662451df9954b4c"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

