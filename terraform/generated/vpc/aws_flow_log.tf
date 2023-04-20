resource "aws_flow_log" "fl_03f5b01259cf1a971" {
  iam_role_arn             = "arn:aws:iam::050779347855:role/FlowLogger"
  log_destination_type     = "cloud-watch-logs"
  max_aggregation_interval = 600
  traffic_type             = "ALL"
  vpc_id                   = "vpc-0c883d416072b2572"
}

resource "aws_flow_log" "fl_07b95a53e786f9aa1" {
  iam_role_arn             = "arn:aws:iam::050779347855:role/FlowLogger"
  log_destination_type     = "cloud-watch-logs"
  max_aggregation_interval = 600
  traffic_type             = "ALL"
  vpc_id                   = "vpc-062a9bb71430eda86"
}

resource "aws_flow_log" "fl_0b075cc86fe8fde6d" {
  destination_options {
    file_format                = "plain-text"
    hive_compatible_partitions = false
    per_hour_partition         = false
  }
  log_destination_type     = "s3"
  max_aggregation_interval = 600
  traffic_type             = "ALL"
  vpc_id                   = "vpc-0bd9acb7990b4154d"
}

