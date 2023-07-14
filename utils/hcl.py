import json
import subprocess
import os
import re
import shutil
from utils.filesystem import create_version_file, create_backend_file
from utils.terraform import Terraform
import yaml
import re
from db.terraform_module_instance import get_module_data
from collections import OrderedDict
import concurrent.futures
import ast


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

        self.module_data = get_module_data(self.workspace_id)

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
                "terraform_version": "1.3.6",
                "serial": 1,
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
            destination_folder = os.getcwd()
            print("Copying Terraform init files...")
            shutil.copytree(temp_dir, os.path.join(
                destination_folder, ".terraform"))
            print("Initializing Terraform...")
            subprocess.run(["terraform", "init"], check=True)
        except Exception as e:
            print(e)
            exit()

    def get_value_from_tfstate(self, state_data, keys):
        try:
            key = keys[0]
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
                return self.get_value_from_tfstate(value, keys[1:])
        except KeyError:
            print(
                f"Warning: field '{'.'.join(keys)}' not found in state file.")
            return None

    def string_repr(self, value):
        if value is None:
            return json.dumps(value)
        elif isinstance(value, bool):
            return "true" if value else "false"
        elif isinstance(value, (list, dict)):
            return json.dumps(value)
        elif isinstance(value, (int, float)):
            return str(value)
        else:
            try:
                return json.loads(value)
            except json.JSONDecodeError:
                value = value.replace('\n', '')
                escaped_value = re.sub(r'\$\{(\w+)\}', r'\1', value)
                return f'"{escaped_value}"'

    # def is_field_set(self, state, arg):
    #     # convert the string to a dict
    #     input_string = state.get(arg, '')
    #     if input_string != '':
    #         return True
    #     else:
    #         return False

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
        if isinstance(join_field, tuple):  # new case when join_field is tuple
            parent_field, value_dict = join_field
            # get function name from the value_dict
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
                #     parent_attributes, parent_field.split(".")))
                # print('child value:', func(child_attributes))
                if self.get_value_from_tfstate(parent_attributes, parent_field.split(".")) == child_value:
                    return True
        else:
            return self.get_value_from_tfstate(parent_attributes, join_field.split(".")) == self.get_value_from_tfstate(
                child_attributes, join_field.split("."))

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
                            original[key] = json.dumps(deep_update(
                                original_value_dict, update_value_dict))

                        except json.JSONDecodeError:
                            # If conversion fails, it's not a 'stringified' dictionary, so just overwrite
                            original[key] = value
                    else:
                        original[key] = value
                return original

            nonlocal root_attributes
            created = False
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
            fields_config = resource_config.get('fields', {})
            target_resource_name = resource_config.get(
                'target_resource_name', "")
            target_submodule = resource_config.get('target_submodule', "")
            root_attribute = resource_config.get('root_attribute', "")
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
                multiline = False
                default = field_info.get('default', 'N/A')
                func_name = field_info.get('function')
                state_field = field_info.get('field', '').split('.')
                if func_name:
                    func = functions.get(func_name)
                    if func is not None:
                        value = None
                        arg = field_info.get('arg', '')
                        multiline = field_info.get('multiline', '')
                        if arg:
                            value = func(resource_attributes, arg)
                        else:
                            value = func(resource_attributes)
                elif state_field:
                    value = self.get_value_from_tfstate(
                        resource_attributes, state_field)

                defaulted = False
                if value in [None, "", [], {}] and default is not 'N/A':
                    value = default
                    defaulted = True

                if value not in [None, "", [], {}] or defaulted:
                    created = True
                    if multiline:
                        value = "<<EOF\n" + value + "\nEOF\n"
                    if root_attribute and root_attribute_key_value:
                        if multiline:
                            attributes[root_attribute][root_attribute_key_value][field] = value
                        else:
                            attributes[root_attribute][root_attribute_key_value][field] = self.string_repr(
                                value)
                    else:
                        if multiline:
                            attributes[field] = value
                        else:
                            attributes[field] = self.string_repr(value)

            if created:
                deployed_resources.append({
                    'resource_type': resource_type,
                    'resource_name': resource_name,
                    'target_resource_name': target_resource_name,
                    'target_submodule': target_submodule,
                    'id': resource_attributes.get('id', ''),
                    'index': root_attribute_key_value if root_attribute_key_value else '',
                    # 'second_index': root_attribute_key_value if root_attribute_key_value else '',
                })

            for child_type, child_config in resource_config.get('childs', {}).items():
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

                        if child_resources:
                            deployed_resources.extend(child_resources)

            return attributes, deployed_resources

        def dict_to_hcl(input_dict, is_top_level=True):
            def escape_special_characters(input_str):
                return input_str.replace("\\", "\\\\")

            hcl_str = "{\n" if is_top_level else ""

            for key, value in input_dict.items():
                if isinstance(value, str) and (value.startswith('{') or value.startswith('[')):
                    try:
                        value = json.loads(value)
                    except json.JSONDecodeError:
                        pass

                if isinstance(value, dict):
                    hcl_str += f"{key} = " + "{\n"
                    hcl_str += dict_to_hcl(value, is_top_level=False)
                    hcl_str += "}\n"
                elif isinstance(value, list):
                    if not value:  # Special case for empty list
                        hcl_str += f"{key} = []\n"
                    elif len(value) == 1 and isinstance(value[0], dict):
                        hcl_str += f"{key} = " + "{\n"
                        hcl_str += dict_to_hcl(value[0], is_top_level=False)
                        hcl_str += "}\n"
                    elif all(isinstance(item, dict) for item in value):
                        hcl_str += f"{key} = [\n"
                        for i, item in enumerate(value):
                            hcl_str += "{\n"
                            hcl_str += dict_to_hcl(item, is_top_level=False)
                            hcl_str += "}"
                            if i < len(value) - 1:
                                hcl_str += ","
                            hcl_str += "\n"
                        hcl_str += "]\n"
                    else:
                        hcl_str += f"{key} = " + "["
                        hcl_str += ",".join([f"{item}" for item in value])
                        hcl_str += "]\n"
                else:
                    if isinstance(value, str):
                        escaped_value = escape_special_characters(value)
                        if escaped_value.lower() == "null":
                            hcl_str += f"{key} = null\n"
                        else:
                            hcl_str += f"{key} = " + (escaped_value if escaped_value.startswith(
                                "\"") and escaped_value.endswith("\"") else "\"" + escaped_value + "\"") + "\n"
                    elif isinstance(value, bool):
                        hcl_str += f'{key} = "{str(value).lower()}"\n'
                    else:
                        hcl_str += f"{key} = {value}\n"

            hcl_str += "}\n" if is_top_level else ""

            return hcl_str

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
                for k, v in value.items():
                    hcl_str += f"{k} = {value_to_hcl(v)}\n"
            elif isinstance(value, list):
                if not value:  # Special case for empty list
                    hcl_str += "[]\n"
                elif len(value) == 1 and isinstance(value[0], dict):
                    hcl_str += "{\n"
                    hcl_str += value_to_hcl(value[0])
                    hcl_str += "}\n"
                elif all(isinstance(item, dict) for item in value):
                    hcl_str += "[\n"
                    for i, item in enumerate(value):
                        hcl_str += "{\n"
                        hcl_str += value_to_hcl(item)
                        hcl_str += "}"
                        if i < len(value) - 1:
                            hcl_str += ","
                        hcl_str += "\n"
                    hcl_str += "]\n"
                else:
                    hcl_str += "["
                    hcl_str += ",".join([f"{item}" for item in value])
                    hcl_str += "]\n"
            else:
                if isinstance(value, str):
                    escaped_value = escape_special_characters(value)
                    if escaped_value.lower() == "null":
                        hcl_str += "null\n"
                    else:
                        hcl_str += (escaped_value if escaped_value.startswith(
                            "\"") and escaped_value.endswith("\"") else "\"" + escaped_value + "\"") + "\n"
                elif isinstance(value, bool):
                    hcl_str += f'"{str(value).lower()}"\n'
                else:
                    hcl_str += f"{value}\n"

            return hcl_str

        attributes, deployed_resources = process_resource(
            resource, resources, config)

        def is_dict_or_list_of_dicts(value):
            try:
                data = json.loads(value)
                return isinstance(data, dict) or (isinstance(data, list) and all(isinstance(item, dict) for item in data))
            except json.JSONDecodeError:
                return False

        # JSON dump the root attributes
        # remove duplicates by converting to a set
        if config[resource['type']].get('dict_to_hcl', False):
            for key, value in attributes.items():
                if not str(value).startswith('<<EOF'):
                    attributes[key] = value_to_hcl(value)

        if attributes or deployed_resources:
            return {
                "type": resource['type'],
                "name": resource['name'],
                "attributes": attributes,
                "deployed_resources": deployed_resources
            }
        else:
            return []

    def module_hcl_code(self, terraform_state_file, config_file, functions={}):
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
                instance['module'] = resource_config.get('terraform_module')
                instance['version'] = resource_config.get(
                    'terraform_module_version')
                if instance:
                    instances.append(instance)

        for instance in instances:
            if instance["attributes"]:
                with open(f'{instance["type"]}-{instance["name"]}.tf', 'w') as file:
                    file.write(f'module "{instance["name"]}" {{\n')
                    file.write(f'source  = "{instance["module"]}"\n')
                    file.write(f'version = "{instance["version"]}"\n')
                    for index, value in instance["attributes"].items():
                        file.write(f'{index} = {value}\n')
                    file.write('}\n')

        subprocess.run(["terraform", "init"], check=True)
        for instance in instances:
            for deployed_resource in instance["deployed_resources"]:
                resource_import_source = f'{deployed_resource["resource_type"]}.{deployed_resource["resource_name"]}'
                index_str = ""
                if deployed_resource["index"]:
                    index_str = '["'+deployed_resource["index"]+'"].'
                if not index_str and deployed_resource["target_submodule"]:
                    deployed_resource["target_submodule"] += "."

                resource_import_target = f'module.{instance["name"]}.{deployed_resource["target_submodule"]}{index_str}{deployed_resource["resource_type"]}.{deployed_resource["target_resource_name"]}'

                # print(resource_import_source)
                # print(resource_import_target)
                # subprocess.run(
                #     ["terraform", "import", resource_import_target, deployed_resource["id"]])
                subprocess.run(
                    ["terraform", "state", "mv", "-backup=/dev/null", resource_import_source, resource_import_target])

        print("Formatting HCL files...")
        subprocess.run(["terraform", "fmt"], check=True)
        subprocess.run(["terraform", "validate"], check=True)

        # exit()
        print("Running Terraform plan on generated files...")
        terraform = Terraform()
        self.json_plan = terraform.tf_plan("./", False)
        create_backend_file(self.bucket, os.path.join(self.state_key, "terraform.tfstate"),
                            self.region, self.dynamodb_table)
        shutil.rmtree("./.terraform", ignore_errors=True)
