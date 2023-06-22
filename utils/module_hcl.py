import yaml
import json
import os


def get_value_from_tfstate(state_data, keys):
    try:
        key = keys[0]
        if isinstance(state_data, list):
            key = int(key)
        value = state_data[key]
        if len(keys) == 1:
            return value
        else:
            return get_value_from_tfstate(value, keys[1:])
    except KeyError:
        print(f"Warning: field '{'.'.join(keys)}' not found in state file.")
        return None


def string_repr(value):
    if isinstance(value, str):
        return f'"{value}"'
    else:
        return repr(value)


def load_yaml_and_tfstate(module, version, terraform_state_file, config_file):
    with open(config_file, 'r') as f:
        config = yaml.safe_load(f)

    with open(terraform_state_file, 'r') as f:
        tfstate = json.load(f)

    resources = tfstate['resources']

    instances = []

    for resource in resources:
        attributes = {}
        resource_type = resource['type']
        if resource_type in config:
            resource_config = config[resource_type]
            resource_attributes = resource['instances'][0]['attributes']
            resource_name = resource['name']
            for field in resource_config['fields']:
                value = get_value_from_tfstate(
                    resource_attributes, field.split("."))
                if value not in [None, "", []]:
                    attributes[field] = string_repr(value)

            for child_type, child in resource_config.get('childs', {}).items():
                for child_instance in [res for res in resources if res['type'] == child_type]:
                    child_attributes = child_instance['instances'][0]['attributes']
                    for join_field in child['join']:
                        if get_value_from_tfstate(resource_attributes, join_field.split(".")) == get_value_from_tfstate(child_attributes, join_field.split(".")):
                            for field in child['fields']:
                                value = get_value_from_tfstate(
                                    child_attributes, field.split("."))
                                if value not in [None, "", []]:
                                    attributes[field] = string_repr(value)
            if attributes:
                instances.append(
                    {"type": resource_type, "name": resource_name, "attributes": attributes})

    for instance in instances:
        if instance["attributes"]:
            with open(f'{instance["type"]}-{instance["name"]}.tf', 'w') as file:
                file.write(f'module "{instance["name"]}" {{\n')
                file.write(f'source  = "{module}"\n')
                file.write(f'version = "{version}"\n')
                for index, key in instance["attributes"].items():
                    file.write(f'{index} = {key}\n')
                file.write('}\n')
