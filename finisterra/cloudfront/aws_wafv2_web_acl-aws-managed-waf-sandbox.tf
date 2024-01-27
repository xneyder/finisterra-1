locals {
  name_938a542f7d = "aws-managed-waf-sandbox"
}

module "aws_wafv2_web_acl-aws-managed-waf-sandbox" {
  source      = "github.com/finisterra-io/terraform-aws-modules.git//wafv2?ref=main"
  name        = local.name_938a542f7d
  description = "Definition for AWS WAF Managed rules"
  scope       = "CLOUDFRONT"
  tags = {
    "Environment" : "dev",
    "Terraform" : "true"
  }
  default_action = [
    {
      "allow" : [
        {
          "custom_request_handling" : []
        }
      ],
      "block" : []
    }
  ]
  visibility_config = [
    {
      "cloudwatch_metrics_enabled" : true,
      "metric_name" : "${local.name_938a542f7d}-metric",
      "sampled_requests_enabled" : true
    }
  ]
  rules = [
    {
      "action" : [],
      "captcha_config" : [],
      "name" : "admin-protection-set",
      "override_action" : [
        {
          "count" : [],
          "none" : [
            {}
          ]
        }
      ],
      "priority" : 2,
      "rule_label" : [],
      "statement" : [
        {
          "and_statement" : [],
          "byte_match_statement" : [],
          "geo_match_statement" : [],
          "ip_set_reference_statement" : [],
          "label_match_statement" : [],
          "managed_rule_group_statement" : [
            {
              "managed_rule_group_configs" : [],
              "name" : "AWSManagedRulesAdminProtectionRuleSet",
              "rule_action_override" : [],
              "scope_down_statement" : [],
              "vendor_name" : "AWS",
              "version" : ""
            }
          ],
          "not_statement" : [],
          "or_statement" : [],
          "rate_based_statement" : [],
          "regex_match_statement" : [],
          "regex_pattern_set_reference_statement" : [],
          "rule_group_reference_statement" : [],
          "size_constraint_statement" : [],
          "sqli_match_statement" : [],
          "xss_match_statement" : []
        }
      ],
      "visibility_config" : [
        {
          "cloudwatch_metrics_enabled" : true,
          "metric_name" : "admin-protection-set-metric-name",
          "sampled_requests_enabled" : true
        }
      ]
    },
    {
      "action" : [],
      "captcha_config" : [],
      "name" : "bad-inputs-set",
      "override_action" : [
        {
          "count" : [],
          "none" : [
            {}
          ]
        }
      ],
      "priority" : 3,
      "rule_label" : [],
      "statement" : [
        {
          "and_statement" : [],
          "byte_match_statement" : [],
          "geo_match_statement" : [],
          "ip_set_reference_statement" : [],
          "label_match_statement" : [],
          "managed_rule_group_statement" : [
            {
              "managed_rule_group_configs" : [],
              "name" : "AWSManagedRulesKnownBadInputsRuleSet",
              "rule_action_override" : [],
              "scope_down_statement" : [],
              "vendor_name" : "AWS",
              "version" : ""
            }
          ],
          "not_statement" : [],
          "or_statement" : [],
          "rate_based_statement" : [],
          "regex_match_statement" : [],
          "regex_pattern_set_reference_statement" : [],
          "rule_group_reference_statement" : [],
          "size_constraint_statement" : [],
          "sqli_match_statement" : [],
          "xss_match_statement" : []
        }
      ],
      "visibility_config" : [
        {
          "cloudwatch_metrics_enabled" : true,
          "metric_name" : "bad-inputs-set-metric-name",
          "sampled_requests_enabled" : true
        }
      ]
    },
    {
      "action" : [],
      "captcha_config" : [],
      "name" : "core-rule-set",
      "override_action" : [
        {
          "count" : [],
          "none" : [
            {}
          ]
        }
      ],
      "priority" : 1,
      "rule_label" : [],
      "statement" : [
        {
          "and_statement" : [],
          "byte_match_statement" : [],
          "geo_match_statement" : [],
          "ip_set_reference_statement" : [],
          "label_match_statement" : [],
          "managed_rule_group_statement" : [
            {
              "managed_rule_group_configs" : [],
              "name" : "AWSManagedRulesCommonRuleSet",
              "rule_action_override" : [],
              "scope_down_statement" : [
                {
                  "and_statement" : [
                    {
                      "statement" : [
                        {
                          "and_statement" : [],
                          "byte_match_statement" : [],
                          "geo_match_statement" : [],
                          "ip_set_reference_statement" : [],
                          "label_match_statement" : [],
                          "not_statement" : [
                            {
                              "statement" : [
                                {
                                  "byte_match_statement" : [
                                    {
                                      "field_to_match" : [
                                        {
                                          "all_query_arguments" : [],
                                          "body" : [],
                                          "cookies" : [],
                                          "headers" : [],
                                          "ja3_fingerprint" : [],
                                          "json_body" : [],
                                          "method" : [],
                                          "query_string" : [],
                                          "single_header" : [],
                                          "single_query_argument" : [],
                                          "uri_path" : [
                                            {}
                                          ]
                                        }
                                      ],
                                      "positional_constraint" : "CONTAINS",
                                      "search_string" : "/oauth2",
                                      "text_transformation" : [
                                        {
                                          "priority" : 0,
                                          "type" : "NONE"
                                        }
                                      ]
                                    }
                                  ],
                                  "geo_match_statement" : [],
                                  "ip_set_reference_statement" : [],
                                  "label_match_statement" : [],
                                  "regex_match_statement" : [],
                                  "regex_pattern_set_reference_statement" : [],
                                  "size_constraint_statement" : [],
                                  "sqli_match_statement" : [],
                                  "xss_match_statement" : []
                                }
                              ]
                            }
                          ],
                          "or_statement" : [],
                          "regex_match_statement" : [],
                          "regex_pattern_set_reference_statement" : [],
                          "size_constraint_statement" : [],
                          "sqli_match_statement" : [],
                          "xss_match_statement" : []
                        },
                        {
                          "and_statement" : [],
                          "byte_match_statement" : [],
                          "geo_match_statement" : [],
                          "ip_set_reference_statement" : [],
                          "label_match_statement" : [],
                          "not_statement" : [
                            {
                              "statement" : [
                                {
                                  "byte_match_statement" : [
                                    {
                                      "field_to_match" : [
                                        {
                                          "all_query_arguments" : [],
                                          "body" : [],
                                          "cookies" : [],
                                          "headers" : [],
                                          "ja3_fingerprint" : [],
                                          "json_body" : [],
                                          "method" : [],
                                          "query_string" : [],
                                          "single_header" : [],
                                          "single_query_argument" : [],
                                          "uri_path" : [
                                            {}
                                          ]
                                        }
                                      ],
                                      "positional_constraint" : "CONTAINS",
                                      "search_string" : "qualifications/upload_document",
                                      "text_transformation" : [
                                        {
                                          "priority" : 0,
                                          "type" : "NONE"
                                        }
                                      ]
                                    }
                                  ],
                                  "geo_match_statement" : [],
                                  "ip_set_reference_statement" : [],
                                  "label_match_statement" : [],
                                  "regex_match_statement" : [],
                                  "regex_pattern_set_reference_statement" : [],
                                  "size_constraint_statement" : [],
                                  "sqli_match_statement" : [],
                                  "xss_match_statement" : []
                                }
                              ]
                            }
                          ],
                          "or_statement" : [],
                          "regex_match_statement" : [],
                          "regex_pattern_set_reference_statement" : [],
                          "size_constraint_statement" : [],
                          "sqli_match_statement" : [],
                          "xss_match_statement" : []
                        }
                      ]
                    }
                  ],
                  "byte_match_statement" : [],
                  "geo_match_statement" : [],
                  "ip_set_reference_statement" : [],
                  "label_match_statement" : [],
                  "not_statement" : [],
                  "or_statement" : [],
                  "regex_match_statement" : [],
                  "regex_pattern_set_reference_statement" : [],
                  "size_constraint_statement" : [],
                  "sqli_match_statement" : [],
                  "xss_match_statement" : []
                }
              ],
              "vendor_name" : "AWS",
              "version" : ""
            }
          ],
          "not_statement" : [],
          "or_statement" : [],
          "rate_based_statement" : [],
          "regex_match_statement" : [],
          "regex_pattern_set_reference_statement" : [],
          "rule_group_reference_statement" : [],
          "size_constraint_statement" : [],
          "sqli_match_statement" : [],
          "xss_match_statement" : []
        }
      ],
      "visibility_config" : [
        {
          "cloudwatch_metrics_enabled" : true,
          "metric_name" : "core-rule-set-metric-name",
          "sampled_requests_enabled" : true
        }
      ]
    },
    {
      "action" : [],
      "captcha_config" : [],
      "name" : "core-rule-set-oauth2",
      "override_action" : [
        {
          "count" : [],
          "none" : [
            {}
          ]
        }
      ],
      "priority" : 4,
      "rule_label" : [],
      "statement" : [
        {
          "and_statement" : [],
          "byte_match_statement" : [],
          "geo_match_statement" : [],
          "ip_set_reference_statement" : [],
          "label_match_statement" : [],
          "managed_rule_group_statement" : [
            {
              "managed_rule_group_configs" : [],
              "name" : "AWSManagedRulesCommonRuleSet",
              "rule_action_override" : [
                {
                  "action_to_use" : [
                    {
                      "allow" : [],
                      "block" : [],
                      "captcha" : [],
                      "challenge" : [],
                      "count" : [
                        {
                          "custom_request_handling" : []
                        }
                      ]
                    }
                  ],
                  "name" : "SizeRestrictions_QUERYSTRING"
                }
              ],
              "scope_down_statement" : [
                {
                  "and_statement" : [],
                  "byte_match_statement" : [
                    {
                      "field_to_match" : [
                        {
                          "all_query_arguments" : [],
                          "body" : [],
                          "cookies" : [],
                          "headers" : [],
                          "ja3_fingerprint" : [],
                          "json_body" : [],
                          "method" : [],
                          "query_string" : [],
                          "single_header" : [],
                          "single_query_argument" : [],
                          "uri_path" : [
                            {}
                          ]
                        }
                      ],
                      "positional_constraint" : "CONTAINS",
                      "search_string" : "/oauth2",
                      "text_transformation" : [
                        {
                          "priority" : 0,
                          "type" : "NONE"
                        }
                      ]
                    }
                  ],
                  "geo_match_statement" : [],
                  "ip_set_reference_statement" : [],
                  "label_match_statement" : [],
                  "not_statement" : [],
                  "or_statement" : [],
                  "regex_match_statement" : [],
                  "regex_pattern_set_reference_statement" : [],
                  "size_constraint_statement" : [],
                  "sqli_match_statement" : [],
                  "xss_match_statement" : []
                }
              ],
              "vendor_name" : "AWS",
              "version" : ""
            }
          ],
          "not_statement" : [],
          "or_statement" : [],
          "rate_based_statement" : [],
          "regex_match_statement" : [],
          "regex_pattern_set_reference_statement" : [],
          "rule_group_reference_statement" : [],
          "size_constraint_statement" : [],
          "sqli_match_statement" : [],
          "xss_match_statement" : []
        }
      ],
      "visibility_config" : [
        {
          "cloudwatch_metrics_enabled" : true,
          "metric_name" : "core-rule-set-oauth2-metric-name",
          "sampled_requests_enabled" : true
        }
      ]
    },
    {
      "action" : [],
      "captcha_config" : [],
      "name" : "core-rule-set-upload",
      "override_action" : [
        {
          "count" : [],
          "none" : [
            {}
          ]
        }
      ],
      "priority" : 5,
      "rule_label" : [],
      "statement" : [
        {
          "and_statement" : [],
          "byte_match_statement" : [],
          "geo_match_statement" : [],
          "ip_set_reference_statement" : [],
          "label_match_statement" : [],
          "managed_rule_group_statement" : [
            {
              "managed_rule_group_configs" : [],
              "name" : "AWSManagedRulesCommonRuleSet",
              "rule_action_override" : [
                {
                  "action_to_use" : [
                    {
                      "allow" : [],
                      "block" : [],
                      "captcha" : [],
                      "challenge" : [],
                      "count" : [
                        {
                          "custom_request_handling" : []
                        }
                      ]
                    }
                  ],
                  "name" : "SizeRestrictions_BODY"
                }
              ],
              "scope_down_statement" : [
                {
                  "and_statement" : [],
                  "byte_match_statement" : [
                    {
                      "field_to_match" : [
                        {
                          "all_query_arguments" : [],
                          "body" : [],
                          "cookies" : [],
                          "headers" : [],
                          "ja3_fingerprint" : [],
                          "json_body" : [],
                          "method" : [],
                          "query_string" : [],
                          "single_header" : [],
                          "single_query_argument" : [],
                          "uri_path" : [
                            {}
                          ]
                        }
                      ],
                      "positional_constraint" : "CONTAINS",
                      "search_string" : "qualifications/upload_document",
                      "text_transformation" : [
                        {
                          "priority" : 0,
                          "type" : "NONE"
                        }
                      ]
                    }
                  ],
                  "geo_match_statement" : [],
                  "ip_set_reference_statement" : [],
                  "label_match_statement" : [],
                  "not_statement" : [],
                  "or_statement" : [],
                  "regex_match_statement" : [],
                  "regex_pattern_set_reference_statement" : [],
                  "size_constraint_statement" : [],
                  "sqli_match_statement" : [],
                  "xss_match_statement" : []
                }
              ],
              "vendor_name" : "AWS",
              "version" : ""
            }
          ],
          "not_statement" : [],
          "or_statement" : [],
          "rate_based_statement" : [],
          "regex_match_statement" : [],
          "regex_pattern_set_reference_statement" : [],
          "rule_group_reference_statement" : [],
          "size_constraint_statement" : [],
          "sqli_match_statement" : [],
          "xss_match_statement" : []
        }
      ],
      "visibility_config" : [
        {
          "cloudwatch_metrics_enabled" : true,
          "metric_name" : "core-rule-set-upload-metric-name",
          "sampled_requests_enabled" : true
        }
      ]
    }
  ]
  log_destination_configs = [
    module.aws_cloudwatch_log_group-aws-waf-logs-aws-managed-waf-sandbox.arn
  ]
}
