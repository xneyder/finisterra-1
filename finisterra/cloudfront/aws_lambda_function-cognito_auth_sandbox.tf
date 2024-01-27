locals {
  function_name_9ee5c6181a = "cognito_auth_sandbox"
}

module "aws_lambda_function-cognito_auth_sandbox" {
  source = "github.com/finisterra-io/terraform-aws-modules.git//lambda?ref=main"
  architectures = [
    "x86_64"
  ]
  description                    = "Enforces JWT authentication through AWS Cognito"
  filename                       = "cloudfront/${local.function_name_9ee5c6181a}.zip"
  function_name                  = local.function_name_9ee5c6181a
  handler                        = "index.handler"
  memory_size                    = 128
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  iam_role_name                  = "${local.function_name_9ee5c6181a}-role"
  runtime                        = "nodejs14.x"
  source_code_hash               = "ZceoXcwi7C+8eNpseUZ9rfg7VV9XYD+EcgvhYkZjjpU="
  tags = {
    "Environment" : "sandbox",
    "Terraform" : "true"
  }
  timeout                = 3
  tracing_config_mode    = "PassThrough"
  ephemeral_storage_size = 512
}
