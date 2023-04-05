import json
import subprocess
import os
import re
import shutil
from utils.filesystem import create_version_file


class HCL:
    def __init__(self, schema_data, provider_name, script_dir, transform_rules):
        self.terraform_state_file = "terraform.tfstate"
        self.schema_data = schema_data
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.transform_rules = transform_rules

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
        # create resource
        resource = {
            "mode": "managed",
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

        for resource in state_data["resources"]:
            # print(
            #     f'Processing resource "{resource["name"]}" of type "{resource["type"]}"...')
            attributes = resource["instances"][0]["attributes"]
            resource_type = resource["type"]
            resource_name = resource["name"]

            schema_attributes = self.schema_data['provider_schemas'][self.provider_name][
                'resource_schemas'][resource_type]["block"]["attributes"]
            schema_block_types = self.schema_data['provider_schemas'][self.provider_name][
                'resource_schemas'][resource_type]["block"].get("block_types", {})

            def convert_value(value):
                if isinstance(value, bool):
                    return "true" if value else "false"
                if isinstance(value, (int, float)):
                    return str(value)
                if isinstance(value, str):
                    return f'"{value}"'
                if isinstance(value, list):
                    return "[\n" + ", ".join([convert_value(v) for v in value]) + "\n]"
                if isinstance(value, dict):
                    return "{\n" + "\n ".join([f'{process_key(k,v)}' for k, v in value.items()]) + "\n}"
                return ""

            def process_key(key, value, validate=True):
                if validate:
                    if value == None or value == "":
                        return ""
                    if isinstance(value, dict) and not value:
                        return ""
                    if isinstance(value, list) and not value:
                        return ""

                    # Check if the field is in the transform rules
                    is_transformed, transform_str = check_transform_rules(
                        key, value, resource_type)
                    if is_transformed:
                        return(f'  {transform_str}')

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
                            for bkey, bvalue in block.items():
                                if bkey in hcl_drop_blocks[key]:
                                    if hcl_drop_blocks[key][bkey] == 'ALL' or hcl_drop_blocks[key][bkey] == bvalue:
                                        return False
                return True

            def multiline_json(value):
                json_value = json.loads(value)
                return json.dumps(json_value, indent=2).replace("${", "$${")

            def process_block_type(key, value, schema_block_types, resource_type):
                return_str = ""
                is_block = False
                if key in schema_block_types:
                    is_block = True
                    if schema_block_types[key]['nesting_mode'] == 'list' or schema_block_types[key]['nesting_mode'] == 'set':
                        for block in value:
                            # validate if a field in the block is empty
                            if not validate_block(key, block, resource_type):
                                return is_block, return_str
                            return_str += (f'  {quote_string(key)} {{\n')
                            for block_key, block_value in block.items():
                                # Ignore is key is computed and handled the exception
                                try:
                                    if schema_block_types[key]['block']['attributes'][block_key]['computed']:
                                        continue
                                except:
                                    pass

                                schema_block_types_child = schema_block_types[key]['block'].get(
                                    "block_types", {})
                                is_child_block, block_child_str = process_block_type(
                                    block_key, block_value, schema_block_types_child, resource_type)
                                if is_child_block:
                                    return_str += (f'    {block_child_str}')
                                    continue

                                return_str += (
                                    f'    {process_key(block_key, block_value)}')
                            return_str += ("  }\n   ")
                return is_block, return_str

            def check_transform_rules(key, value, resource_type):
                is_transformed = False
                return_str = ""
                if resource_type in self.transform_rules:
                    if 'hcl_drop_fields' in self.transform_rules[resource_type]:
                        hcl_drop_fields = self.transform_rules[resource_type]['hcl_drop_fields']
                        if key in hcl_drop_fields:
                            if hcl_drop_fields[key] == 'ALL' or hcl_drop_fields[key] == value:
                                return_str = ""
                                is_transformed = True
                    if 'hcl_keep_fields' in self.transform_rules[resource_type]:
                        hcl_keep_fields = self.transform_rules[resource_type]['hcl_keep_fields']
                        if key in hcl_keep_fields:
                            return_str += (
                                f'{process_key(key, value, False)}')
                            is_transformed = True
                    if 'hcl_prefix' in self.transform_rules[resource_type]:
                        hcl_prefix = self.transform_rules[resource_type]['hcl_prefix']
                        if key in hcl_prefix:
                            return_str += (
                                f'{process_key(key, hcl_prefix[key]+value, False)}')
                            # f'{quote_string(key)}="{hcl_prefix[key]}{value}"\n')
                            is_transformed = True
                    if 'hcl_json_multiline' in self.transform_rules[resource_type]:
                        hcl_json_multiline = self.transform_rules[resource_type]['hcl_json_multiline']
                        if key in hcl_json_multiline:
                            return_str += (
                                f'{quote_string(key)}=<<EOF\n{multiline_json(value)}\nEOF\n')
                            is_transformed = True
                    if 'hcl_file_function' in self.transform_rules[resource_type]:
                        hcl_file_function = self.transform_rules[resource_type]['hcl_file_function']
                        if key in hcl_file_function:
                            file_name = f"{resource_name}.{hcl_file_function[key]['type']}"
                            with open(file_name, "w") as hcl_output:
                                hcl_output.write(f'{value}')
                                return_str += (
                                    f'{quote_string(key)}=file("{file_name}")\n')
                                is_transformed = True
                    if 'hcl_transform_fields' in self.transform_rules[resource_type]:
                        hcl_transform_fields = self.transform_rules[resource_type]['hcl_transform_fields']
                        if key in hcl_transform_fields:
                            if hcl_transform_fields[key]['source'] == value:
                                target = hcl_transform_fields[key]['target']
                                return_str += (
                                    f' {process_key(key, target, False)}')
                                is_transformed = True

                return is_transformed, return_str

            with open(f"{resource_type}.tf", "a") as hcl_output:
                hcl_output.write(
                    f'resource "{resource_type}" "{resource_name}" {{\n')
                for key, value in attributes.items():
                    # Ignore is key is computed and handled the exception
                    try:
                        if schema_attributes[key]['computed']:
                            continue
                    except:
                        pass

                    is_block, block_str = process_block_type(
                        key, value, schema_block_types, resource_type)
                    if is_block:
                        hcl_output.write(f'    {block_str}')
                        continue

                    hcl_output.write(f'  {process_key(key, value)}')

                hcl_output.write("}\n\n")
        print("Formatting HCL files...")
        subprocess.run(["terraform", "fmt"], check=True)

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
            self.create_state_file(resource_type, resource_name, attributes)

    def count_state(self):
        resource_count = {}
        with open(self.terraform_state_file, "r") as state_file:
            state_data = json.load(state_file)
            for resource in state_data["resources"]:
                if resource["type"] in resource_count:
                    resource_count[resource["type"]] += 1
                else:
                    resource_count[resource["type"]] = 1
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
            generated_path = os.path.join(folder)
            self.create_folder(generated_path)
            os.chdir(generated_path)
            create_version_file()
            print("Initializing Terraform...")
            subprocess.run(["terraform", "init"], check=True)
        except Exception as e:
            print(e)
            exit()
