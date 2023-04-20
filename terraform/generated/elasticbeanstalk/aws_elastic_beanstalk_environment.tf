resource "aws_elastic_beanstalk_environment" "e_p6bifdmp7h" {
  name        = "capillary-web-ui-gateway-green"
  application = "capillary-web-ui-gateway"
}

resource "aws_elastic_beanstalk_environment" "e_fbj96npvkw" {
  name        = "identity-service-blue"
  application = "identity-service"
}

resource "aws_elastic_beanstalk_environment" "e_tx62adwg2k" {
  name        = "identity-service-green"
  application = "identity-service"
}

resource "aws_elastic_beanstalk_environment" "e_jhagz8maay" {
  name        = "market-service-green"
  application = "market-service"
}

resource "aws_elastic_beanstalk_environment" "e_pcw37ypdme" {
  name        = "mobile-client-gateway-blue"
  application = "mobile-client-gateway"
}

resource "aws_elastic_beanstalk_environment" "e_fmzgrfkcqp" {
  name        = "book-service-blue"
  application = "book-service"
}

resource "aws_elastic_beanstalk_environment" "e_bner7vhrif" {
  name        = "capillary-web-ui-gateway-blue"
  application = "capillary-web-ui-gateway"
}

resource "aws_elastic_beanstalk_environment" "e_rwv222b3qp" {
  name        = "learner-web-ui-gateway-green"
  application = "learner-web-ui-gateway"
}

resource "aws_elastic_beanstalk_environment" "e_xmec4epg3c" {
  name        = "book-service-green"
  application = "book-service"
}

resource "aws_elastic_beanstalk_environment" "e_jgrjparfpf" {
  name        = "dbt-clinician-web-green"
  application = "dbt-clinician-web"
}

resource "aws_elastic_beanstalk_environment" "e_32xzmdus8p" {
  name        = "services-gateway-blue"
  application = "services-gateway"
}

resource "aws_elastic_beanstalk_environment" "e_59p3bpnwec" {
  name        = "learner-web-ui-gateway-blue"
  application = "learner-web-ui-gateway"
}

resource "aws_elastic_beanstalk_environment" "e_3evreti3za" {
  name        = "collaboration-person-blue"
  application = "collaboration-person"
}

resource "aws_elastic_beanstalk_environment" "e_bmqqxwyjst" {
  name        = "form-service-blue"
  application = "form-service"
}

resource "aws_elastic_beanstalk_environment" "e_yd9s5vvfgp" {
  name        = "internal-services-gateway-green"
  application = "internal-services-gateway"
}

