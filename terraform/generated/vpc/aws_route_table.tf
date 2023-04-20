resource "aws_route_table" "rtb_01b841faa1acf44ab" {
  tags = {
    DeploymentEnvironment = "production"

    Description = "Provides routes for private subnet a in the !Sub ${DeploymentEnvironment} VPC."

    Name = "production-private-a"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_route_table" "rtb_02056949513302f39" {
  tags = {
    DeploymentEnvironment = "production"

    Description = "Provides routes for public subnets in the !Sub ${DeploymentEnvironment} VPC."

    Name = "production-public"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_route_table" "rtb_03ebd081b9afeb921" {
  vpc_id = "vpc-0c883d416072b2572"
}

resource "aws_route_table" "rtb_0650b3e5bc7cf549f" {
  vpc_id = "vpc-062a9bb71430eda86"
}

resource "aws_route_table" "rtb_0b69ef69e0995469a" {
  tags = {
    Description = "Provides routes for public subnets in the ThirdParty VPC."

    Name = "ThirdParty-public"

  }
  vpc_id = "vpc-062a9bb71430eda86"
}

resource "aws_route_table" "rtb_0c3d02600a29b9644" {
  tags = {
    DeploymentEnvironment = "production"

    Description = "Provides routes for private subnet b in the !Sub ${DeploymentEnvironment} VPC."

    Name = "production-private-b"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_route_table" "rtb_0e001cff6079c7c1e" {
  tags = {
    DeploymentEnvironment = "production"

    Description = "Provides routes for private subnet c in the !Sub ${DeploymentEnvironment} VPC."

    Name = "production-private-c"

  }
  vpc_id = "vpc-0bd9acb7990b4154d"
}

resource "aws_route_table" "rtb_0f8e708d7686aeffe" {
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Description = "Provides routes for public subnets in the DeveloperTools VPC."

    Name = "DeveloperTools-public"

  }
  vpc_id = "vpc-0c883d416072b2572"
}

resource "aws_route_table" "rtb_0ffdd5c1eeea40e3b" {
  vpc_id = "vpc-0bd9acb7990b4154d"
}

