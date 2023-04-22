resource "aws_api_gateway_method_response" "m3u7aza1eh_gn08eh_POST_201" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_models = {
    "application/json" = "CreateActivitiesResponse"

  }
  rest_api_id = "m3u7aza1eh"
  status_code = "201"
}

resource "aws_api_gateway_method_response" "m3u7aza1eh_gn08eh_POST_400" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_models = {
    "application/json" = "ApiError"

  }
  rest_api_id = "m3u7aza1eh"
  status_code = "400"
}

resource "aws_api_gateway_method_response" "m3u7aza1eh_gn08eh_POST_401" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_models = {
    "application/json" = "ApiError"

  }
  rest_api_id = "m3u7aza1eh"
  status_code = "401"
}

resource "aws_api_gateway_method_response" "m3u7aza1eh_gn08eh_POST_403" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_models = {
    "application/json" = "ApiError"

  }
  rest_api_id = "m3u7aza1eh"
  status_code = "403"
}

resource "aws_api_gateway_method_response" "m3u7aza1eh_gn08eh_POST_500" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_models = {
    "application/json" = "ApiError"

  }
  rest_api_id = "m3u7aza1eh"
  status_code = "500"
}

