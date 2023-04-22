resource "aws_api_gateway_method" "m3u7aza1eh_gn08eh_POST" {
  api_key_required = false
  authorization    = "CUSTOM"
  authorizer_id    = "eigism"
  http_method      = "POST"
  operation_name   = "createActivities"
  request_models = {
    "application/json" = "CreateActivitiesRequest"

  }
  request_parameters = {
    "method.request.header.Authorization" = false

  }
  resource_id = "gn08eh"
  rest_api_id = "m3u7aza1eh"
}

