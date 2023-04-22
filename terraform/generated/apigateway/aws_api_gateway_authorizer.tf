resource "aws_api_gateway_authorizer" "eigism" {
  authorizer_credentials           = "arn:aws-us-gov:iam::050779347855:role/aws-api-gateway-role"
  authorizer_result_ttl_in_seconds = 60
  authorizer_uri                   = "arn:aws-us-gov:apigateway:us-gov-west-1:lambda:path/2015-03-31/functions/arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:identity-authorizeGatewayRequest:$LATEST/invocations"
  identity_source                  = "method.request.header.Authorization"
  identity_validation_expression   = "Bearer [^\\.]+\\.[^\\.]+\\.[^\\.]+"
  name                             = "standardAuthorizer"
  rest_api_id                      = "m3u7aza1eh"
  type                             = "TOKEN"
}

