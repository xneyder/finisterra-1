resource "aws_db_option_group" "default_aurora_mysql_5_7" {
  engine_name              = "aurora-mysql"
  major_engine_version     = "5.7"
  option_group_description = "Default option group for aurora-mysql 5.7"
}

resource "aws_db_option_group" "default_docdb_4_0" {
  engine_name              = "docdb"
  major_engine_version     = "4.0"
  option_group_description = "Default option group for docdb 4.0"
}

resource "aws_db_option_group" "default_postgres_10" {
  engine_name              = "postgres"
  major_engine_version     = "10"
  option_group_description = "Default option group for postgres 10"
}

