resource "aws_db_parameter_group" "default_aurora_mysql5_7" {
  description = "Default parameter group for aurora-mysql5.7"
  family      = "aurora-mysql5.7"
}

resource "aws_db_parameter_group" "default_docdb4_0" {
  description = "Default parameter group for docdb4.0"
  family      = "docdb4.0"
}

resource "aws_db_parameter_group" "default_postgres10" {
  description = "Default parameter group for postgres10"
  family      = "postgres10"
}

