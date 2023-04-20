resource "aws_launch_template" "lt_048012777ea865559" {
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = "true"
      encrypted             = "true"
      kms_key_id            = "arn:aws-us-gov:kms:us-gov-west-1:050779347855:key/77a11a54-ca9b-43cf-8653-4020ca89cd10"
    }
  }
  block_device_mappings {
    device_name = "/dev/sdb"
    ebs {
      delete_on_termination = "false"
      encrypted             = "true"
      kms_key_id            = "arn:aws-us-gov:kms:us-gov-west-1:050779347855:key/77a11a54-ca9b-43cf-8653-4020ca89cd10"
    }
  }
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  credit_specification {
    cpu_credits = "standard"
  }
  disable_api_stop        = false
  disable_api_termination = false
  ebs_optimized           = "false"
  hibernation_options {
    configured = false
  }
  image_id                             = "ami-09f96565880b69e5f"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.medium"
  key_name                             = "AARONTEST"
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    instance_metadata_tags = "disabled"
  }
  monitoring {
    enabled = false
  }
  network_interfaces {
    device_index       = 0
    ipv4_address_count = 0
    ipv4_prefix_count  = 0
    ipv6_address_count = 0
    ipv6_prefix_count  = 0
    network_card_index = 0
    security_groups = [
      "sg-0b0eed2b18edcbfaa"
    ]
  }
  placement {
    partition_number = 0
    tenancy          = "default"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "dbimport062822"

    }
  }
}

