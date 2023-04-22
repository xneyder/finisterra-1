resource "aws_api_gateway_method_settings" "m3u7aza1eh_production____" {
  method_path = "*/*"
  rest_api_id = "m3u7aza1eh"
  settings {
    throttling_burst_limit = 2000
    throttling_rate_limit  = 1000
  }
  stage_name = "production"
}

