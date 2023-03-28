import os
import boto3
import os
import subprocess
import shutil
import json
from utils.hcl import HCL

class Route53:
    def __init__(self, session, script_dir, provider_name, schema_data, region):
        self.session=session
        self.        self.transform_rules = {
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
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data=schema_data
        self.hcl = HCL(self.schema_data, self.provider_name, self.script_dir, self.transform_rules)
        self.region=region


    def route53(self):
        self.hcl.prepare_folder(os.path.join("generated","route53"))
        self.process_route53()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def process_route53(self):
        route53 = self.session.client("route53", region_name=self.region)

        print("Processing Route53 hosted zones and records...")
        paginator = route53.get_paginator("list_hosted_zones")
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


