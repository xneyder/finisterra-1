import json

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
