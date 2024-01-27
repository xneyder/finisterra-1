locals {
  name_65f0f36807 = "aws-waf-logs-aws-managed-waf-sandbox"
}

module "aws_cloudwatch_log_group-aws-waf-logs-aws-managed-waf-sandbox" {
  source            = "github.com/finisterra-io/terraform-aws-modules.git//cloudwatch-logs/modules/log-group?ref=main"
  name              = local.name_65f0f36807
  retention_in_days = 90
  tags = {
    "Environment" : "dev",
    "Terraform" : "true"
  }
}
