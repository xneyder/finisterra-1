resource "aws_s3_bucket" "allogy_gov_bundles" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_cloudformation_files" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_contents" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_creator_web_ui" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_email" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_instructor_web_ui" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_integration_test" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_integration_test_public" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_learner_web_ui" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_learning_image" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_learning_image_distribution" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_learning_media" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_learning_media_distribution" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_learning_pdf" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_market_service" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_person_images_scaled" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_person_images_upload" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_gov_tenant_admin_web_ui" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_tenant_configurations" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "allogy_gov_web_services" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "allogy_govcloud_import" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "aws_glue_assets_050779347855_us_gov_west_1" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "aws_glue_scripts_050779347855_us_gov_west_1" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "aws_glue_temporary_050779347855_us_gov_west_1" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "cf_templates_1bohskxf0k9l4_us_gov_west_1" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "elasticbeanstalk_us_gov_west_1_050779347855" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "vpc_flowlogs_050779347855_vpc_0bd9acb7990b4154d" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Name = "Production"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

resource "aws_s3_bucket" "vpc_flowlogs_050779347855_vpc_0f662451df9954b4c" {
  grant {
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }
  tags = {
    Name = "Production"

  }
  versioning {
    enabled    = false
    mfa_delete = false
  }
}

