import os
import boto3
import os
import subprocess
import shutil
import json
from utils.hcl import HCL

class Aws:
    def __init__(self, script_dir):
        self.aws_access_key_id = os.getenv("AWS_ACCESS_KEY_ID")
        self.aws_secret_access_key = os.getenv("AWS_SECRET_ACCESS_KEY")
        self.aws_session_token = os.getenv("AWS_SESSION_TOKEN")
        self.region = os.getenv("AWS_REGION")

        if self.aws_access_key_id and self.aws_secret_access_key and self.region:
            self.session = boto3.Session(
                aws_access_key_id=self.aws_access_key_id,
                aws_secret_access_key=self.aws_secret_access_key,
                aws_session_token=self.aws_session_token,
                region_name=self.region,
            )
        else:
            print("AWS credentials not found in environment variables.")
            exit()

        self.transform_rules = {
            "aws_vpc": {
                "hcl_drop_fields": {"ipv6_netmask_length": 0},
                "hcl_keep_fields": {"cidr_block": True},
            },
            "aws_subnet": {
                "hcl_drop_fields": {"map_customer_owned_ip_on_launch": False},
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
        self.provider_name = "registry.terraform.io/hashicorp/aws"
        self.script_dir = script_dir
        self.schema_data=self.load_provider_schema()
        self.hcl = HCL(self.schema_data, self.provider_name, self.script_dir, self.transform_rules)

    def create_folder(self,folder):
        if not os.path.exists(folder):
            os.makedirs(folder)
            print(f"Folder '{folder}' has been created.")
        else:
            print(f"Folder '{folder}' already exists.")
    
    def load_provider_schema(self):
        self.create_folder(os.path.join("tmp"))
        os.chdir(os.path.join("tmp"))
        self.create_version_file()
        print("Initializing Terraform...")
        subprocess.run(["terraform", "init"], check=True)
        print("Loading provider schema...")
        global schema_data
        temp_file='terraform_providers_schema.json'
        # Load the provider schema using the terraform cli
        output = open(temp_file, 'w')
        subprocess.run(["terraform", "providers", "schema",
                    "-json"], check=True, stdout=output)
        with open(temp_file, "r") as schema_file:
            schema_data = json.load(schema_file)
        # remove the temporary file
        os.chdir(self.script_dir)
        shutil.rmtree(os.path.join("tmp"))
        return schema_data
    
    def create_version_file(self):
        with open("version.tf", "w") as version_file:
            version_file.write('terraform {\n')
            version_file.write('  required_providers {\n')
            version_file.write('  aws = {\n')
            version_file.write('  source  = "hashicorp/aws"\n')
            version_file.write('  version = "~> 4.0"\n')
            version_file.write('}\n')
            version_file.write('}\n')
            version_file.write('}\n')

    def prepare_folder(self,folder):
        os.chdir(self.script_dir)
        generated_path=os.path.join(folder)
        self.hcl.create_folder(generated_path)
        os.chdir(generated_path)
        self.create_version_file()
        print("Initializing Terraform...")
        subprocess.run(["terraform", "init"], check=True)

    def process_route53(self):
        route53 = self.session.client("route53", region_name=self.region)

        print("Processing Route53 hosted zones and records...")
        self.prepare_folder(os.path.join("generated","route53"))
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

                self.hcl.process_resource("aws_route53_zone",
                                zone_id+"_"+zone_name.replace(".", "_"), attributes)
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
                        self.hcl.process_resource("aws_route53_record",
                                        resource_name, attributes)
                        generated=True
        if generated:
            self.hcl.refresh_state()
            self.hcl.generate_hcl_file()


    def process_vpc(self):
        ec2 = self.session.client("ec2", region_name=self.region)

        print("Processing VPCs...")
        self.prepare_folder(os.path.join("generated","vpc"))
        vpcs = ec2.describe_vpcs()["Vpcs"]
        generated=False
        for vpc in vpcs:
            vpc_id = vpc["VpcId"]
            print(f"  Processing VPC: {vpc_id}")
            attributes = {
                "id": vpc_id,
            }
            self.hcl.process_resource("aws_vpc", vpc_id.replace("-", "_"), attributes)

            print(f"  Processing Subnets for VPC: {vpc_id}")
            subnets = ec2.describe_subnets(Filters=[{"Name": "vpc-id", "Values": [vpc_id]}])["Subnets"]
            for subnet in subnets:
                subnet_id = subnet["SubnetId"]
                print(f"    Processing Subnet: {subnet_id}")
                attributes = {
                    "id": subnet_id,
                    "vpc_id": vpc_id,
                    "cidr_block": subnet["CidrBlock"],
                    "availability_zone": subnet["AvailabilityZone"],
                }
                self.hcl.process_resource("aws_subnet", subnet_id.replace("-", "_"), attributes)
                generated=True
        
        if generated:
            self.hcl.refresh_state()
            self.hcl.generate_hcl_file()            


