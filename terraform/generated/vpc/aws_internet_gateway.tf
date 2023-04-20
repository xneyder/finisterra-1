resource "aws_internet_gateway" "igw_0606c63cc605becd7" {
  tags = {
    Name = "ThirdParty"

  }
}

resource "aws_internet_gateway" "igw_067fed3ddf94bbad0" {
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Name = "DeveloperTools"

  }
}

resource "aws_internet_gateway" "igw_0fd5d14925b7fcf92" {
  tags = {
    DeploymentEnvironment = "production"

    Name = "production"

  }
}

