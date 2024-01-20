import json
import hashlib
import copy

### UTIL ###
def get_module_additional_data(module_name, id, additional_data):
    if module_name not in additional_data:
        return None
    if id not in additional_data[module_name]:
        return None
    return additional_data[module_name][id]


#### IAM ####

def get_policy_attachment_index(attributes, arg=None, additional_data=None):
    role = attributes.get('role')
    policy_name = attributes.get('policy_arn').split('/')[-1]
    return role+"_"+policy_name

def get_inline_policies(attributes, arg=None, additional_data=None):
    # convert data_dict to str
    inline_policy = attributes.get("inline_policy")
    for policy in inline_policy:
        policy_str = json.dumps(policy["policy"])
        policy_str = policy_str.replace('${', '$${')
        policy["policy"] = json.loads(policy_str)
    return inline_policy

def get_instance_profiles(attributes, arg=None, additional_data=None):
    name = attributes.get("name")
    tags = attributes.get("tags")
    result=[{"name":name, "tags": tags}]
    path = attributes.get("path")
    if path != "/":
        result[0]["path"] = path
    return result

def get_policy_documents(attributes, arg=None, additional_data=None):
    # convert data_dict to str
    policy_documents = attributes.get("policy")
    policy_documents_dict = json.loads(policy_documents)
    #check if policy_documents_dict["Statement"] is a list
    if not isinstance(policy_documents_dict["Statement"], list):
        policy_documents_dict["Statement"] = [policy_documents_dict["Statement"]]
    #use policy_documents_dict for result
    result = json.dumps(policy_documents_dict)
    result = result.replace('${', '$${')
    # convert data_str back to dict
    return result

def iam_get_managed_policy_arns(attributes, arg=None, additional_data=None):
    policy_arns = attributes.get("managed_policy_arns")
    result= {}
    for policy_arn in policy_arns:
        policy_name = policy_arn.split('/')[-1]
        result[policy_name] = policy_arn
    return result

#### SECURITY GROUP ####

def get_security_group_rules(attributes, arg=None, additional_data=None):
    key = attributes["id"]
    result = {key: {}}
    for k in attributes.keys():
        if k not in ["from_port","to_port","ip_protocol","description","cidr_ipv4","cidr_ipv6","prefix_list_id","referenced_security_group_id","tags"]:
            continue
        val = attributes.get(k)
        if not val and val!=0:
            continue
        if k == "referenced_security_group_id":
            security_group_id = attributes.get("security_group_id")
            if security_group_id == val:
                result[key][k] = "self"
                continue
        result[key][k] = val
    return result

def get_vpc_id(attributes, arg=None, additional_data=None):
    vpc_name = get_vpc_name(attributes, arg, additional_data)
    if vpc_name is None:
        return attributes.get(arg)
    return ""

def get_vpc_name(attributes, arg=None, additional_data=None):
    vpc_name = None
    vpc_id = attributes.get(arg)
    if 'vpc' in additional_data:
        vpc_data = additional_data['vpc'].get(vpc_id)
        if vpc_data:
            vpc_name = vpc_data.get("name")
    return vpc_name

### KMS ###

def build_aliases(attributes, arg=None, additional_data=None):
    name = attributes.get(arg)
    return [name]

def build_grants(attributes, arg=None, additional_data=None):
    key = attributes.get("id")
    #hash the key and get the last 8 chars
    # key = hashlib.sha256(key.encode()).hexdigest()[:8]
    # key = "grant_"+key
    
    result = {key: {}}
    name = attributes.get("name")
    grantee_principal = attributes.get("grantee_principal")
    operations = attributes.get("operations")
    constraints = attributes.get("constraints")
    retiring_principal = attributes.get("retiring_principal")
    grant_creation_tokens = attributes.get("grant_creation_tokens")
    retire_on_delete = attributes.get("retire_on_delete")
    result[key]["name"] = name
    result[key]["grantee_principal"] = grantee_principal
    result[key]["operations"] = operations
    result[key]["constraints"] = constraints
    result[key]["retiring_principal"] = retiring_principal
    result[key]["grant_creation_tokens"] = grant_creation_tokens
    result[key]["retire_on_delete"] = retire_on_delete
    return result

### CODEARTIFACT ###
def codeartifact_build_repositories(attributes, arg=None, additional_data=None):
    result = {}
    repository = attributes.get("repository")
    result[repository] = {}
    description = attributes.get("description")
    if description:
        result[repository]["description"] = description
    external_connections = attributes.get("external_connections")
    if external_connections:
        result[repository]["external_connections"] = external_connections
    upstreams = attributes.get("upstreams")
    if upstreams:
        result[repository]["upstreams"] = upstreams
    tags = attributes.get("tags")
    if tags:
        result[repository]["tags"] = tags

    return result

def codeartifact_build_repositories_policy(attributes, arg=None, additional_data=None):
    result = {}
    repository = attributes.get("repository")
    result[repository] = {}
    policy_document = attributes.get("policy_document")
    if policy_document:
        result[repository]["policy_document"] = policy_document

    return result

def code_artifact_get_encryption_key_alias(attributes, arg=None, additional_data=None):
    id = attributes.get("id")
    instance_data = get_module_additional_data("codeartifact", id, additional_data)
    alias = ""
    if instance_data:
        alias = instance_data.get("kms_key_alias","")
    return alias
        
def code_artifact_get_encryption_key(attributes, arg=None, additional_data=None):
    kms_key_id = attributes.get("encryption_key")
    alias = code_artifact_get_encryption_key_alias(attributes, arg, additional_data)
    if alias:
        return ""
    return kms_key_id


### ACM ###
def get_field_from_attrs(attributes, arg=None, additional_data=None):
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

def acm_get_validation_method(attributes, arg=None, additional_data=None):
    validation_method = attributes.get("validation_method", None)
    if validation_method == "NONE":
        return None
    return validation_method


### ELBV2 ###
def get_listeners_elbv2(attributes, arg=None, additional_data=None):
    port=attributes.get('port')
    listener = {
        'port': port,
        'protocol': attributes.get('protocol'),
        'ssl_policy': attributes.get('ssl_policy'),
        'certificate_arn': attributes.get('certificate_arn'),
        'default_action': attributes.get('default_action'),
        'tags': attributes.get('tags'),
    }

    return {port: listener}

def get_port_elbv2(attributes, arg=None, additional_data=None):
    return str(attributes.get('port'))

# def get_listener_certificate_elbv2(attributes, arg=None, additional_data=None):
#     listener_arn = attributes.get('listener_arn')
#     # Get the port of the listener
#     response_listener = self.aws_clients.elbv2_client.describe_listeners(
#         ListenerArns=[listener_arn]
#     )
#     listener_port = response_listener['Listeners'][0]['Port']

#     certificate_arn = attributes.get('certificate_arn')
#     if certificate_arn:
#         # Get the domain name for the certificate
#         response = self.aws_clients.acm_client.describe_certificate(
#             CertificateArn=certificate_arn)

#     return self.listeners

# def get_port_domain_name_elbv2(attributes, arg=None, additional_data=None):
#     listener_arn = attributes.get('listener_arn')

#     # Get the port of the listener
#     response_listener = self.aws_clients.elbv2_client.describe_listeners(
#         ListenerArns=[listener_arn]
#     )
#     listener_port = response_listener['Listeners'][0]['Port']

#     domain_name = ""
#     if attributes.get('certificate_arn'):
#         # Use the ACM client
#         response = self.aws_clients.acm_client.describe_certificate(
#             CertificateArn=attributes.get('certificate_arn')
#         )
#         domain_name = response['Certificate']['DomainName']

#     # Return in the format 'port-domain_name'
#     return f"{listener_port}-{domain_name}"

def get_subnet_names_elbv2(attributes, arg=None, additional_data=None):
    id = attributes.get('id')
    instance_data = get_module_additional_data("aws_lb", id, additional_data)
    return instance_data.get("subnet_names", [])

def get_subnet_ids_elbv2(attributes, arg=None, additional_data=None):
    subnet_names = get_subnet_names_elbv2(attributes, arg, additional_data)
    if subnet_names:
        return ""
    else:
        return attributes.get(arg)

def get_vpc_name_elbv2(attributes, arg=None, additional_data=None):
    id = attributes.get('id')
    instance_data = get_module_additional_data("aws_lb", id, additional_data)
    return instance_data.get("vpc_name", "")

def get_vpc_id_elbv2(attributes, arg=None, additional_data=None):
    vpc_name = get_vpc_name_elbv2(attributes, arg, additional_data)
    if vpc_name is None:
        return attributes.get(arg)
    else:
        return ""

### APIGATEWAY ###
def apigateway_build_resources(attributes, arg=None, additional_data=None):
    result = {}
    path = attributes.get('path')
    path_part= attributes.get('path_part')
    parent_path_part = path.replace(path_part, '')

    if parent_path_part != '/':
        parent_path_part = parent_path_part.rstrip('/')

    result[path] = {}
    result[path]['path_part'] = path_part
    result[path]['parent_path_part'] = parent_path_part

    #calculate the depth by looking at the number of slashes in the path
    if path == '/':
        depth = 0
    else:
        depth = path.count('/')
    result[path]['depth'] = depth

    return result

def apigateway_build_methods(attributes, arg=None, additional_data=None):
    result = {}
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    http_method = attributes.get('http_method')
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')
    # path = self.aws_clients.apigateway_client.get_resource(restApiId=rest_api_id, resourceId=resource_id)['path']
    result[path] = {'methods':{}}
    result[path]['methods'][http_method] = {}
    result[path]['methods'][http_method]['authorization'] = attributes.get('authorization')
    result[path]['methods'][http_method]['authorizer_id'] = attributes.get('authorizer_id')
    result[path]['methods'][http_method]['authorization_scopes'] = attributes.get('authorization_scopes')
    result[path]['methods'][http_method]['api_key_required'] = attributes.get('api_key_required')
    result[path]['methods'][http_method]['operation_name'] = attributes.get('operation_name')
    result[path]['methods'][http_method]['request_models'] = attributes.get('request_models')
    result[path]['methods'][http_method]['request_validator_id'] = attributes.get('request_validator_id')
    result[path]['methods'][http_method]['request_parameters'] = attributes.get('request_parameters')

    return result

def apigateway_build_integrations(attributes, arg=None, additional_data=None):
    result = {}
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    http_method = attributes.get('http_method')
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')
    result[path] = {'methods':{}}
    result[path]['methods'][http_method] = {"integration":{}}
    result[path]['methods'][http_method]['integration']['integration_http_method'] = attributes.get('integration_http_method')
    result[path]['methods'][http_method]['integration']['type'] = attributes.get('type')
    result[path]['methods'][http_method]['integration']['connection_type'] = attributes.get('connection_type')
    result[path]['methods'][http_method]['integration']['connection_id'] = attributes.get('connection_id')
    result[path]['methods'][http_method]['integration']['uri'] = attributes.get('uri')
    result[path]['methods'][http_method]['integration']['credentials'] = attributes.get('credentials')
    result[path]['methods'][http_method]['integration']['request_templates'] = attributes.get('request_templates')
    result[path]['methods'][http_method]['integration']['request_parameters'] = attributes.get('request_parameters')
    result[path]['methods'][http_method]['integration']['passthrough_behavior'] = attributes.get('passthrough_behavior')
    result[path]['methods'][http_method]['integration']['cache_key_parameters'] = attributes.get('cache_key_parameters')
    result[path]['methods'][http_method]['integration']['cache_namespace'] = attributes.get('cache_namespace')
    result[path]['methods'][http_method]['integration']['content_handling'] = attributes.get('content_handling')
    result[path]['methods'][http_method]['integration']['timeout_milliseconds'] = attributes.get('timeout_milliseconds')
    result[path]['methods'][http_method]['integration']['tls_config'] = attributes.get('tls_config')

    return result
    

def apigateway_build_method_responses(attributes, arg=None, additional_data=None):
    result = {}
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    http_method = attributes.get('http_method')
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')
    result[path] = {'methods':{}}
    result[path]['methods'][http_method] = {"method_responses":{}}
    result[path]['methods'][http_method]['method_responses'][attributes.get('status_code')]={}
    result[path]['methods'][http_method]['method_responses'][attributes.get('status_code')]['response_models'] = attributes.get('response_models')
    result[path]['methods'][http_method]['method_responses'][attributes.get('status_code')]['response_parameters'] = attributes.get('response_parameters')

    return result

def apigateway_build_integration_responses(attributes, arg=None, additional_data=None):
    result = {}
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    http_method = attributes.get('http_method')
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')
    result[path] = {'methods':{}}
    result[path]['methods'][http_method] = {"integration":{}}
    result[path]['methods'][http_method]['integration']['responses'] = {}
    result[path]['methods'][http_method]['integration']['responses'][attributes.get('status_code')]={}
    result[path]['methods'][http_method]['integration']['responses'][attributes.get('status_code')]['response_templates'] = attributes.get('response_templates')
    result[path]['methods'][http_method]['integration']['responses'][attributes.get('status_code')]['response_parameters'] = attributes.get('response_parameters')
    result[path]['methods'][http_method]['integration']['responses'][attributes.get('status_code')]['content_handling'] = attributes.get('content_handling')
    result[path]['methods'][http_method]['integration']['responses'][attributes.get('status_code')]['selection_pattern'] = attributes.get('selection_pattern')

    return result

def apigateway_target_resource_name(attributes, arg=None, additional_data=None):
    path = attributes.get('path')
    if path == '/':
        depth = 0
    else:
        depth = path.count('/')
    
    return "depth_"+str(depth)

def apigateway_target_method_name(attributes, arg=None, additional_data=None):
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    #get path for resource
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')
    # path = self.aws_clients.apigateway_client.get_resource(restApiId=rest_api_id, resourceId=resource_id)['path']
    if path == '/':
        depth = 0
    else:
        depth = path.count('/')
    
    return "depth_"+str(depth)

def apigateway_target_integration_name(attributes, arg=None, additional_data=None):
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    #get path for resource
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')
    # path = self.aws_clients.apigateway_client.get_resource(restApiId=rest_api_id, resourceId=resource_id)['path']
    if path == '/':
        depth = 0
    else:
        depth = path.count('/')
    
    return "depth_"+str(depth)

def apigateway_method_index(attributes, arg=None, additional_data=None):
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    #Get the resource path
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')

    # path = self.aws_clients.apigateway_client.get_resource(restApiId=rest_api_id, resourceId=resource_id)['path']
    http_method = attributes.get('http_method')
    return f"{path}/{http_method}"

def apigateway_integration_index(attributes, arg=None, additional_data=None):
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    #Get the resource path
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')

    # path = self.aws_clients.apigateway_client.get_resource(restApiId=rest_api_id, resourceId=resource_id)['path']
    http_method = attributes.get('http_method')
    return f"{path}/{http_method}"

def apigateway_method_response_index(attributes, arg=None, additional_data=None):
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')
    #Get the resource path
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')

    # path = self.aws_clients.apigateway_client.get_resource(restApiId=rest_api_id, resourceId=resource_id)['path']
    http_method = attributes.get('http_method')
    return f"{path}/{http_method}/{attributes.get('status_code')}"

def apigateway_integration_response_index(attributes):
    # rest_api_id = attributes.get('rest_api_id')
    resource_id = attributes.get('resource_id')        
    #Get the resource path
    instance_data = get_module_additional_data("aws_api_gateway_resource", resource_id, additional_data)
    path = instance_data.get('path')

    # path = self.aws_clients.apigateway_client.get_resource(restApiId=rest_api_id, resourceId=resource_id)['path']
    http_method = attributes.get('http_method')
    return f"{path}/{http_method}/{attributes.get('status_code')}"


def apigateway_deployment_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes['rest_api_id']}/{attributes['id']}"

def apigateway_resource_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes['rest_api_id']}/{attributes['id']}"

def apigateway_method_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes['rest_api_id']}/{attributes['resource_id']}/{attributes['http_method']}"

def apigateway_integration_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes['rest_api_id']}/{attributes['resource_id']}/{attributes['http_method']}"

def apigateway_method_response_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes['rest_api_id']}/{attributes['resource_id']}/{attributes['http_method']}/{attributes['status_code']}"

def apigateway_integration_response_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes['rest_api_id']}/{attributes['resource_id']}/{attributes['http_method']}/{attributes['status_code']}"

def apigateway_gateway_response_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes['rest_api_id']}/{attributes['response_type']}"

def apigateway_model_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes['rest_api_id']}/{attributes['name']}"

def apigateway_build_models(attributes, arg=None, additional_data=None):
    result = {}
    name = attributes.get('name')
    result[name] = {}
    result[name]['content_type'] = attributes.get('content_type')
    result[name]['description'] = attributes.get('description')
    result[name]['schema'] = attributes.get('schema')

    return result


def apigateway_build_gateway_responses(attributes, arg=None, additional_data=None):
    result = {}
    response_type = attributes.get('response_type')
    result[response_type] = {}
    result[response_type]['status_code'] = attributes.get('status_code')
    result[response_type]['response_templates'] = attributes.get('response_templates')
    result[response_type]['response_parameters'] = attributes.get('response_parameters')

    return result


def apigateway_get_method_settings(attributes, arg=None, additional_data=None):
    stage_name = attributes['stage_name']
    method_path = attributes['method_path']
    return f"{stage_name}/{method_path}"

def apigateway_build_method_settings(attributes, arg=None, additional_data=None):
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
        result[key]['data_trace_enabled'] = settings[0].get('data_trace_enabled')
        result[key]['logging_level'] = settings[0].get('logging_level')
        result[key]['metrics_enabled'] = settings[0].get('metrics_enabled')
        result[key]['require_authorization_for_cache_control'] = settings[0].get('require_authorization_for_cache_control')
        result[key]['throttling_burst_limit'] = settings[0].get('throttling_burst_limit')
        result[key]['throttling_rate_limit'] = settings[0].get('throttling_rate_limit')
        result[key]['unauthorized_cache_control_header_strategy'] = settings[0].get('unauthorized_cache_control_header_strategy')

    return result

def apigateway_get_stage_name_index(attributes, arg=None, additional_data=None):
    stage_name = attributes['stage_name']
    deployment_id = attributes['deployment_id']
    return f"{deployment_id}-{stage_name}"

def apigateway_build_stages(attributes, arg=None, additional_data=None):
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

def apigateway_build_deployments(attributes, arg=None, additional_data=None):
    deployment_id = attributes['id']
    result = {}
    if deployment_id not in result:
        result[deployment_id] = {}
    result[deployment_id]['description'] = attributes.get('description')
    return result    

### CLOUDFRONT ###
def cloudfront_build_origin(attributes, arg=None, additional_data=None):
    # Create a deep copy of the attributes to avoid modifying the original
    attributes_copy = copy.deepcopy(attributes)
    origin_list = attributes_copy.get("origin", [])
    result = {}

    for origin in origin_list:
        origin_key = origin['origin_id']

        # Remove empty fields and convert lists to their first item
        transformed_origin = {}
        for k, v in origin.items():
            if v:  # check if the value is not empty
                if k in ("custom_header"):
                    transformed_origin[k] = v
                elif isinstance(v, list):
                    transformed_origin[k] = v[0]
                else:
                    transformed_origin[k] = v

        result[origin_key] = transformed_origin

    return result


def cloudfront_build_default_cache_behavior(attributes, arg=None, additional_data=None):
    default_cache_behavior = attributes.get("default_cache_behavior", [])
    result = {}
    if not default_cache_behavior:
        return result
    instance_data = get_module_additional_data("aws_cloudfront_distribution", "managed_policies", additional_data)
    for k, v in default_cache_behavior[0].items():
        if v:  # check if the value is not empty
            if k == "cache_policy_id":
                cache_policy_name = instance_data.get(v, "")
                if cache_policy_name:
                    result["cache_policy_name"] = cache_policy_name
                else:
                    result[k] = v
                continue
            if k == "lambda_function_association":
                assoc_result = {}
                for association in v:
                    assoc_key = association['event_type']
                    assoc_result[assoc_key] = {}
                    assoc_result[assoc_key]['lambda_arn'] = association['lambda_arn']
                    assoc_result[assoc_key]['include_body'] = association['include_body']
                result[k] = assoc_result
                continue

            if k == "function_association":
                assoc_result = {}
                for association in v:
                    assoc_key = association['event_type']
                    assoc_result[assoc_key] = {}
                    assoc_result[assoc_key]['function_arn'] = association['function_arn']
                result[k] = assoc_result
                continue

            if k == "forwarded_values":
                for forwarded_value in v:
                    assoc_result = {}
                    assoc_result["headers"] = forwarded_value.get("headers", [])
                    assoc_result["query_string"] = forwarded_value.get("query_string", False)
                    assoc_result["cookies_forward"] = forwarded_value.get("cookies", [{}])[0].get("forward", "none")
                    assoc_result["cookies_whitelisted_names"] = forwarded_value.get("cookies", [{}])[0].get("whitelisted_names", [])
                    assoc_result["query_string_cache_keys"] = forwarded_value.get("query_string_cache_keys", [])
                    result[k] = [assoc_result]
                continue                

            if isinstance(v, list):
                if isinstance(v[0], dict):
                    result[k] = v[0]
                else:
                    result[k] = v
            else:
                result[k] = v
    return result

def cloudfront_build_ordered_cache_behavior(attributes, arg=None, additional_data=None):
    ordered_cache_behavior = attributes.get("ordered_cache_behavior", [])
    result = []
    if not ordered_cache_behavior:
        return result
    instance_data = get_module_additional_data("aws_cloudfront_distribution", "managed_policies", additional_data)
    for cache_behavior in ordered_cache_behavior:
        record = {}
        for k, v in cache_behavior.items():
            if v:
                if k == "cache_policy_id":
                    cache_policy_name = instance_data.get(v, "")
                    if cache_policy_name:
                        record["cache_policy_name"] = cache_policy_name
                    else:
                        record[k] = v
                    continue
                if k == "lambda_function_association":
                    assoc_result = {}
                    for association in v:
                        assoc_key = association['event_type']
                        assoc_result[assoc_key] = {}
                        assoc_result[assoc_key]['lambda_arn'] = association['lambda_arn']
                        assoc_result[assoc_key]['include_body'] = association['include_body']
                    record[k] = assoc_result
                    continue


                if k == "function_association":
                    assoc_result = {}
                    for association in v:
                        assoc_key = association['event_type']
                        assoc_result[assoc_key] = {}
                        assoc_result[assoc_key]['function_arn'] = association['function_arn']
                    record[k] = assoc_result
                    continue

                if k == "forwarded_values":
                    for forwarded_value in v:
                        assoc_result = {}
                        assoc_result["headers"] = forwarded_value.get("headers", [])
                        assoc_result["query_string"] = forwarded_value.get("query_string", False)
                        assoc_result["cookies_forward"] = forwarded_value.get("cookies", [{}])[0].get("forward", "none")
                        assoc_result["cookies_whitelisted_names"] = forwarded_value.get("cookies", [{}])[0].get("whitelisted_names", [])
                        assoc_result["query_string_cache_keys"] = forwarded_value.get("query_string_cache_keys", [])
                        record[k] = [assoc_result]
                    continue

                if isinstance(v, list):
                    if isinstance(v[0], dict):
                        record[k] = v[0]
                    else:
                        record[k] = v
                else:
                    record[k] = v
        result.append(record)
    return result

def cloudfront_build_geo_restriction(attributes, arg=None, additional_data=None):
    restrictions = attributes.get("restrictions", [])
    result = {}
    if not restrictions:
        return result
    if 'geo_restriction' in restrictions[0]:
        if restrictions[0]['geo_restriction'][0].get('restriction_type', 'none') != 'none':
            result = restrictions[0]['geo_restriction'][0]
    return result

def cloudfront_build_viewer_certificate(attributes, arg=None, additional_data=None):
    viewer_certificate = attributes.get("viewer_certificate", [])
    result = {}
    if not viewer_certificate:
        return result
    for k, v in viewer_certificate[0].items():
        if v:  # check if the value is not empty
            if isinstance(v, list):
                if isinstance(v[0], dict):
                    result[k] = v[0]
                else:
                    result[k] = v
            else:
                result[k] = v
    return result


### CLOUDMAP ###
def cloudmap_get_vpc_name(attributes, arg=None, additional_data=None):
    id = attributes.get("id")
    instance_data = get_module_additional_data("aws_service_discovery_private_dns_namespace", id, additional_data)
    vpc_name = instance_data.get("vpc_name", "")
    return vpc_name

def cloudmap_build_service_names(attributes, arg=None, additional_data=None):
    key = attributes.get("name")
    result = {}
    result[key] = {
        'name': attributes.get("name"),
        'description': attributes.get("description"),
        'dns_records': attributes.get("dns_config", [{}])[0].get("dns_records", [{}]),
        'routing_policy': attributes.get("dns_config", [{}])[0].get("routing_policy", ""),
        'health_check_config': attributes.get("health_check_config"),
        'health_check_custom_config': attributes.get("health_check_custom_config"),
        'tags': attributes.get("tags"),
    }
    return result

def cloudmap_private_dns_namespace_import_id(attributes, arg=None, additional_data=None):
    namespace_id = attributes.get("id")
    vpc_id = attributes.get("vpc")
    return f"{namespace_id}:{vpc_id}"

### DOCDB ###
def docdb_build_cluster_instances(attributes, arg=None, additional_data=None):
    key = attributes[arg]
    result = {key: {}}
    for k in ['identifier', 'apply_immediately', 'preferred_maintenance_window', 'instance_class', 'engine', 'auto_minor_version_upgrade', 'enable_performance_insights', 'promotion_tier', 'tags']:
        val = attributes.get(k)
        if isinstance(val, str):
            val = val.replace('${', '$${')
        result[key][k] = val
    return result

def docdb_get_subnet_names(attributes, arg=None, additional_data=None):
    id = attributes.get("id")
    instance_data = get_module_additional_data("aws_docdb_subnet_group", id, additional_data)
    subnet_names = instance_data.get("subnet_names", [])
    return subnet_names

def docdb_get_subnet_ids(attributes, arg=None, additional_data=None):
    subnet_names = docdb_get_subnet_names(attributes, arg, additional_data)
    if subnet_names:
        return ""
    subnet_ids = attributes.get("subnet_ids")
    return subnet_ids

def docdb_get_vpc_name(attributes, arg=None, additional_data=None):
    id = attributes.get("id")
    instance_data = get_module_additional_data("aws_docdb_subnet_group", id, additional_data)
    vpc_name = instance_data.get("vpc_name", "")
    return vpc_name

def docdb_get_vpc_id(attributes, arg=None, additional_data=None):
    vpc_name = docdb_get_vpc_name(attributes, arg, additional_data)
    if vpc_name:
        return ""
    instance_data = get_module_additional_data("aws_docdb_subnet_group", id, additional_data)
    vpc_id = instance_data.get("vpc_id", "")
    return vpc_id



### DYNAMODB ###
def dynamodb_aws_appautoscaling_policy_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes.get('service_namespace')}/{attributes.get('resource_id')}/{attributes.get('scalable_dimension')}/{attributes.get('name')}"

def dynamodb_aws_appautoscaling_target_import_id(attributes, arg=None, additional_data=None):
    return f"{attributes.get('service_namespace')}/{attributes.get('resource_id')}/{attributes.get('scalable_dimension')}"

def dynamodb_get_name_from_arn(attributes, arg=None, additional_data=None):
    arn = attributes.get(arg)
    if arn is not None:
        return arn.split('/')[-1]
    return None

def dynamodb_aws_dynamodb_target_name(attributes, arg=None, additional_data=None):
    id = attributes.get("id")
    instance_data = get_module_additional_data("aws_dynamodb_table", id, additional_data)
    target_name = instance_data.get("target_name", "")
    return target_name

def dynamodb_build_autoscaling(attributes, arg=None, additional_data=None):
    scalable_dimension = attributes.get("scalable_dimension", "")
    name = get_scalable_dimension(scalable_dimension)
    
    result = {}
    result[name] = {}
    result[name]["max_capacity"] = attributes.get("max_capacity", None)
    result[name]["min_capacity"] = attributes.get("min_capacity", None)
    result[name]["scalable_dimension"] = scalable_dimension
    return result

def get_scalable_dimension(scalable_dimension):
    if scalable_dimension == "dynamodb:table:ReadCapacityUnits":
        name = "table_read_policy"
    elif scalable_dimension == "dynamodb:table:WriteCapacityUnits":
        name = "table_write_policy"
    elif scalable_dimension == "dynamodb:index:ReadCapacityUnits":
        name = "index_read_policy"
    elif scalable_dimension == "dynamodb:index:WriteCapacityUnits":
        name = "index_write_policy"

    return name

def dynamodb_get_autosaling_type(attributes, arg=None, additional_data=None):
    scalable_dimension = attributes.get("scalable_dimension", "")
    return get_scalable_dimension(scalable_dimension)

def dynamodb_build_autoscaling_policy(attributes, arg=None, additional_data=None):
    scalable_dimension = attributes.get("scalable_dimension", "")
    name = get_scalable_dimension(scalable_dimension)
    result = {}
    result[name] = {}
    result[name]["policy_name"] = attributes.get("name", None)
    tmp = attributes.get("target_tracking_scaling_policy_configuration", [])
    if tmp:
        tmp2 = tmp[0].get("predefined_metric_specification", [])
        if tmp2:
            result[name]["predefined_metric_type"] = tmp2[0].get("predefined_metric_type", None)
        result[name]["scale_in_cooldown"] = tmp[0].get("scale_in_cooldown", None)
        result[name]["scale_out_cooldown"] = tmp[0].get("scale_out_cooldown", None)
        result[name]["target_value"] = tmp[0].get("target_value", None)

    return result


### EC2 ###
def ec2_get_public_ip_addresses(attributes, arg=None, additional_data=None):
    result ={}
    public_ip = attributes.get("public_ip")
    if public_ip is not None:
        tags = attributes.get("tags")
        result[public_ip] = {'tags': tags }
    return result

def ec2_get_user_data(attributes, arg=None, additional_data=None):
    id = attributes.get("id")
    instance_data = get_module_additional_data("aws_instance", id, additional_data)
    user_data = instance_data.get("user_data", "")
    return user_data

def get_subnet_name_ec2(attributes, arg=None, additional_data=None):
    id = attributes.get('id')
    instance_data = get_module_additional_data("aws_instance", id, additional_data)
    subnet_name = instance_data.get("subnet_name", "")
    return subnet_name

def get_subnet_id_ec2(attributes, arg=None, additional_data=None):
    subnet_name = get_subnet_name_ec2(attributes, arg, additional_data)
    if subnet_name:
        return ""
    else:
        return attributes.get("subnet_id")  

def ec2_get_device_name(attributes, arg=None, additional_data=None):
    id = attributes.get("id")
    instance_data = get_module_additional_data("aws_ebs_volume", id, additional_data)
    device_name = instance_data.get("device_name", "")
    return device_name

def ec2_get_device_name_list(attributes, arg=None, additional_data=None):
    volume_id = attributes.get("id")
    device_name = ec2_get_device_name(attributes, arg, additional_data)
    if not device_name:
        return None

    result = {}
    result[device_name] = {}

    volume_type = attributes.get("type")
    iops = attributes.get("iops")
    throughput = attributes.get("throughput")

    if volume_type != "gp2" and iops:
        result[device_name]["iops"] = iops

    if throughput and throughput != 0:
        result[device_name]["throughput"] = throughput

    # Add other fields conditionally if they are not empty or have a non-zero value
    for key in ["size", "tags", "encrypted", "kms_key_id", "type"]:
        value = attributes.get(key)
        if key == "kms_key_id":
            # Get the key alias if it exists using boto3
            if value:
                instance_data = get_module_additional_data("aws_ebs_volume", volume_id, additional_data)
                kms_alias = instance_data.get("kms_key_alias", "")
                if kms_alias:
                    value = kms_alias
                    key = "kms_key_alias"
        if value:
            result[device_name][key] = value

    return result
    
def get_kms_key_alias_ec2(attributes, arg=None, additional_data=None):
    id = attributes.get("id")
    instance_data = get_module_additional_data("aws_instance", id, additional_data)
    kms_key_alias = instance_data.get("kms_key_alias", "")
    return kms_key_alias

def get_kms_key_id_ec2(attributes, arg=None, additional_data=None):
    root_block_device = attributes.get("root_block_device")
    if root_block_device:
        kms_key_id = root_block_device[0].get("kms_key_id")
        kms_key_alias =  get_kms_key_alias_ec2(attributes, arg, additional_data)
        if not kms_key_alias:
            return kms_key_id
    return None

