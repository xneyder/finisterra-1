resource "aws_elasticache_subnet_group" "developer_tools" {
  description = "ElastiCache subnet group for the DeveloperTools VPC"
  name        = "developer-tools"
  subnet_ids = [
    "subnet-05abe9522c20e70aa", "subnet-0d9fc337565eaccd1"
  ]
}

resource "aws_elasticache_subnet_group" "production_private" {
  description = "Subnet group using any private subnet addresses."
  name        = "production-private"
  subnet_ids = [
    "subnet-04e27b7af0a76d7ee", "subnet-05203dc92b0823553", "subnet-096303542f2113a20"
  ]
}

