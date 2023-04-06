resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO__2cb01c2fb5a7f1094676ad157d2ae856_billing_dev_posthog_dev_CNAME" {
  name = "_2cb01c2fb5a7f1094676ad157d2ae856.billing.dev.posthog.dev"
  records = [
    "_46ce5ffab33bbb9f9539470491c9f77d.gbycpywhzv.acm-validations.aws."
  ]
  ttl     = 60
  type    = "CNAME"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO__8a934ac523e3b568e4eb197a89f81b47_app_static_dev_posthog_dev_CNAME" {
  name = "_8a934ac523e3b568e4eb197a89f81b47.app-static.dev.posthog.dev"
  records = [
    "_2849ea4ce001b2fa43a116178f851ef3.mybbdzzyvz.acm-validations.aws."
  ]
  ttl     = 60
  type    = "CNAME"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO__e3a5b451ac9f8f995c8863c4098a6f29_app_dev_posthog_dev_CNAME" {
  name = "_e3a5b451ac9f8f995c8863c4098a6f29.app.dev.posthog.dev"
  records = [
    "_dd5a624a2d05fe25b34d068b5ecdb0e2.rdnyqppgxp.acm-validations.aws."
  ]
  ttl     = 60
  type    = "CNAME"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO_app_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = false
    name                   = "d7o5ifb4cypi2.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
  }
  name    = "app.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO_app_static_dev_posthog_dev_CNAME" {
  name = "app-static.dev.posthog.dev"
  records = [
    "d1d54aj35kyghm.cloudfront.net"
  ]
  ttl     = 60
  type    = "CNAME"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO_billing_2_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = true
    name                   = "dualstack.posthog-cloud-ingress-alb-1703901433.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
  }
  name    = "billing-2.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO_billing_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = false
    name                   = "d31la12sdkdcuv.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
  }
  name    = "billing.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO_dev_posthog_dev_NS" {
  name = "dev.posthog.dev"
  records = [
    "ns-1152.awsdns-16.org.", "ns-1928.awsdns-49.co.uk.", "ns-239.awsdns-29.com.", "ns-582.awsdns-08.net."
  ]
  ttl     = 172800
  type    = "NS"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z01090581NU9MF363HUO_dev_posthog_dev_SOA" {
  name = "dev.posthog.dev"
  records = [
    "ns-582.awsdns-08.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
  ttl     = 900
  type    = "SOA"
  zone_id = "/hostedzone/Z01090581NU9MF363HUO"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1___us_east_1_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = true
    name                   = "dualstack.posthog-cloud-ingress-alb-1703901433.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
  }
  name    = "*.us-east-1.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_alertmanager_us_east_1_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = true
    name                   = "internal-k8s-posthog-posthogp-f4badb036a-886562175.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
  }
  name    = "alertmanager.us-east-1.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_alertmanager_us_east_1_dev_posthog_dev_TXT" {
  name = "alertmanager.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/posthog/posthog-prometheus-alertmanager"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_billing_frank_us_east_1_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = true
    name                   = "ingress-nginx-fd854499e32f769f.elb.us-east-1.amazonaws.com"
    zone_id                = "Z26RNL4JYFTOTI"
  }
  name    = "billing-frank.us-east-1.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_billing_frank_us_east_1_dev_posthog_dev_TXT" {
  name = "billing-frank.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/billing/billing"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_cname_alertmanager_us_east_1_dev_posthog_dev_TXT" {
  name = "cname-alertmanager.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/posthog/posthog-prometheus-alertmanager"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_cname_grafana_us_east_1_dev_posthog_dev_TXT" {
  name = "cname-grafana.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/posthog/posthog-grafana"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_cname_loki_us_east_1_dev_posthog_dev_TXT" {
  name = "cname-loki.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/posthog/posthog-loki"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_cname_prometheus_us_east_1_dev_posthog_dev_TXT" {
  name = "cname-prometheus.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/posthog/posthog-prometheus-server"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_grafana_us_east_1_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = true
    name                   = "internal-k8s-posthog-posthogg-25be658f67-1995422338.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
  }
  name    = "grafana.us-east-1.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_grafana_us_east_1_dev_posthog_dev_TXT" {
  name = "grafana.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/posthog/posthog-grafana"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_loki_us_east_1_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = true
    name                   = "internal-k8s-posthog-posthogl-ac35fb0cca-1513582405.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
  }
  name    = "loki.us-east-1.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_loki_us_east_1_dev_posthog_dev_TXT" {
  name = "loki.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/posthog/posthog-loki"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_prometheus_us_east_1_dev_posthog_dev_A" {
  alias {
    evaluate_target_health = true
    name                   = "internal-k8s-posthog-posthogp-0b83e50386-1206577592.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
  }
  name    = "prometheus.us-east-1.dev.posthog.dev"
  type    = "A"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_prometheus_us_east_1_dev_posthog_dev_TXT" {
  name = "prometheus.us-east-1.dev.posthog.dev"
  records = [
    "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/posthog/posthog-prometheus-server"
  ]
  ttl     = 300
  type    = "TXT"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_us_east_1_dev_posthog_dev_NS" {
  name = "us-east-1.dev.posthog.dev"
  records = [
    "ns-0.awsdns-00.com.", "ns-1024.awsdns-00.org.", "ns-1536.awsdns-00.co.uk.", "ns-512.awsdns-00.net."
  ]
  ttl     = 172800
  type    = "NS"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z022506014OQVW0SW3RY1_us_east_1_dev_posthog_dev_SOA" {
  name = "us-east-1.dev.posthog.dev"
  records = [
    "ns-1536.awsdns-00.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
  ttl     = 900
  type    = "SOA"
  zone_id = "/hostedzone/Z022506014OQVW0SW3RY1"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_dev_iad_ch_1a_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "dev-iad-ch-1a.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "172.31.95.28"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_dev_iad_ch_1b_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "dev-iad-ch-1b.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "172.31.13.250"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_dev_iad_ch_internal_ec2_us_east_1_dev_posthog_dev_CNAME" {
  name = "dev-iad-ch.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "dev-iad-ch-80e90edf49b09ce8.elb.us-east-1.amazonaws.com"
  ]
  ttl     = 60
  type    = "CNAME"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_dev_iad_zk_1_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "dev-iad-zk-1.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "172.31.88.1"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_dev_iad_zk_2_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "dev-iad-zk-2.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "172.31.11.69"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_dev_iad_zk_3_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "dev-iad-zk-3.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "172.31.43.60"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_internal_ec2_us_east_1_dev_posthog_dev_NS" {
  name = "internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "ns-0.awsdns-00.com.", "ns-1024.awsdns-00.org.", "ns-1536.awsdns-00.co.uk.", "ns-512.awsdns-00.net."
  ]
  ttl     = 172800
  type    = "NS"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_internal_ec2_us_east_1_dev_posthog_dev_SOA" {
  name = "internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "ns-1536.awsdns-00.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
  ttl     = 900
  type    = "SOA"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_1377_dev_iad_ch_1a_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-1377-dev-iad-ch-1a.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.169.127"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_1377_dev_iad_ch_1b_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-1377-dev-iad-ch-1b.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.146.2"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_1377_dev_iad_ch_1c_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-1377-dev-iad-ch-1c.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.131.32"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_1377_dev_iad_ch_1d_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-1377-dev-iad-ch-1d.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.163.57"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_1377_dev_iad_ch_internal_ec2_us_east_1_dev_posthog_dev_CNAME" {
  name = "test-ch-pr-1377-dev-iad-ch.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "test-ch-pr-1377-dev-iad-ch-dfe291f4b77f3633.elb.us-east-1.amazonaws.com"
  ]
  ttl     = 60
  type    = "CNAME"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_1377_dev_iad_zk_1_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-1377-dev-iad-zk-1.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.172.84"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_1377_dev_iad_zk_2_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-1377-dev-iad-zk-2.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.147.166"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_1377_dev_iad_zk_3_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-1377-dev-iad-zk-3.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.129.230"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_485_dev_iad_ch_1a_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-485-dev-iad-ch-1a.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.169.234"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_485_dev_iad_ch_1b_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-485-dev-iad-ch-1b.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.151.167"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_485_dev_iad_ch_1c_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-485-dev-iad-ch-1c.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.136.244"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_485_dev_iad_ch_1d_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-485-dev-iad-ch-1d.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.168.230"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_485_dev_iad_ch_internal_ec2_us_east_1_dev_posthog_dev_CNAME" {
  name = "test-ch-pr-485-dev-iad-ch.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "test-ch-pr-485-dev-iad-ch-aa3b68fd8c7a024a.elb.us-east-1.amazonaws.com"
  ]
  ttl     = 60
  type    = "CNAME"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_485_dev_iad_zk_1_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-485-dev-iad-zk-1.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.171.180"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_485_dev_iad_zk_2_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-485-dev-iad-zk-2.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.157.245"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_ch_pr_485_dev_iad_zk_3_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-ch-pr-485-dev-iad-zk-3.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.142.114"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_pr_1377_dev_iad_zk_1_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-pr-1377-dev-iad-zk-1.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.174.200"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_pr_1377_dev_iad_zk_2_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-pr-1377-dev-iad-zk-2.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.144.225"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

resource "aws_route53_record" "_hostedzone_Z043900936DZ9G8H9I247_test_pr_1377_dev_iad_zk_3_internal_ec2_us_east_1_dev_posthog_dev_A" {
  name = "test-pr-1377-dev-iad-zk-3.internal.ec2.us-east-1.dev.posthog.dev"
  records = [
    "10.0.135.240"
  ]
  ttl     = 60
  type    = "A"
  zone_id = "/hostedzone/Z043900936DZ9G8H9I247"
}

