import os
from utils.hcl import HCL


class SNS:
    def __init__(self, sns_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules):
        self.sns_client = sns_client
        self.transform_rules = {
            "aws_sns_topic_policy": {
                "hcl_json_multiline": {"policy": True}
            },
            "aws_sns_topic_subscription": {
                "hcl_json_multiline": {"filter_policy": True}
            },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}

    def build_subscriptions(self, attributes):
        key = attributes['arn'].split(':')[-1]
        result = {key: {}}
        for k, v in attributes.items():
            if v:
                result[key][k] = v
        return result

    def get_key_from_arn(self, attributes):
        key = attributes['arn'].split(':')[-1]
        return key

    def signature_version(self, attributes):
        signature_version = attributes.get("signature_version", None)
        if signature_version != 0:
            return signature_version
        return None

    def sns(self):
        self.hcl.prepare_folder(os.path.join("generated", "sns"))

        # self.aws_sns_platform_application()
        # self.aws_sns_sms_preferences()
        self.aws_sns_topic()

        functions = {
            'build_subscriptions': self.build_subscriptions,
            'signature_version': self.signature_version,
            'get_key_from_arn': self.get_key_from_arn,
        }

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "sns.yaml"), functions)

        exit()

        self.json_plan = self.hcl.json_plan

    def aws_sns_platform_application(self):
        print("Processing SNS Platform Applications...")

        paginator = self.sns_client.get_paginator("list_platform_applications")
        for page in paginator.paginate():
            for platform_application in page.get("PlatformApplications", []):
                arn = platform_application["PlatformApplicationArn"]
                name = arn.split(":")[-1]
                print(f"  Processing SNS Platform Application: {name}")

                attributes = {
                    "id": arn,
                    "name": name,
                }
                self.hcl.process_resource(
                    "aws_sns_platform_application", name.replace("-", "_"), attributes)

    def aws_sns_sms_preferences(self):
        print("Processing SNS SMS Preferences...")

        try:
            preferences = self.sns_client.get_sms_attributes()["attributes"]
            attributes = {key: value for key, value in preferences.items()}

            self.hcl.process_resource(
                "aws_sns_sms_preferences", "sns_sms_preferences", attributes)
        except Exception as e:
            print(f"Error retrieving SNS SMS Preferences: {str(e)}")

    def aws_sns_topic(self):
        print("Processing SNS Topics...")

        paginator = self.sns_client.get_paginator("list_topics")
        for page in paginator.paginate():
            for topic in page.get("Topics", []):
                arn = topic["TopicArn"]
                name = arn.split(":")[-1]

                # if name != 'learning-mediaAssetModified':
                #     continue
                print(f"  Processing SNS Topic: {name}")

                attributes = {
                    "id": arn,
                    "name": name,
                }
                self.hcl.process_resource(
                    "aws_sns_topic", name.replace("-", "_"), attributes)

                self.aws_sns_topic_policy(arn)
                self.aws_sns_topic_data_protection_policy(arn)
                self.aws_sns_topic_subscription(arn)

    def aws_sns_topic_policy(self, arn):
        print("Processing SNS Topic Policies...")

        name = arn.split(":")[-1]

        try:
            policy = self.sns_client.get_topic_attributes(
                TopicArn=arn)["Attributes"].get("Policy")
            if policy:
                attributes = {
                    "id": arn,
                    "arn": arn,
                    "policy": policy,
                }
                self.hcl.process_resource(
                    "aws_sns_topic_policy", f"{name}_policy".replace("-", "_"), attributes)
        except Exception as e:
            print(f"Error retrieving SNS Topic Policy for {name}: {str(e)}")

    def aws_sns_topic_data_protection_policy(self, arn):
        print("Processing SNS Topic Data Protection Policies...")

        name = arn.split(":")[-1]

        try:
            policy = self.sns_client.get_topic_attributes(
                TopicArn=arn)["Attributes"].get("DataProtectionPolicy")
            if policy:
                attributes = {
                    "id": arn,
                    "arn": arn,
                    "data_protection_policy": policy,
                }
                self.hcl.process_resource(
                    "aws_sns_topic_data_protection_policy", f"{name}_data_protection_policy".replace("-", "_"), attributes)
        except Exception as e:
            print(
                f"Error retrieving SNS Topic Data Protection Policy for {name}: {str(e)}")

    def aws_sns_topic_subscription(self, topic_arn):
        print("Processing SNS Topic Subscriptions...")

        paginator = self.sns_client.get_paginator("list_subscriptions")
        for page in paginator.paginate():
            for subscription in page.get("Subscriptions", []):
                # Process only subscriptions for the given topic ARN
                if subscription["TopicArn"] == topic_arn:
                    arn = subscription["SubscriptionArn"]
                    if arn == "PendingConfirmation":
                        continue
                    name = arn.split(":")[-1]
                    print(f"  Processing SNS Topic Subscription: {name}")

                    attributes = {
                        "id": arn,
                        "arn": arn,
                        "topic_arn": subscription["TopicArn"],
                        "protocol": subscription["Protocol"],
                        "endpoint": subscription["Endpoint"],
                    }

                    if subscription.get("FilterPolicy"):
                        attributes["filter_policy"] = subscription["FilterPolicy"]

                    self.hcl.process_resource(
                        "aws_sns_topic_subscription", name.replace("-", "_"), attributes)
