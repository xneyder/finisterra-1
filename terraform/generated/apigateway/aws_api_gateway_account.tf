resource "aws_api_gateway_account" "api_gateway_account" {
  cloudwatch_role_arn = "arn:aws-us-gov:iam::050779347855:role/aws-api-gateway-role"
}

