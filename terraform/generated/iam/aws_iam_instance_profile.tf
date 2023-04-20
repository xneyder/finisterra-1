resource "aws_iam_instance_profile" "BastionServer" {
  path = "/"
  role = "BastionServer"
}

resource "aws_iam_instance_profile" "DeveloperTools_S3Proxy" {
  path = "/"
  role = "DeveloperTools-S3Proxy"
}

resource "aws_iam_instance_profile" "JenkinsMaster" {
  path = "/DeveloperTools/"
  role = "JenkinsMaster"
}

resource "aws_iam_instance_profile" "JenkinsRubySlave" {
  path = "/"
  role = "JenkinsRubySlave"
}

resource "aws_iam_instance_profile" "SessionManagerMinimum" {
  path = "/"
  role = "SessionManagerMinimum"
}

resource "aws_iam_instance_profile" "ecsInstanceRole" {
  path = "/"
  role = "ecsInstanceRole"
}

resource "aws_iam_instance_profile" "internal_services_gateway" {
  path = "/"
  role = "internal-services-gateway"
}

resource "aws_iam_instance_profile" "services_gateway" {
  path = "/"
  role = "services-gateway"
}

resource "aws_iam_instance_profile" "temp_admin" {
  path = "/"
  role = "temp-admin"
}

resource "aws_iam_instance_profile" "test" {
  path = "/"
  role = "test"
}

resource "aws_iam_instance_profile" "web_app_book_service" {
  path = "/"
  role = "web-app-book-service"
}

resource "aws_iam_instance_profile" "web_app_collaboration_person_service" {
  path = "/"
  role = "web-app-collaboration-person-service"
}

resource "aws_iam_instance_profile" "web_app_dbt_clinician_web" {
  path = "/"
  role = "web-app-dbt-clinician-web"
}

resource "aws_iam_instance_profile" "web_app_form_service" {
  path = "/"
  role = "web-app-form-service"
}

resource "aws_iam_instance_profile" "web_app_gateway" {
  path = "/"
  role = "web-app-gateway"
}

resource "aws_iam_instance_profile" "web_app_identity_service" {
  path = "/"
  role = "web-app-identity-service"
}

resource "aws_iam_instance_profile" "web_app_market_service" {
  path = "/"
  role = "web-app-market-service"
}

resource "aws_iam_instance_profile" "web_app_mobile_client_gateway" {
  path = "/"
  role = "web-app-mobile-client-gateway"
}

resource "aws_iam_instance_profile" "web_app_test_web_service" {
  path = "/"
  role = "web-app-test-web-service"
}

