locals {
  name_b83d57e80a = "test"
}

module "aws_cloudfront_origin_request_policy-test_b83d57e80a" {
  source          = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront/modules/origin_request_policy?ref=main"
  name            = local.name_b83d57e80a
  cookie_behavior = "allExcept"
  cookies = [
    local.name_b83d57e80a
  ]
  header_behavior       = "allViewer"
  query_string_behavior = "all"
}
