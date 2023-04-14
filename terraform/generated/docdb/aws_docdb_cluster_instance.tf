resource "aws_docdb_cluster_instance" "general_documentdb_01_instance_01" {
  auto_minor_version_upgrade = true
  cluster_identifier         = "general-documentdb-01"
  engine                     = "docdb"
  instance_class             = "db.r5.large"
  promotion_tier             = 1
  tags = {
    DeploymentEnvironment = "production"

    Name = "general-documentdb-01"

  }
}

