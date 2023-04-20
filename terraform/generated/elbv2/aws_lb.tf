resource "aws_lb" "awseb_AWSEB_15FYW3NG9H6DT" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "collaboration-person-blue"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "collaboration-person-blue"

    "elasticbeanstalk:environment-id" = "e-3evreti3za"

    "elasticbeanstalk:environment-name" = "collaboration-person-blue"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_15X3QV41KCHP8" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "capillary-web-ui-gateway-blue"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "capillary-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-bner7vhrif"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-blue"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_19VCM7V6OTYWF" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "market-service-green"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "market-service-green"

    "elasticbeanstalk:environment-id" = "e-jhagz8maay"

    "elasticbeanstalk:environment-name" = "market-service-green"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_1GLHUBRW9EX1B" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "mobile-client-gateway-blue"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "mobile-client-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-pcw37ypdme"

    "elasticbeanstalk:environment-name" = "mobile-client-gateway-blue"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_1MDXACYOB2IRQ" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "internal-services-gateway-green"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "internal-services-gateway-green"

    "elasticbeanstalk:environment-id" = "e-yd9s5vvfgp"

    "elasticbeanstalk:environment-name" = "internal-services-gateway-green"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_1SO91UM91RWQI" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "identity-service-blue"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "identity-service-blue"

    "elasticbeanstalk:environment-id" = "e-fbj96npvkw"

    "elasticbeanstalk:environment-name" = "identity-service-blue"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_1T7NB5B3Y3A7K" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "book-service-blue"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "book-service-blue"

    "elasticbeanstalk:environment-id" = "e-fmzgrfkcqp"

    "elasticbeanstalk:environment-name" = "book-service-blue"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_1W0ZV84FILDNY" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "book-service-green"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "book-service-green"

    "elasticbeanstalk:environment-id" = "e-xmec4epg3c"

    "elasticbeanstalk:environment-name" = "book-service-green"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_61URVRH00UCZ" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "identity-service-green"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "identity-service-green"

    "elasticbeanstalk:environment-id" = "e-tx62adwg2k"

    "elasticbeanstalk:environment-name" = "identity-service-green"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_8H0U1SE19616" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "dbt-clinician-web-green"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "dbt-clinician-web-green"

    "elasticbeanstalk:environment-id" = "e-jgrjparfpf"

    "elasticbeanstalk:environment-name" = "dbt-clinician-web-green"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_9EQA00IFFDNV" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "services-gateway-blue"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "services-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-32xzmdus8p"

    "elasticbeanstalk:environment-name" = "services-gateway-blue"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_DJD83A7DQHVI" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "learner-web-ui-gateway-blue"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "learner-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-59p3bpnwec"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-blue"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_NDZP2R5I5BRY" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "form-service-blue"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "form-service-blue"

    "elasticbeanstalk:environment-id" = "e-bmqqxwyjst"

    "elasticbeanstalk:environment-name" = "form-service-blue"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_XZ6JUMA8IEE" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "learner-web-ui-gateway-green"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "learner-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-rwv222b3qp"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-green"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "awseb_AWSEB_ZRMNV8V7XEA5" {
  access_logs {
    bucket  = "allogy-elb-logs-prod"
    enabled = true
    prefix  = "capillary-web-ui-gateway-green"
  }
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-0680aa96bc65f072d"
  }
  subnet_mapping {
    subnet_id = "subnet-07402e5b661b23bec"
  }
  subnet_mapping {
    subnet_id = "subnet-076f8b852c6b60060"
  }
  tags = {
    Name = "capillary-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-p6bifdmp7h"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-green"

  }
  xff_header_processing_mode = "append"
}

resource "aws_lb" "service_infrastructure_internal" {
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  load_balancer_type                          = "application"
  preserve_host_header                        = false
  subnet_mapping {
    subnet_id = "subnet-04e27b7af0a76d7ee"
  }
  subnet_mapping {
    subnet_id = "subnet-05203dc92b0823553"
  }
  subnet_mapping {
    subnet_id = "subnet-096303542f2113a20"
  }
  xff_header_processing_mode = "append"
}

