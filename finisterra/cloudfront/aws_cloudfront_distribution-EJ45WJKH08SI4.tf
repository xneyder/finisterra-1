module "aws_cloudfront_distribution-EJ45WJKH08SI4" {
  source              = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront?ref=main"
  enabled             = true
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  logging_config = {
    "bucket" : module.aws_s3_bucket-coast-sandbox-test-logs_0f3535a674.bucket_domain_name,
    "include_cookies" : false,
    "prefix" : "cloudfront"
  }
  origin = {
    "test-webapp" : {
      "connection_attempts" : 3,
      "connection_timeout" : 10,
      "domain_name" : "coast-sandbox-test-webapp.s3.amazonaws.com",
      "origin_id" : "test-webapp",
      "s3_origin_config" : {
        "origin_access_identity" : module.aws_cloudfront_origin_access_identity-ESGKI4G1X71SX_ddd0bfc2c7.cloudfront_access_identity_path
      }
    }
  }
  default_cache_behavior = {
    "allowed_methods" : [
      "GET",
      "HEAD"
    ],
    "cache_policy_name" : "Managed-CachingOptimized",
    "cached_methods" : [
      "GET",
      "HEAD"
    ],
    "compress" : true,
    "lambda_function_association" : {
      "origin-request" : {
        "lambda_arn" : module.aws_lambda_function-test-spa-deep-linking.qualified_arn,
        "include_body" : false
      },
      "viewer-request" : {
        "lambda_arn" : module.aws_lambda_function-test-cloudfront-webapp-auth.qualified_arn,
        "include_body" : false
      }
    },
    "target_origin_id" : "test-webapp",
    "viewer_protocol_policy" : "redirect-to-https"
  }
  ordered_cache_behavior = [
    {
      "allowed_methods" : [
        "GET",
        "HEAD"
      ],
      "cache_policy_name" : "Managed-CachingDisabled",
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "lambda_function_association" : {
        "origin-request" : {
          "lambda_arn" : module.aws_lambda_function-test-spa-deep-linking.qualified_arn,
          "include_body" : false
        },
        "viewer-request" : {
          "lambda_arn" : module.aws_lambda_function-test-cloudfront-webapp-auth.qualified_arn,
          "include_body" : false
        }
      },
      "path_pattern" : "/",
      "target_origin_id" : "test-webapp",
      "viewer_protocol_policy" : "redirect-to-https"
    }
  ]
  viewer_certificate = {
    "cloudfront_default_certificate" : true,
    "minimum_protocol_version" : "TLSv1"
  }
}
