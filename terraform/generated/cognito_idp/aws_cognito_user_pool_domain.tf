resource "aws_cognito_user_pool_domain" "allogy_internal" {
  domain       = "allogy-internal"
  user_pool_id = "us-gov-west-1_6HCrpEvID"
}

