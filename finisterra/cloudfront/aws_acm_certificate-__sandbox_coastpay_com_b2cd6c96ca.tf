locals {
  domain_name_b2cd6c96ca = "*.sandbox.coastpay.com"
}

module "aws_acm_certificate-__sandbox_coastpay_com_b2cd6c96ca" {
  source      = "github.com/finisterra-io/terraform-aws-modules.git//acm?ref=main"
  domain_name = local.domain_name_b2cd6c96ca
  subject_alternative_names = [
    local.domain_name_b2cd6c96ca
  ]
  key_algorithm = "RSA_2048"
  tags = {
    "Environment" : "sandbox",
    "Terraform" : "true"
  }
}
