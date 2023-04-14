resource "aws_route53_record" "_hostedzone_Z06043291OZAVV2GGJY00_allogy_production_original_NS" {
  name = "allogy-production-original"
  records = [
    "ns-0.awsdns-us-gov-00.com.", "ns-1024.awsdns-us-gov-00.org.", "ns-1536.awsdns-us-gov-00.us.", "ns-512.awsdns-us-gov-00.net."
  ]
  ttl     = 172800
  type    = "NS"
  zone_id = "/hostedzone/Z06043291OZAVV2GGJY00"
}

resource "aws_route53_record" "_hostedzone_Z06043291OZAVV2GGJY00_allogy_production_original_SOA" {
  name = "allogy-production-original"
  records = [
    "ns-0.awsdns-us-gov-00.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
  ttl     = 15
  type    = "SOA"
  zone_id = "/hostedzone/Z06043291OZAVV2GGJY00"
}

resource "aws_route53_record" "_hostedzone_Z10007291701AVIAY46A3_discovery_internal_zone_us_gov_west_1a_production_A" {
  name = "discovery-internal-zone-us-gov-west-1a.production"
  records = [
    "10.21.26.171"
  ]
  ttl     = 120
  type    = "A"
  zone_id = "/hostedzone/Z10007291701AVIAY46A3"
}

resource "aws_route53_record" "_hostedzone_Z10007291701AVIAY46A3_discovery_internal_zone_us_gov_west_1b_production_A" {
  name = "discovery-internal-zone-us-gov-west-1b.production"
  records = [
    "10.21.34.210"
  ]
  ttl     = 120
  type    = "A"
  zone_id = "/hostedzone/Z10007291701AVIAY46A3"
}

resource "aws_route53_record" "_hostedzone_Z10007291701AVIAY46A3_discovery_internal_zone_us_gov_west_1c_production_A" {
  name = "discovery-internal-zone-us-gov-west-1c.production"
  records = [
    "10.21.93.37"
  ]
  ttl     = 120
  type    = "A"
  zone_id = "/hostedzone/Z10007291701AVIAY46A3"
}

resource "aws_route53_record" "_hostedzone_Z10007291701AVIAY46A3_internal_services_production_CNAME" {
  name = "internal-services.production"
  records = [
    "allogy-internal-services-gateway.us-gov-west-1.elasticbeanstalk.com"
  ]
  ttl     = 300
  type    = "CNAME"
  zone_id = "/hostedzone/Z10007291701AVIAY46A3"
}

resource "aws_route53_record" "_hostedzone_Z10007291701AVIAY46A3_production_NS" {
  name = "production"
  records = [
    "ns-0.awsdns-us-gov-00.com.", "ns-1024.awsdns-us-gov-00.org.", "ns-1536.awsdns-us-gov-00.us.", "ns-512.awsdns-us-gov-00.net."
  ]
  ttl     = 172800
  type    = "NS"
  zone_id = "/hostedzone/Z10007291701AVIAY46A3"
}

resource "aws_route53_record" "_hostedzone_Z10007291701AVIAY46A3_production_SOA" {
  name = "production"
  records = [
    "ns-0.awsdns-us-gov-00.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
  ttl     = 900
  type    = "SOA"
  zone_id = "/hostedzone/Z10007291701AVIAY46A3"
}

