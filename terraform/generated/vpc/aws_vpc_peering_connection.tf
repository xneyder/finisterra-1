resource "aws_vpc_peering_connection" "pcx_0e687a961b2e51509" {
  peer_vpc_id = "vpc-039a5e5dc91372d60"
  requester {
    allow_classic_link_to_remote_vpc = false
    allow_remote_vpc_dns_resolution  = false
    allow_vpc_to_remote_classic_link = false
  }
  tags = {
    Name = "integration-DeveloperTools"

  }
  vpc_id = "vpc-0c883d416072b2572"
}

