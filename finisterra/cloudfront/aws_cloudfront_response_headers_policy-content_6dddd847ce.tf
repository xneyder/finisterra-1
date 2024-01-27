locals {
  name_6dddd847ce = "content"
}

module "aws_cloudfront_response_headers_policy-content_6dddd847ce" {
  source = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront/modules/response_headers_policy?ref=main"
  name   = local.name_6dddd847ce
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
          "override" : false,
          "value" : "no-cache"
        },
        {
          "header" : "nginx",
          "override" : false,
          "value" : "block"
        }
      ]
    }
  ]
  security_headers_config = [
    {
      "${local.name_6dddd847ce}_security_policy" : [
        {
          "${local.name_6dddd847ce}_security_policy" : "frame-ancestors 'none'",
          "override" : true
        }
      ],
      "${local.name_6dddd847ce}_type_options" : [],
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
