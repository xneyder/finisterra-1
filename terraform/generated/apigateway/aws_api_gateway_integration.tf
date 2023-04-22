resource "aws_api_gateway_integration" "m3u7aza1eh_gn08eh_POST" {
  connection_type         = "INTERNET"
  credentials             = "arn:aws-us-gov:iam::050779347855:role/aws-api-gateway-role"
  http_method             = "POST"
  integration_http_method = "POST"
  request_templates = {
    "application/json" : <<EOF
{
    "tenantId" : "$context.authorizer.tenantId",
    "tenantRole" : "$context.authorizer.tenantRole",
    "principalId" : "$context.authorizer.principalId",
    "apiGatewayStage" : "$stageVariables.name",
    "body" : $input.json('$')
    }
    
EOF
  }
  resource_id          = "gn08eh"
  rest_api_id          = "m3u7aza1eh"
  timeout_milliseconds = 29000
  type                 = "AWS"
  uri                  = "arn:aws-us-gov:apigateway:us-gov-west-1:lambda:path/2015-03-31/functions/arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:learning-createActivities:$LATEST/invocations"
}

