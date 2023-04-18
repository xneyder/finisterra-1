resource "aws_ssm_association" "b83728e2_db52_470e_b5ca_f79ac6b0eaba" {
  apply_only_at_cron_interval = false
  name                        = "AWS-GatherSoftwareInventory"
  schedule_expression         = "rate(30 minutes)"
  targets {
    key = "InstanceIds"
    values = [
      "*"
    ]
  }
}

