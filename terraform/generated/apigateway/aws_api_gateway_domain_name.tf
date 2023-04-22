resource "aws_api_gateway_domain_name" "learning_activities_00_allogy_com" {
  domain_name = "learning-activities-00.allogy.com"
  endpoint_configuration {
    types = [
      "REGIONAL"
    ]
  }
  regional_certificate_arn = "arn:aws-us-gov:acm:us-gov-west-1:050779347855:certificate/0ba5a0ce-3752-4631-8422-28ca164d70bc"
}

resource "aws_api_gateway_domain_name" "learning_activities_allogy_com" {
  domain_name = "learning-activities.allogy.com"
  endpoint_configuration {
    types = [
      "REGIONAL"
    ]
  }
  regional_certificate_arn = "arn:aws-us-gov:acm:us-gov-west-1:050779347855:certificate/0ba5a0ce-3752-4631-8422-28ca164d70bc"
}

