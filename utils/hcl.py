import subprocess
import os
import re
import shutil
from utils.filesystem import create_version_file
import tempfile
import json
import http.client
import zipfile

class HCL:
    def __init__(self, schema_data, provider_name):
        self.terraform_state_file = "terraform.tfstate"
        self.schema_data = schema_data
        self.provider_name = provider_name
        self.script_dir = tempfile.mkdtemp()
        self.module_data = {}
        self.ftstacks = {}
        self.unique_ftstacks = set()
        self.ftstacks_files = {}
        self.additional_data = {}
        self.id_key_list = ["id", "arn"]

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


    def replace_special_chars(self, input_string):
        # Define a mapping of special characters to their ASCII representations
        ascii_map = {
            ' ': '',
            '.': '-',
        }

        # Function to replace each match
        def replace(match):
            char = match.group(0)
            return ascii_map.get(char, f'_{ord(char):02X}_')  # Default to hex code representation

        # Replace using a regular expression and the replace function
        output_string = re.sub(r'\s|[-.]|\W', replace, input_string)
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

        if not prev_resources_count:
            print("No state file found.")
            return
        
        print("Initializing Terraform...")
        subprocess.run(["terraform", "init"], check=True)

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
            [shutil.rmtree(os.path.join(folder, f)) if os.path.isdir(os.path.join(folder, f)) else os.remove(os.path.join(folder, f)) for f in os.listdir(folder)]
            # shutil.rmtree(folder)
        os.makedirs(folder, exist_ok=True)
        print(f"Folder '{folder}' has been created.")

    def prepare_folder(self, folder):
        try:
            os.chdir(self.script_dir)
            generated_path = os.path.join(folder)
            self.create_folder(generated_path)
            os.chdir(generated_path)
            create_version_file()
            destination_folder = os.getcwd()
            print("Copying Terraform init files...")
            terraform_folder=os.path.join(
                destination_folder, ".terraform")
            if os.path.exists(terraform_folder):
                shutil.rmtree(terraform_folder)
            temp_dir = os.path.join(self.script_dir, "tmp", ".terraform")
            #Check if temp_dir exists
            if  os.path.exists(temp_dir):
                shutil.copytree(temp_dir, terraform_folder)
        except Exception as e:
            print(e)
            exit()

    def add_stack(self, resource_name, id, ftstack, files=None):
        if ftstack:
            if resource_name not in self.ftstacks:
                self.ftstacks[resource_name] = {}
            if id not in self.ftstacks[resource_name]:
                self.ftstacks[resource_name][id] = {}
            if "ftstack_list" not in self.ftstacks[resource_name][id]:
                self.ftstacks[resource_name][id]["ftstack_list"] = set()
            self.ftstacks[resource_name][id]["ftstack_list"].add(ftstack)
            self.unique_ftstacks.add(ftstack)
            if files:
                if ftstack not in self.ftstacks_files:
                    self.ftstacks_files[ftstack] = []
                self.ftstacks_files[ftstack].append(files)
                
    def id_resource_processed(self, resource_name, id, ftstack):
        if ftstack:
            if resource_name not in self.ftstacks:
                return False
            if id not in self.ftstacks[resource_name]:
                return False
            if "ftstack_list" not in self.ftstacks[resource_name][id]:
                return False
            if ftstack not in self.ftstacks[resource_name][id]["ftstack_list"]:
                return False
            return True

    def add_additional_data(self, resource_type, id, key, value):
        if resource_type not in self.additional_data:
            self.additional_data[resource_type] = {}
        if id not in self.additional_data[resource_type]:
            self.additional_data[resource_type][id] = {}
        self.additional_data[resource_type][id][key] = value
        
    def request_tf_code(self):
        tfstate = None
        # Check if self.terraform_state_file is file bigger than 0
        if not os.path.isfile(self.terraform_state_file):
            return
        print("Requesting Terraform code...")
        print("Sending Terraform state file...", os.path.join(self.script_dir,"generated", self.terraform_state_file))
        with open(self.terraform_state_file, 'r') as f:
            tfstate = json.load(f)

        # Convert tfstate to JSON string
        tfstate_json = json.dumps(tfstate)

        # Define the API endpoint
        api_token = os.environ.get('FT_API_TOKEN')
        api_host = os.environ.get('API_HOST', 'localhost')
        api_port = 8000
        api_path = '/api/hcl/'

        # Create a connection to the API server
        conn = http.client.HTTPConnection(api_host, api_port)
        # Define the request headers
        headers = {'Content-Type': 'application/json', "Authorization": "Bearer " + api_token}

        # Define the request payload
        payload = {
            'tfstate': tfstate_json,
            'provider_name': self.provider_name,
            'ftstacks': self.ftstacks,
            'additional_data': self.additional_data,
            'id_key_list': self.id_key_list,
            'region': self.region,
            'account_id': self.account_id,
        }

        if not tfstate_json:
            print('No resources found')
            return

        # Convert the payload to JSON string
        payload_json = json.dumps(payload, default=list)

        # Send the POST request
        conn.request('POST', api_path, body=payload_json, headers=headers)

        # Get the response from the server
        response = conn.getresponse()
        # Check if the response is successful
        if response.status == 200:
            # Read the response data
            response_data = response.read()

            temp_dir = tempfile.mkdtemp()
            zip_file_path = os.path.join(temp_dir, 'finisterra.zip')
            with open(zip_file_path, 'wb') as zip_file:
                zip_file.write(response_data)

            print('Zip file saved at:', zip_file_path)

            root_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
            #clean up folder
            try:
                os.chdir(os.path.join(root_path,"finisterra"))
                for stack in self.unique_ftstacks:
                    shutil.rmtree(stack)
            except:
                pass
                
            # Unzip the file to the current directory
            with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
                zip_ref.extractall(root_path)
                print('Zip file extracted to:', root_path)


            # Save additional files
            for ftstack, zip_files in self.ftstacks_files.items():
                for zip_file in zip_files:
                    print("zip_file", zip_file)
                    base_dir = zip_file["base_dir"]
                    filename = zip_file["filename"]
                    target_dir = os.path.join(root_path, "finisterra", ftstack, filename)
                    print('source', os.path.join(base_dir,filename))
                    print('target_dir', target_dir)
                    os.makedirs(os.path.dirname(target_dir), exist_ok=True)
                    shutil.copyfile(os.path.join(base_dir,filename), target_dir)

            
            if True: #TO-DO Change to a flag
                # plan the terragrunt
                print("Planning Terraform...")
                os.chdir(os.path.join(root_path,"finisterra"))
                shutil.copyfile("./terragrunt.hcl", "./terragrunt.hcl.remote-state")
                shutil.copyfile("./terragrunt.hcl.local-state", "./terragrunt.hcl")
                for stack in self.unique_ftstacks:
                    subprocess.run(["terragrunt", "run-all", "init", "--terragrunt-include-dir", stack], check=True)
                    subprocess.run(["terragrunt", "run-all", "plan", "--terragrunt-include-dir", stack], check=True)
                shutil.copyfile("./terragrunt.hcl", "./terragrunt.hcl.local-state")
                shutil.copyfile("./terragrunt.hcl.remote-state", "./terragrunt.hcl")

        else:
            print(response.status, response.reason)

        conn.close()
