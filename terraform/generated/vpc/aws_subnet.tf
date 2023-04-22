resource "aws_subnet" "subnet_00624cc56bc520484" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "172.16.128.128/26"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    Name = "ThirdParty-public-c"

  }
  vpc_id = "vpc-062a9bb71430eda86"
}

resource "aws_subnet" "subnet_04e27b7af0a76d7ee" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.21.0.0/19"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-private-a"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_subnet" "subnet_05203dc92b0823553" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.21.32.0/19"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-private-b"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_subnet" "subnet_05abe9522c20e70aa" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "172.16.0.0/26"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Name = "DeveloperTools-public-b"

  }
  vpc_id = "vpc-0c883d416072b2572"
}

resource "aws_subnet" "subnet_0680aa96bc65f072d" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.21.128.0/20"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-public-a"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_subnet" "subnet_07402e5b661b23bec" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.21.144.0/20"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-public-b"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_subnet" "subnet_076f8b852c6b60060" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.21.160.0/20"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-public-c"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_subnet" "subnet_08f964badcff95e70" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "172.16.128.0/26"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    Name = "ThirdParty-public-a"

  }
  vpc_id = "vpc-062a9bb71430eda86"
}

resource "aws_subnet" "subnet_096303542f2113a20" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.21.64.0/19"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-private-c"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_subnet" "subnet_0a92863259a3cd002" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "172.16.128.64/26"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    Name = "ThirdParty-public-b"

  }
  vpc_id = "vpc-062a9bb71430eda86"
}

resource "aws_subnet" "subnet_0d9fc337565eaccd1" {
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "172.16.0.64/26"
  enable_dns64                                   = false
  enable_lni_at_device_index                     = 0
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Name = "DeveloperTools-public-c"

  }
  vpc_id = "vpc-0c883d416072b2572"
}

