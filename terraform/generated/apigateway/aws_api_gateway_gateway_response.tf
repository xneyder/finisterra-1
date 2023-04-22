resource "aws_api_gateway_gateway_response" "m3u7aza1eh_ACCESS_DENIED" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "ACCESS_DENIED"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "403"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_API_CONFIGURATION_ERROR" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "API_CONFIGURATION_ERROR"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "500"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_AUTHORIZER_CONFIGURATION_ERROR" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "AUTHORIZER_CONFIGURATION_ERROR"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "500"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_AUTHORIZER_FAILURE" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "AUTHORIZER_FAILURE"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "500"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_BAD_REQUEST_BODY" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "BAD_REQUEST_BODY"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "400"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_BAD_REQUEST_PARAMETERS" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "BAD_REQUEST_PARAMETERS"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "400"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_DEFAULT_4XX" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "DEFAULT_4XX"
  rest_api_id   = "m3u7aza1eh"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_DEFAULT_5XX" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "DEFAULT_5XX"
  rest_api_id   = "m3u7aza1eh"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_EXPIRED_TOKEN" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "EXPIRED_TOKEN"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "403"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_INTEGRATION_FAILURE" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "INTEGRATION_FAILURE"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "504"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_INTEGRATION_TIMEOUT" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "INTEGRATION_TIMEOUT"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "504"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_INVALID_API_KEY" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "INVALID_API_KEY"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "403"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_INVALID_SIGNATURE" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "INVALID_SIGNATURE"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "403"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_MISSING_AUTHENTICATION_TOKEN" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "MISSING_AUTHENTICATION_TOKEN"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "403"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_QUOTA_EXCEEDED" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "QUOTA_EXCEEDED"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "429"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_REQUEST_TOO_LARGE" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "REQUEST_TOO_LARGE"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "413"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_RESOURCE_NOT_FOUND" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "RESOURCE_NOT_FOUND"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "404"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_THROTTLED" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "THROTTLED"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "429"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_UNAUTHORIZED" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "UNAUTHORIZED"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "401"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_UNSUPPORTED_MEDIA_TYPE" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "UNSUPPORTED_MEDIA_TYPE"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "415"
}

resource "aws_api_gateway_gateway_response" "m3u7aza1eh_WAF_FILTERED" {
  response_templates = {
    "application/json" : <<EOF
{"message":$context.error.messageString}
EOF
  }
  response_type = "WAF_FILTERED"
  rest_api_id   = "m3u7aza1eh"
  status_code   = "403"
}

