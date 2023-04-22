resource "aws_api_gateway_rest_api" "m3u7aza1eh" {
  endpoint_configuration {
    types = [
      "REGIONAL"
    ]
  }
  minimum_compression_size = -1
  name                     = "Learning Activities Service"
}

