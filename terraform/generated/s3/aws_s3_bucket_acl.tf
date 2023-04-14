resource "aws_s3_bucket_acl" "allogy_gov_bundles" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-bundles"
}

resource "aws_s3_bucket_acl" "allogy_gov_cloudformation_files" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-cloudformation-files"
}

resource "aws_s3_bucket_acl" "allogy_gov_contents" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-contents"
}

resource "aws_s3_bucket_acl" "allogy_gov_creator_web_ui" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-creator-web-ui"
}

resource "aws_s3_bucket_acl" "allogy_gov_email" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-email"
}

resource "aws_s3_bucket_acl" "allogy_gov_instructor_web_ui" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-instructor-web-ui"
}

resource "aws_s3_bucket_acl" "allogy_gov_integration_test" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-integration-test"
}

resource "aws_s3_bucket_acl" "allogy_gov_integration_test_public" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-integration-test-public"
}

resource "aws_s3_bucket_acl" "allogy_gov_learner_web_ui" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-learner-web-ui"
}

resource "aws_s3_bucket_acl" "allogy_gov_learning_image" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-learning-image"
}

resource "aws_s3_bucket_acl" "allogy_gov_learning_image_distribution" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-learning-image-distribution"
}

resource "aws_s3_bucket_acl" "allogy_gov_learning_media" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-learning-media"
}

resource "aws_s3_bucket_acl" "allogy_gov_learning_media_distribution" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-learning-media-distribution"
}

resource "aws_s3_bucket_acl" "allogy_gov_learning_pdf" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-learning-pdf"
}

resource "aws_s3_bucket_acl" "allogy_gov_market_service" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-market-service"
}

resource "aws_s3_bucket_acl" "allogy_gov_person_images_scaled" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-person-images-scaled"
}

resource "aws_s3_bucket_acl" "allogy_gov_person_images_upload" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-person-images-upload"
}

resource "aws_s3_bucket_acl" "allogy_gov_tenant_admin_web_ui" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-tenant-admin-web-ui"
}

resource "aws_s3_bucket_acl" "allogy_gov_tenant_configurations" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-tenant-configurations"
}

resource "aws_s3_bucket_acl" "allogy_gov_web_services" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-gov-web-services"
}

resource "aws_s3_bucket_acl" "allogy_govcloud_import" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "allogy-govcloud-import"
}

resource "aws_s3_bucket_acl" "aws_glue_assets_050779347855_us_gov_west_1" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "aws-glue-assets-050779347855-us-gov-west-1"
}

resource "aws_s3_bucket_acl" "aws_glue_scripts_050779347855_us_gov_west_1" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "aws-glue-scripts-050779347855-us-gov-west-1"
}

resource "aws_s3_bucket_acl" "aws_glue_temporary_050779347855_us_gov_west_1" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "aws-glue-temporary-050779347855-us-gov-west-1"
}

resource "aws_s3_bucket_acl" "cf_templates_1bohskxf0k9l4_us_gov_west_1" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "cf-templates-1bohskxf0k9l4-us-gov-west-1"
}

resource "aws_s3_bucket_acl" "elasticbeanstalk_us_gov_west_1_050779347855" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "elasticbeanstalk-us-gov-west-1-050779347855"
}

resource "aws_s3_bucket_acl" "vpc_flowlogs_050779347855_vpc_0bd9acb7990b4154d" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "vpc-flowlogs-050779347855-vpc-0bd9acb7990b4154d"
}

resource "aws_s3_bucket_acl" "vpc_flowlogs_050779347855_vpc_0f662451df9954b4c" {
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
    }
  }
  bucket = "vpc-flowlogs-050779347855-vpc-0f662451df9954b4c"
}

