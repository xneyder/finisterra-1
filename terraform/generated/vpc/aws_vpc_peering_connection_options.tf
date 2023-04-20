resource "aws_vpc_peering_connection_options" "pcx_0e687a961b2e51509" {
  requester {
    allow_classic_link_to_remote_vpc = false
    allow_remote_vpc_dns_resolution  = false
    allow_vpc_to_remote_classic_link = false
  }
  vpc_peering_connection_id = "pcx-0e687a961b2e51509"
}

