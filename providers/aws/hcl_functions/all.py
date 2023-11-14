import json

#### IAM ####
def get_policy_attachment_index(attributes):
    role = attributes.get('role')
    policy_name = attributes.get('policy_arn').split('/')[-1]
    return role+"_"+policy_name

def get_inline_policies(attributes):
    # convert data_dict to str
    inline_policy = attributes.get("inline_policy")
    for policy in inline_policy:
        policy_str = json.dumps(policy["policy"])
        policy_str = policy_str.replace('${', '$${')
        policy["policy"] = json.loads(policy_str)
    return inline_policy

def get_instance_profiles(attributes):
    name = attributes.get("name")
    tags = attributes.get("tags")
    result=[{"name":name, "tags": tags}]
    return result

def get_policy_documents(attributes):
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