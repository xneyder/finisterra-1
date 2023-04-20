resource "aws_cognito_user_pool" "AllogyInternal" {
  admin_create_user_config {
    allow_admin_create_user_only = false
  }
  auto_verified_attributes = [
    "email"
  ]
  deletion_protection = "INACTIVE"
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
  mfa_configuration = "OFF"
  name              = "AllogyInternal"
  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    name                     = "email"
    required                 = true
    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true
    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}

