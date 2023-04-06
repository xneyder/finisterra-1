resource "aws_s3_bucket_acl" "config_bucket_169684386827" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "config-bucket-169684386827"
}

resource "aws_s3_bucket_acl" "databeach_hackathon" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "databeach-hackathon"
}

resource "aws_s3_bucket_acl" "dev_posthog_lambda_edge" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "dev-posthog-lambda-edge"
}

resource "aws_s3_bucket_acl" "posthog_cloud_billing_dev_us_east_1_cdn_logs" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    grant {
      grantee {
        id   = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-billing-dev-us-east-1-cdn-logs"
}

resource "aws_s3_bucket_acl" "posthog_cloud_dev_us_east_1_app_assets" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-dev-us-east-1-app-assets"
}

resource "aws_s3_bucket_acl" "posthog_cloud_dev_us_east_1_cdn_logs" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    grant {
      grantee {
        id   = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-dev-us-east-1-cdn-logs"
}

resource "aws_s3_bucket_acl" "posthog_cloud_dev_us_east_1_flow_logs" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-dev-us-east-1-flow-logs"
}

resource "aws_s3_bucket_acl" "posthog_cloud_dev_us_east_1_lb_logs" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-dev-us-east-1-lb-logs"
}

resource "aws_s3_bucket_acl" "posthog_cloud_dev_us_east_1_loki" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-dev-us-east-1-loki"
}

resource "aws_s3_bucket_acl" "posthog_cloud_dev_us_east_1_msk_logs" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-dev-us-east-1-msk-logs"
}

resource "aws_s3_bucket_acl" "posthog_cloud_dev_us_east_1_static_assets" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-dev-us-east-1-static-assets"
}

resource "aws_s3_bucket_acl" "posthog_cloud_terraform_dev_us_east_1" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-cloud-terraform-dev-us-east-1"
}

resource "aws_s3_bucket_acl" "posthog_s3disk" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "posthog-s3disk"
}

resource "aws_s3_bucket_acl" "test_vpc_pr_1378_flow_logs" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "test-vpc-pr-1378-flow-logs"
}

resource "aws_s3_bucket_acl" "xvello_export_test" {
  access_control_policy {
    grant {
      grantee {
        id   = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
    owner {
      id = "56f15421f68015754caba7955d10de3c12682d1085cc26698243bc8771fd62f0"
    }
  }
  bucket = "xvello-export-test"
}

