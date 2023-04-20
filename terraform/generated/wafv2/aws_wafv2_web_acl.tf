resource "aws_wafv2_web_acl" "a8aed78a_de24_456a_8fc4_394e54ddb293" {
  default_action {
    block {
    }
  }
  name = "AllogyGatewayDefault"
  rule {
    action {
      allow {
      }
    }
    name     = "allogyDomainRequest"
    priority = 0
    statement {
      or_statement {
        statement {
          byte_match_statement {
            field_to_match {
              single_header {
                name = "host"
              }
            }
            positional_constraint = "ENDS_WITH"
            search_string         = "allogy.com"
            text_transformation {
              priority = 0
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          byte_match_statement {
            field_to_match {
              single_header {
                name = "host"
              }
            }
            positional_constraint = "ENDS_WITH"
            search_string         = "allogy.net"
            text_transformation {
              priority = 0
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          byte_match_statement {
            field_to_match {
              single_header {
                name = "host"
              }
            }
            positional_constraint = "ENDS_WITH"
            search_string         = "us-gov-west-1.elasticbeanstalk.com"
            text_transformation {
              priority = 0
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          byte_match_statement {
            field_to_match {
              single_header {
                name = "host"
              }
            }
            positional_constraint = "ENDS_WITH"
            search_string         = "deployedmedicine.com"
            text_transformation {
              priority = 0
              type     = "LOWERCASE"
            }
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "notAllogyDomainRequest"
      sampled_requests_enabled   = true
    }
  }
  rule {
    action {
      block {
      }
    }
    name     = "webThreats"
    priority = 1
    statement {
      or_statement {
        statement {
          sqli_match_statement {
            field_to_match {
              uri_path {
              }
            }
            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }
        statement {
          sqli_match_statement {
            field_to_match {
              query_string {
              }
            }
            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "webThreats"
      sampled_requests_enabled   = true
    }
  }
  scope = "REGIONAL"
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "AllogyGatewayDefault"
    sampled_requests_enabled   = true
  }
}

