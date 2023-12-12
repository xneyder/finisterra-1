import json
import hashlib

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

#### IAM ####

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
        result[key][k] = val
    return result

def get_vpc_id(attributes, arg=None, additional_data=None):
    vpc_name = get_vpc_name(attributes, arg, additional_data)
    if vpc_name is None:
        return attributes.get(arg)
    else:
        return ""    

def get_vpc_name(attributes, arg=None, additional_data=None):
    vpc_name = None
    vpc_id = attributes.get(arg)
    vpc_data = additional_data.get(vpc_id)
    if vpc_data:
        vpc_name = vpc_data.get("name")
    return vpc_name

#### SECURITY GROUP ####

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

### KMS ###
