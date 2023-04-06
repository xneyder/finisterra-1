resource "aws_route53_zone" "_hostedzone_Z01090581NU9MF363HUO" {
  comment = "Publicly facing zone"
  name    = "dev.posthog.dev"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_route53_zone" "_hostedzone_Z022506014OQVW0SW3RY1" {
  comment = "Internal zone for services in us-east-1/dev"
  name    = "us-east-1.dev.posthog.dev"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  vpc {
    vpc_id = "vpc-0468a75dd54969ff3"
  }
  vpc {
    vpc_id = "vpc-0bf9f139bb9db614e"
  }
}

resource "aws_route53_zone" "_hostedzone_Z043900936DZ9G8H9I247" {
  comment = "Internal zone for EC2 instances in us-east-1/dev"
  name    = "internal.ec2.us-east-1.dev.posthog.dev"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
  vpc {
    vpc_id = "vpc-0468a75dd54969ff3"
  }
  vpc {
    vpc_id = "vpc-0bf9f139bb9db614e"
  }
}

