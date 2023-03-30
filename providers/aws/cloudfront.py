import os
from utils.hcl import HCL


class CloudFront:
    def __init__(self, cloudfront_client, script_dir, provider_name, schema_data, region):
        self.cloudfront_client = self.cloudfront_client_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def cloudfront(self):
        self.hcl.prepare_folder(os.path.join("generated", "cloudfront"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_cloudfront_cache_policy(self):
        print("Processing CloudFront Cache Policies...")

        paginator = self.cloudfront_client.get_paginator("list_cache_policies")
        for page in paginator.paginate(Type="custom"):
            for cache_policy_summary in page["CachePolicyList"]["Items"]:
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

        paginator = self.cloudfront_client.get_paginator(
            "list_field_level_encryption_configs")
        for page in paginator.paginate():
            for config_summary in page["FieldLevelEncryptionList"]["Items"]:
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

        paginator = self.cloudfront_client.get_paginator(
            "list_field_level_encryption_profiles")
        for page in paginator.paginate():
            for profile_summary in page["FieldLevelEncryptionProfileList"]["Items"]:
                profile_id = profile_summary["Id"]
                print(
                    f"  Processing CloudFront Field-Level Encryption Profile: {profile_id}")

                attributes = {
                    "id": profile_id,
                }

                self.hcl.process_resource(
                    "aws_cloudfront_field_level_encryption_profile", profile_id.replace("-", "_"), attributes)

    def aws_cloudfront_monitoring_subscription(self):
        print("Processing CloudFront Monitoring Subscriptions...")

        paginator = self.cloudfront_client.get_paginator("list_distributions")
        for page in paginator.paginate():
            for distribution_summary in page["DistributionList"]["Items"]:
                distribution_id = distribution_summary["Id"]
                distribution_arn = distribution_summary["ARN"]

                monitoring_subscription = self.cloudfront_client.get_monitoring_subscription(
                    DistributionId=distribution_id)["MonitoringSubscription"]

                if monitoring_subscription.get("RealtimeMetricsSubscriptionConfig"):
                    print(
                        f"  Processing CloudFront Monitoring Subscription: {distribution_id}")

                    attributes = {
                        "id": distribution_id,
                        "distribution_arn": distribution_arn,
                    }

                    self.hcl.process_resource(
                        "aws_cloudfront_monitoring_subscription", distribution_id.replace("-", "_"), attributes)

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

    # def aws_cloudfront_origin_access_control(self):
    #     print("Processing CloudFront Origin Access Controls...")

    #     # AWS CloudFront does not provide a specific API to describe Origin Access Controls,
    #     # but you can extract the required information from the CloudFront distribution configuration.

    def aws_cloudfront_origin_request_policy(self):
        print("Processing CloudFront Origin Request Policies...")
        paginator = self.cloudfront_client.get_paginator(
            "list_origin_request_policies")

        for page in paginator.paginate():
            for policy_summary in page["OriginRequestPolicies"]["Items"]:
                policy_id = policy_summary["Id"]
                print(
                    f"  Processing CloudFront Origin Request Policy: {policy_id}")

                policy = self.cloudfront_client.get_origin_request_policy(
                    Id=policy_id)["OriginRequestPolicy"]
                attributes = {
                    "id": policy_id,
                    "name": policy["OriginRequestPolicyConfig"]["Name"],
                    "comment": policy["OriginRequestPolicyConfig"].get("Comment", ""),
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

    def aws_cloudfront_realtime_log_config(self):
        print("Processing CloudFront Realtime Log Configs...")
        paginator = self.cloudfront_client.get_paginator(
            "list_realtime_log_configs")

        for page in paginator.paginate():
            for log_config in page["RealtimeLogConfigs"]["Items"]:
                log_config_id = log_config["Id"]
                print(
                    f"  Processing CloudFront Realtime Log Config: {log_config_id}")

                attributes = {
                    "id": log_config_id,
                    "name": log_config["Name"],
                    "fields": log_config["Fields"],
                    # Add other required attributes, like "sampling_rate" and "endpoint"
                    # You may need to process the "Endpoints" list and extract the necessary information
                }
                self.hcl.process_resource(
                    "aws_cloudfront_realtime_log_config", log_config_id.replace("-", "_"), attributes)

    def aws_cloudfront_response_headers_policy(self):
        print("Processing CloudFront Response Headers Policies...")
        paginator = self.cloudfront_client.get_paginator(
            "list_response_headers_policies")

        for page in paginator.paginate():
            for headers_policy in page["ResponseHeadersPolicies"]["Items"]:
                policy_id = headers_policy["Id"]
                print(
                    f"  Processing CloudFront Response Headers Policy: {policy_id}")

                policy = self.cloudfront_client.get_response_headers_policy(
                    Id=policy_id)["ResponseHeadersPolicy"]
                attributes = {
                    "id": policy_id,
                    "name": policy["ResponseHeadersPolicyConfig"]["Name"],
                    "comment": policy["ResponseHeadersPolicyConfig"].get("Comment", ""),
                    # Add other required attributes, like "cors_config", "security_headers_config", etc.
                    # You may need to process the configuration dictionaries and extract the necessary information
                }
                self.hcl.process_resource(
                    "aws_cloudfront_response_headers_policy", policy_id.replace("-", "_"), attributes)
