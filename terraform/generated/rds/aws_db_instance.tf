resource "aws_db_instance" "allogy_core_postgresql" {
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot      = true
  customer_owned_ip_enabled  = false
  deletion_protection        = true
  enabled_cloudwatch_logs_exports = [
    "postgresql", "upgrade"
  ]
  iam_database_authentication_enabled = false
  instance_class                      = "db.m3.large"
  max_allocated_storage               = 0
  monitoring_interval                 = 60
  performance_insights_enabled        = false
  publicly_accessible                 = false
  storage_encrypted                   = true
}

resource "aws_db_instance" "allogy_default_postgresql_01" {
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot      = true
  customer_owned_ip_enabled  = false
  deletion_protection        = true
  enabled_cloudwatch_logs_exports = [
    "postgresql", "upgrade"
  ]
  iam_database_authentication_enabled = false
  instance_class                      = "db.t2.medium"
  max_allocated_storage               = 1000
  monitoring_interval                 = 60
  performance_insights_enabled        = false
  publicly_accessible                 = false
  storage_encrypted                   = true
}

resource "aws_db_instance" "allogy_secure_postgresql_01" {
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot      = true
  customer_owned_ip_enabled  = false
  deletion_protection        = true
  enabled_cloudwatch_logs_exports = [
    "postgresql", "upgrade"
  ]
  iam_database_authentication_enabled = false
  instance_class                      = "db.t3.medium"
  max_allocated_storage               = 1000
  monitoring_interval                 = 60
  performance_insights_enabled        = false
  publicly_accessible                 = false
  storage_encrypted                   = true
}

