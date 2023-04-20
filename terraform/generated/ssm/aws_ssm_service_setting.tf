resource "aws_ssm_service_setting" "_ssm_parameter_store_default_parameter_tier" {
  setting_id    = "arn:aws-us-gov:ssm:us-gov-west-1:050779347855:servicesetting/ssm/parameter-store/default-parameter-tier"
  setting_value = "Standard"
}

resource "aws_ssm_service_setting" "_ssm_parameter_store_high_throughput_enabled" {
  setting_id    = "arn:aws-us-gov:ssm:us-gov-west-1:050779347855:servicesetting/ssm/parameter-store/high-throughput-enabled"
  setting_value = "false"
}

