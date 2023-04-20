resource "aws_nat_gateway" "nat_0955f97e2eb10272c" {
  allocation_id     = "eipalloc-0c9b5e5bd9c1d6c09"
  association_id    = "eipassoc-0cb96dd88da8fa224"
  connectivity_type = "public"
  subnet_id         = "subnet-07402e5b661b23bec"
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-nat-b"

  }
}

resource "aws_nat_gateway" "nat_0a9c5c1c49f952d26" {
  allocation_id     = "eipalloc-06f59b0695ed32e75"
  association_id    = "eipassoc-020ccae25ecb5002e"
  connectivity_type = "public"
  subnet_id         = "subnet-0680aa96bc65f072d"
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-nat-a"

  }
}

resource "aws_nat_gateway" "nat_0d8b2f0ad23aa7527" {
  allocation_id     = "eipalloc-09ccddf6c47a6ae4a"
  association_id    = "eipassoc-00ee35b4077e0cd1d"
  connectivity_type = "public"
  subnet_id         = "subnet-076f8b852c6b60060"
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-nat-c"

  }
}

