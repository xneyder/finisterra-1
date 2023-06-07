import botocore
import os
from utils.hcl import HCL


def cors_config_transform(value):
    return "{items="+str(value)+"}\n"
    # if value == []:
    #     return {"items": []}
    # else:
    #     return value


# def convert_to_terraform_format(env_variables_dict):
#     # Format the dictionary to Terraform format
#     # terraform_format = "variables = {\n"
#     print(env_variables_dict)
#     terraform_format = "{\n"
#     for key, value in env_variables_dict.items():
#         # Escape the double quotes
#         value = str(value).replace('"', '\\"')
#         terraform_format += f"  {key} = \"{value}\"\n"
#     terraform_format += "}"

#     return terraform_format


class CloudFront:
    def __init__(self, cloudfront_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key):
        self.cloudfront_client = cloudfront_client
        self.transform_rules = {
            "aws_cloudfront_response_headers_policy": {
                "hcl_apply_function_block": {
                    "cors_config.access_control_allow_headers": {'function': [cors_config_transform]},
                    "cors_config.access_control_allow_methods": {'function': [cors_config_transform]}
                },
            },
            "aws_cloudfront_distribution": {
                "hcl_keep_fields": {"origin.domain_name": True, },
            },
            # "aws_cloudfront_response_headers_policy": {
            #     "hcl_keep_fields": {'source': [], 'target': '{items=[]}'},
            # },
            # "aws_cloudfront_response_headers_policy": {
            #     "hcl_transform_fields": {
            #         "access_control_allow_headers": {'source': [], 'target': '{items=[]}'},
            #     },
            # },
            # "aws_cloudfront_response_headers_policy": {
            #     "hcl_apply_function": {
            #         "identity_validation_expression": {'function': [replace_backslashes]}
            #     },
            # },

            # "aws_cloudfront_response_headers_policy": {
            #     "hcl_keep_fields": {"cors_config.access_control_allow_headers": True},
            # },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key)
        self.resource_list = {}

    def cloudfront(self):
        self.hcl.prepare_folder(os.path.join("generated", "cloudfront"))

        if "gov" not in self.region:
            self.aws_cloudfront_cache_policy()
            self.aws_cloudfront_distribution()
            self.aws_cloudfront_field_level_encryption_config()
            self.aws_cloudfront_field_level_encryption_profile()
            self.aws_cloudfront_function()
            self.aws_cloudfront_key_group()
            self.aws_cloudfront_monitoring_subscription()
            # self.aws_cloudfront_origin_access_control()  # No API from AWS
            self.aws_cloudfront_origin_access_identity()
            self.aws_cloudfront_origin_request_policy()
            self.aws_cloudfront_public_key()
            self.aws_cloudfront_realtime_log_config()
            self.aws_cloudfront_response_headers_policy()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_cloudfront_cache_policy(self):
        print("Processing CloudFront Cache Policies...")

        response = self.cloudfront_client.list_cache_policies(Type="custom")
        if "CachePolicyList" in response and "Items" in response["CachePolicyList"]:
            for cache_policy_summary in response["CachePolicyList"]["Items"]:
                cache_policy = cache_policy_summary["CachePolicy"]
                cache_policy_id = cache_policy["Id"]
                print(
                    f"  Processing CloudFront Cache Policy: {cache_policy_id}")

                attributes = {
                    "id": cache_policy_id,
                    "name": cache_policy["CachePolicyConfig"]["Name"],
                }

                self.hcl.process_resource(
                    "aws_cloudfront_cache_policy", cache_policy_id.replace("-", "_"), attributes)

    def aws_cloudfront_distribution(self):
        print("Processing CloudFront Distributions...")

        paginator = self.cloudfront_client.get_paginator("list_distributions")
        for page in paginator.paginate():
            for distribution_summary in page["DistributionList"]["Items"]:
                distribution_id = distribution_summary["Id"]
                print(
                    f"  Processing CloudFront Distribution: {distribution_id}")

                attributes = {
                    "id": distribution_id,
                    "arn": distribution_summary["ARN"],
                    "domain_name": distribution_summary["DomainName"],
                }

                self.hcl.process_resource(
                    "aws_cloudfront_distribution", distribution_id.replace("-", "_"), attributes)

    def aws_cloudfront_field_level_encryption_config(self):
        print("Processing CloudFront Field-Level Encryption Configs...")

        response = self.cloudfront_client.list_field_level_encryption_configs()
        if "FieldLevelEncryptionList" in response and "Items" in response["FieldLevelEncryptionList"]:
            for config_summary in response["FieldLevelEncryptionList"]["Items"]:
                config_id = config_summary["Id"]
                print(
                    f"  Processing CloudFront Field-Level Encryption Config: {config_id}")

                attributes = {
                    "id": config_id,
                }

                self.hcl.process_resource(
                    "aws_cloudfront_field_level_encryption_config", config_id.replace("-", "_"), attributes)

    def aws_cloudfront_field_level_encryption_profile(self):
        print("Processing CloudFront Field-Level Encryption Profiles...")

        response = self.cloudfront_client.list_field_level_encryption_profiles()
        if "FieldLevelEncryptionProfileList" in response and "Items" in response["FieldLevelEncryptionProfileList"]:
            for profile_summary in response["FieldLevelEncryptionProfileList"]["Items"]:
                profile_id = profile_summary["Id"]
                print(
                    f"  Processing CloudFront Field-Level Encryption Profile: {profile_id}")

                attributes = {
                    "id": profile_id,
                }

                self.hcl.process_resource(
                    "aws_cloudfront_field_level_encryption_profile", profile_id.replace("-", "_"), attributes)

    def aws_cloudfront_function(self):
        print("Processing CloudFront Functions...")

        response = self.cloudfront_client.list_functions()
        if "FunctionSummaryList" in response:
            for function_summary in response["FunctionSummaryList"]:
                function_arn = function_summary["FunctionMetadata"]["FunctionARN"]
                function_name = function_summary["FunctionConfig"]["Name"]

                print(f"  Processing CloudFront Function: {function_name}")

                attributes = {
                    "id": function_arn,
                    "name": function_name,
                }

                self.hcl.process_resource(
                    "aws_cloudfront_function", function_name.replace("-", "_"), attributes)

    def aws_cloudfront_key_group(self):
        print("Processing CloudFront Key Groups...")

        response = self.cloudfront_client.list_key_groups()
        if "KeyGroupList" in response and "Items" in response["KeyGroupList"]:
            for key_group in response["KeyGroupList"]["Items"]:
                key_group_id = key_group["KeyGroup"]["Id"]
                key_group_name = key_group["KeyGroup"]["KeyGroupName"]

                print(f"  Processing CloudFront Key Group: {key_group_name}")

                attributes = {
                    "id": key_group_id,
                    "name": key_group_name,
                }

                self.hcl.process_resource(
                    "aws_cloudfront_key_group", key_group_id.replace("-", "_"), attributes)

    def aws_cloudfront_monitoring_subscription(self):
        print("Processing CloudFront Monitoring Subscriptions...")

        paginator = self.cloudfront_client.get_paginator("list_distributions")
        for page in paginator.paginate():
            for distribution_summary in page["DistributionList"]["Items"]:
                distribution_id = distribution_summary["Id"]
                distribution_arn = distribution_summary["ARN"]

                try:
                    monitoring_subscription = self.cloudfront_client.get_monitoring_subscription(
                        DistributionId=distribution_id)["MonitoringSubscription"]

                    if monitoring_subscription.get("RealtimeMetricsSubscriptionConfig"):
                        print(
                            f"  Processing CloudFront Monitoring Subscription: {distribution_id}")

                        attributes = {
                            "id": distribution_id,
                            "distribution_id": distribution_id,
                            "distribution_arn": distribution_arn,
                        }

                        self.hcl.process_resource(
                            "aws_cloudfront_monitoring_subscription", distribution_id.replace("-", "_"), attributes)
                except botocore.exceptions.ClientError as e:
                    if e.response['Error']['Code'] == 'NoSuchMonitoringSubscription':
                        print(
                            f"No monitoring subscription found for distribution: {distribution_id}")
                    else:
                        raise

    def aws_cloudfront_origin_access_identity(self):
        print("Processing CloudFront Origin Access Identities...")

        paginator = self.cloudfront_client.get_paginator(
            "list_cloud_front_origin_access_identities")
        for page in paginator.paginate():
            for oai_summary in page["CloudFrontOriginAccessIdentityList"]["Items"]:
                oai_id = oai_summary["Id"]
                oai_comment = oai_summary["Comment"]
                print(
                    f"  Processing CloudFront Origin Access Identity: {oai_id}")

                attributes = {
                    "id": oai_id,
                    "comment": oai_comment,
                }

                self.hcl.process_resource(
                    "aws_cloudfront_origin_access_identity", oai_id.replace("-", "_"), attributes)

    def aws_cloudfront_origin_request_policy(self):
        print("Processing CloudFront Origin Request Policies...")

        response = self.cloudfront_client.list_origin_request_policies()

        for policy_summary in response["OriginRequestPolicyList"]["Items"]:
            policy_id = policy_summary["OriginRequestPolicy"]["Id"]
            print(
                f"  Processing CloudFront Origin Request Policy: {policy_id}")

            # policy = self.cloudfront_client.get_origin_request_policy(
            #     Id=policy_id)["OriginRequestPolicy"]
            attributes = {
                "id": policy_id,
                # "name": policy["OriginRequestPolicyConfig"]["Name"],
                # "comment": policy["OriginRequestPolicyConfig"].get("Comment", ""),
                # Add other required attributes as needed
            }
            self.hcl.process_resource(
                "aws_cloudfront_origin_request_policy", policy_id.replace("-", "_"), attributes)

    def aws_cloudfront_public_key(self):
        print("Processing CloudFront Public Keys...")
        paginator = self.cloudfront_client.get_paginator("list_public_keys")

        for page in paginator.paginate():
            for public_key_summary in page["PublicKeyList"]["Items"]:
                public_key_id = public_key_summary["Id"]
                print(f"  Processing CloudFront Public Key: {public_key_id}")

                public_key = self.cloudfront_client.get_public_key(
                    Id=public_key_id)["PublicKey"]
                attributes = {
                    "id": public_key_id,
                    "name": public_key["PublicKeyConfig"]["Name"],
                    "encoded_key": public_key["PublicKeyConfig"]["EncodedKey"],
                    "comment": public_key["PublicKeyConfig"].get("Comment", ""),
                }
                self.hcl.process_resource(
                    "aws_cloudfront_public_key", public_key_id.replace("-", "_"), attributes)

    def aws_cloudfront_public_key(self):
        print("Processing CloudFront Public Keys...")

        response = self.cloudfront_client.list_public_keys()

        for public_key in response.get("PublicKeyList", {}).get("Items", []):
            public_key_id = public_key["Id"]
            print(f"  Processing CloudFront Public Key: {public_key_id}")

            attributes = {
                "id": public_key_id,
                "name": public_key["Name"],
                # Add other required attributes as needed
            }

            self.hcl.process_resource(
                "aws_cloudfront_public_key", public_key_id.replace("-", "_"), attributes)

    def aws_cloudfront_realtime_log_config(self):
        print("Processing CloudFront Realtime Log Configs...")

        response = self.cloudfront_client.list_realtime_log_configs()

        if "RealtimeLogConfigs" in response and "Items" in response["RealtimeLogConfigs"]:
            for log_config in response["RealtimeLogConfigs"]["Items"]:
                log_config_id = log_config["ARN"]
                print(
                    f"  Processing CloudFront Realtime Log Config: {log_config_id}")

                attributes = {
                    "id": log_config_id,
                    "name": log_config["Name"],
                    "fields": log_config["Fields"],
                    # Add other required attributes as needed
                }

                self.hcl.process_resource(
                    "aws_cloudfront_realtime_log_config", log_config_id.replace("-", "_"), attributes)

    def aws_cloudfront_response_headers_policy(self):
        print("Processing CloudFront Response Headers Policies...")

        response = self.cloudfront_client.list_response_headers_policies()

        for headers_policy in response["ResponseHeadersPolicyList"]["Items"]:
            policy_id = headers_policy["ResponseHeadersPolicy"]["Id"]
            print(
                f"  Processing CloudFront Response Headers Policy: {policy_id}")

            attributes = {
                "id": policy_id,
                # "name": policy["ResponseHeadersPolicyConfig"]["Name"],
                # "comment": policy["ResponseHeadersPolicyConfig"].get("Comment", ""),
                # Add other required attributes, like "cors_config", "security_headers_config", etc.
                # You may need to process the configuration dictionaries and extract the necessary information
            }
            self.hcl.process_resource(
                "aws_cloudfront_response_headers_policy", policy_id.replace("-", "_"), attributes)
