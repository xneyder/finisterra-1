resource "aws_elasticsearch_domain" "shared_01" {
  advanced_security_options {
    enabled                        = false
    internal_user_database_enabled = false
  }
  auto_tune_options {
    desired_state = "ENABLED"
    maintenance_schedule {
      cron_expression_for_recurrence = "cron(0 0 ? * 1 *)"
      duration {
        unit  = "HOURS"
        value = 2
      }
      start_at = "2022-10-21T19:16:56Z"
    }
  }
  cluster_config {
    cold_storage_options {
    }
    dedicated_master_count   = 0
    dedicated_master_enabled = false
    instance_count           = 2
    instance_type            = "t2.small.elasticsearch"
    warm_enabled             = false
    zone_awareness_config {
      availability_zone_count = 2
    }
    zone_awareness_enabled = true
  }
  domain_endpoint_options {
    custom_endpoint_enabled = false
    enforce_https           = false
  }
  domain_name = "shared-01"
  ebs_options {
    ebs_enabled = true
    volume_size = 20
  }
  elasticsearch_version = "6.8"
  encrypt_at_rest {
    enabled = false
  }
  log_publishing_options {
    cloudwatch_log_group_arn = "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:/aws/OpenSearchService/domains/shared-01/application-logs"
    enabled                  = true
    log_type                 = "ES_APPLICATION_LOGS"
  }
  node_to_node_encryption {
    enabled = false
  }
  snapshot_options {
    automated_snapshot_start_hour = 6
  }
  tags = {
    DeploymentEnvironment = "production"

    Name = "shared-01"

  }
  vpc_options {
    security_group_ids = [
      "sg-081ba48ae3370758b"
    ]
    subnet_ids = [
      "subnet-04e27b7af0a76d7ee", "subnet-05203dc92b0823553"
    ]
  }
}

resource "aws_elasticsearch_domain" "shared_02" {
  advanced_security_options {
    enabled                        = false
    internal_user_database_enabled = false
  }
  auto_tune_options {
    desired_state = "ENABLED"
    maintenance_schedule {
      cron_expression_for_recurrence = "cron(0 0 ? * 1 *)"
      duration {
        unit  = "HOURS"
        value = 2
      }
      start_at = "2023-03-10T23:21:47Z"
    }
  }
  cluster_config {
    cold_storage_options {
    }
    dedicated_master_count   = 3
    dedicated_master_enabled = true
    dedicated_master_type    = "t3.medium.elasticsearch"
    instance_count           = 3
    instance_type            = "t3.small.elasticsearch"
    warm_enabled             = false
    zone_awareness_config {
      availability_zone_count = 3
    }
    zone_awareness_enabled = true
  }
  domain_endpoint_options {
    custom_endpoint_enabled = false
    enforce_https           = false
  }
  domain_name = "shared-02"
  ebs_options {
    ebs_enabled = true
    volume_size = 20
  }
  elasticsearch_version = "6.8"
  encrypt_at_rest {
    enabled = true
  }
  node_to_node_encryption {
    enabled = true
  }
  snapshot_options {
    automated_snapshot_start_hour = 6
  }
  tags = {
    DeploymentEnvironment = "production"

    Name = "shared-02"

  }
  vpc_options {
    security_group_ids = [
      "sg-09655a5d35c96b651"
    ]
    subnet_ids = [
      "subnet-04e27b7af0a76d7ee", "subnet-05203dc92b0823553", "subnet-096303542f2113a20"
    ]
  }
}

