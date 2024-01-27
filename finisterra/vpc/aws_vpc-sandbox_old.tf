locals {
  name_be7b2e5455 = "sandbox_old"
}

module "aws_vpc-sandbox_old" {
  source                               = "github.com/finisterra-io/terraform-aws-modules.git//vpc?ref=main"
  create_igw                           = true
  name                                 = local.name_be7b2e5455
  cidr                                 = "10.13.0.0/16"
  enable_network_address_usage_metrics = false
  tags = {
    "Name" : "${local.name_be7b2e5455}"
  }
  manage_default_route_table = true
  default_route_table_routes = [
    {
      "cidr_block" : "0.0.0.0/0",
      "gateway_id" : "igw-0e2f02b12786d0d88"
    }
  ]
  default_route_table_tags = {
    "Name" : "sandbox-public"
  }
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
    },
    {
      "action" : "allow",
      "cidr_block" : "68.175.116.233/32",
      "from_port" : 55439,
      "icmp_code" : "0",
      "icmp_type" : "0",
      "protocol" : "6",
      "rule_no" : 97,
      "to_port" : 55439
    },
    {
      "action" : "allow",
      "cidr_block" : "75.4.189.238/32",
      "from_port" : 55439,
      "icmp_code" : "0",
      "icmp_type" : "0",
      "protocol" : "6",
      "rule_no" : 98,
      "to_port" : 55439
    },
    {
      "action" : "deny",
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 55439,
      "icmp_code" : "0",
      "icmp_type" : "0",
      "protocol" : "6",
      "rule_no" : 99,
      "to_port" : 55439
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
      "cidr_blocks" : "0.0.0.0/0",
      "description" : "inbound postgresql from open internet",
      "from_port" : 5432,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "tcp",
      "security_groups" : "",
      "self" : false,
      "to_port" : 5432
    },
    {
      "cidr_blocks" : "",
      "description" : "",
      "from_port" : 0,
      "ipv6_cidr_blocks" : "",
      "prefix_list_ids" : "",
      "protocol" : "-1",
      "security_groups" : "",
      "self" : true,
      "to_port" : 0
    }
  ]
  private_subnets = {
    "10.13.5.0/24" : {
      "az" : "${local.aws_region}d",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Name" : "sandbox-public-access-test"
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
  public_subnets = {
    "10.13.1.0/24" : {
      "az" : "${local.aws_region}a",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "sandbox",
        "Name" : "sandbox-public-${local.aws_region}a"
      },
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "map_public_ip_on_launch" : false,
      "private_dns_hostname_type_on_launch" : "ip-name"
    },
    "10.13.2.0/24" : {
      "az" : "${local.aws_region}b",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "sandbox",
        "Name" : "sandbox-public-${local.aws_region}b"
      },
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "map_public_ip_on_launch" : false,
      "private_dns_hostname_type_on_launch" : "ip-name"
    },
    "10.13.3.0/24" : {
      "az" : "${local.aws_region}c",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "sandbox",
        "Name" : "sandbox-public-${local.aws_region}c"
      },
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "map_public_ip_on_launch" : false,
      "private_dns_hostname_type_on_launch" : "ip-name"
    },
    "10.13.4.0/24" : {
      "az" : "${local.aws_region}d",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "sandbox",
        "Name" : "sandbox-public-${local.aws_region}d"
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
  igw_tags = {
    "Environment" : "sandbox",
    "Name" : "sandbox"
  }
  enable_dhcp_options_association = true
  dhcp_options_id                 = "dopt-017e01039570bfb2d"
  create_dhcp_options             = true
  dhcp_options_domain_name        = "ec2.internal"
  dhcp_options_domain_name_servers = [
    "AmazonProvidedDNS"
  ]
}
