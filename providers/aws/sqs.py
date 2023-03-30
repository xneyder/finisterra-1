import os
from utils.hcl import HCL


class SQS:
    def __init__(self, sqs_client, script_dir, provider_name, schema_data, region):
        self.sqs_client = self.sqs_client_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def sqs(self):
        self.hcl.prepare_folder(os.path.join("generated", "sqs"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_sqs_queue(self):
        print("Processing SQS Queues...")

        paginator = self.sqs_client.get_paginator("list_queues")
        for page in paginator.paginate():
            for queue_url in page.get("QueueUrls", []):
                queue_name = queue_url.split("/")[-1]
                print(f"  Processing SQS Queue: {queue_name}")

                attributes = {
                    "id": queue_name,
                }
                self.hcl.process_resource(
                    "aws_sqs_queue", queue_name.replace("-", "_"), attributes)

    def aws_sqs_queue_policy(self):
        print("Processing SQS Queue Policies...")

        paginator = self.sqs_client.get_paginator("list_queues")
        for page in paginator.paginate():
            for queue_url in page.get("QueueUrls", []):
                queue_name = queue_url.split("/")[-1]
                try:
                    policy = self.sqs_client.get_queue_attributes(
                        QueueUrl=queue_url, AttributeNames=["Policy"])["Attributes"]["Policy"]
                except Exception as e:
                    print(
                        f"Error retrieving SQS Queue Policy for {queue_name}: {str(e)}")
                    continue

                print(f"  Processing SQS Queue Policy: {queue_name}")

                attributes = {
                    "id": queue_name,
                    "queue_url": queue_url,
                    "policy": policy,
                }
                self.hcl.process_resource(
                    "aws_sqs_queue_policy", queue_name.replace("-", "_"), attributes)
