
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


def aws_api_gateway_method(self):
    print("Processing API Gateway Methods...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        resources = apigateway.get_resources(restApiId=rest_api["id"])["items"]

        for resource in resources:
            if "resourceMethods" in resource:
                for method in resource["resourceMethods"]:
                    method_details = apigateway.get_method(
                        restApiId=rest_api["id"], resourceId=resource["id"], httpMethod=method)

                    print(
                        f"  Processing API Gateway Method: {resource['path']} {method}")

                    attributes = {
                        "rest_api_id": rest_api["id"],
                        "resource_id": resource["id"],
                        "http_method": method,
                        "authorization": method_details["authorizationType"],
                        "api_key_required": method_details.get("apiKeyRequired", False),
                    }

                    resource_name = f"{rest_api['id']}-{resource['id']}-{method}"
                    self.hcl.process_resource(
                        "aws_api_gateway_method", resource_name, attributes)


def aws_api_gateway_method_response(self):
    print("Processing API Gateway Method Responses...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        resources = apigateway.get_resources(restApiId=rest_api["id"])["items"]

        for resource in resources:
            if "resourceMethods" in resource:
                for method in resource["resourceMethods"]:
                    method_details = apigateway.get_method(
                        restApiId=rest_api["id"], resourceId=resource["id"], httpMethod=method)

                    for status_code in method_details["methodResponses"]:
                        method_response = method_details["methodResponses"][status_code]

                        print(
                            f"  Processing API Gateway Method Response: {resource['path']} {method} {status_code}")

                        attributes = {
                            "rest_api_id": rest_api["id"],
                            "resource_id": resource["id"],
                            "http_method": method,
                            "status_code": status_code,
                            "response_models": method_response.get("responseModels", {}),
                            "response_parameters": method_response.get("responseParameters", {}),
                        }

                        resource_name = f"{rest_api['id']}-{resource['id']}-{method}-{status_code}"
                        self.hcl.process_resource(
                            "aws_api_gateway_method_response", resource_name, attributes)


def aws_api_gateway_model(self):
    print("Processing API Gateway Models...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        models = apigateway.get_models(restApiId=rest_api["id"])["items"]

        for model in models:
            print(f"  Processing API Gateway Model: {model['name']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "name": model["name"],
                "content_type": model["contentType"],
                "description": model.get("description", ""),
                "schema": model.get("schema", ""),
            }

            resource_name = f"{rest_api['id']}-{model['name']}"
            self.hcl.process_resource(
                "aws_api_gateway_model", resource_name, attributes)


def aws_api_gateway_method_settings(self):
    print("Processing API Gateway Method Settings...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        stages = apigateway.get_stages(restApiId=rest_api["id"])["item"]

        for stage in stages:
            settings = stage["methodSettings"]

            for key, setting in settings.items():
                print(f"  Processing API Gateway Method Setting: {key}")

                attributes = {
                    "rest_api_id": rest_api["id"],
                    "stage_name": stage["stageName"],
                    "method_path": key,
                    "settings": setting,
                }

                resource_name = f"{rest_api['id']}-{stage['stageName']}-{key}"
                self.hcl.process_resource(
                    "aws_api_gateway_method_settings", resource_name, attributes)


def aws_api_gateway_request_validator(self):
    print("Processing API Gateway Request Validators...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        validators = apigateway.get_request_validators(
            restApiId=rest_api["id"])["items"]

        for validator in validators:
            print(
                f"  Processing API Gateway Request Validator: {validator['name']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "name": validator["name"],
                "validate_request_body": validator["validateRequestBody"],
                "validate_request_parameters": validator["validateRequestParameters"],
            }

            resource_name = f"{rest_api['id']}-{validator['name']}"
            self.hcl.process_resource(
                "aws_api_gateway_request_validator", resource_name, attributes)


def aws_api_gateway_resource(self):
    print("Processing API Gateway Resources...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        resources = apigateway.get_resources(restApiId=rest_api["id"])["items"]

        for resource in resources:
            print(f"  Processing API Gateway Resource: {resource['path']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "parent_id": resource["parentId"],
                "path_part": resource["pathPart"],
            }

            resource_name = f"{rest_api['id']}-{resource['path'].replace('/', '-')}"
            self.hcl.process_resource(
                "aws_api_gateway_resource", resource_name, attributes)


def aws_api_gateway_rest_api(self):
    print("Processing API Gateway REST APIs...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        print(f"  Processing API Gateway REST API: {rest_api['name']}")

        attributes = {
            "name": rest_api["name"],
            "description": rest_api.get("description", ""),
            "api_key_source": rest_api["apiKeySource"],
            "endpoint_configuration": rest_api["endpointConfiguration"],
        }

        resource_name = f"{rest_api['id']}"
        self.hcl.process_resource(
            "aws_api_gateway_rest_api", resource_name, attributes)


def aws_api_gateway_rest_api_policy(self):
    print("Processing API Gateway REST API Policies...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        policy = rest_api.get("policy", None)

        if policy:
            print(
                f"  Processing API Gateway REST API Policy for {rest_api['name']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "policy": policy,
            }

            resource_name = f"{rest_api['id']}-policy"
            self.hcl.process_resource(
                "aws_api_gateway_rest_api_policy", resource_name, attributes)


def aws_api_gateway_stage(self):
    print("Processing API Gateway Stages...")

    apigateway = self.session.client("apigateway", region_name=self.region)
    rest_apis = apigateway.get_rest_apis()["items"]

    for rest_api in rest_apis:
        stages = apigateway.get_stages(restApiId=rest_api["id"])["item"]

        for stage in stages:
            print(f"  Processing API Gateway Stage: {stage['stageName']}")

            attributes = {
                "rest_api_id": rest_api["id"],
                "stage_name": stage["stageName"],
                "deployment_id": stage["deploymentId"],
                "description": stage.get("description", ""),
            }

            resource_name = f"{rest_api['id']}-{stage['stageName']}"
            self.hcl.process_resource(
                "aws_api_gateway_stage", resource_name, attributes)


def aws_api_gateway_usage_plan_and_key(self):
    print("Processing API Gateway Usage Plans and Usage Plan Keys...")

    paginator = self.apigateway_client.get_paginator("get_usage_plans")
    page_iterator = paginator.paginate()

    for page in page_iterator:
        for usage_plan in page["items"]:
            usage_plan_id = usage_plan["id"]
            print(f"  Processing API Gateway Usage Plan: {usage_plan_id}")

            attributes = {
                "id": usage_plan_id,
                "name": usage_plan["name"],
                "description": usage_plan.get("description", ""),
                "api_stages": usage_plan.get("apiStages", []),
                "quota_settings": usage_plan.get("quota", {}),
                "throttle_settings": usage_plan.get("throttle", {}),
            }
            self.hcl.process_resource(
                "aws_api_gateway_usage_plan", usage_plan_id, attributes)

            # Process Usage Plan Keys
            paginator_key = self.apigateway_client.get_paginator(
                "get_usage_plan_keys")
            page_iterator_key = paginator_key.paginate(
                usagePlanId=usage_plan_id)

            for page_key in page_iterator_key:
                for usage_plan_key in page_key["items"]:
                    key_id = usage_plan_key["id"]
                    key_type = usage_plan_key["type"]

                    print(
                        f"    Processing API Gateway Usage Plan Key: {key_id}")

                    attributes_key = {
                        "id": key_id,
                        "usage_plan_id": usage_plan_id,
                        "key_id": key_id,
                        "key_type": key_type,
                    }
                    self.hcl.process_resource(
                        "aws_api_gateway_usage_plan_key", f"{usage_plan_id}-{key_id}", attributes_key)


def aws_api_gateway_usage_plan(self):
    print("Processing API Gateway Usage Plans...")

    paginator = self.apigateway_client.get_paginator("get_usage_plans")
    page_iterator = paginator.paginate()

    for page in page_iterator:
        for usage_plan in page["items"]:
            usage_plan_id = usage_plan["id"]
            print(f"  Processing API Gateway Usage Plan: {usage_plan_id}")

            attributes = {
                "id": usage_plan_id,
                "name": usage_plan["name"],
                "description": usage_plan.get("description", ""),
                "api_stages": usage_plan.get("apiStages", []),
                "quota_settings": usage_plan.get("quota", {}),
                "throttle_settings": usage_plan.get("throttle", {}),
            }
            self.hcl.process_resource(
                "aws_api_gateway_usage_plan", usage_plan_id, attributes)


def aws_api_gateway_usage_plan_key(self):
    print("Processing API Gateway Usage Plan Keys...")

    paginator = self.apigateway_client.get_paginator("get_usage_plans")
    page_iterator = paginator.paginate()

    for page in page_iterator:
        for usage_plan in page["items"]:
            usage_plan_id = usage_plan["id"]

            # Process Usage Plan Keys
            paginator_key = self.apigateway_client.get_paginator(
                "get_usage_plan_keys")
            page_iterator_key = paginator_key.paginate(
                usagePlanId=usage_plan_id)

            for page_key in page_iterator_key:
                for usage_plan_key in page_key["items"]:
                    key_id = usage_plan_key["id"]
                    key_type = usage_plan_key["type"]

                    print(f"  Processing API Gateway Usage Plan Key: {key_id}")

                    attributes_key = {
                        "id": key_id,
                        "usage_plan_id": usage_plan_id,
                        "key_id": key_id,
                        "key_type": key_type,
                    }
                    self.hcl.process_resource(
                        "aws_api_gateway_usage_plan_key", f"{usage_plan_id}-{key_id}", attributes_key)


def aws_api_gateway_vpc_link(self):
    print("Processing API Gateway VPC Links...")

    paginator = self.apigateway_client.get_paginator("get_vpc_links")
    page_iterator = paginator.paginate()

    for page in page_iterator:
        for vpc_link in page["items"]:
            vpc_link_id = vpc_link["id"]
            print(f"  Processing API Gateway VPC Link: {vpc_link_id}")

            attributes = {
                "id": vpc_link_id,
                "name": vpc_link["name"],
                "description": vpc_link.get("description", ""),
                "target_arns": vpc_link["targetArns"],
            }
            self.hcl.process_resource(
                "aws_api_gateway_vpc_link", vpc_link_id, attributes)
