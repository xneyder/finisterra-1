locals {
  domain_name_5f173e5960 = "cf.coastpay.com"
}

module "aws_acm_certificate-cf_coastpay_com_5f173e5960" {
  source      = "github.com/finisterra-io/terraform-aws-modules.git//acm?ref=main"
  domain_name = local.domain_name_5f173e5960
  subject_alternative_names = [
    local.domain_name_5f173e5960
  ]
  key_algorithm = "RSA_2048"
}
