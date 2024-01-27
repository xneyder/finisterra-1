locals {
  name_b7ad567477 = "sandbox"
}

module "aws_vpc-sandbox" {
  source                               = "github.com/finisterra-io/terraform-aws-modules.git//vpc?ref=main"
  create_igw                           = true
  name                                 = local.name_b7ad567477
  cidr                                 = "10.16.0.0/16"
  enable_network_address_usage_metrics = false
  tags = {
    "Environment" : "${local.name_b7ad567477}",
    "Name" : "${local.name_b7ad567477}",
    "Terraform" : "true"
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
    "10.16.14.0/23" : {
      "az" : "${local.aws_region}c",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-private-${local.aws_region}c",
        "Terraform" : "true",
        "Type" : "private"
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
    "10.16.10.0/23" : {
      "az" : "${local.aws_region}a",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-private-${local.aws_region}a",
        "Terraform" : "true",
        "Type" : "private"
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
    "10.16.12.0/23" : {
      "az" : "${local.aws_region}b",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-private-${local.aws_region}b",
        "Terraform" : "true",
        "Type" : "private"
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
    "rtb-07afea4a3875305bf" : {
      "associations" : {
        "10.16.14.0/23" : true,
        "10.16.10.0/23" : true,
        "10.16.12.0/23" : true
      },
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-private",
        "Terraform" : "true"
      },
      "routes" : {
        "rtb_07afea4a3875305bf-0.0.0.0-0" : {
          "destination_cidr_block" : "0.0.0.0/0",
          "nat_gateway_name" : "${local.name_b7ad567477}-${local.aws_region}a"
        }
      }
    }
  }
  public_subnets = {
    "10.16.1.0/24" : {
      "az" : "${local.aws_region}a",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-public-${local.aws_region}a",
        "Terraform" : "true",
        "Type" : "public"
      },
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "map_public_ip_on_launch" : false,
      "private_dns_hostname_type_on_launch" : "ip-name"
    },
    "10.16.3.0/24" : {
      "az" : "${local.aws_region}c",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-public-${local.aws_region}c",
        "Terraform" : "true",
        "Type" : "public"
      },
      "assign_ipv6_address_on_creation" : false,
      "enable_dns64" : false,
      "enable_resource_name_dns_aaaa_record_on_launch" : false,
      "enable_resource_name_dns_a_record_on_launch" : false,
      "ipv6_native" : false,
      "map_public_ip_on_launch" : false,
      "private_dns_hostname_type_on_launch" : "ip-name"
    },
    "10.16.2.0/24" : {
      "az" : "${local.aws_region}b",
      "ipv6_cidr_block" : "",
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-public-${local.aws_region}b",
        "Terraform" : "true",
        "Type" : "public"
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
    "rtb-05b4edda8573de6ce" : {
      "associations" : {
        "10.16.1.0/24" : true,
        "10.16.3.0/24" : true,
        "10.16.2.0/24" : true
      },
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-public",
        "Terraform" : "true"
      },
      "routes" : {
        "rtb_05b4edda8573de6ce-0.0.0.0-0" : {
          "destination_cidr_block" : "0.0.0.0/0",
          "igw" : true
        }
      }
    }
  }
  nat_gateways = {
    "${local.name_b7ad567477}-${local.aws_region}a" : {
      "subnet_cidr" : "10.16.1.0/24",
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477}-${local.aws_region}a",
        "Terraform" : "true"
      },
      "eip_tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Name" : "${local.name_b7ad567477} NAT Gateway EIP 0",
        "Terraform" : "true"
      }
    }
  }
  igw_tags = {
    "Environment" : "${local.name_b7ad567477}",
    "Name" : "${local.name_b7ad567477}",
    "Terraform" : "true"
  }
  aws_flow_logs = {
    "s3" : {
      "log_destination" : module.aws_s3_bucket-coast-sandbox-us-east-1-070252509141-log-bucket_3688b8cadf.arn,
      "log_destination_type" : "s3",
      "log_format" : "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status}",
      "iam_role_arn" : "",
      "traffic_type" : "ALL",
      "max_aggregation_interval" : 600,
      "destination_options" : [
        {
          "file_format" : "plain-text",
          "hive_compatible_partitions" : false,
          "per_hour_partition" : false
        }
      ],
      "log_group_name" : "",
      "tags" : {
        "Environment" : "${local.name_b7ad567477}",
        "Terraform" : "true"
      }
    }
  }
  enable_dhcp_options_association = true
  dhcp_options_id                 = "dopt-017e01039570bfb2d"
  dhcp_options_domain_name        = "ec2.internal"
  dhcp_options_domain_name_servers = [
    "AmazonProvidedDNS"
  ]
}
