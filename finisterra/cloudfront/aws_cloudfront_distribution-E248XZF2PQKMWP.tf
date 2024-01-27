module "aws_cloudfront_distribution-E248XZF2PQKMWP" {
  source  = "github.com/finisterra-io/terraform-aws-modules.git//cloudfront?ref=main"
  enabled = true
  aliases = [
    "portal.sandbox.coastpay.com"
  ]
  is_ipv6_enabled = true
  price_class     = "PriceClass_All"
  web_acl_id      = module.aws_wafv2_web_acl-aws-managed-waf-sandbox.arn
  tags = {
    "Environment" : "sandbox",
    "Terraform" : "true"
  }
  logging_config = {
    "bucket" : module.aws_s3_bucket-coast-sandbox-us-east-1-070252509141-log-bucket_3688b8cadf.bucket_domain_name,
    "include_cookies" : false,
    "prefix" : "cloudfront"
  }
  origin = {
    "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com" : {
      "connection_attempts" : 3,
      "connection_timeout" : 10,
      "custom_header" : [
        {
          "name" : "X-ALB-Name",
          "value" : "sandbox-apps-alb"
        }
      ],
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
      "domain_name" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
      "origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com"
    },
    "first.iovation.com" : {
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
      "domain_name" : "first.iovation.com",
      "origin_id" : "first.iovation.com"
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
    "cached_methods" : [
      "GET",
      "HEAD"
    ],
    "forwarded_values" : [
      {
        "headers" : [
          "*"
        ],
        "query_string" : true,
        "cookies_forward" : "all",
        "cookies_whitelisted_names" : [],
        "query_string_cache_keys" : []
      }
    ],
    "lambda_function_association" : {
      "viewer-request" : {
        "lambda_arn" : module.aws_lambda_function-cognito_auth_sandbox.qualified_arn,
        "include_body" : false
      }
    },
    "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-api_617d38dd7e.id,
    "target_origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
    "viewer_protocol_policy" : "redirect-to-https"
  }
  ordered_cache_behavior = [
    {
      "allowed_methods" : [
        "DELETE",
        "GET",
        "HEAD",
        "OPTIONS",
        "PATCH",
        "POST",
        "PUT"
      ],
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "compress" : true,
      "default_ttl" : 30,
      "forwarded_values" : [
        {
          "headers" : [
            "Host"
          ],
          "query_string" : false,
          "cookies_forward" : "none",
          "cookies_whitelisted_names" : [],
          "query_string_cache_keys" : []
        }
      ],
      "lambda_function_association" : {
        "viewer-request" : {
          "lambda_arn" : module.aws_lambda_function-cognito_auth_sandbox.qualified_arn,
          "include_body" : false
        }
      },
      "max_ttl" : 30,
      "path_pattern" : "/",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-root_e92de2a470.id,
      "target_origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
      "viewer_protocol_policy" : "redirect-to-https"
    },
    {
      "allowed_methods" : [
        "DELETE",
        "GET",
        "HEAD",
        "OPTIONS",
        "PATCH",
        "POST",
        "PUT"
      ],
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "compress" : true,
      "default_ttl" : 86400,
      "forwarded_values" : [
        {
          "headers" : [
            "Host"
          ],
          "query_string" : false,
          "cookies_forward" : "none",
          "cookies_whitelisted_names" : [],
          "query_string_cache_keys" : []
        }
      ],
      "lambda_function_association" : {
        "viewer-request" : {
          "lambda_arn" : module.aws_lambda_function-cognito_auth_sandbox.qualified_arn,
          "include_body" : false
        }
      },
      "max_ttl" : 86400,
      "path_pattern" : "/static/*",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-content_51e18e4eaf.id,
      "target_origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
      "viewer_protocol_policy" : "redirect-to-https"
    },
    {
      "allowed_methods" : [
        "DELETE",
        "GET",
        "HEAD",
        "OPTIONS",
        "PATCH",
        "POST",
        "PUT"
      ],
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "compress" : true,
      "default_ttl" : 86400,
      "forwarded_values" : [
        {
          "headers" : [
            "Host"
          ],
          "query_string" : false,
          "cookies_forward" : "none",
          "cookies_whitelisted_names" : [],
          "query_string_cache_keys" : []
        }
      ],
      "lambda_function_association" : {
        "viewer-request" : {
          "lambda_arn" : module.aws_lambda_function-cognito_auth_sandbox.qualified_arn,
          "include_body" : false
        }
      },
      "max_ttl" : 86400,
      "path_pattern" : "/manifest.json",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-content_51e18e4eaf.id,
      "target_origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
      "viewer_protocol_policy" : "redirect-to-https"
    },
    {
      "allowed_methods" : [
        "DELETE",
        "GET",
        "HEAD",
        "OPTIONS",
        "PATCH",
        "POST",
        "PUT"
      ],
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "compress" : true,
      "default_ttl" : 86400,
      "forwarded_values" : [
        {
          "headers" : [
            "Host"
          ],
          "query_string" : false,
          "cookies_forward" : "none",
          "cookies_whitelisted_names" : [],
          "query_string_cache_keys" : []
        }
      ],
      "lambda_function_association" : {
        "viewer-request" : {
          "lambda_arn" : module.aws_lambda_function-cognito_auth_sandbox.qualified_arn,
          "include_body" : false
        }
      },
      "max_ttl" : 86400,
      "path_pattern" : "/favicon.ico",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-content_51e18e4eaf.id,
      "target_origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
      "viewer_protocol_policy" : "redirect-to-https"
    },
    {
      "allowed_methods" : [
        "DELETE",
        "GET",
        "HEAD",
        "OPTIONS",
        "PATCH",
        "POST",
        "PUT"
      ],
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "compress" : true,
      "default_ttl" : 86400,
      "forwarded_values" : [
        {
          "headers" : [
            "Host"
          ],
          "query_string" : false,
          "cookies_forward" : "none",
          "cookies_whitelisted_names" : [],
          "query_string_cache_keys" : []
        }
      ],
      "lambda_function_association" : {
        "viewer-request" : {
          "lambda_arn" : module.aws_lambda_function-cognito_auth_sandbox.qualified_arn,
          "include_body" : false
        }
      },
      "max_ttl" : 86400,
      "path_pattern" : "/logo192.png",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-content_51e18e4eaf.id,
      "target_origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
      "viewer_protocol_policy" : "redirect-to-https"
    },
    {
      "allowed_methods" : [
        "DELETE",
        "GET",
        "HEAD",
        "OPTIONS",
        "PATCH",
        "POST",
        "PUT"
      ],
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "compress" : true,
      "default_ttl" : 86400,
      "forwarded_values" : [
        {
          "headers" : [
            "Host"
          ],
          "query_string" : false,
          "cookies_forward" : "none",
          "cookies_whitelisted_names" : [],
          "query_string_cache_keys" : []
        }
      ],
      "lambda_function_association" : {
        "viewer-request" : {
          "lambda_arn" : module.aws_lambda_function-cognito_auth_sandbox.qualified_arn,
          "include_body" : false
        }
      },
      "max_ttl" : 86400,
      "path_pattern" : "/io-loader.js",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-content_51e18e4eaf.id,
      "target_origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
      "viewer_protocol_policy" : "redirect-to-https"
    },
    {
      "allowed_methods" : [
        "DELETE",
        "GET",
        "HEAD",
        "OPTIONS",
        "PATCH",
        "POST",
        "PUT"
      ],
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "compress" : true,
      "default_ttl" : 86400,
      "forwarded_values" : [
        {
          "headers" : [
            "Host"
          ],
          "query_string" : false,
          "cookies_forward" : "none",
          "cookies_whitelisted_names" : [],
          "query_string_cache_keys" : []
        }
      ],
      "lambda_function_association" : {
        "viewer-request" : {
          "lambda_arn" : module.aws_lambda_function-cognito_auth_sandbox.qualified_arn,
          "include_body" : false
        }
      },
      "max_ttl" : 86400,
      "path_pattern" : "/heap.js",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-content_51e18e4eaf.id,
      "target_origin_id" : "sandbox-apps-alb-1168574949.us-east-1.elb.amazonaws.com",
      "viewer_protocol_policy" : "redirect-to-https"
    },
    {
      "allowed_methods" : [
        "DELETE",
        "GET",
        "HEAD",
        "OPTIONS",
        "PATCH",
        "POST",
        "PUT"
      ],
      "cached_methods" : [
        "GET",
        "HEAD"
      ],
      "forwarded_values" : [
        {
          "headers" : [
            "*"
          ],
          "query_string" : true,
          "cookies_forward" : "all",
          "cookies_whitelisted_names" : [],
          "query_string_cache_keys" : []
        }
      ],
      "function_association" : {
        "viewer-request" : {
          "function_arn" : module.aws_cloudfront_function-sandbox-portal-cloudfront-function-rewrite-iojs-uri_af6fcab864.arn
        }
      },
      "path_pattern" : "/iojs/*",
      "response_headers_policy_id" : module.aws_cloudfront_response_headers_policy-sandbox-portal-api_617d38dd7e.id,
      "target_origin_id" : "first.iovation.com",
      "viewer_protocol_policy" : "redirect-to-https"
    }
  ]
  viewer_certificate = {
    "acm_certificate_arn" : module.aws_acm_certificate-__sandbox_coastpay_com_b2cd6c96ca.arn,
    "minimum_protocol_version" : "TLSv1.2_2021",
    "ssl_support_method" : "sni-only"
  }
}
