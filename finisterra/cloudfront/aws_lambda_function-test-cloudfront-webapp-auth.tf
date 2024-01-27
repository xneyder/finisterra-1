locals {
  function_name_5b83a6bf5c = "test-cloudfront-webapp-auth"
}

module "aws_lambda_function-test-cloudfront-webapp-auth" {
  source = "github.com/finisterra-io/terraform-aws-modules.git//lambda?ref=main"
  architectures = [
    "x86_64"
  ]
  description                    = "Lambda function associated with cloudfront auth"
  filename                       = "cloudfront/${local.function_name_5b83a6bf5c}.zip"
  function_name                  = local.function_name_5b83a6bf5c
  handler                        = "index.handler"
  memory_size                    = 128
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  iam_role_name                  = local.function_name_5b83a6bf5c
  runtime                        = "nodejs18.x"
  source_code_hash               = "+kBZUM0sZRik6xQ43IZZF62fOMukpDK/BlpUJaG1a9s="
  timeout                        = 3
  tracing_config_mode            = "PassThrough"
  ephemeral_storage_size         = 512
}
