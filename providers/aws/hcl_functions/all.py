import json
import hashlib

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
    subnet_names = get_subnet_names_elbv2(attributes, arg=None, additional_data=None)
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
