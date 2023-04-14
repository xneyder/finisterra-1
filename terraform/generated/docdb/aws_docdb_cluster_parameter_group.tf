resource "aws_docdb_cluster_parameter_group" "default_aurora_mysql5_7" {
  description = "Default cluster parameter group for aurora-mysql5.7"
  family      = "aurora-mysql5.7"
}

resource "aws_docdb_cluster_parameter_group" "default_docdb4_0" {
  description = "Default cluster parameter group for docdb4.0"
  family      = "docdb4.0"
}

