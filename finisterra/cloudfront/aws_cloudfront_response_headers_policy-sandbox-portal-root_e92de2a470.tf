locals {
  name_e92de2a470 = "sandbox-portal-root"
}

module "aws_cloudfront_response_headers_policy-sandbox-portal-root_e92de2a470" {
  source = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront/modules/response_headers_policy?ref=main"
  name   = local.name_e92de2a470
  custom_headers_config = [
    {
      "items" : [
        {
          "header" : "Cache-Control",
          "override" : false,
          "value" : "max-age=30"
        },
        {
          "header" : "server",
          "override" : true,
          "value" : "coast"
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
      "content_type_options" : [
        {
          "override" : true
        }
      ],
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
          "include_subdomains" : true,
          "override" : true,
          "preload" : true
        }
      ],
      "xss_protection" : []
    }
  ]
}
