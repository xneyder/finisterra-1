import {
  id = "vpc-0868909cf17491187"
  to = module.aws_vpc-sandbox.aws_vpc.this[0]
}

import {
  id = "vpc-0868909cf17491187"
  to = module.aws_vpc-sandbox.aws_default_route_table.default[0]
}

import {
  id = "acl-011e5b259ac2ff3f9"
  to = module.aws_vpc-sandbox.aws_default_network_acl.this[0]
}

import {
  id = "sg-057a151e62b88da75"
  to = module.aws_vpc-sandbox.aws_default_security_group.this[0]
}

import {
  id = "subnet-042f2cf6a24a0b2ed"
  to = module.aws_vpc-sandbox.aws_subnet.private["10.16.14.0/23"]
}

import {
  id = "subnet-042f2cf6a24a0b2ed/rtb-07afea4a3875305bf"
  to = module.aws_vpc-sandbox.aws_route_table_association.private["10.16.14.0/23-rtb-07afea4a3875305bf"]
}

import {
  id = "rtb-07afea4a3875305bf"
  to = module.aws_vpc-sandbox.aws_route_table.private["rtb-07afea4a3875305bf"]
}

import {
  id = "rtb-07afea4a3875305bf_0.0.0.0/0"
  to = module.aws_vpc-sandbox.aws_route.private["rtb_07afea4a3875305bf-0.0.0.0-0"]
}

import {
  id = "subnet-045543fe0da5f0682"
  to = module.aws_vpc-sandbox.aws_subnet.private["10.16.10.0/23"]
}

import {
  id = "subnet-045543fe0da5f0682/rtb-07afea4a3875305bf"
  to = module.aws_vpc-sandbox.aws_route_table_association.private["10.16.10.0/23-rtb-07afea4a3875305bf"]
}

import {
  id = "subnet-0dfaf37ddc2bd9135"
  to = module.aws_vpc-sandbox.aws_subnet.private["10.16.12.0/23"]
}

import {
  id = "subnet-0dfaf37ddc2bd9135/rtb-07afea4a3875305bf"
  to = module.aws_vpc-sandbox.aws_route_table_association.private["10.16.12.0/23-rtb-07afea4a3875305bf"]
}

import {
  id = "subnet-01f02a965cf0f4923"
  to = module.aws_vpc-sandbox.aws_subnet.public["10.16.1.0/24"]
}

import {
  id = "subnet-01f02a965cf0f4923/rtb-05b4edda8573de6ce"
  to = module.aws_vpc-sandbox.aws_route_table_association.public["10.16.1.0/24-rtb-05b4edda8573de6ce"]
}

import {
  id = "rtb-05b4edda8573de6ce"
  to = module.aws_vpc-sandbox.aws_route_table.public["rtb-05b4edda8573de6ce"]
}

import {
  id = "rtb-05b4edda8573de6ce_0.0.0.0/0"
  to = module.aws_vpc-sandbox.aws_route.public["rtb_05b4edda8573de6ce-0.0.0.0-0"]
}

import {
  id = "nat-0841156feb4fa5884"
  to = module.aws_vpc-sandbox.aws_nat_gateway.this["sandbox-us-east-1a"]
}

import {
  id = "eipalloc-0be65474010d8c724"
  to = module.aws_vpc-sandbox.aws_eip.nat["sandbox-us-east-1a"]
}

import {
  id = "subnet-05d809faa0e0d852b"
  to = module.aws_vpc-sandbox.aws_subnet.public["10.16.3.0/24"]
}

import {
  id = "subnet-05d809faa0e0d852b/rtb-05b4edda8573de6ce"
  to = module.aws_vpc-sandbox.aws_route_table_association.public["10.16.3.0/24-rtb-05b4edda8573de6ce"]
}

import {
  id = "subnet-0cb698290a250953d"
  to = module.aws_vpc-sandbox.aws_subnet.public["10.16.2.0/24"]
}

import {
  id = "subnet-0cb698290a250953d/rtb-05b4edda8573de6ce"
  to = module.aws_vpc-sandbox.aws_route_table_association.public["10.16.2.0/24-rtb-05b4edda8573de6ce"]
}

import {
  id = "igw-0874fe73c015f4bb6"
  to = module.aws_vpc-sandbox.aws_internet_gateway.this[0]
}

import {
  id = "fl-0fea1cb4774b28a92"
  to = module.aws_vpc-sandbox.aws_flow_log.this["s3"]
}

import {
  id = "vpc-0868909cf17491187"
  to = module.aws_vpc-sandbox.aws_vpc_dhcp_options_association.this[0]
}

