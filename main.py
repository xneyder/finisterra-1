import json
import subprocess
import boto3
import os
import sys

def create_temporary_config(resource_type, resource_name, attributes):
    with open("temp.tf", "w") as temp_file:
        temp_file.write(f'resource "{resource_type}" "{resource_name}"')
        temp_file.write('{')
        for key, value in attributes.items():
            if key != "resource_id":
                temp_file.write(f'  {key} = "{value}"')
        temp_file.write('}')


def search_state_file(resource_type, resource_name, resource_id):
    # Load the state file
    try:
        with open( terraform_state_file, 'r') as f:
            state_data = json.load(f)
        state_resources = state_data['resources']
    except Exception as e:
        print(f'Failed to load state file "{terraform_state_file}": {e}')
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
    if found:
        print(
            f'Resource "{resource_name}" of type "{resource_type}" with ID "{resource_id}" was found in the state.')
    else:
        print(
            f'Resource "{resource_name}" of type "{resource_type}" with ID "{resource_id}" was not found in the state.')

    return found


def load_provider_schema():
    global schema_data
    temp_file='terraform_providers_schema.json'
    # Load the provider schema using the terraform cli
    output = open(temp_file, 'w')
    subprocess.run(["terraform", "providers", "schema",
                   "-json"], check=True, stdout=output)
    with open(temp_file, "r") as schema_file:
        schema_data = json.load(schema_file)
    # remove the temporary file
    subprocess.run(["rm", temp_file], check=True)
    return schema_data


def create_state_file(resource_type, resource_name, attributes):
    schema_version = int(schema_data['provider_schemas'][provider_name]
                         ['resource_schemas'][resource_type]['version'])
    # create resource
    resource = {
        "mode": "managed",
        "type": resource_type,
        "name": resource_name,
        "provider": f"provider[\"{provider_name}\"]",
        "instances": [
            {
                "schema_version": schema_version,
                "attributes": attributes
            }
        ]
    }
    # Load the state file
    try:
        with open( terraform_state_file, 'r') as f:
            state_data = json.load(f)
        # add resource to state
        state_data['resources'].append(resource)
    except Exception as e:
        print(
            f'State file "{terraform_state_file}" does not exist. Creating a new one.')
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
    with open( terraform_state_file, 'w') as state_file:
        json.dump(state_data, state_file, indent=2)


def generate_hcl_file():
    print("Generating HCL files from the state file...")
    with open( terraform_state_file, "r") as state_file:
        state_data = json.load(state_file)

    for resource in state_data["resources"]:
        attributes = resource["instances"][0]["attributes"]
        resource_type = resource["type"]
        resource_name = resource["name"]

        schema_attributes = schema_data['provider_schemas'][provider_name][
            'resource_schemas'][resource_type]["block"]["attributes"]
        schema_block_types = schema_data['provider_schemas'][provider_name][
            'resource_schemas'][resource_type]["block"].get("block_types", {})

        def convert_value(value):
            if isinstance(value, bool):
                return "true" if value else "false"
            if isinstance(value, (int, float)):
                return str(value)
            if isinstance(value, str):
                return f'"{value}"'
            if isinstance(value, list):
                return "[" + ", ".join([convert_value(v) for v in value]) + "]"
            if isinstance(value, dict):
                return "{" + ", ".join([f'{k}={convert_value(v)}' for k, v in value.items()]) + "}"
            return ""

        with open( f"{resource_type}_{resource_name}.tf", "w") as hcl_output:
            hcl_output.write(
                f'resource "{resource_type}" "{resource_name}" {{\n')
            for key, value in attributes.items():

                if resource_type in transform_rules:
                    if 'hcl_drop_fields' in transform_rules[resource_type]:
                        hcl_drop_fields = transform_rules[resource_type]['hcl_drop_fields']
                        if key in hcl_drop_fields:
                            if hcl_drop_fields[key] == 'ALL' or hcl_drop_fields[key] == value:
                                continue
                    if 'hcl_transform_fields' in transform_rules[resource_type]:
                        hcl_transform_fields = transform_rules[resource_type]['hcl_transform_fields']
                        if key in hcl_transform_fields:
                            if hcl_transform_fields[key]['source'] == value:
                                target = hcl_transform_fields[key]['target']
                                hcl_output.write(
                                    f'  {key} = {convert_value(target)}\n')
                                continue

                # Ignore is key is computed and handled the exception
                try:
                    if schema_attributes[key]['computed']:
                        continue
                except:
                    pass

                if value == None or value == "":
                    continue

                if isinstance(value, dict) and not value:
                    continue

                if isinstance(value, list) and not value:
                    continue

                if key in schema_block_types:
                    if schema_block_types[key]['nesting_mode'] == 'list':
                        for block in value:
                            hcl_output.write(f'  {key} {{\n')
                            for block_key, block_value in block.items():
                                hcl_output.write(
                                    f'    {block_key} = {convert_value(block_value)}\n')
                            hcl_output.write("  }\n")
                        continue

                hcl_output.write(f'  {key} = {convert_value(value)}\n')
            hcl_output.write("}\n")


def process_resource(resource_type, resource_name, attributes):
    resource_id = attributes["id"]
    # create_temporary_config(resource_type, resource_name, attributes)
    # search if resource exists in the state
    if not search_state_file(resource_type, resource_name, resource_id):
        print("Importing resource...")
        create_state_file(resource_type, resource_name, attributes)
        # subprocess.run(["terraform", "import", resource_type+"." +
        #                 resource_name, resource_id], check=True)


def main():
    print("Fetching AWS resources using boto3...")

    aws_profile = "appkube"  # Update this with your AWS profile name, if needed
    region = "us-east-1"  # Replace with your desired region

    session = boto3.Session(profile_name=aws_profile)
    route53 = session.client("route53", region_name=region)
    ec2 = session.client("ec2", region_name=region)


    print("Processing VPCs...")
    prepare_folder(os.path.join("generated","vpc"))
    vpcs = ec2.describe_vpcs()["Vpcs"]
    generated=False
    for vpc in vpcs:
        vpc_id = vpc["VpcId"]
        print(f"  Processing VPC: {vpc_id}")
        attributes = {
            "id": vpc_id,
        }
        process_resource("aws_vpc", vpc_id.replace("-", "_"), attributes)
        generated=True
    
    if generated:
        print("Refreshing state...")
        subprocess.run(["terraform", "refresh"], check=True)
        # Generate HCL files from the state file
        generate_hcl_file()



    print("Processing Route53 hosted zones and records...")
    prepare_folder(os.path.join("generated","route53"))
    paginator = route53.get_paginator("list_hosted_zones")
    generated=False
    for page in paginator.paginate():
        for hosted_zone in page["HostedZones"]:
            zone_id = hosted_zone["Id"].split("/")[-1]
            zone_name = hosted_zone["Name"].rstrip(".")

            attributes = {
                "id": zone_id,
            }
            print(f"Processing hosted zone: {zone_name} (ID: {zone_id})")

            process_resource("aws_route53_zone",
                             zone_name.replace(".", "_"), attributes)
            generated=True

            record_paginator = route53.get_paginator(
                "list_resource_record_sets")
            for record_page in record_paginator.paginate(HostedZoneId=hosted_zone["Id"]):
                for record in record_page["ResourceRecordSets"]:
                    record_name = record["Name"].rstrip(".")
                    record_type = record["Type"]

                    if record_type in ["SOA", "NS"]:
                        continue

                    print(
                        f"  Processing record: {record_name} ({record_type})")

                    resource_name = f"{zone_name}_{record_name}_{record_type}".replace(
                        ".", "_")
                    resource_id = f"{zone_id}_{record_name}_{record_type}"
                    attributes = {
                        "id": resource_id,
                        "type": record_type,
                        "name": record_name,
                        "zone_id": zone_id,
                    }
                    process_resource("aws_route53_record",
                                     resource_name, attributes)
                    generated=True
    if generated:
        print("Refreshing state...")
        subprocess.run(["terraform", "refresh"], check=True)
        # Generate HCL files from the state file
        generate_hcl_file()

    print("Finished processing AWS resources.")

def prepare_folder(folder):
    os.chdir(script_dir)
    generated_path=os.path.join(folder)
    create_folder(generated_path)
    os.chdir(generated_path)
    create_version_file()
    print("Initializing Terraform...")
    subprocess.run(["terraform", "init"], check=True)

def create_version_file():
    with open("version.tf", "w") as version_file:
        version_file.write('terraform {\n')
        version_file.write('  required_providers {\n')
        version_file.write('  aws = {\n')
        version_file.write('  source  = "hashicorp/aws"\n')
        version_file.write('  version = "~> 4.0"\n')
        version_file.write('}\n')
        version_file.write('}\n')
        version_file.write('}\n')

def create_folder(folder):
    if not os.path.exists(folder):
        os.makedirs(folder)
        print(f"Folder '{folder}' has been created.")
    else:
        print(f"Folder '{folder}' already exists.")

if __name__ == "__main__":

    terraform_state_file = "terraform.tfstate"
    provider_name = "registry.terraform.io/hashicorp/aws"

    transform_rules = {
        "aws_vpc": {
            "hcl_drop_fields": {"ipv6_netmask_length": 0},
        },
        "aws_route53_zone": {
            "hcl_transform_fields": {
                "force_destroy": {'source': None, 'target': False},
                "comment": {'source': "", 'target': ""},
            },
        },
        "aws_route53_record": {
            "hcl_drop_fields": {
                "multivalue_answer_routing_policy": False,
                "ttl": 0,
            },
        },
    }

    script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))

    # Load the provider schema
    schema_data = load_provider_schema()

    main()
