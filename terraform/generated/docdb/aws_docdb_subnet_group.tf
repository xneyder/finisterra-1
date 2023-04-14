resource "aws_docdb_subnet_group" "production_postgresql" {
  description = "Subnet group using the private subnet addresses."
  subnet_ids = [
    "subnet-04e27b7af0a76d7ee", "subnet-05203dc92b0823553", "subnet-096303542f2113a20"
  ]
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-postgresql"

  }
}

resource "aws_docdb_subnet_group" "production_private" {
  description = "Places a DocumentDB cluser in our private subnets."
  subnet_ids = [
    "subnet-04e27b7af0a76d7ee", "subnet-05203dc92b0823553", "subnet-096303542f2113a20"
  ]
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-private"

  }
}

