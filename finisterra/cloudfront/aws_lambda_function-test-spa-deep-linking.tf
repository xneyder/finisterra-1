locals {
  function_name_2262633f2f = "test-spa-deep-linking"
}

module "aws_lambda_function-test-spa-deep-linking" {
  source = "github.com/finisterra-io/terraform-aws-modules.git//lambda?ref=main"
  architectures = [
    "x86_64"
  ]
  description                    = "Lambda function associated with cloudfront origin request to support SPA routing"
  filename                       = "cloudfront/${local.function_name_2262633f2f}.zip"
  function_name                  = local.function_name_2262633f2f
  handler                        = "index.handler"
  memory_size                    = 128
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  iam_role_name                  = local.function_name_2262633f2f
  runtime                        = "nodejs18.x"
  source_code_hash               = "iW3Hl5el4WNgO5bQpqjo7VXqgcA01JcwOMH0sy93YHM="
  timeout                        = 3
  tracing_config_mode            = "PassThrough"
  ephemeral_storage_size         = 512
}
