import json
import subprocess
import os
import re
import shutil
from utils.filesystem import create_version_file, create_backend_file, create_data_file, create_locals_file
from utils.terraform import Terraform
import yaml
import re
from db.terraform_module_instance import get_module_data
from collections import OrderedDict
import hashlib


class HCL:
    def __init__(self, schema_data, provider_name, script_dir, transform_rules, region, bucket, dynamodb_table, state_key, workspace_id, modules):
        self.terraform_state_file = "terraform.tfstate"
        self.schema_data = schema_data
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.transform_rules = transform_rules
        self.region = region
        self.bucket = bucket
        self.dynamodb_table = dynamodb_table
        self.state_key = state_key
        self.workspace_id = workspace_id
        self.modules = modules
        self.json_plan = {}
        self.global_deployed_resources = []

        # self.module_data = get_module_data(self.workspace_id)
        self.module_data = {}

    def search_state_file(self, resource_type, resource_name, resource_id):
        # Load the state file
        try:
            with open(self.terraform_state_file, 'r') as f:
                state_data = json.load(f)
            state_resources = state_data['resources']
        except Exception as e:
            return False

        # Search for the resource in the state
        found = False
        for resource in state_resources:
            if resource.get('type') == resource_type \
                    and resource.get('name') == resource_name \
                    and resource.get('instances') is not None:
                for instance in resource['instances']:
                    if instance.get('attributes', {}).get('id') == resource_id:
                        found = True
                        break
            if found:
                break

        # Check if the resource was found
        # if found:
        #     print(
        #         f'Resource "{resource_name}" of type "{resource_type}" with ID "{resource_id}" was found in the state.')
        # else:
        #     print(
        #         f'Resource "{resource_name}" of type "{resource_type}" with ID "{resource_id}" was not found in the state.')

        return found

    def create_state_file(self, resource_type, resource_name, attributes):
        schema_version = int(self.schema_data['provider_schemas'][self.provider_name]
                             ['resource_schemas'][resource_type]['version'])

        key = f"{resource_type}_{resource_name}"
        module = ""
        if key in self.module_data:
            module_instance = self.module_data[key]["module_instance"]
            module = f'module.{module_instance}'

        # create resource
        resource = {
            "mode": "managed",
            "module": module,
            "type": resource_type,
            "name": resource_name,
            "provider": f"provider[\"{self.provider_name}\"]",
            "instances": [
                {
                    "schema_version": schema_version,
                    "attributes": attributes
                }
            ]
        }
        # Load the state file
        try:
            with open(self.terraform_state_file, 'r') as f:
                state_data = json.load(f)
            # add resource to state
            state_data['resources'].append(resource)
        except Exception as e:
            print(
                f'State file "{self.terraform_state_file}" does not exist. Creating a new one.')
            state_data = {
                "version": 4,
                "terraform_version": "1.5.0",
                "serial": 2,
                "lineage": "",
                "outputs": {},
                "resources": [
                    resource
                ]
            }
        with open(self.terraform_state_file, 'w') as state_file:
            json.dump(state_data, state_file, indent=2)

    def generate_hcl_file(self):
        print("Generating HCL files from the state file...")
        with open(self.terraform_state_file, "r") as state_file:
            state_data = json.load(state_file)

        # Get modules info

        modules_code = {}

        for resource in state_data["resources"]:
            # print("=======================RESOURCE=======================")
            # print(
            #     f'Processing resource "{resource["name"]}" of type "{resource["type"]}"...')
            attributes = resource["instances"][0]["attributes"]
            resource_type = resource["type"]
            resource_name = resource["name"]

            if 'module' in resource and resource['module'] != "":
                key = f"{resource_type}_{resource_name}"
                module_name = ""
                if key in self.module_data:
                    module_name = self.module_data[key]["module_name"]

                key = f"{resource_type}-{resource_name}"
                if key not in self.modules[module_name]:
                    # no variables for the resource
                    continue

                module_instance = resource['module']

                if module_instance not in modules_code:
                    modules_code[module_instance] = OrderedDict()
                    for okey, ovalue in self.modules[module_name].items():
                        for ikey in ovalue.keys():
                            modules_code[module_instance][f'{okey}-{ikey}'] = ""

                for key_field in self.modules[module_name][key].keys():
                    modules_code[module_instance][f'{key}-{key_field}'] = resource['instances'][0]['attributes'][key_field]

                # print(
                #     f'Skipping {resource_type}_{resource_name} belongs to {module_instance}')
                continue

            schema_attributes = self.schema_data['provider_schemas'][self.provider_name][
                'resource_schemas'][resource_type]["block"]["attributes"]
            schema_block_types = self.schema_data['provider_schemas'][self.provider_name][
                'resource_schemas'][resource_type]["block"].get("block_types", {})

            def escape_dollar_sign(value):
                # replacement = "$$"
                # escaped_value = value.replace("$", replacement)

                escaped_value = re.sub(r'\$\{(\w+)\}', r'\1', value)

                return f'{escaped_value}'

            def convert_value(value):
                if value is None:
                    return "null"
                if isinstance(value, bool):
                    return "true" if value else "false"
                if isinstance(value, (int, float)):
                    return str(value)
                if isinstance(value, str):
                    value = value.replace('\n', '')
                    return f'"{escape_dollar_sign(value)}"'
                if isinstance(value, list):
                    return "[\n" + ", ".join([convert_value(v) for v in value]) + "\n]"
                if isinstance(value, dict):
                    return "{\n" + "\n ".join([f'{process_key(k,v)}' for k, v in value.items()]) + "\n}"
                return ""

            def process_key(key, value, validate=True, parent=None):
                if validate:
                    # Check if the field is in the transform rules
                    is_transformed, transform_str = check_transform_rules(
                        key, value, resource_type, parent)
                    if is_transformed:
                        return (f'  {transform_str}')
                    else:
                        # return null ony if is not validated
                        if value == None or value == "":
                            return ""
                        if isinstance(value, dict) and not value:
                            return ""
                        if isinstance(value, list) and not value:
                            return ""

                    # Ignore is key is computed and handled the exception
                    try:
                        if schema_attributes[key]['computed']:
                            return ""
                    except:
                        pass
                return f'{quote_string(key)}={convert_value(value)}\n'

            def quote_string(s):
                if re.search(r'\W', s):
                    return f'"{s}"'
                else:
                    return s

            def validate_block(key, block, resource_type):
                if resource_type in self.transform_rules:
                    if 'hcl_drop_blocks' in self.transform_rules[resource_type]:
                        hcl_drop_blocks = self.transform_rules[resource_type]['hcl_drop_blocks']
                        if key in hcl_drop_blocks:
                            if hcl_drop_blocks[key] == "ALL":
                                return False
                            for bkey, bvalue in block.items():
                                if bkey in hcl_drop_blocks[key]:
                                    if hcl_drop_blocks[key][bkey] == 'ALL' or hcl_drop_blocks[key][bkey] == bvalue:
                                        return False
                return True

            def multiline_json(value):
                try:
                    json_value = json.loads(value)
                    return json.dumps(json_value, indent=2).replace("${", "$${")
                except:
                    return value

            def process_block_type(key, value, schema_block_types, resource_type):
                return_str = ""
                is_block = False
                if not value:
                    return is_block, return_str
                if key in schema_block_types:
                    is_block = True
                    if schema_block_types[key]['nesting_mode'] == 'list' or schema_block_types[key]['nesting_mode'] == 'set':
                        for block in value:
                            # print(key, block)
                            # validate if a field in the block is empty
                            if not validate_block(key, block, resource_type):
                                return is_block, return_str
                            return_str += (f'  {quote_string(key)} {{\n')
                            for block_key, block_value in block.items():
                                # # Ignore is key is computed and handled the exception
                                # try:

                                #     if schema_block_types[key]['block']['attributes'][block_key]['computed']:
                                #         continue
                                # except:
                                #     pass

                                schema_block_types_child = schema_block_types[key]['block'].get(
                                    "block_types", {})
                                is_child_block, block_child_str = process_block_type(
                                    block_key, block_value, schema_block_types_child, resource_type)
                                if is_child_block:
                                    return_str += (f'    {block_child_str}')
                                    continue

                                return_str += (
                                    f'    {process_key(block_key, block_value, True, key)}')
                            return_str += ("  }\n   ")
                return is_block, return_str

            def check_transform_rules(key, value, resource_type, parent=None):
                is_transformed = False
                return_str = ""
                if parent:
                    key = f'{parent}.{key}'
                    # print(key, value)
                if resource_type in self.transform_rules:
                    if 'hcl_drop_fields' in self.transform_rules[resource_type]:
                        hcl_drop_fields = self.transform_rules[resource_type]['hcl_drop_fields']
                        # print(key, value)
                        if key in hcl_drop_fields:
                            if hcl_drop_fields[key] == 'ALL' or hcl_drop_fields[key] == value:
                                return_str = ""
                                is_transformed = True
                                return is_transformed, return_str
                    if 'hcl_keep_fields' in self.transform_rules[resource_type]:
                        hcl_keep_fields = self.transform_rules[resource_type]['hcl_keep_fields']
                        if key in hcl_keep_fields:
                            key = key.split('.')[-1]
                            return_str += (
                                f'{process_key(key, value, False)}')
                            is_transformed = True
                            return is_transformed, return_str
                    if 'hcl_prefix' in self.transform_rules[resource_type]:
                        hcl_prefix = self.transform_rules[resource_type]['hcl_prefix']
                        if key in hcl_prefix:
                            key = key.split('.')[-1]
                            return_str += (
                                f'{process_key(key, hcl_prefix[key]+value, False)}')
                            is_transformed = True
                            return is_transformed, return_str
                    if 'hcl_json_multiline' in self.transform_rules[resource_type]:
                        hcl_json_multiline = self.transform_rules[resource_type]['hcl_json_multiline']
                        if key in hcl_json_multiline:
                            key = key.split('.')[-1]
                            multiline_json_value = multiline_json(value)
                            if multiline_json_value != "":
                                return_str += (
                                    f'{quote_string(key)}=<<EOF\n{multiline_json(value)}\nEOF\n')
                            else:
                                return_str += ""
                            is_transformed = True
                            return is_transformed, return_str
                    if 'hcl_file_function' in self.transform_rules[resource_type]:
                        hcl_file_function = self.transform_rules[resource_type]['hcl_file_function']
                        if key in hcl_file_function:
                            file_name = f"{resource_name}.{hcl_file_function[key]['type']}"
                            with open(file_name, "w") as hcl_output:
                                hcl_output.write(f'{value}')
                                key = key.split('.')[-1]
                                return_str += (
                                    f'{quote_string(key)}=file("{file_name}")\n')
                                is_transformed = True
                                return is_transformed, return_str
                    if 'hcl_apply_function' in self.transform_rules[resource_type]:
                        hcl_apply_function = self.transform_rules[resource_type]['hcl_apply_function']
                        # print(key, hcl_apply_function)
                        if key in hcl_apply_function:
                            for function in hcl_apply_function[key]["function"]:
                                value = function(value)
                            key = key.split('.')[-1]
                            return_str += (
                                f'{quote_string(key)}="{value}"\n')
                            is_transformed = True
                            return is_transformed, return_str
                    if 'hcl_apply_function_dict' in self.transform_rules[resource_type]:
                        hcl_apply_function_dict = self.transform_rules[
                            resource_type]['hcl_apply_function_dict']
                        if key in hcl_apply_function_dict:
                            for function in hcl_apply_function_dict[key]["function"]:
                                value = function(value)
                            key = key.split('.')[-1]
                            return_str += (
                                f'{quote_string(key)}={value}\n')
                            is_transformed = True
                            return is_transformed, return_str
                    if 'hcl_apply_function_block' in self.transform_rules[resource_type]:
                        hcl_apply_function_block = self.transform_rules[
                            resource_type]['hcl_apply_function_block']
                        if key in hcl_apply_function_block:
                            for function in hcl_apply_function_block[key]["function"]:
                                value = function(value)
                            key = key.split('.')[-1]
                            return_str += (
                                f'{quote_string(key)} {value}\n')
                            is_transformed = True
                            return is_transformed, return_str
                    if 'hcl_transform_fields' in self.transform_rules[resource_type]:
                        hcl_transform_fields = self.transform_rules[resource_type]['hcl_transform_fields']
                        if key in hcl_transform_fields:
                            if hcl_transform_fields[key]['source'] == value:
                                target = hcl_transform_fields[key]['target']
                                key = key.split('.')[-1]
                                return_str += (
                                    f' {process_key(key, target, False)}')
                                is_transformed = True
                                return is_transformed, return_str

                return is_transformed, return_str

            with open(f"{resource_type}.tf", "a") as hcl_output:
                hcl_output.write(
                    f'resource "{resource_type}" "{resource_name}" {{\n')
                for key, value in attributes.items():
                    is_block, block_str = process_block_type(
                        key, value, schema_block_types, resource_type)
                    if is_block:
                        hcl_output.write(f'    {block_str}')
                        continue

                    hcl_output.write(f'  {process_key(key, value)}')

                hcl_output.write("}\n\n")

        print("Creating resources under modules")
        pattern = re.compile(r'\${(.*?)}')  # Matches '${xxxxxx}'

        for tmodule, attributes in modules_code.items():
            # Get the name after the first dot
            tmodule_name = tmodule.split('.')[1]
            db_module_name = self.module_data[tmodule_name]["module_name"]
            with open(f'{tmodule_name}.tf', 'w') as f:
                f.write(f'module "{tmodule_name}" {{\n')
                f.write(f'  source = "../../../modules/{db_module_name}"\n')
                for attribute, value in attributes.items():
                    if isinstance(value, dict):
                        # Loop through the dictionary items
                        for k, v in value.items():
                            if isinstance(v, str):  # Check if the value is a string
                                # Replace '${xxxxxx}' with 'xxxxxx' if present
                                value[k] = re.sub(pattern, r'\1', v)
                        # Format the dictionary as a JSON string, then remove the quotes around the keys
                        formatted_value = json.dumps(value, indent=2)
                        formatted_value = formatted_value.replace('\n', '\n  ')
                        f.write(f'  {attribute} = {formatted_value}\n')
                    elif isinstance(value, list):  # Check if the value is a list
                        # For simplicity, let's just write out the list as a string
                        # This can be modified to handle more complex list elements
                        json_value = json.dumps(value)
                        f.write(f'  {attribute} = {json_value}\n')
                    else:
                        if isinstance(value, str):  # Check if the value is a string
                            # Replace '${xxxxxx}' with 'xxxxxx' if present
                            value = re.sub(pattern, r'\1', value)
                        # Surround value with quotes
                        f.write(f'  {attribute} = "{value}"\n')

                f.write('}\n')

        print("Formatting HCL files...")

        subprocess.run(["terraform", "fmt"], check=True)
        # Because i have modules i need to remove these checks
        # subprocess.run(["terraform", "init"], check=True)
        # subprocess.run(["terraform", "validate"], check=True)
        # print("Running Terraform plan on generated files...")
        # terraform = Terraform()
        # self.json_plan = terraform.tf_plan("./", True)
        create_backend_file(self.bucket, os.path.join(self.state_key, "terraform.tfstate"),
                            self.region, self.dynamodb_table)
        shutil.rmtree("./.terraform", ignore_errors=True)

    def replace_special_chars(self, input_string):
        # Replace spaces, "-", ".", and any special character with "_"
        output_string = re.sub(r'\s|-|\.|\W', '_', input_string)
        return output_string

    def add_underscore(self, string):
        if string[0].isdigit():
            return '_' + string
        else:
            return string

    def process_resource(self, resource_type, resource_name, attributes):
        resource_id = attributes["id"]
        resource_name = self.add_underscore(
            self.replace_special_chars(resource_name))
        # search if resource exists in the state
        if not self.search_state_file(resource_type, resource_name, resource_id):
            # print("Importing resource...")
            self.create_state_file(
                resource_type, resource_name, attributes)

    def count_state(self):
        resource_count = {}
        try:
            with open(self.terraform_state_file, "r") as state_file:
                state_data = json.load(state_file)
                for resource in state_data["resources"]:
                    if resource["type"] in resource_count:
                        resource_count[resource["type"]] += 1
                    else:
                        resource_count[resource["type"]] = 1
        except:
            pass
        return resource_count

    def refresh_state(self):
        # count resources in state file
        prev_resources_count = self.count_state()

        print("Refreshing state...")
        subprocess.run(["terraform", "refresh"], check=True)
        try:
            subprocess.run(
                ["rm", self.terraform_state_file+".backup"], check=True)
        except:
            pass

        print("Counting resources in state file...")
        with open(self.terraform_state_file, "r") as state_file:
            state_data = json.load(state_file)
            resources_count = len(state_data["resources"])

        resources_count = self.count_state()
        for resource in prev_resources_count:
            if resource not in resources_count:
                print(
                    f'ERROR: {resource} number of resources in state file has changed {prev_resources_count[resource]} -> 0')
            elif prev_resources_count[resource] != resources_count[resource]:
                print(
                    f'ERROR: {resource} number of resources in state file has changed {prev_resources_count[resource]} -> {resources_count[resource]}')
            else:
                print(
                    f'{resource} State count {prev_resources_count[resource]} -> {resources_count[resource]}')

    def create_folder(self, folder):
        if os.path.exists(folder):
            print(f"Folder '{folder}' already exists removing it.")
            shutil.rmtree(folder)
        os.makedirs(folder)
        print(f"Folder '{folder}' has been created.")

    def prepare_folder(self, folder):
        try:
            os.chdir(self.script_dir)
            temp_dir = os.path.join(self.script_dir, "tmp", ".terraform")
            generated_path = os.path.join(folder)
            self.create_folder(generated_path)
            os.chdir(generated_path)
            create_version_file()
            # create_data_file()
            # create_locals_file()
            destination_folder = os.getcwd()
            print("Copying Terraform init files...")
            shutil.copytree(temp_dir, os.path.join(
                destination_folder, ".terraform"))
            print("Initializing Terraform...")
            subprocess.run(["terraform", "init"], check=True)
        except Exception as e:
            print(e)
            exit()

    def get_value_from_tfstate(self, state_data, keys, type=None):
        try:
            # TO_DO handle all cases
            key = keys[0]
            if type == "string":
                value = state_data[key]
                # if key == "engine_version":
                #     print(value)
            else:
                if isinstance(state_data, list):
                    # Check if the list contains dictionaries
                    if all(isinstance(item, dict) for item in state_data):
                        # Using json.dumps to ensure double quotes
                        value = json.dumps(
                            next((item[key] for item in state_data if key in item), None))
                    else:
                        key = int(key)
                        value = state_data[key]
                else:
                    value = state_data[key]

            if len(keys) == 1:
                return value
            else:
                return self.get_value_from_tfstate(value, keys[1:], type)
        except KeyError:
            print(
                f"Warning: field '{'.'.join(keys)}' not found in state file.")
            return None

    def string_repr(self, value, field_type=None):
        if field_type == "string" and isinstance(value, str):
            value = value.replace('\n', '')
            escaped_value = value.replace('${', '$${')
            return f'"{escaped_value}"'
        elif value is None:
            return json.dumps(value, indent=2)
        elif isinstance(value, bool):
            return "true" if value else "false"
        elif isinstance(value, (list)):
            if field_type == "map":
                if len(value) == 1:
                    return json.dumps(value[0], indent=2)
            return json.dumps(value, indent=2)
        elif isinstance(value, (dict)):
            return json.dumps(value, indent=2)
        elif isinstance(value, (int, float)):
            return str(value)
        else:
            try:
                return json.loads(value)
            except json.JSONDecodeError:
                value = value.replace('\n', '')
                escaped_value = value.replace('${', '$${')
                return f'"{escaped_value}"'

    def find_resource_config(self, config, resource_type):
        resource_config = config.get(resource_type)

        if resource_config is not None:
            return resource_config

        for key, value in config.items():
            if isinstance(value, dict):
                resource_config = self.find_resource_config(
                    value, resource_type)
                if resource_config is not None:
                    return resource_config
            elif isinstance(value, list):
                for item in value:
                    if isinstance(item, dict):
                        resource_config = self.find_resource_config(
                            item, resource_type)
                        if resource_config is not None:
                            return resource_config

        return None

    def match_fields(self, parent_attributes, child_attributes, join_field, functions):
        # print('join_field', join_field)
        if isinstance(join_field, tuple):
            parent_field, value_dict = join_field
            parent_field = parent_field.split('.')
            # get function name from the value_dict
            join_function = value_dict.get('join_function')
            join_func = functions.get(join_function)
            func_name = value_dict.get('function')
            func = functions.get(func_name)

            if func is not None:
                arg = value_dict.get('arg')
                child_value = None
                if arg:
                    child_value = func(child_attributes, arg)
                else:
                    child_value = func(child_attributes)
                # print('parent value:', self.get_value_from_tfstate(
                #     parent_attributes, parent_field))
                # print('child value:', child_value)
                if self.get_value_from_tfstate(parent_attributes, parent_field) == child_value:
                    return True
            elif join_func is not None:
                matches = join_func(parent_attributes, child_attributes)
                return matches
            else:
                child_field = value_dict.get('field', None)
                if child_field:
                    child_field = child_field.split('.')
                    # print('parent', self.get_value_from_tfstate(
                    #     parent_attributes, parent_field))
                    # print('child', self.get_value_from_tfstate(
                    #     child_attributes, child_field))
                    return self.get_value_from_tfstate(parent_attributes, parent_field) == self.get_value_from_tfstate(
                        child_attributes, child_field)

        return False

    def process_resource_module(self, resource, resources, config, functions={}):
        root_attributes = set()

        def process_resource(resource, resources, config, parent_root_attribute_key_value=None):

            def deep_update(original, update):
                """
                Recursively update a dictionary.

                :param original: original dictionary
                :param update: updated dictionary
                """
                if not isinstance(update, dict):
                    return update

                for key, value in update.items():
                    if isinstance(value, dict):
                        original[key] = deep_update(
                            original.get(key, {}), value)
                    elif isinstance(value, str) and isinstance(original.get(key), str):
                        try:
                            # Check if the string can be converted to a dictionary
                            original_value_dict = json.loads(original[key])
                            update_value_dict = json.loads(value)

                            # If conversion is successful, merge the dictionaries
                            if isinstance(original_value_dict, list):
                                original_value_dict.extend(update_value_dict)
                                original[key] = json.dumps(
                                    original_value_dict, indent=2)
                            else:
                                original[key] = json.dumps(deep_update(
                                    original_value_dict, update_value_dict), indent=2)

                        except json.JSONDecodeError:
                            # If conversion fails, it's not a 'stringified' dictionary, so just overwrite
                            original[key] = value
                    else:
                        original[key] = value
                return original

            nonlocal root_attributes
            attributes = {}
            deployed_resources = []
            resource_type = resource['type']
            resource_name = resource['name']
            resource_config = self.find_resource_config(config, resource_type)

            if resource_config is None:
                print(
                    f"Warning: Config not found for resource type {resource_type}. Skipping.")
                return attributes, deployed_resources

            resource_attributes = resource['instances'][0]['attributes']
            skip_if = resource_config.get(
                'skip_if', "")

            # Check if skip_if is a dictionary and has a key called 'function'
            if isinstance(skip_if, dict) and 'function' in skip_if:
                func_name = skip_if.get('function')
                func = functions.get(func_name)
                if func is not None:
                    arg = skip_if.get('arg')
                    if arg:
                        skip_if = func(resource_attributes, arg)
                    else:
                        skip_if = func(resource_attributes)

            if skip_if:
                print(
                    f"Warning: condition not met {resource_type}. Skipping.")
                return attributes, deployed_resources

            fields_config = resource_config.get('fields', {})
            target_resource_name = resource_config.get(
                'target_resource_name', "")

            # Check if target_resource_name is a dictionary and has a key called 'function'
            if isinstance(target_resource_name, dict) and 'function' in target_resource_name:
                func_name = target_resource_name.get('function')
                func = functions.get(func_name)
                if func is not None:
                    arg = target_resource_name.get('arg')
                    if arg:
                        target_resource_name = func(resource_attributes, arg)
                    else:
                        target_resource_name = func(resource_attributes)

            target_submodule = resource_config.get('target_submodule', "")
            root_attribute = resource_config.get('root_attribute', "")
            created = True

            root_attribute_key_value = None
            if parent_root_attribute_key_value:
                root_attribute_key_value = parent_root_attribute_key_value
            root_attribute_key = resource_config.get(
                'root_attribute_key', None)

            if root_attribute != "" and root_attribute not in resource_attributes:
                if not root_attribute_key_value:
                    root_attribute_key_value = self.get_value_from_tfstate(
                        resource_attributes, [root_attribute_key],)

                if root_attribute not in attributes:
                    attributes[root_attribute] = {}
                if root_attribute_key_value not in attributes[root_attribute]:
                    attributes[root_attribute][root_attribute_key_value] = {}

                # add this root_attribute to the list
                root_attributes.add(root_attribute)

            defaults = resource_config.get('defaults', {})
            for default in defaults:
                if root_attribute and root_attribute_key_value:
                    attributes[root_attribute][root_attribute_key_value][default] = self.string_repr(
                        defaults[default])
                else:
                    attributes[default] = self.string_repr(defaults[default])

            for field, field_info in fields_config.items():
                value = None
                unique = field_info.get('unique', "N/A")
                multiline = field_info.get('multiline', False)
                jsonencode = field_info.get('jsonencode', False)
                default = field_info.get('default', 'N/A')
                module_default = field_info.get('module_default', 'N/A')
                func_name = field_info.get('function')
                field_type = field_info.get('type', None)
                state_field = field_info.get('field', '').split('.')
                if func_name:
                    func = functions.get(func_name)
                    if func is not None:
                        value = None
                        arg = field_info.get('arg', '')
                        if arg:
                            value = func(resource_attributes, arg)
                        else:
                            value = func(resource_attributes)
                elif state_field:
                    value = self.get_value_from_tfstate(
                        resource_attributes, state_field, field_type)

                if unique != "N/A":
                    id = resource_attributes.get('id', '')
                    matches = [resource for resource in self.global_deployed_resources if resource['resource_type']
                               == resource_type and resource['id'] == id]
                    if matches:
                        if field_type == "map":
                            value = {}
                        elif field_type == "list":
                            value = []
                        elif field_type == "bool":
                            value = False
                        elif field_type == "string":
                            value = ""
                        else:
                            value = None
                        created = False
                    else:
                        if value:
                            value = value
                        else:
                            value = unique
                        created = True

                defaulted = False
                if value in [None, "", [], {}] and default != 'N/A':
                    value = default
                    defaulted = True

                if module_default != 'N/A':
                    if value == module_default:
                        value = None

                if value not in [None, "", [], {}] or defaulted:
                    if multiline:
                        print(field, value)
                        value = "<<EOF\n" + \
                            json.dumps(json.loads(value), indent=4) + "\nEOF\n"
                    if jsonencode:
                        value = "jsonencode(" + \
                            json.dumps(json.loads(value), indent=4) + ")\n"
                    if root_attribute and root_attribute_key_value:
                        if multiline:
                            attributes[root_attribute][root_attribute_key_value][field] = value
                        else:
                            attributes[root_attribute][root_attribute_key_value][field] = self.string_repr(
                                value, field_type)
                    else:
                        if multiline or jsonencode:
                            attributes[field] = value
                        else:
                            attributes[field] = self.string_repr(
                                value, field_type)

            if created:
                second_index = resource_config.get('second_index', "")
                second_index_value = None
                if second_index:
                    enabled = second_index.get('enabled', True)
                    if not enabled:
                        second_index_value = "disabled"
                    else:
                        func_name = second_index.get('function')
                        func = functions.get(func_name)
                        if func is not None:
                            arg = second_index.get('arg')
                            if arg:
                                second_index_value = func(
                                    resource_attributes, arg)
                            else:
                                second_index_value = func(resource_attributes)
                        else:
                            field_name = second_index.get('field')
                            if field_name:
                                second_index_value = self.get_value_from_tfstate(
                                    resource_attributes, field_name.split('.'))

                import_id = resource_config.get('import_id', "")
                import_id_value = resource_attributes.get('id', '')
                if import_id:
                    func_name = import_id.get('function')
                    func = functions.get(func_name)
                    if func is not None:
                        arg = import_id.get('arg')
                        if arg:
                            import_id_value = func(
                                resource_attributes, arg)
                        else:
                            import_id_value = func(resource_attributes)
                    else:
                        field_name = import_id.get('field')
                        if field_name:
                            import_id_value = self.get_value_from_tfstate(
                                resource_attributes, field_name.split('.'))

                deployed_resources.append({
                    'resource_type': resource_type,
                    'resource_name': resource_name,
                    'target_resource_name': target_resource_name,
                    'target_submodule': target_submodule,
                    'id': resource_attributes.get('id', ''),
                    'import_id': import_id_value,
                    'index': root_attribute_key_value if root_attribute_key_value else '',
                    'second_index_value': second_index_value if second_index_value else '',
                })
                self.global_deployed_resources.append({
                    'resource_type': resource_type,
                    'resource_name': resource_name,
                    'target_resource_name': target_resource_name,
                    'target_submodule': target_submodule,
                    'id': resource_attributes.get('id', ''),
                    'import_id': import_id_value,
                    'index': root_attribute_key_value if root_attribute_key_value else '',
                    'second_index_value': second_index_value if second_index_value else '',
                })

            for child_type, child_config in resource_config.get('childs', {}).items():
                # Check if resource type is defined use it
                child_type = child_config.get('resource_type', child_type)
                for child_instance in [res for res in resources if res['type'] == child_type]:
                    join_fields = [
                        item for item in child_config.get('join', {}).items()]
                    match = all(self.match_fields(
                        resource_attributes, child_instance['instances'][0]['attributes'], join_field, functions) for join_field in join_fields)
                    if match:
                        child_attributes, child_resources = process_resource(
                            child_instance, resources, {child_type: child_config}, root_attribute_key_value)

                        if child_attributes:
                            child_attributes_copy = child_attributes.copy()
                            if 'root_attribute' in child_config:
                                root_attribute = child_config['root_attribute']
                                # make a copy of the child_attributes

                                if root_attribute in attributes and root_attribute in child_attributes:
                                    if isinstance(attributes[root_attribute], list):
                                        attributes[root_attribute].append(
                                            child_attributes[root_attribute])
                                        child_attributes_copy.pop(
                                            root_attribute)
                                    else:
                                        attributes[root_attribute] = deep_update(attributes.get(
                                            root_attribute, {}), child_attributes[root_attribute])
                                        child_attributes_copy.pop(
                                            root_attribute)

                            # update the rest of the attributes normally, using the copy
                            attributes = deep_update(
                                attributes, child_attributes_copy)

                        for child_resource in child_resources:
                            if not any(
                                    d['resource_type'] == child_resource['resource_type'] and
                                    d['resource_name'] == child_resource['resource_name']
                                    for d in deployed_resources):
                                deployed_resources.append(child_resource)

            return attributes, deployed_resources

        def dict_to_hcl(input_dict, indent=0, root=True):
            def escape_special_characters(input_str):
                return input_str.replace("\\", "\\\\")

            def indent_str(level):
                return '  ' * level

            hcl_lines = []

            for key, value in input_dict.items():
                if isinstance(value, str) and (value.startswith('{') or value.startswith('[')):
                    try:
                        value = json.loads(value)
                    except json.JSONDecodeError:
                        pass

                if isinstance(value, dict):
                    if not root:
                        hcl_lines.append(f"{indent_str(indent)}{key} = {{")
                        hcl_lines.extend(dict_to_hcl(
                            value, indent=indent+1, root=False))
                        hcl_lines.append(f"{indent_str(indent)}}}")
                    else:
                        hcl_lines.append(f"{indent_str(indent)}{key} = ")
                        hcl_lines.extend(dict_to_hcl(
                            value, indent=indent+1, root=False))
                elif isinstance(value, list):
                    hcl_lines.append(f"{indent_str(indent)}{key} = [")
                    for item in value:
                        if isinstance(item, dict):
                            hcl_lines.extend(dict_to_hcl(
                                item, indent=indent+1, root=False))
                            hcl_lines.append(",")
                        else:
                            hcl_lines.append(f"{indent_str(indent+1)}{item},")
                    # Remove trailing comma from the last item
                    hcl_lines[-1] = hcl_lines[-1][:-1]
                    hcl_lines.append(f"{indent_str(indent)}]")
                else:
                    if isinstance(value, str):
                        escaped_value = escape_special_characters(value)
                        if escaped_value.lower() == "null":
                            hcl_lines.append(
                                f"{indent_str(indent)}{key} = null")
                        else:
                            hcl_lines.append(f"{indent_str(indent)}{key} = " + (escaped_value if escaped_value.startswith(
                                "\"") and escaped_value.endswith("\"") else "\"" + escaped_value + "\""))
                    elif isinstance(value, bool):
                        hcl_lines.append(
                            f'{indent_str(indent)}{key} = "{str(value).lower()}"')
                    else:
                        hcl_lines.append(
                            f"{indent_str(indent)}{key} = {value}")

            return hcl_lines

        def value_to_hcl(value):
            def escape_special_characters(input_str):
                return input_str.replace("\\", "\\\\")

            hcl_str = ""
            if isinstance(value, str) and (value.startswith('{') or value.startswith('[')):
                try:
                    value = json.loads(value)
                except json.JSONDecodeError:
                    pass

            if isinstance(value, dict):
                hcl_str += "{\n"
                for k, v in value.items():
                    hcl_str += f"\"{k}\" = {value_to_hcl(v)}"
                hcl_str += "}\n"
            elif isinstance(value, list):
                if not value:  # Special case for empty list
                    hcl_str += "[]\n"
                elif all(isinstance(item, dict) for item in value):
                    hcl_str += "[\n"
                    for i, item in enumerate(value):
                        hcl_str += value_to_hcl(item)
                        if i < len(value) - 1:
                            hcl_str += ","
                        hcl_str += "\n"
                    hcl_str += "]\n"
                else:
                    hcl_str += "["
                    hcl_str += ",".join([f"{item}" for item in value])
                    hcl_str += "]\n"
            elif isinstance(value, bool):
                hcl_str += f"{str(value).lower()}\n"
            else:
                if isinstance(value, str):
                    escaped_value = escape_special_characters(value)
                    if escaped_value.lower() == "null":
                        hcl_str += "null\n"
                    # check for "true" or "false" strings
                    elif escaped_value.lower() in ["true", "false"]:
                        hcl_str += f"{escaped_value}\n"
                    else:
                        hcl_str += (escaped_value if escaped_value.startswith(
                            "\"") and escaped_value.endswith("\"") else "\"" + escaped_value + "\"") + "\n"
                elif isinstance(value, bool):
                    hcl_str += f"{str(value).lower()}\n"
                else:
                    hcl_str += f"{value}\n"
            return hcl_str

        attributes, deployed_resources = process_resource(
            resource, resources, config)

        # JSON dump the root attributes
        # remove duplicates by converting to a set
        full_dump = {}
        if config[resource['type']].get('dict_to_hcl', False):
            for key, value in attributes.items():
                if not str(value).startswith('<<EOF') and not str(value).startswith('jsonencode('):
                    # print("===========================")
                    # print(key, value)
                    attributes[key] = value_to_hcl(value)
                    # print(key, attributes[key])
                    # print("===========================")

        if attributes or deployed_resources:
            name_field = config[resource['type']].get("name_field", "name")
            resoource_name = attributes.get(name_field, None)
            replace_name = True
            if not resoource_name:
                resoource_name = resource['name']
                replace_name = False
            return {
                "type": resource['type'],
                "name": resoource_name,
                "replace_name": replace_name,
                "name_field": name_field,
                "attributes": attributes,
                "full_dump": full_dump,
                "deployed_resources": deployed_resources
            }
        else:
            return []

    def module_hcl_code(self, terraform_state_file, config_file, functions={}, aws_region="", aws_account_id=""):

        with open(config_file, 'r') as f:
            config = yaml.safe_load(f)

        with open(terraform_state_file, 'r') as f:
            tfstate = json.load(f)

        resources = tfstate['resources']

        instances = []

        for resource in resources:
            if resource['type'] in config:  # Check if resource is root in the config
                resource_config = config[resource['type']]
                instance = self.process_resource_module(
                    resource, resources, config, functions)
                if not instance:
                    continue
                instance['module'] = resource_config.get('terraform_module')
                instance['path'] = resource_config.get('path', "")
                instance['dependencies'] = resource_config.get(
                    'dependencies', [])
                instance['version'] = resource_config.get(
                    'terraform_module_version')
                if instance:
                    instances.append(instance)

        subfolders = {}
        for instance in instances:
            if instance["attributes"]:
                instance["name"] = instance["name"].replace("\n", "")
                module_instance_name = instance["name"].replace(
                    '"', '').replace(" ", "_").replace(".", "_").replace("/", "_").replace("(", "_").replace(")", "_").replace("*", "_")
                module_instance_name = f'{instance["type"]}-{module_instance_name}'

                name_value = ""
                name_field = ""

                module_file_path = os.path.join(
                    instance["path"], f'{module_instance_name}.tf')

                if instance["path"]:
                    os.makedirs(os.path.dirname(
                        module_file_path), exist_ok=True)
                if instance["path"] not in subfolders:
                    subfolders[instance["path"]] = {
                        'dependencies': instance["dependencies"]}

                with open(module_file_path, 'w') as file:
                    if instance["replace_name"]:
                        name_value = instance["name"].replace('"', '')
                        name_value_replaced = name_value

                        if aws_account_id:
                            name_value_replaced = re.sub(r'\b' + aws_account_id +
                                                         r'\b', "${local.aws_account_id}", name_value_replaced)
                        if aws_region:
                            name_value_replaced = re.sub(
                                r'\b(' + aws_region + r')(?=[a-z]?\b)', "${local.aws_region}", name_value_replaced)
                            aws_partition = 'aws-us-gov' if 'gov' in aws_region else 'aws'
                            name_value_replaced = re.sub(
                                r'\barn:' + aws_partition + r':\b', "arn:${local.aws_partition}:", name_value_replaced)

                        name_field = f'{instance["name_field"]}'

                        hash_value = hashlib.sha256(
                            name_value.encode()).hexdigest()[:10]
                        name_field = f'{instance["name_field"]}_{hash_value}'
                        file.write(f'locals {{\n')
                        file.write(
                            f'{name_field} = "{name_value_replaced}"\n')
                        file.write(f'}}\n\n')

                    file.write(
                        f'module "{module_instance_name}" {{\n')
                    file.write(f'source  = "{instance["module"]}"\n')
                    # file.write(f'version = "{instance["version"]}"\n') # TO REMOVE COMMENT
                    if instance["full_dump"]:
                        file.write(instance["full_dump"]['attributes'])
                    else:
                        for index, value in instance["attributes"].items():
                            try:
                                if instance["replace_name"]:
                                    value = re.sub(
                                        r'\"' + re.escape(name_value) + r'\"', "local." + name_field, value)

                                if instance["replace_name"]:
                                    # if '-DLQ' in value:
                                    #     print("before", value)
                                    # value = re.sub(
                                    #     r'\b' + re.escape(name_value) + r'\b', "${local."+name_field+"}", value)

                                    def replace_value(match):
                                        prefix = match.group(1) or ''
                                        suffix = match.group(
                                            2) if match.group(2) else ''
                                        if prefix.endswith('$'):
                                            # format("$%s-scaling-policy", local.name_7a25b73ae1)
                                            # return f'$" + local.{name_field} + "{suffix}' if suffix else '$" + local.' + name_field

                                            return f'format("{prefix}%s{suffix}", local.{name_field})'
                                        elif prefix:
                                            if '"' in prefix:
                                                return f'{prefix}${{local.{name_field}}}{suffix}"'
                                            else:
                                                return f'"{prefix}${{local.{name_field}}}{suffix}"'
                                        else:
                                            return f'"${{local.{name_field}}}{suffix}"'

                                    pattern = r'"?(.*\$?)' + \
                                        re.escape(name_value) + r'([^"]*)"?'

                                    value = re.sub(
                                        pattern, replace_value, value)

                                    # if 'local' in value:
                                    #     print("after", value)

                                if aws_account_id:
                                    value = re.sub(r'\b' + aws_account_id +
                                                   r'\b', "${local.aws_account_id}", value)
                                if aws_region:
                                    value = re.sub(
                                        r'\b(' + aws_region + r')(?=[a-z]?\b)', "${local.aws_region}", value)
                                    aws_partition = 'aws-us-gov' if 'gov' in aws_region else 'aws'
                                    value = re.sub(
                                        r'\barn:' + aws_partition + r':\b', "arn:${local.aws_partition}:", value)

                            except Exception as e:
                                print(f"Error processing index {index}: {e}")
                                print(value)

                            file.write(f'{index} = {value}\n')
                    file.write('}\n')

        for key, values in subfolders.items():
            terragrunt_path = os.path.join(key, "terragrunt.hcl")

            # If the file doesn't exist, create it
            if not os.path.exists(terragrunt_path):
                with open(terragrunt_path, 'w') as file:

                    file.write(f'include {{\n')
                    file.write(f'path = find_in_parent_folders()\n')
                    file.write(f'}}\n')

                    if values['dependencies']:
                        file.write(f'dependencies  {{\n')
                        file.write(
                            f'paths = {json.dumps(values["dependencies"])}\n')
                        file.write(f'}}\n')
                        for dependency in values['dependencies']:
                            os.makedirs(dependency, exist_ok=True)

        for instance in instances:
            module_instance_name = instance["name"].replace(
                '"', '').replace(" ", "_").replace(".", "_").replace("/", "_").replace("(", "_").replace(")", "_").replace("*", "_")
            module_instance_name = f'{instance["type"]}-{module_instance_name}'
            import_file_path = os.path.join("", f'import.tf')

            for deployed_resource in instance["deployed_resources"]:
                index_str = ""
                if deployed_resource["index"]:
                    index_str = '["'+deployed_resource["index"]+'"].'
                if not index_str and deployed_resource["target_submodule"]:
                    deployed_resource["target_submodule"] += "."

                second_index_str = "[0]"
                if deployed_resource["second_index_value"]:
                    if deployed_resource["second_index_value"] == "disabled":
                        second_index_str = ""
                    else:
                        if isinstance(deployed_resource["second_index_value"], int):
                            second_index_str = \
                                f'[{deployed_resource["second_index_value"]}]'
                        else:
                            second_index_str = '["' + \
                                deployed_resource["second_index_value"]+'"]'

                resource_import_target = f'module.{module_instance_name}.{deployed_resource["target_submodule"]}{index_str}{deployed_resource["resource_type"]}.{deployed_resource["target_resource_name"]}{second_index_str}'
                # Write to import.tf file
                with open(import_file_path, 'a') as file:  # 'a' is for append mode
                    file.write(
                        f'import {{\n  id = "{deployed_resource["import_id"]}"\n  to   = {resource_import_target}\n}}\n\n')

        print("Formatting HCL files...")
        subprocess.run(["terragrunt", "init"], check=True)
        subprocess.run(["terragrunt", "hclfmt"], check=True)
        subprocess.run(["terraform", "fmt", "-recursive"], check=True)
        subprocess.run(["terragrunt",  "validate"], check=True)
        print("Running terragrunt plan on generated files...")
        subprocess.run(["terragrunt", "plan", "-refresh-only"], check=True)
