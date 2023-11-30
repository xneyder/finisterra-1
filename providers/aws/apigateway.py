import os
from utils.hcl import HCL


def replace_backslashes(value):
    return value.replace("\\", "\\\\") if isinstance(value, str) else value


def escape_quotes(value):
    return value.replace('"', '\\"') if isinstance(value, str) else value


def drop_new_lines(value):
    return value.replace("\n", "") if isinstance(value, str) else value


def process_template(input_dict):
    output = '{\n'
    for key, value in input_dict.items():
        value = value.replace('\n', '\n    ')
        formatted_value = f'<<EOF\n{value}\nEOF'
        output += f'  "{key}" : {formatted_value},\n'
    output = output.rstrip(',\n') + '\n}'
    return output


class Apigateway:
    def __init__(self, apigateway_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.apigateway_client = apigateway_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.aws_account_id = aws_account_id

        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}

    def get_field_from_attrs(self, attributes, arg):
        keys = arg.split(".")
        result = attributes
        for key in keys:
            if isinstance(result, list):
                result = [sub_result.get(key, None) if isinstance(
                    sub_result, dict) else None for sub_result in result]
                if len(result) == 1:
                    result = result[0]
            else:
                result = result.get(key, None)
            if result is None:
                return None
        return result

    def aws_api_gateway_deployment_import_id(self, attributes):
        return f"{attributes['rest_api_id']}/{attributes['id']}"
    
    def get_gateway_method_settings(self, attributes):
        stage_name = attributes['stage_name']
        method_path = attributes['method_path']
        return f"{stage_name}/{method_path}"
    
    def build_api_gateway_method_settings(self, attributes, arg):
        result = {}
        stage_name = attributes['stage_name']
        method_path = attributes['method_path']
        key = f"{stage_name}/{method_path}"
        result[key] = {}
        result[key]['stage_name'] = stage_name
        result[key]['method_path'] = method_path
        settings = attributes.get('settings')
        if settings:
            result[key]['cache_data_encrypted'] = settings[0].get('cache_data_encrypted')
            result[key]['cache_ttl_in_seconds'] = settings[0].get('cache_ttl_in_seconds')
            result[key]['caching_enabled'] = settings[0].get('caching_enabled')
            result[key]['data_trace_enabled'] = settings[0].get('caching_enabled')
            result[key]['logging_level'] = settings[0].get('logging_level')
            result[key]['metrics_enabled'] = settings[0].get('metrics_enabled')
            result[key]['require_authorization_for_cache_control'] = settings[0].get('require_authorization_for_cache_control')
            result[key]['throttling_burst_limit'] = settings[0].get('throttling_burst_limit')
            result[key]['throttling_rate_limit'] = settings[0].get('throttling_rate_limit')
            result[key]['unauthorized_cache_control_header_strategy'] = settings[0].get('unauthorized_cache_control_header_strategy')

        return result
    
    def get_stage_name(self,attributes):
        restApiId=attributes['rest_api_id']
        deploymentId=attributes['id']
        stages=self.apigateway_client.get_stages(restApiId=restApiId, deploymentId=deploymentId)
        return stages['item'][0]['stageName']

    # def build_deployment(self, attributes, arg):
    #     description = attributes.get('description')
    #     #use boto3 to get the stage name of the deployment
    #     stage_name = self.get_stage_name(attributes)
    #     result = {}
    #     result[stage_name] = {}
    #     result[stage_name]['deployment_description'] = description
    #     return result

    def get_stage_name_index(self, attributes):
        stage_name = attributes['stage_name']
        deployment_id = attributes['deployment_id']
        return f"{deployment_id}-{stage_name}"

    def build_stages(self, attributes, arg):
        stage_name = attributes['stage_name']
        deployment_id = attributes['deployment_id']
        result = {}
        if deployment_id not in result:
            result[deployment_id] = {'stages':{}}
        result[deployment_id]['stages'][stage_name] = {}
        result[deployment_id]['stages'][stage_name]['xray_tracing_enabled'] = attributes.get('xray_tracing_enabled')
        result[deployment_id]['stages'][stage_name]['cache_cluster_enabled'] = attributes.get('cache_cluster_enabled')
        tmp = attributes.get('cache_cluster_size')
        if tmp:
            result[deployment_id]['stages'][stage_name]['cache_cluster_size'] = tmp
        tmp = attributes.get('description')
        if tmp:
            result[deployment_id]['stages'][stage_name]['description'] = tmp
        tmp = attributes.get('tags')
        if tmp:
            result[deployment_id]['stages'][stage_name]['tags'] = tmp
        tmp = attributes.get('variables')
        if tmp:
            result[deployment_id]['stages'][stage_name]['variables'] = tmp
        tmp = attributes.get('access_log_settings')
        if tmp:
            result[deployment_id]['stages'][stage_name]['access_log_settings'] = tmp

        return result
    
    def build_deployments(self, attributes, arg):
        deployment_id = attributes['id']
        result = {}
        if deployment_id not in result:
            result[deployment_id] = {}
        result[deployment_id]['description'] = attributes.get('description')
        return result

    def apigateway(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        # aws_api_gateway_deployment.this
        # aws_api_gateway_method_settings.all
        # aws_api_gateway_rest_api.this
        # aws_api_gateway_rest_api_policy.this
        # aws_api_gateway_stage.this
        # aws_api_gateway_vpc_link.this
        # "aws_api_gateway_account" "this"

        # self.aws_api_gateway_account()
        self.aws_api_gateway_rest_api()
        self.aws_api_gateway_vpc_link()
        # self.aws_api_gateway_api_key()
        # self.aws_api_gateway_authorizer()
        # self.aws_api_gateway_base_path_mapping()
        # self.aws_api_gateway_client_certificate()
        # self.aws_api_gateway_deployment()
        # self.aws_api_gateway_documentation_part()
        # self.aws_api_gateway_documentation_version()
        # self.aws_api_gateway_domain_name()
        # self.aws_api_gateway_gateway_response()
        # self.aws_api_gateway_integration()
        # self.aws_api_gateway_integration_response()
        # self.aws_api_gateway_method()
        # self.aws_api_gateway_method_response()
        # self.aws_api_gateway_method_settings()
        # self.aws_api_gateway_model()
        # self.aws_api_gateway_request_validator()
        # self.aws_api_gateway_resource()
        # self.aws_api_gateway_rest_api_policy()
        # self.aws_api_gateway_stage()
        # self.aws_api_gateway_usage_plan()
        # self.aws_api_gateway_usage_plan_key()

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'aws_api_gateway_deployment_import_id': self.aws_api_gateway_deployment_import_id,
            'build_stages': self.build_stages,
            # 'build_deployment': self.build_deployment,
            'get_stage_name': self.get_stage_name,
            'build_deployments': self.build_deployments,
            'get_stage_name_index': self.get_stage_name_index,
            'get_gateway_method_settings': self.get_gateway_method_settings,
            'build_api_gateway_method_settings': self.build_api_gateway_method_settings,
        }

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "apigateway.yaml"), functions, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

    def aws_api_gateway_account(self):
        print("Processing API Gateway Account...")

        account = self.apigateway_client.get_account()

        attributes = {}

        if "cloudwatchRoleArn" in account:
            attributes["cloudwatch_role_arn"] = account["cloudwatchRoleArn"]

        if "throttleSettings" in account:
            if "burstLimit" in account["throttleSettings"]:
                attributes["throttle_settings_burst_limit"] = account["throttleSettings"]["burstLimit"]
            if "rateLimit" in account["throttleSettings"]:
                attributes["throttle_settings_rate_limit"] = account["throttleSettings"]["rateLimit"]

        attributes["id"] = "api_gateway_account"

        self.hcl.process_resource(
            "aws_api_gateway_account", "api_gateway_account", attributes)

    def aws_api_gateway_rest_api(self):
        resource_type = "aws_api_gateway_rest_api"
        print("Processing API Gateway REST APIs...")

        rest_apis = self.apigateway_client.get_rest_apis()["items"]

        # Get the region from the client
        region = self.apigateway_client.meta.region_name

        for rest_api in rest_apis:

            # if rest_api["name"] != "noovie-short-links-stage":
            #     continue

            print(f"  Processing API Gateway REST API: {rest_api['name']}")
            api_id = rest_api["id"]

            # Construct the ARN for the API Gateway REST API
            arn = f"arn:aws:apigateway:{region}::/restapis/{api_id}"

            fstack = ""
            try:
                response = self.apigateway_client.get_tags(resourceArn=arn)
                tags = response.get('tags', {})
                for tag_key, tag_value in tags.items():
                    if tag_key == 'ftstack':
                        fstack = tag_value
                        break
            except Exception as e:
                print("Error occurred: ", e)

            attributes = {
                "id": api_id,
            }

            resource_name = f"{api_id}"
            self.hcl.process_resource(
                resource_type, resource_name, attributes)
            
            self.hcl.add_stack(resource_type, api_id, fstack)


            # self.aws_api_gateway_method(rest_api["id"])
            self.aws_api_gateway_method_settings(rest_api["id"])
            self.aws_api_gateway_rest_api_policy(rest_api["id"])
            self.aws_api_gateway_deployment(rest_api["id"])
            # self.aws_api_gateway_stage(rest_api["id"])

    def aws_api_gateway_deployment(self, rest_api_id):
        print("Processing API Gateway Deployment...")

        # Get deployments for the specified API
        deployments = self.apigateway_client.get_deployments(restApiId=rest_api_id)["items"]

        for deployment in deployments:
            print(f"  Processing Deployment: {deployment['id']}")

            # Process each deployment
            attributes = {
                "id": deployment["id"],
                "rest_api_id": rest_api_id
            }

            if "description" in deployment:
                attributes["description"] = deployment["description"]

            self.hcl.process_resource(
                "aws_api_gateway_deployment", deployment["id"], attributes)

            print(f"Processed API Gateway Deployment: {deployment['id']}")

            self.aws_api_gateway_stage(rest_api_id, deployment['id'])

    # def aws_api_gateway_stage(self, rest_api_id, deployment_id):
    #     print("Processing API Gateway Stages...")

    #     # Filter stages by deployment ID
    #     stages = self.apigateway_client.get_stages(restApiId=rest_api_id)["item"]
    #     filtered_stages = [stage for stage in stages if stage["deploymentId"] == deployment_id]

    #     for stage in filtered_stages:
    #         print(f"  Processing API Gateway Stage: {stage['stageName']} for Deployment ID: {deployment_id}")

    #         stage_detail = self.apigateway_client.get_stage(
    #             restApiId=rest_api_id,
    #             stageName=stage["stageName"]
    #         )

    #         attributes = {
    #             "id": rest_api_id + "/" + stage["stageName"],
    #             "stage_name": stage["stageName"],
    #             "deployment_id": stage["deploymentId"],
    #             "description": stage.get("description", "")
    #         }

    #         resource_name = f"{rest_api_id}-{stage['stageName']}"
    #         self.hcl.process_resource(
    #             "aws_api_gateway_stage", resource_name, attributes)
            
    def aws_api_gateway_stage(self, rest_api_id, deployment_id):
        print("Processing API Gateway Stages...")

        stages = self.apigateway_client.get_stages(
            restApiId=rest_api_id)["item"]
        filtered_stages = [stage for stage in stages if stage["deploymentId"] == deployment_id]

        for stage in filtered_stages:
            print(f"  Processing API Gateway Stage: {stage['stageName']}")

            stage_detail = self.apigateway_client.get_stage(
                restApiId=rest_api_id,
                stageName=stage["stageName"]
            )

            attributes = {
                "id": rest_api_id + "/" + stage["stageName"],
                "rest_api_id": rest_api_id,
                "stage_name": stage["stageName"],
                "deployment_id": stage["deploymentId"],
                "description": stage.get("description", ""),
            }

            resource_name = f"{rest_api_id}-{stage['stageName']}"
            self.hcl.process_resource(
                "aws_api_gateway_stage", resource_name, attributes)            


    def aws_api_gateway_method(self, rest_api_id):
        print("Processing API Gateway Methods...")

        resources = self.apigateway_client.get_resources(
            restApiId=rest_api_id)["items"]

        for resource in resources:
            if "resourceMethods" in resource:
                for method in resource["resourceMethods"]:
                    method_details = self.apigateway_client.get_method(
                        restApiId=rest_api_id, resourceId=resource["id"], httpMethod=method)

                    print(
                        f"  Processing API Gateway Method: {resource['path']} {method}")

                    attributes = {
                        "id": rest_api_id + "/" + resource["id"] + "/" + method,
                        "rest_api_id": rest_api_id,
                        "resource_id": resource["id"],
                        "http_method": method,
                        "authorization": method_details["authorizationType"],
                        "api_key_required": method_details.get("apiKeyRequired", False),
                    }

                    resource_name = f"{rest_api_id}-{resource['id']}-{method}"
                    self.hcl.process_resource(
                        "aws_api_gateway_method", resource_name, attributes)

    def aws_api_gateway_method_settings(self, rest_api_id):
        print("Processing API Gateway Method Settings...")

        stages = self.apigateway_client.get_stages(
            restApiId=rest_api_id)["item"]

        for stage in stages:
            settings = stage["methodSettings"]

            for key, setting in settings.items():
                print(f"  Processing API Gateway Method Setting: {key}")

                attributes = {
                    "id": rest_api_id + "/" + stage["stageName"] + "/" + key,
                    "rest_api_id": rest_api_id,
                    "stage_name": stage["stageName"],
                    "method_path": key,
                    # "settings": setting,
                }

                resource_name = f"{rest_api_id}-{stage['stageName']}-{key}"
                self.hcl.process_resource(
                    "aws_api_gateway_method_settings", resource_name, attributes)

    def aws_api_gateway_rest_api_policy(self, rest_api_id):
        print("Processing API Gateway REST API Policies...")

        rest_api = self.apigateway_client.get_rest_api(
            restApiId=rest_api_id)

        policy = rest_api.get("policy", None)

        if policy:
            print(
                f"  Processing API Gateway REST API Policy for {rest_api['name']}")

            attributes = {
                "id": rest_api_id,
                "rest_api_id": rest_api_id,
                # "policy": policy,
            }

            resource_name = f"{rest_api_id}-policy"
            self.hcl.process_resource(
                "aws_api_gateway_rest_api_policy", resource_name, attributes)


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

    # def aws_api_gateway_api_key(self):
    #     print("Processing API Gateway API Keys...")

    #     paginator = self.apigateway_client.get_paginator("get_api_keys")
    #     page_iterator = paginator.paginate()

    #     for page in page_iterator:
    #         for api_key in page["items"]:
    #             print(f"  Processing API Gateway API Key: {api_key['id']}")

    #             attributes = {
    #                 "id": api_key["id"],
    #                 "name": api_key["name"],
    #             }

    #             if "description" in api_key:
    #                 attributes["description"] = api_key["description"]

    #             if "enabled" in api_key:
    #                 attributes["enabled"] = api_key["enabled"]

    #             self.hcl.process_resource(
    #                 "aws_api_gateway_api_key", api_key["id"], attributes)

    # def aws_api_gateway_authorizer(self):
    #     print("Processing API Gateway Authorizers...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         authorizers = self.apigateway_client.get_authorizers(
    #             restApiId=rest_api["id"])["items"]

    #         for authorizer in authorizers:
    #             authorizer_id = authorizer['id']
    #             print(f"  Processing API Gateway Authorizer: {authorizer_id}")

    #             attributes = {
    #                 "id": authorizer_id,
    #                 "rest_api_id": rest_api["id"],
    #                 # "name": authorizer["name"],
    #                 # "type": authorizer["type"],
    #             }

    #             # if "authorizerUri" in authorizer:
    #             #     attributes["authorizer_uri"] = authorizer["authorizerUri"]

    #             # if "authorizerCredentials" in authorizer:
    #             #     attributes["authorizer_credentials"] = authorizer["authorizerCredentials"]

    #             # if "identitySource" in authorizer:
    #             #     attributes["identity_source"] = authorizer["identitySource"]

    #             self.hcl.process_resource(
    #                 "aws_api_gateway_authorizer", authorizer_id, attributes)

    # def aws_api_gateway_base_path_mapping(self):
    #     print("Processing API Gateway Base Path Mappings...")

    #     domain_names = self.apigateway_client.get_domain_names()["items"]

    #     for domain_name in domain_names:
    #         base_path_mappings = self.apigateway_client.get_base_path_mappings(
    #             domainName=domain_name["domainName"])["items"]

    #         for base_path_mapping in base_path_mappings:
    #             print(
    #                 f"  Processing API Gateway Base Path Mapping: {base_path_mapping['basePath']}")

    #             attributes = {
    #                 "id": f"{domain_name['domainName']}/{base_path_mapping['basePath']}",
    #                 "domain_name": domain_name["domainName"],
    #                 "rest_api_id": base_path_mapping["restApiId"],
    #                 "stage": base_path_mapping["stage"],
    #             }

    #             if "basePath" in base_path_mapping:
    #                 attributes["base_path"] = base_path_mapping["basePath"]

    #             self.hcl.process_resource(
    #                 "aws_api_gateway_base_path_mapping", attributes["id"], attributes)

    # def aws_api_gateway_client_certificate(self):
    #     print("Processing API Gateway Client Certificates...")

    #     client_certificates = self.apigateway_client.get_client_certificates()[
    #         "items"]

    #     for client_certificate in client_certificates:
    #         print(
    #             f"  Processing API Gateway Client Certificate: {client_certificate['clientCertificateId']}")

    #         attributes = {
    #             "id": client_certificate['clientCertificateId'],
    #             "description": client_certificate["description"],
    #         }

    #         self.hcl.process_resource("aws_api_gateway_client_certificate",
    #                                   client_certificate["clientCertificateId"], attributes)

    # def aws_api_gateway_documentation_part(self):
    #     print("Processing API Gateway Documentation Parts...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         documentation_parts = self.apigateway_client.get_documentation_parts(
    #             restApiId=rest_api["id"])["items"]

    #         for documentation_part in documentation_parts:
    #             print(
    #                 f"  Processing API Gateway Documentation Part: {documentation_part['id']}")

    #             attributes = {
    #                 "id": rest_api["id"]+"/"+documentation_part['id'],
    #                 # "location": documentation_part["location"],
    #                 # "properties": documentation_part["properties"],
    #             }

    #             self.hcl.process_resource(
    #                 "aws_api_gateway_documentation_part", documentation_part["id"], attributes)

    # def aws_api_gateway_documentation_version(self):
    #     print("Processing API Gateway Documentation Versions...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         documentation_versions = self.apigateway_client.get_documentation_versions(
    #             restApiId=rest_api["id"])["items"]

    #         for documentation_version in documentation_versions:
    #             print(
    #                 f"  Processing API Gateway Documentation Version: {documentation_version['version']}")

    #             attributes = {
    #                 "id": rest_api["id"],
    #                 "version": documentation_version["version"],
    #                 "description": documentation_version["description"],
    #             }

    #             self.hcl.process_resource(
    #                 "aws_api_gateway_documentation_version", documentation_version["version"], attributes)

    # def aws_api_gateway_domain_name(self):
    #     print("Processing API Gateway Domain Names...")

    #     domain_names = self.apigateway_client.get_domain_names()["items"]

    #     for domain_name in domain_names:
    #         print(
    #             f"  Processing API Gateway Domain Name: {domain_name['domainName']}")

    #         attributes = {
    #             "id": domain_name["domainName"],
    #             "domain_name": domain_name["domainName"],
    #             "certificate_arn": domain_name.get("certificateArn", ""),
    #             "security_policy": domain_name.get("securityPolicy", ""),
    #         }

    #         self.hcl.process_resource(
    #             "aws_api_gateway_domain_name", domain_name["domainName"], attributes)

    # def aws_api_gateway_gateway_response(self):
    #     print("Processing API Gateway Gateway Responses...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         gateway_responses = self.apigateway_client.get_gateway_responses(
    #             restApiId=rest_api["id"])["items"]

    #         for gateway_response in gateway_responses:
    #             print(
    #                 f"  Processing API Gateway Gateway Response: {gateway_response['responseType']}")

    #             attributes = {
    #                 "id": rest_api["id"]+"/" + gateway_response["responseType"],
    #                 "rest_api_id": rest_api["id"],
    #                 "response_type": gateway_response["responseType"],
    #                 # "status_code": gateway_response.get("statusCode", ""),
    #                 # "response_parameters": gateway_response.get("responseParameters", {}),
    #                 # "response_templates": gateway_response.get("responseTemplates", {}),
    #             }

    #             resource_name = f"{rest_api['id']}-{gateway_response['responseType']}"
    #             self.hcl.process_resource(
    #                 "aws_api_gateway_gateway_response", resource_name, attributes)

    # def aws_api_gateway_integration(self):
    #     print("Processing API Gateway Integrations...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         resources = self.apigateway_client.get_resources(
    #             restApiId=rest_api["id"])["items"]

    #         for resource in resources:
    #             if "resourceMethods" in resource:
    #                 for method in resource["resourceMethods"]:
    #                     integration = self.apigateway_client.get_integration(
    #                         restApiId=rest_api["id"], resourceId=resource["id"], httpMethod=method)

    #                     print(
    #                         f"  Processing API Gateway Integration: {resource['path']} {method}")

    #                     attributes = {
    #                         "id": rest_api["id"]+"/"+resource["id"]+"/"+method,
    #                         "rest_api_id": rest_api["id"],
    #                         "resource_id": resource["id"],
    #                         "http_method": method,
    #                         "type": integration["type"],
    #                         "uri": integration.get("uri", ""),
    #                         "integration_http_method": integration.get("httpMethod", ""),
    #                     }

    #                     resource_name = f"{rest_api['id']}-{resource['id']}-{method}"
    #                     self.hcl.process_resource(
    #                         "aws_api_gateway_integration", resource_name, attributes)

    # def aws_api_gateway_integration_response(self):
    #     print("Processing API Gateway Integration Responses...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         resources = self.apigateway_client.get_resources(
    #             restApiId=rest_api["id"])["items"]

    #         for resource in resources:
    #             if "resourceMethods" in resource:
    #                 for method in resource["resourceMethods"]:
    #                     integration = self.apigateway_client.get_integration(
    #                         restApiId=rest_api["id"], resourceId=resource["id"], httpMethod=method)

    #                     for status_code in integration["integrationResponses"]:
    #                         integration_response = integration["integrationResponses"][status_code]

    #                         print(
    #                             f"  Processing API Gateway Integration Response: {resource['path']} {method} {status_code}")

    #                         attributes = {
    #                             "id": rest_api["id"]+"/"+resource["id"]+"/"+method+"/"+status_code,
    #                             "rest_api_id": rest_api["id"],
    #                             "resource_id": resource["id"],
    #                             "http_method": method,
    #                             "status_code": status_code,
    #                             "response_parameters": integration_response.get("responseParameters", {}),
    #                             "response_templates": integration_response.get("responseTemplates", {}),
    #                         }

    #                         resource_name = f"{rest_api['id']}-{resource['id']}-{method}-{status_code}"
    #                         self.hcl.process_resource(
    #                             "aws_api_gateway_integration_response", resource_name, attributes)

    # def aws_api_gateway_method_response(self):
    #     print("Processing API Gateway Method Responses...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         resources = self.apigateway_client.get_resources(
    #             restApiId=rest_api["id"])["items"]

    #         for resource in resources:
    #             if "resourceMethods" in resource:
    #                 for method in resource["resourceMethods"]:
    #                     method_details = self.apigateway_client.get_method(
    #                         restApiId=rest_api["id"], resourceId=resource["id"], httpMethod=method)

    #                     for status_code in method_details["methodResponses"]:
    #                         method_response = method_details["methodResponses"][status_code]

    #                         print(
    #                             f"  Processing API Gateway Method Response: {resource['path']} {method} {status_code}")

    #                         attributes = {
    #                             "id": rest_api["id"]+"/"+resource["id"]+"/"+method+"/"+status_code,
    #                             "rest_api_id": rest_api["id"],
    #                             "resource_id": resource["id"],
    #                             "http_method": method,
    #                             "status_code": status_code,
    #                             "response_models": method_response.get("responseModels", {}),
    #                             "response_parameters": method_response.get("responseParameters", {}),
    #                         }

    #                         resource_name = f"{rest_api['id']}-{resource['id']}-{method}-{status_code}"
    #                         self.hcl.process_resource(
    #                             "aws_api_gateway_method_response", resource_name, attributes)

    # def aws_api_gateway_model(self):
    #     print("Processing API Gateway Models...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         models = self.apigateway_client.get_models(
    #             restApiId=rest_api["id"])["items"]

    #         for model in models:
    #             print(f"  Processing API Gateway Model: {model['name']}")

    #             attributes = {
    #                 "id": rest_api["id"]+"/"+model["name"],
    #                 "rest_api_id": rest_api["id"],
    #                 "name": model["name"],
    #                 "content_type": model["contentType"],
    #                 "description": model.get("description", ""),
    #                 "schema": model.get("schema", ""),
    #             }

    #             resource_name = f"{rest_api['id']}-{model['name']}"
    #             self.hcl.process_resource(
    #                 "aws_api_gateway_model", resource_name, attributes)

    # def aws_api_gateway_request_validator(self):
    #     print("Processing API Gateway Request Validators...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         validators = self.apigateway_client.get_request_validators(
    #             restApiId=rest_api["id"])["items"]

    #         for validator in validators:
    #             print(
    #                 f"  Processing API Gateway Request Validator: {validator['name']}")

    #             attributes = {
    #                 "id": rest_api["id"]+"/"+validator["name"],
    #                 "rest_api_id": rest_api["id"],
    #                 "name": validator["name"],
    #                 "validate_request_body": validator["validateRequestBody"],
    #                 "validate_request_parameters": validator["validateRequestParameters"],
    #             }

    #             resource_name = f"{rest_api['id']}-{validator['name']}"
    #             self.hcl.process_resource(
    #                 "aws_api_gateway_request_validator", resource_name, attributes)

    # def aws_api_gateway_resource(self):
    #     print("Processing API Gateway Resources...")

    #     rest_apis = self.apigateway_client.get_rest_apis()["items"]

    #     for rest_api in rest_apis:
    #         resources = self.apigateway_client.get_resources(
    #             restApiId=rest_api["id"])["items"]

    #         for resource in resources:
    #             # Skip the root resource
    #             if "parentId" not in resource:
    #                 continue

    #             print(f"  Processing API Gateway Resource: {resource['path']}")

    #             attributes = {
    #                 "id": resource["id"],
    #                 "rest_api_id": rest_api["id"],
    #                 "parent_id": resource.get("parentId"),
    #                 "path_part": resource.get("pathPart"),
    #             }

    #             resource_name = f"{rest_api['id']}-{resource['path'].replace('/', '-')}"
    #             self.hcl.process_resource(
    #                 "aws_api_gateway_resource", resource_name, attributes)

    # def aws_api_gateway_usage_plan_key(self):
    #     print("Processing API Gateway Usage Plans and Usage Plan Keys...")

    #     paginator = self.apigateway_client.get_paginator("get_usage_plans")
    #     page_iterator = paginator.paginate()

    #     for page in page_iterator:
    #         for usage_plan in page["items"]:
    #             usage_plan_id = usage_plan["id"]

    #             # Process Usage Plan Keys
    #             paginator_key = self.apigateway_client.get_paginator(
    #                 "get_usage_plan_keys")
    #             page_iterator_key = paginator_key.paginate(
    #                 usagePlanId=usage_plan_id)

    #             for page_key in page_iterator_key:
    #                 for usage_plan_key in page_key["items"]:
    #                     key_id = usage_plan_key["id"]
    #                     key_type = usage_plan_key["type"]

    #                     print(
    #                         f"    Processing API Gateway Usage Plan Key: {key_id}")

    #                     attributes_key = {
    #                         "id": usage_plan_id+"/"+key_id,
    #                         "usage_plan_id": usage_plan_id,
    #                         "key_id": key_id,
    #                         "key_type": key_type,
    #                     }
    #                     self.hcl.process_resource(
    #                         "aws_api_gateway_usage_plan_key", f"{usage_plan_id}-{key_id}", attributes_key)

    # def aws_api_gateway_usage_plan(self):
    #     print("Processing API Gateway Usage Plans...")

    #     paginator = self.apigateway_client.get_paginator("get_usage_plans")
    #     page_iterator = paginator.paginate()

    #     for page in page_iterator:
    #         for usage_plan in page["items"]:
    #             usage_plan_id = usage_plan["id"]
    #             print(f"  Processing API Gateway Usage Plan: {usage_plan_id}")

    #             attributes = {
    #                 "id": usage_plan_id,
    #                 "name": usage_plan["name"],
    #                 "description": usage_plan.get("description", ""),
    #                 "api_stages": usage_plan.get("apiStages", []),
    #                 "quota_settings": usage_plan.get("quota", {}),
    #                 "throttle_settings": usage_plan.get("throttle", {}),
    #             }
    #             self.hcl.process_resource(
    #                 "aws_api_gateway_usage_plan", usage_plan_id, attributes)

    # def aws_api_gateway_usage_plan_key(self):
    #     print("Processing API Gateway Usage Plan Keys...")

    #     paginator = self.apigateway_client.get_paginator("get_usage_plans")
    #     page_iterator = paginator.paginate()

    #     for page in page_iterator:
    #         for usage_plan in page["items"]:
    #             usage_plan_id = usage_plan["id"]

    #             # Process Usage Plan Keys
    #             paginator_key = self.apigateway_client.get_paginator(
    #                 "get_usage_plan_keys")
    #             page_iterator_key = paginator_key.paginate(
    #                 usagePlanId=usage_plan_id)

    #             for page_key in page_iterator_key:
    #                 for usage_plan_key in page_key["items"]:
    #                     key_id = usage_plan_key["id"]
    #                     key_type = usage_plan_key["type"]

    #                     print(
    #                         f"  Processing API Gateway Usage Plan Key: {key_id}")

    #                     attributes_key = {
    #                         "id": key_id,
    #                         "usage_plan_id": usage_plan_id,
    #                         "key_id": key_id,
    #                         "key_type": key_type,
    #                     }
    #                     self.hcl.process_resource(
    #                         "aws_api_gateway_usage_plan_key", f"{usage_plan_id}-{key_id}", attributes_key)
