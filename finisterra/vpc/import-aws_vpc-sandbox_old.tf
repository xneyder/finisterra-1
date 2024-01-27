import {
  id = "vpc-003da48d19d092877"
  to = module.aws_vpc-sandbox_old.aws_vpc.this[0]
}

import {
  id = "vpc-003da48d19d092877"
  to = module.aws_vpc-sandbox_old.aws_default_route_table.default[0]
}

import {
  id = "acl-0b211561a74993c57"
  to = module.aws_vpc-sandbox_old.aws_default_network_acl.this[0]
}

import {
  id = "sg-0efb2c2adeaee9816"
  to = module.aws_vpc-sandbox_old.aws_default_security_group.this[0]
}

import {
  id = "subnet-0ed280dcb1e0623db"
  to = module.aws_vpc-sandbox_old.aws_subnet.private["10.13.5.0/24"]
}

import {
  id = "subnet-01168d730d33011da"
  to = module.aws_vpc-sandbox_old.aws_subnet.public["10.13.1.0/24"]
}

import {
  id = "subnet-02749901d02bc051a"
  to = module.aws_vpc-sandbox_old.aws_subnet.public["10.13.2.0/24"]
}

import {
  id = "subnet-09547948e39735cf2"
  to = module.aws_vpc-sandbox_old.aws_subnet.public["10.13.3.0/24"]
}

import {
  id = "subnet-0fb80085d99d8c61e"
  to = module.aws_vpc-sandbox_old.aws_subnet.public["10.13.4.0/24"]
}

import {
  id = "igw-0e2f02b12786d0d88"
  to = module.aws_vpc-sandbox_old.aws_internet_gateway.this[0]
}

import {
  id = "vpc-003da48d19d092877"
  to = module.aws_vpc-sandbox_old.aws_vpc_dhcp_options_association.this[0]
}

import {
  id = "dopt-017e01039570bfb2d"
  to = module.aws_vpc-sandbox_old.aws_vpc_dhcp_options.this[0]
}

