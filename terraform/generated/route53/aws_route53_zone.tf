resource "aws_route53_zone" "_hostedzone_Z06043291OZAVV2GGJY00" {
  comment = "Created by AWS Cloud Map namespace with ARN arn:aws-us-gov:servicediscovery:us-gov-west-1:050779347855:namespace/ns-tv5fbeasjwkzjret"
  name    = "allogy-production-original"
  vpc {
    vpc_id = "vpc-0bd9acb7990b4154d"
  }
}

resource "aws_route53_zone" "_hostedzone_Z10007291701AVIAY46A3" {
  comment = "used by the eureka discovery service"
  name    = "production"
  vpc {
    vpc_id = "vpc-0bd9acb7990b4154d"
  }
}

