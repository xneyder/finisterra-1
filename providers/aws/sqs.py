import os
from utils.hcl import HCL
import json


class SQS:
    def __init__(self, aws_clients, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id,hcl = None):
        self.aws_clients = aws_clients
        self.transform_rules = {
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.aws_account_id = aws_account_id

        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}
        self.dlq_list = {}

        functions = {
            'aws_sqs_queue_target_name': self.aws_sqs_queue_target_name,
            'sqs_is_dql': self.sqs_is_dql,
            'sqs_get_parent_url': self.sqs_get_parent_url,
        }

        self.hcl.functions.update(functions)        


    def sqs(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_sqs_queue()


        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate","../providers/aws/", {}, self.region, self.aws_account_id)

        self.json_plan = self.hcl.json_plan

    def aws_sqs_queue(self):
        resource_type = "aws_sqs_queue"
        print("Processing SQS Queues...")

        paginator = self.aws_clients.sqs_client.get_paginator("list_queues")
        for page in paginator.paginate():
            for queue_url in page.get("QueueUrls", []):
                queue_name = queue_url.split("/")[-1]

                # if queue_name != 'market-marketSubscriptionTenantIdentityActivationQueue':
                #     continue

                print(f"Processing SQS Queue: {queue_name}")
                id = queue_url

                fstack = "sqs"
                try:
                    tags_response = self.aws_clients.sqs_client.list_queue_tags(QueueUrl=queue_url)
                    tags = tags_response.get('Tags', {})
                    if tags.get('ftstack', 'sqs') != 'sqs':
                        fstack = "stack_"+tags.get('ftstack', 'sqs')
                except Exception as e:
                    print("Error occurred: ", e)

                attributes = {
                    "id": id,
                }
                self.hcl.process_resource(
                    resource_type, id, attributes)
                self.hcl.add_stack(resource_type, id, fstack)

                # Call aws_sqs_queue_policy with the queue_url as an argument
                self.aws_sqs_queue_policy(queue_url)

                # Get the redrive policy for the queue
                response = self.aws_clients.sqs_client.get_queue_attributes(
                    QueueUrl=queue_url,
                    AttributeNames=['RedrivePolicy']
                )

                # If a RedrivePolicy exists, extract and add the DLQ ARN to dlq_list
                if 'Attributes' in response and 'RedrivePolicy' in response['Attributes']:
                    redrive_policy = json.loads(
                        response['Attributes']['RedrivePolicy'])
                    if 'deadLetterTargetArn' in redrive_policy:
                        # get the url of the DLQ by the arn
                        deadLetterTargetArn = redrive_policy['deadLetterTargetArn'].split(":")[-1]
                        try:
                            dlq_url = self.aws_clients.sqs_client.get_queue_url(
                                QueueName=redrive_policy['deadLetterTargetArn'].split(":")[-1])
                            self.dlq_list[dlq_url['QueueUrl']] = queue_url
                        except Exception as e:
                            print("Error occurred: ", e)
                            continue

                # Call aws_sqs_queue_redrive_policy with the queue_url as an argument
                self.aws_sqs_queue_redrive_policy(queue_url)
                self.aws_sqs_queue_redrive_allow_policy(queue_url)

    def aws_sqs_queue_policy(self, queue_url):
        print("Processing SQS Queue Policies...")

        queue_name = queue_url.split("/")[-1]
        response = self.aws_clients.sqs_client.get_queue_attributes(
            QueueUrl=queue_url, AttributeNames=["Policy"])

        if "Attributes" in response and "Policy" in response["Attributes"]:
            policy = response["Attributes"]["Policy"]

            print(f"  Processing SQS Queue Policy: {queue_name}")

            attributes = {
                "id": queue_url,
                "policy": policy,
            }
            self.hcl.process_resource(
                "aws_sqs_queue_policy", queue_name.replace("-", "_"), attributes)
        else:
            print(f"  No policy found for SQS Queue: {queue_name}")

    def aws_sqs_queue_redrive_policy(self, queue_url):
        print("Processing SQS Queue Redrive Policies...")

        queue_name = queue_url.split("/")[-1]
        response = self.aws_clients.sqs_client.get_queue_attributes(
            QueueUrl=queue_url,
            AttributeNames=['RedrivePolicy']
        )

        # If a RedrivePolicy exists, process it as a separate resource
        if 'Attributes' in response and 'RedrivePolicy' in response['Attributes']:
            redrive_policy = response['Attributes']['RedrivePolicy']
            print(f"  Processing SQS Queue Redrive Policy: {queue_name}")

            # Process the redrive policy as a separate resource
            attributes = {
                "id": queue_url,
                "redrive_policy": redrive_policy,
            }
            self.hcl.process_resource(
                "aws_sqs_queue_redrive_policy", queue_name.replace("-", "_"), attributes)
        else:
            print(f"  No redrive policy found for SQS Queue: {queue_name}")

    def aws_sqs_queue_redrive_allow_policy(self, queue_url):
        print("Processing SQS Queue Redrive Allow Policies...")

        queue_name = queue_url.split("/")[-1]
        response = self.aws_clients.sqs_client.get_queue_attributes(
            QueueUrl=queue_url,
            # AttributeNames=['RedriveAllowPolicy']
        )

        # If a Policy exists, process it as a separate resource
        if 'Attributes' in response and 'Policy' in response['Attributes']:
            redrive_allow_policy = response['Attributes']['RedriveAllowPolicy']
            print(f"  Processing SQS Queue Redrive Allow Policy: {queue_name}")

            # Process the allow policy as a separate resource
            attributes = {
                "id": queue_url,
                "redrive_allow_policy": redrive_allow_policy,
            }
            self.hcl.process_resource(
                "aws_sqs_queue_redrive_allow_policy", queue_name.replace("-", "_"), attributes)
        else:
            print(f"  No allow policy found for SQS Queue: {queue_name}")
