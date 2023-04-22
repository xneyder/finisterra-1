resource "aws_api_gateway_stage" "m3u7aza1eh_production" {
  cache_cluster_enabled = false
  deployment_id         = "t1bd27"
  rest_api_id           = "m3u7aza1eh"
  stage_name            = "production"
  variables = {
    name = "production"

  }
  xray_tracing_enabled = false
}

