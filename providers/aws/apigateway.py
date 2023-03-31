
def aws_api_gateway_account(self):
    print("Processing API Gateway Account...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    account = apigateway.get_account()

    attributes = {}

    if "cloudwatchRoleArn" in account:
        attributes["cloudwatch_role_arn"] = account["cloudwatchRoleArn"]

    if "throttleSettings" in account:
        if "burstLimit" in account["throttleSettings"]:
            attributes["throttle_settings_burst_limit"] = account["throttleSettings"]["burstLimit"]
        if "rateLimit" in account["throttleSettings"]:
            attributes["throttle_settings_rate_limit"] = account["throttleSettings"]["rateLimit"]

    self.hcl.process_resource(
        "aws_api_gateway_account", "api_gateway_account", attributes)


def aws_api_gateway_api_key(self):
    print("Processing API Gateway API Keys...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    paginator = apigateway.get_paginator("get_api_keys")
    page_iterator = paginator.paginate()

    for page in page_iterator:
        for api_key in page["items"]:
            print(f"  Processing API Gateway API Key: {api_key['id']}")

            attributes = {
                "name": api_key["name"],
            }

            if "description" in api_key:
                attributes["description"] = api_key["description"]

            if "enabled" in api_key:
                attributes["enabled"] = api_key["enabled"]

            self.hcl.process_resource(
                "aws_api_gateway_api_key", api_key["id"], attributes)


def aws_api_gateway_authorizer(self):
    print("Processing API Gateway Authorizers...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        authorizers = apigateway.get_authorizers(
            restApiId=rest_api["id"])["items"]

        for authorizer in authorizers:
            print(f"  Processing API Gateway Authorizer: {authorizer['id']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "name": authorizer["name"],
                "type": authorizer["type"],
            }

            if "authorizerUri" in authorizer:
                attributes["authorizer_uri"] = authorizer["authorizerUri"]

            if "authorizerCredentials" in authorizer:
                attributes["authorizer_credentials"] = authorizer["authorizerCredentials"]

            if "identitySource" in authorizer:
                attributes["identity_source"] = authorizer["identitySource"]

            self.hcl.process_resource(
                "aws_api_gateway_authorizer", authorizer["id"], attributes)


def aws_api_gateway_base_path_mapping(self):
    print("Processing API Gateway Base Path Mappings...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    domain_names = apigateway.get_domain_names()["items"]

    for domain_name in domain_names:
        base_path_mappings = apigateway.get_base_path_mappings(
            domainName=domain_name["domainName"])["items"]

        for base_path_mapping in base_path_mappings:
            print(
                f"  Processing API Gateway Base Path Mapping: {base_path_mapping['basePath']}")

            attributes = {
                "domain_name": domain_name["domainName"],
                "rest_api_id": base_path_mapping["restApiId"],
                "stage": base_path_mapping["stage"],
            }

            if "basePath" in base_path_mapping:
                attributes["base_path"] = base_path_mapping["basePath"]

            resource_name = f"{domain_name['domainName']}-{base_path_mapping['basePath']}"
            self.hcl.process_resource(
                "aws_api_gateway_base_path_mapping", resource_name, attributes)


def aws_api_gateway_client_certificate(self):
    print("Processing API Gateway Client Certificates...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    client_certificates = apigateway.get_client_certificates()["items"]

    for client_certificate in client_certificates:
        print(
            f"  Processing API Gateway Client Certificate: {client_certificate['clientCertificateId']}")

        attributes = {
            "description": client_certificate["description"],
        }

        self.hcl.process_resource("aws_api_gateway_client_certificate",
                                  client_certificate["clientCertificateId"], attributes)


def aws_api_gateway_deployment(self):
    print("Processing API Gateway Deployments...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        deployments = apigateway.get_deployments(
            restApiId=rest_api["id"])["items"]

        for deployment in deployments:
            print(f"  Processing API Gateway Deployment: {deployment['id']}")

            attributes = {
                "rest_api_id": rest_api["id"],
            }

            if "description" in deployment:
                attributes["description"] = deployment["description"]

            if "stageName" in deployment:
                attributes["stage_name"] = deployment["stageName"]

            self.hcl.process_resource(
                "aws_api_gateway_deployment", deployment["id"], attributes)


def aws_api_gateway_documentation_part(self):
    print("Processing API Gateway Documentation Parts...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        documentation_parts = apigateway.get_documentation_parts(
            restApiId=rest_api["id"])["items"]

        for documentation_part in documentation_parts:
            print(
                f"  Processing API Gateway Documentation Part: {documentation_part['id']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "location": documentation_part["location"],
                "properties": documentation_part["properties"],
            }

            self.hcl.process_resource(
                "aws_api_gateway_documentation_part", documentation_part["id"], attributes)


def aws_api_gateway_documentation_version(self):
    print("Processing API Gateway Documentation Versions...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        documentation_versions = apigateway.get_documentation_versions(
            restApiId=rest_api["id"])["items"]

        for documentation_version in documentation_versions:
            print(
                f"  Processing API Gateway Documentation Version: {documentation_version['version']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "version": documentation_version["version"],
                "description": documentation_version["description"],
            }

            self.hcl.process_resource(
                "aws_api_gateway_documentation_version", documentation_version["version"], attributes)


def aws_api_gateway_domain_name(self):
    print("Processing API Gateway Domain Names...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    domain_names = apigateway.get_domain_names()["items"]

    for domain_name in domain_names:
        print(
            f"  Processing API Gateway Domain Name: {domain_name['domainName']}")

        attributes = {
            "domain_name": domain_name["domainName"],
            "certificate_arn": domain_name.get("certificateArn", ""),
            "security_policy": domain_name.get("securityPolicy", ""),
        }

        self.hcl.process_resource(
            "aws_api_gateway_domain_name", domain_name["domainName"], attributes)


def aws_api_gateway_gateway_response(self):
    print("Processing API Gateway Gateway Responses...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        gateway_responses = apigateway.get_gateway_responses(
            restApiId=rest_api["id"])["items"]

        for gateway_response in gateway_responses:
            print(
                f"  Processing API Gateway Gateway Response: {gateway_response['responseType']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "response_type": gateway_response["responseType"],
                "status_code": gateway_response.get("statusCode", ""),
                "response_parameters": gateway_response.get("responseParameters", {}),
                "response_templates": gateway_response.get("responseTemplates", {}),
            }

            resource_name = f"{rest_api['id']}-{gateway_response['responseType']}"
            self.hcl.process_resource(
                "aws_api_gateway_gateway_response", resource_name, attributes)


def aws_api_gateway_integration(self):
    print("Processing API Gateway Integrations...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        resources = apigateway.get_resources(restApiId=rest_api["id"])["items"]

        for resource in resources:
            if "resourceMethods" in resource:
                for method in resource["resourceMethods"]:
                    integration = apigateway.get_integration(
                        restApiId=rest_api["id"], resourceId=resource["id"], httpMethod=method)

                    print(
                        f"  Processing API Gateway Integration: {resource['path']} {method}")

                    attributes = {
                        "rest_api_id": rest_api["id"],
                        "resource_id": resource["id"],
                        "http_method": method,
                        "type": integration["type"],
                        "uri": integration.get("uri", ""),
                        "integration_http_method": integration.get("httpMethod", ""),
                    }

                    resource_name = f"{rest_api['id']}-{resource['id']}-{method}"
                    self.hcl.process_resource(
                        "aws_api_gateway_integration", resource_name, attributes)


def aws_api_gateway_integration_response(self):
    print("Processing API Gateway Integration Responses...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        resources = apigateway.get_resources(restApiId=rest_api["id"])["items"]

        for resource in resources:
            if "resourceMethods" in resource:
                for method in resource["resourceMethods"]:
                    integration = apigateway.get_integration(
                        restApiId=rest_api["id"], resourceId=resource["id"], httpMethod=method)

                    for status_code in integration["integrationResponses"]:
                        integration_response = integration["integrationResponses"][status_code]

                        print(
                            f"  Processing API Gateway Integration Response: {resource['path']} {method} {status_code}")

                        attributes = {
                            "rest_api_id": rest_api["id"],
                            "resource_id": resource["id"],
                            "http_method": method,
                            "status_code": status_code,
                            "response_parameters": integration_response.get("responseParameters", {}),
                            "response_templates": integration_response.get("responseTemplates", {}),
                        }

                        resource_name = f"{rest_api['id']}-{resource['id']}-{method}-{status_code}"
                        self.hcl.process_resource(
                            "aws_api_gateway_integration_response", resource_name, attributes)


aws_api_gateway_method
aws_api_gateway_method_response
aws_api_gateway_method_settings
aws_api_gateway_model
aws_api_gateway_request_validator
aws_api_gateway_resource
aws_api_gateway_rest_api
aws_api_gateway_rest_api_policy
aws_api_gateway_stage
aws_api_gateway_usage_plan
aws_api_gateway_usage_plan_key
aws_api_gateway_vpc_link
