locals {
  name_99a7403187 = "portal-api-sandbox"
}

module "aws_cloudfront_cache_policy-portal-api-sandbox_99a7403187" {
  source                        = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront/modules/cache_policy?ref=main"
  name                          = local.name_99a7403187
  default_ttl                   = 0
  max_ttl                       = 1
  min_ttl                       = 0
  enable_accept_encoding_brotli = false
  enable_accept_encoding_gzip   = false
  cookie_behavior               = "none"
  header_behavior               = "whitelist"
  headers = [
    "Authorization",
    "Content-Type",
    "Host",
    "Origin",
    "access-control-request-method",
    "x-coast-fleet-id"
  ]
  query_string_behavior = "all"
}
