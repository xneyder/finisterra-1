locals {
  name_ae2436a9ab = "oscilar-vpc"
}

module "aws_vpc-oscilar-vpc" {
  source                               = "github.com/finisterra-io/terraform-aws-modules.git//vpc?ref=main"
  create_igw                           = true
  name                                 = local.name_ae2436a9ab
  cidr                                 = "10.0.0.0/16"
  enable_network_address_usage_metrics = false
  tags = {
    "Name" : "${local.name_ae2436a9ab}"
  }
  manage_default_route_table = true
  manage_default_network_acl = true
  default_network_acl_egress = [
    {
      "action" : "allow",
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "icmp_code" : "0",
      "icmp_type" : "0",
      "protocol" : "-1",
      "rule_no" : 100,
      "to_port" : 0
    }
  ]
  default_network_acl_ingress = [
    {
      "action" : "allow",
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "icmp_code" : "0",
      "icmp_type" : "0",
      "protocol" : "-1",
      "rule_no" : 100,
      "to_port" : 0
    }
  ]
  manage_default_security_group = true
  default_security_group_egress = [
    {
      "cidr_blocks" : "0.0.0.0/0",
      "description" : "",
      "from_port" : 0,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "-1",
      "security_groups" : "",
      "self" : false,
      "to_port" : 0
    }
  ]
  default_security_group_ingress = [
    {
      "cidr_blocks" : "18.190.74.75/32,3.136.12.241/32,3.17.226.111/32",
      "description" : "oscilar vpn",
      "from_port" : 5439,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "tcp",
      "security_groups" : "",
      "self" : false,
      "to_port" : 5439
    },
    {
      "cidr_blocks" : "216.158.152.153/32",
      "description" : "anton IP (office)",
      "from_port" : 5439,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "tcp",
      "security_groups" : "",
      "self" : false,
      "to_port" : 5439
    },
    {
      "cidr_blocks" : "3.130.211.174/32,3.12.231.218/32,3.140.220.104/32",
      "description" : "oscilar sandbox",
      "from_port" : 5439,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "tcp",
      "security_groups" : "",
      "self" : false,
      "to_port" : 5439
    },
    {
      "cidr_blocks" : "52.25.130.38/32,34.223.203.0/28",
      "description" : "segment",
      "from_port" : 5439,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "tcp",
      "security_groups" : "",
      "self" : false,
      "to_port" : 5439
    },
    {
      "cidr_blocks" : "67.250.160.229/32",
      "description" : "delia IP (home)",
      "from_port" : 5439,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "tcp",
      "security_groups" : "",
      "self" : false,
      "to_port" : 5439
    },
    {
      "cidr_blocks" : "69.112.150.161/32",
      "description" : "anton IP (home)",
      "from_port" : 5439,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "tcp",
      "security_groups" : "",
      "self" : false,
      "to_port" : 5439
    }
  ]
  private_subnets = {
    "10.0.144.0/20" : {
      "az" : "${local.aws_region}b",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Name" : "oscilar-subnet-private2-${local.aws_region}b"
      },
      "route_tables" : [],
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "private_dns_hostname_type_on_launch" : "ip-name",
      "map_public_ip_on_launch" : false
    },
    "10.0.128.0/20" : {
      "az" : "${local.aws_region}a",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Name" : "oscilar-subnet-private1-${local.aws_region}a"
      },
      "route_tables" : [],
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "private_dns_hostname_type_on_launch" : "ip-name",
      "map_public_ip_on_launch" : false
    },
    "10.0.160.0/20" : {
      "az" : "${local.aws_region}c",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Name" : "oscilar-subnet-private3-${local.aws_region}c"
      },
      "route_tables" : [],
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "private_dns_hostname_type_on_launch" : "ip-name",
      "map_public_ip_on_launch" : false
    }
  }
  private_route_tables = {
    "rtb-08ad5f34b14652cb3" : {
      "associations" : {
        "10.0.144.0/20" : true
      },
      "tags" : {
        "Name" : "oscilar-rtb-private2-${local.aws_region}b"
      }
    },
    "rtb-0c13c006a40c63c07" : {
      "associations" : {
        "10.0.128.0/20" : true
      },
      "tags" : {
        "Name" : "oscilar-rtb-private1-${local.aws_region}a"
      }
    },
    "rtb-0c2babcfc0f3cba76" : {
      "associations" : {
        "10.0.160.0/20" : true
      },
      "tags" : {
        "Name" : "oscilar-rtb-private3-${local.aws_region}c"
      }
    }
  }
  public_subnets = {
    "10.0.32.0/20" : {
      "az" : "${local.aws_region}c",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Name" : "oscilar-subnet-public3-${local.aws_region}c"
      },
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "map_public_ip_on_launch" : false,
      "private_dns_hostname_type_on_launch" : "ip-name"
    },
    "10.0.16.0/20" : {
      "az" : "${local.aws_region}b",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Name" : "oscilar-subnet-public2-${local.aws_region}b"
      },
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "map_public_ip_on_launch" : false,
      "private_dns_hostname_type_on_launch" : "ip-name"
    },
    "10.0.0.0/20" : {
      "az" : "${local.aws_region}a",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Name" : "oscilar-subnet-public1-${local.aws_region}a"
      },
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "map_public_ip_on_launch" : false,
      "private_dns_hostname_type_on_launch" : "ip-name"
    }
  }
  public_subnet_enable_dns64                                   = false
  public_subnet_enable_resource_name_dns_aaaa_record_on_launch = false
  map_public_ip_on_launch                                      = false
  public_subnet_private_dns_hostname_type_on_launch            = "ip-name"
  public_route_tables = {
    "rtb-0528751a33c3dde0a" : {
      "associations" : {
        "10.0.32.0/20" : true,
        "10.0.16.0/20" : true,
        "10.0.0.0/20" : true
      },
      "tags" : {
        "Name" : "oscilar-rtb-public"
      },
      "routes" : {
        "rtb_0528751a33c3dde0a-0.0.0.0-0" : {
          "destination_cidr_block" : "0.0.0.0/0",
          "igw" : true
        }
      }
    }
  }
  igw_tags = {
    "Name" : "oscilar-igw"
  }
  enable_dhcp_options_association = true
  dhcp_options_id                 = "dopt-017e01039570bfb2d"
  dhcp_options_domain_name        = "ec2.internal"
  dhcp_options_domain_name_servers = [
    "AmazonProvidedDNS"
  ]
}
