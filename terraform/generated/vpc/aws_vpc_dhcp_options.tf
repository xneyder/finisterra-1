resource "aws_vpc_dhcp_options" "dopt_029bb7c8f84474030" {
  domain_name = "us-gov-west-1.compute.internal"
  domain_name_servers = [
    "AmazonProvidedDNS"
  ]
}

