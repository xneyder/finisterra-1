resource "aws_elastic_beanstalk_application" "dbt_clinician_web" {
  name        = "dbt-clinician-web"
  description = "DBT Clinician Web"
}

resource "aws_elastic_beanstalk_application" "book_service" {
  name        = "book-service"
  description = "Allogy Book Service"
}

resource "aws_elastic_beanstalk_application" "learner_web_ui_gateway" {
  name        = "learner-web-ui-gateway"
  description = "Learner Web UI Gateway"
}

resource "aws_elastic_beanstalk_application" "collaboration_person" {
  name        = "collaboration-person"
  description = "Person Service"
}

resource "aws_elastic_beanstalk_application" "form_service" {
  name        = "form-service"
  description = "Form Service"
}

resource "aws_elastic_beanstalk_application" "mobile_client_gateway" {
  name        = "mobile-client-gateway"
  description = "Mobile Client Gateway"
}

resource "aws_elastic_beanstalk_application" "market_service" {
  name        = "market-service"
  description = "Market Service"
}

resource "aws_elastic_beanstalk_application" "identity_service" {
  name        = "identity-service"
  description = "Identity Service"
}

resource "aws_elastic_beanstalk_application" "capillary_web_ui_gateway" {
  name        = "capillary-web-ui-gateway"
  description = "Capillary Web UI Gateway"
}

resource "aws_elastic_beanstalk_application" "services_gateway" {
  name        = "services-gateway"
  description = "Services Gateway"
}

resource "aws_elastic_beanstalk_application" "internal_services_gateway" {
  name        = "internal-services-gateway"
  description = "Internal Services Gateway"
}

resource "aws_elastic_beanstalk_application" "test_web_service" {
  name        = "test-web-service"
  description = "Test Web Service"
}

