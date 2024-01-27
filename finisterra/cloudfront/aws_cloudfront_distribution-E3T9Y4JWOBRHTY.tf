module "aws_cloudfront_distribution-E3T9Y4JWOBRHTY" {
  source  = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront?ref=main"
  enabled = true
  aliases = [
    "portal-api.sandbox.coastpay.com"
  ]
  is_ipv6_enabled = false
  price_class     = "PriceClass_All"
  web_acl_id      = module.aws_wafv2_web_acl-aws-managed-waf-sandbox.arn
  tags = {
    "Environment" : "sandbox",
    "Name" : "client-portal-bff",
    "Terraform" : "true"
  }
  origin = {
    "sandbox-portal-api" : {
      "connection_attempts" : 3,
      "connection_timeout" : 10,
      "custom_origin_config" : {
        "http_port" : 80,
        "https_port" : 443,
        "origin_keepalive_timeout" : 5,
        "origin_protocol_policy" : "https-only",
        "origin_read_timeout" : 30,
        "origin_ssl_protocols" : [
          "TLSv1.2"
        ]
      },
      "domain_name" : "sandbox-portal-api-1513159882.us-east-1.elb.amazonaws.com",
      "origin_id" : "sandbox-portal-api"
    }
  }
  default_cache_behavior = {
    "allowed_methods" : [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT"
    ],
    "cache_policy_id" : module.aws_cloudfront_cache_policy-portal-api-sandbox_99a7403187.id,
    "cached_methods" : [
      "GET",
      "HEAD"
    ],
    "target_origin_id" : "sandbox-portal-api",
    "viewer_protocol_policy" : "redirect-to-https"
  }
  viewer_certificate = {
    "acm_certificate_arn" : module.aws_acm_certificate-__sandbox_coastpay_com_b2cd6c96ca.arn,
    "minimum_protocol_version" : "TLSv1.2_2021",
    "ssl_support_method" : "sni-only"
  }
}
