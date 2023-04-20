resource "aws_network_acl" "acl_02870bd3064cb0e80" {
  tags = {
    Name = "ThirdParty-PublicAcl"

  }
  vpc_id = "vpc-062a9bb71430eda86"
}

resource "aws_network_acl" "acl_066a348fb81dcaef3" {
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-PrivateAcl"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_network_acl" "acl_0a8f17f3dfe0678ad" {
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-PublicAcl"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_network_acl" "acl_0c0b56b0d5d4ea4ac" {
  tags = {
    Name = "DeveloperTools-PublicAcl"

  }
  vpc_id = "vpc-0c883d416072b2572"
}

