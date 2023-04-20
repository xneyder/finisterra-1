resource "aws_route" "rtb_01b841faa1acf44ab_0_0_0_0_0" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "nat-0a9c5c1c49f952d26"
  route_table_id         = "rtb-01b841faa1acf44ab"
}

resource "aws_route" "rtb_01b841faa1acf44ab_10_21_0_0_16" {
  destination_cidr_block = "10.21.0.0/16"
  gateway_id             = "local"
  route_table_id         = "rtb-01b841faa1acf44ab"
}

resource "aws_route" "rtb_02056949513302f39_0_0_0_0_0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-0fd5d14925b7fcf92"
  route_table_id         = "rtb-02056949513302f39"
}

resource "aws_route" "rtb_02056949513302f39_10_21_0_0_16" {
  destination_cidr_block = "10.21.0.0/16"
  gateway_id             = "local"
  route_table_id         = "rtb-02056949513302f39"
}

resource "aws_route" "rtb_03ebd081b9afeb921_172_16_0_0_24" {
  destination_cidr_block = "172.16.0.0/24"
  gateway_id             = "local"
  route_table_id         = "rtb-03ebd081b9afeb921"
}

resource "aws_route" "rtb_0650b3e5bc7cf549f_172_16_128_0_24" {
  destination_cidr_block = "172.16.128.0/24"
  gateway_id             = "local"
  route_table_id         = "rtb-0650b3e5bc7cf549f"
}

resource "aws_route" "rtb_0b69ef69e0995469a_0_0_0_0_0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-0606c63cc605becd7"
  route_table_id         = "rtb-0b69ef69e0995469a"
}

resource "aws_route" "rtb_0b69ef69e0995469a_172_16_128_0_24" {
  destination_cidr_block = "172.16.128.0/24"
  gateway_id             = "local"
  route_table_id         = "rtb-0b69ef69e0995469a"
}

resource "aws_route" "rtb_0c3d02600a29b9644_0_0_0_0_0" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "nat-0955f97e2eb10272c"
  route_table_id         = "rtb-0c3d02600a29b9644"
}

resource "aws_route" "rtb_0c3d02600a29b9644_10_21_0_0_16" {
  destination_cidr_block = "10.21.0.0/16"
  gateway_id             = "local"
  route_table_id         = "rtb-0c3d02600a29b9644"
}

resource "aws_route" "rtb_0e001cff6079c7c1e_0_0_0_0_0" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "nat-0d8b2f0ad23aa7527"
  route_table_id         = "rtb-0e001cff6079c7c1e"
}

resource "aws_route" "rtb_0e001cff6079c7c1e_10_21_0_0_16" {
  destination_cidr_block = "10.21.0.0/16"
  gateway_id             = "local"
  route_table_id         = "rtb-0e001cff6079c7c1e"
}

resource "aws_route" "rtb_0f8e708d7686aeffe_0_0_0_0_0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-067fed3ddf94bbad0"
  route_table_id         = "rtb-0f8e708d7686aeffe"
}

resource "aws_route" "rtb_0f8e708d7686aeffe_172_16_0_0_24" {
  destination_cidr_block = "172.16.0.0/24"
  gateway_id             = "local"
  route_table_id         = "rtb-0f8e708d7686aeffe"
}

resource "aws_route" "rtb_0f8e708d7686aeffe_172_16_1_0_24" {
  destination_cidr_block    = "172.16.1.0/24"
  route_table_id            = "rtb-0f8e708d7686aeffe"
  vpc_peering_connection_id = "pcx-0e687a961b2e51509"
}

resource "aws_route" "rtb_0ffdd5c1eeea40e3b_10_21_0_0_16" {
  destination_cidr_block = "10.21.0.0/16"
  gateway_id             = "local"
  route_table_id         = "rtb-0ffdd5c1eeea40e3b"
}

