resource "aws_vpc" "vpc_062a9bb71430eda86" {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = "172.16.128.0/24"
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    Name = "ThirdParty"

  }
}

resource "aws_vpc" "vpc_0bd9acb7990b4154d" {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = "10.21.0.0/16"
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    DeploymentEnvironment = "production"

    Name = "production"

  }
}

resource "aws_vpc" "vpc_0c883d416072b2572" {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = "172.16.0.0/24"
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Name = "DeveloperTools"

  }
}

