import {
  id = "vpc-0897ca670bc464bcb"
  to = module.aws_vpc-oscilar-vpc.aws_vpc.this[0]
}

import {
  id = "vpc-0897ca670bc464bcb"
  to = module.aws_vpc-oscilar-vpc.aws_default_route_table.default[0]
}

import {
  id = "acl-0b8a765bf3fa058a6"
  to = module.aws_vpc-oscilar-vpc.aws_default_network_acl.this[0]
}

import {
  id = "sg-0bf019396a0e49e66"
  to = module.aws_vpc-oscilar-vpc.aws_default_security_group.this[0]
}

import {
  id = "subnet-01135eb4f1527650b"
  to = module.aws_vpc-oscilar-vpc.aws_subnet.private["10.0.144.0/20"]
}

import {
  id = "subnet-01135eb4f1527650b/rtb-08ad5f34b14652cb3"
  to = module.aws_vpc-oscilar-vpc.aws_route_table_association.private["10.0.144.0/20-rtb-08ad5f34b14652cb3"]
}

import {
  id = "rtb-08ad5f34b14652cb3"
  to = module.aws_vpc-oscilar-vpc.aws_route_table.private["rtb-08ad5f34b14652cb3"]
}

import {
  id = "subnet-0584c179f643c1098"
  to = module.aws_vpc-oscilar-vpc.aws_subnet.private["10.0.128.0/20"]
}

import {
  id = "subnet-0584c179f643c1098/rtb-0c13c006a40c63c07"
  to = module.aws_vpc-oscilar-vpc.aws_route_table_association.private["10.0.128.0/20-rtb-0c13c006a40c63c07"]
}

import {
  id = "rtb-0c13c006a40c63c07"
  to = module.aws_vpc-oscilar-vpc.aws_route_table.private["rtb-0c13c006a40c63c07"]
}

import {
  id = "subnet-0d5ea5b3b3a3482ed"
  to = module.aws_vpc-oscilar-vpc.aws_subnet.private["10.0.160.0/20"]
}

import {
  id = "subnet-0d5ea5b3b3a3482ed/rtb-0c2babcfc0f3cba76"
  to = module.aws_vpc-oscilar-vpc.aws_route_table_association.private["10.0.160.0/20-rtb-0c2babcfc0f3cba76"]
}

import {
  id = "rtb-0c2babcfc0f3cba76"
  to = module.aws_vpc-oscilar-vpc.aws_route_table.private["rtb-0c2babcfc0f3cba76"]
}

import {
  id = "subnet-002c87bc3c476ab05"
  to = module.aws_vpc-oscilar-vpc.aws_subnet.public["10.0.32.0/20"]
}

import {
  id = "subnet-002c87bc3c476ab05/rtb-0528751a33c3dde0a"
  to = module.aws_vpc-oscilar-vpc.aws_route_table_association.public["10.0.32.0/20-rtb-0528751a33c3dde0a"]
}

import {
  id = "rtb-0528751a33c3dde0a"
  to = module.aws_vpc-oscilar-vpc.aws_route_table.public["rtb-0528751a33c3dde0a"]
}

import {
  id = "rtb-0528751a33c3dde0a_0.0.0.0/0"
  to = module.aws_vpc-oscilar-vpc.aws_route.public["rtb_0528751a33c3dde0a-0.0.0.0-0"]
}

import {
  id = "subnet-088ffe12a4c9a2b0d"
  to = module.aws_vpc-oscilar-vpc.aws_subnet.public["10.0.16.0/20"]
}

import {
  id = "subnet-088ffe12a4c9a2b0d/rtb-0528751a33c3dde0a"
  to = module.aws_vpc-oscilar-vpc.aws_route_table_association.public["10.0.16.0/20-rtb-0528751a33c3dde0a"]
}

import {
  id = "subnet-0b21977a952f63deb"
  to = module.aws_vpc-oscilar-vpc.aws_subnet.public["10.0.0.0/20"]
}

import {
  id = "subnet-0b21977a952f63deb/rtb-0528751a33c3dde0a"
  to = module.aws_vpc-oscilar-vpc.aws_route_table_association.public["10.0.0.0/20-rtb-0528751a33c3dde0a"]
}

import {
  id = "igw-08053cea7eb268fa3"
  to = module.aws_vpc-oscilar-vpc.aws_internet_gateway.this[0]
}

import {
  id = "vpc-0897ca670bc464bcb"
  to = module.aws_vpc-oscilar-vpc.aws_vpc_dhcp_options_association.this[0]
}

