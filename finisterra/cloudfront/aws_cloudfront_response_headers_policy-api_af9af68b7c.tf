locals {
  name_af9af68b7c = "api"
}

module "aws_cloudfront_response_headers_policy-api_af9af68b7c" {
  source = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront/modules/response_headers_policy?ref=main"
  name   = local.name_af9af68b7c
  custom_headers_config = [
    {
      "items" : [
        {
          "header" : "Cache-control",
          "override" : true,
          "value" : "no-store, no-cache"
        },
        {
          "header" : "Pragma",
          "override" : true,
          "value" : "no-cache"
        }
      ]
    }
  ]
  security_headers_config = [
    {
      "content_security_policy" : [
        {
          "content_security_policy" : "frame-ancestors 'none'",
          "override" : true
        }
      ],
      "content_type_options" : [],
      "frame_options" : [
        {
          "frame_option" : "DENY",
          "override" : true
        }
      ],
      "referrer_policy" : [],
      "strict_transport_security" : [
        {
          "access_control_max_age_sec" : 31536000,
          "include_subdomains" : false,
          "override" : true,
          "preload" : false
        }
      ],
      "xss_protection" : []
    }
  ]
}
