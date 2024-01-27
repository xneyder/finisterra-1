module "aws_cloudfront_distribution-E31WQ2W96RYYTV" {
  source  = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront?ref=main"
  enabled = true
  aliases = [
    "cf.coastpay.com"
  ]
  is_ipv6_enabled = true
  price_class     = "PriceClass_All"
  origin = {
    "coast-cf-poc.s3.us-east-1.amazonaws.com" : {
      "connection_attempts" : 3,
      "connection_timeout" : 10,
      "domain_name" : "coast-cf-poc.s3.us-east-1.amazonaws.com",
      "origin_id" : "coast-cf-poc.s3.us-east-1.amazonaws.com"
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
    "target_origin_id" : "coast-cf-poc.s3.us-east-1.amazonaws.com",
    "viewer_protocol_policy" : "allow-all"
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
      "compress" : true,
      "path_pattern" : "/api/*",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-api_af9af68b7c.id,
      "target_origin_id" : "coast-cf-poc.s3.us-east-1.amazonaws.com",
      "viewer_protocol_policy" : "allow-all"
    },
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
      "compress" : true,
      "origin_request_policy_id" : module.aws_cloudfront_origin_request_policy-test_b83d57e80a.id,
      "path_pattern" : "/content/*",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-content_6dddd847ce.id,
      "target_origin_id" : "coast-cf-poc.s3.us-east-1.amazonaws.com",
      "viewer_protocol_policy" : "allow-all"
    }
  ]
  viewer_certificate = {
    "acm_certificate_arn" : module.aws_acm_certificate-cf_coastpay_com_5f173e5960.arn,
    "minimum_protocol_version" : "TLSv1.2_2021",
    "ssl_support_method" : "sni-only"
  }
}
