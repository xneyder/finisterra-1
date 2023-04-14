resource "aws_docdb_cluster" "general_documentdb_01" {
  backup_retention_period = 21
  deletion_protection     = false
  engine                  = "docdb"
  port                    = 27017
  storage_encrypted       = true
  tags = {
    DeploymentEnvironment = "production"

    Name = "general-documentdb-01"

  }
}

