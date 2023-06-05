import os
from utils.hcl import HCL
from botocore.exceptions import ClientError


class S3:
    def __init__(self, s3_session, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key):
        self.s3_session = s3_session
        self.transform_rules = {
            "aws_s3_bucket_policy": {
                "hcl_json_multiline": {"policy": True}
            }
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key)
        self.resource_list = {}

    def s3(self):
        self.hcl.prepare_folder(os.path.join("generated", "s3"))

        self.aws_s3_bucket()
        if "gov" not in self.region:
            self.aws_s3_bucket_accelerate_configuration()
            self.aws_s3_bucket_intelligent_tiering_configuration()

        self.aws_s3_bucket_acl()
        self.aws_s3_bucket_analytics_configuration()
        self.aws_s3_bucket_cors_configuration()
        self.aws_s3_bucket_inventory()
        self.aws_s3_bucket_lifecycle_configuration()
        self.aws_s3_bucket_logging()
        self.aws_s3_bucket_metric()
        self.aws_s3_bucket_notification()
        self.aws_s3_bucket_object_lock_configuration()
        self.aws_s3_bucket_ownership_controls()
        self.aws_s3_bucket_policy()
        self.aws_s3_bucket_public_access_block()
        self.aws_s3_bucket_replication_configuration()
        self.aws_s3_bucket_request_payment_configuration()
        self.aws_s3_bucket_server_side_encryption_configuration()
        self.aws_s3_bucket_versioning()
        self.aws_s3_bucket_website_configuration()
        # self.aws_s3_bucket_object() # Too long to add

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_s3_bucket(self):
        print("Processing S3 Buckets...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            print(f"  Processing S3 Bucket: {bucket_name}")

            attributes = {
                "id": bucket_name,
                "bucket": bucket_name,
            }

            self.hcl.process_resource(
                "aws_s3_bucket", bucket_name.replace("-", "_"), attributes)

    def aws_s3_bucket_accelerate_configuration(self):
        print("Processing S3 Bucket Accelerate Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            try:
                accelerate_config = self.s3_session.get_bucket_accelerate_configuration(
                    Bucket=bucket_name)
                status = accelerate_config.get("Status", None)
                if status:
                    print(
                        f"  Processing S3 Bucket Accelerate Configuration: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "accelerate_status": status,
                    }

                    self.hcl.process_resource(
                        "aws_s3_bucket_accelerate_configuration", bucket_name.replace("-", "_"), attributes)
                else:
                    print(
                        f"  No Accelerate Configuration found for S3 Bucket: {bucket_name}")
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] == "NoSuchAccelerateConfiguration":
                    print(
                        f"  No Accelerate Configuration found for S3 Bucket: {bucket_name}")
                else:
                    raise

    def aws_s3_bucket_acl(self):
        print("Processing S3 Bucket ACLs...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            acl = self.s3_session.get_bucket_acl(Bucket=bucket_name)
            print(f"  Processing S3 Bucket ACL: {bucket_name}")

            attributes = {
                "id": bucket_name,
                "bucket": bucket_name,
                # "acl": acl["Grants"],
            }
            self.hcl.process_resource(
                "aws_s3_bucket_acl", bucket_name.replace("-", "_"), attributes)

    def aws_s3_bucket_analytics_configuration(self):
        print("Processing S3 Bucket Analytics Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            analytics_configs = self.s3_session.list_bucket_analytics_configurations(
                Bucket=bucket_name)

            if "AnalyticsConfigurationList" not in analytics_configs:
                continue

            for config in analytics_configs["AnalyticsConfigurationList"]:
                config_id = config["Id"]
                print(
                    f"  Processing S3 Bucket Analytics Configuration: {config_id} for bucket {bucket_name}")

                attributes = {
                    "id": config_id,
                    "bucket": bucket_name,
                    "name": config_id,
                    "filter": config["Filter"],
                    "storage_class_analysis": config["StorageClassAnalysis"],
                }
                self.hcl.process_resource("aws_s3_bucket_analytics_configuration",
                                          f"{bucket_name}-{config_id}".replace("-", "_"), attributes)

    def aws_s3_bucket_cors_configuration(self):
        print("Processing S3 Bucket CORS Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            try:
                cors = self.s3_session.get_bucket_cors(Bucket=bucket_name)
                print(
                    f"  Processing S3 Bucket CORS Configuration: {bucket_name}")

                attributes = {
                    "id": bucket_name,
                    "bucket": bucket_name,
                    "rule": cors["CORSRules"],
                }
                self.hcl.process_resource(
                    "aws_s3_bucket_cors_configuration", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] == "NoSuchCORSConfiguration":
                    print(f"  No CORS Configuration for bucket: {bucket_name}")
                else:
                    raise

    def aws_s3_bucket_intelligent_tiering_configuration(self):
        print("Processing S3 Bucket Intelligent Tiering Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            intelligent_tiering_configs = self.s3_session.list_bucket_intelligent_tiering_configurations(
                Bucket=bucket_name)

            if "IntelligentTieringConfigurationList" not in intelligent_tiering_configs:
                continue

            for config in intelligent_tiering_configs["IntelligentTieringConfigurationList"]:
                config_id = config["Id"]
                print(
                    f"  Processing S3 Bucket Intelligent Tiering Configuration: {config_id} for bucket {bucket_name}")

                attributes = {
                    "id": config_id,
                    "bucket": bucket_name,
                    "name": config_id,
                    "filter": config["Filter"],
                    "status": config["Status"],
                    "tierings": config["Tierings"],
                }
                self.hcl.process_resource("aws_s3_bucket_intelligent_tiering_configuration",
                                          f"{bucket_name}-{config_id}".replace("-", "_"), attributes)

    def aws_s3_bucket_inventory(self):
        print("Processing S3 Bucket Inventories...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            inventory_configs = self.s3_session.list_bucket_inventory_configurations(
                Bucket=bucket_name)

            if "InventoryConfigurationList" not in inventory_configs:
                continue

            for config in inventory_configs["InventoryConfigurationList"]:
                config_id = config["Id"]
                print(
                    f"  Processing S3 Bucket Inventory: {config_id} for bucket {bucket_name}")

                attributes = {
                    "id": config_id,
                    "bucket": bucket_name,
                    "name": config_id,
                    "destination": config["Destination"],
                    "schedule": config["Schedule"],
                    "included_object_versions": config["IncludedObjectVersions"],
                    "optional_fields": config["OptionalFields"] if "OptionalFields" in config else [],
                    "filter": config["Filter"] if "Filter" in config else None,
                }
                self.hcl.process_resource(
                    "aws_s3_bucket_inventory", f"{bucket_name}-{config_id}".replace("-", "_"), attributes)

    def aws_s3_bucket_lifecycle_configuration(self):
        print("Processing S3 Bucket Lifecycle Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            try:
                lifecycle = self.s3_session.get_bucket_lifecycle_configuration(
                    Bucket=bucket_name)
                print(
                    f"  Processing S3 Bucket Lifecycle Configuration: {bucket_name}")

                attributes = {
                    "id": bucket_name,
                    "bucket": bucket_name,
                    "rule": lifecycle["Rules"],
                }
                self.hcl.process_resource(
                    "aws_s3_bucket_lifecycle_configuration", bucket_name.replace("-", "_"), attributes)
            except ClientError as e:
                if e.response['Error']['Code'] == 'NoSuchLifecycleConfiguration':
                    print(
                        f"  No Lifecycle Configuration for bucket: {bucket_name}")
                else:
                    raise

    def aws_s3_bucket_logging(self):
        print("Processing S3 Bucket Logging...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            logging = self.s3_session.get_bucket_logging(Bucket=bucket_name)
            if "LoggingEnabled" in logging:
                target_bucket = logging["LoggingEnabled"]["TargetBucket"]
                target_prefix = logging["LoggingEnabled"]["TargetPrefix"]
                print(f"  Processing S3 Bucket Logging: {bucket_name}")

                attributes = {
                    "id": bucket_name,
                    "bucket": bucket_name,
                    "target_bucket": target_bucket,
                    "target_prefix": target_prefix,
                }
                self.hcl.process_resource(
                    "aws_s3_bucket_logging", bucket_name.replace("-", "_"), attributes)

    def aws_s3_bucket_metric(self):
        print("Processing S3 Bucket Metrics...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            metrics = self.s3_session.list_bucket_metrics_configurations(
                Bucket=bucket_name)

            if "MetricsConfigurationList" not in metrics:
                continue

            for metric in metrics["MetricsConfigurationList"]:
                metric_id = metric["Id"]
                print(
                    f"  Processing S3 Bucket Metric: {metric_id} for bucket {bucket_name}")

                attributes = {
                    "id": metric_id,
                    "bucket": bucket_name,
                    "name": metric_id,
                    "filter": metric["Filter"] if "Filter" in metric else None,
                }
                self.hcl.process_resource(
                    "aws_s3_bucket_metric", f"{bucket_name}-{metric_id}".replace("-", "_"), attributes)

    def aws_s3_bucket_notification(self):
        print("Processing S3 Bucket Notifications...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            notifications = self.s3_session.get_bucket_notification_configuration(
                Bucket=bucket_name)

            for event in notifications.keys():
                if event != "ResponseMetadata":
                    print(
                        f"  Processing S3 Bucket Notification: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "notification_configuration": {event: notifications[event]},
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_notification", bucket_name.replace("-", "_"), attributes)

    def aws_s3_bucket_object(self):
        print("Processing S3 Bucket Objects...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]
            objects = self.s3_session.list_objects(Bucket=bucket_name)

            for obj in objects.get("Contents", []):
                key = obj["Key"]
                print(
                    f"  Processing S3 Bucket Object: {key} in bucket {bucket_name}")

                attributes = {
                    "id": f"{bucket_name}/{key}",
                    "bucket": bucket_name,
                    "key": key,
                }
                self.hcl.process_resource(
                    "aws_s3_bucket_object", f"{bucket_name}-{key}".replace("-", "_"), attributes)

    def aws_s3_bucket_object_lock_configuration(self):
        print("Processing S3 Bucket Object Lock Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]

            try:
                object_lock_configuration = self.s3_session.get_object_lock_configuration(
                    Bucket=bucket_name)
                config = object_lock_configuration.get(
                    "ObjectLockConfiguration", {})

                if config:
                    print(
                        f"  Processing S3 Bucket Object Lock Configuration: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "object_lock_configuration": config,
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_object_lock_configuration", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "ObjectLockConfigurationNotFoundError":
                    raise
                else:
                    print(
                        f"  No Object Lock Configuration for bucket: {bucket_name}")

    def aws_s3_bucket_ownership_controls(self):
        print("Processing S3 Bucket Ownership Controls...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]

            try:
                ownership_controls = self.s3_session.get_bucket_ownership_controls(
                    Bucket=bucket_name)
                controls = ownership_controls.get("OwnershipControls", {})

                if controls:
                    print(
                        f"  Processing S3 Bucket Ownership Controls: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "ownership_controls": controls,
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_ownership_controls", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "OwnershipControlsNotFoundError":
                    raise
                else:
                    print(f"  No Ownership Controls for bucket: {bucket_name}")

    def aws_s3_bucket_policy(self):
        print("Processing S3 Bucket Policies...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]

            try:
                bucket_policy = self.s3_session.get_bucket_policy(
                    Bucket=bucket_name)
                policy = bucket_policy.get("Policy")

                if policy:
                    print(f"  Processing S3 Bucket Policy: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "policy": policy,
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_policy", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "NoSuchBucketPolicy":
                    raise

    def aws_s3_bucket_public_access_block(self):
        print("Processing S3 Bucket Public Access Blocks...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]

            try:
                public_access_block = self.s3_session.get_public_access_block(
                    Bucket=bucket_name)
                block_config = public_access_block.get(
                    "PublicAccessBlockConfiguration", {})

                if block_config:
                    print(
                        f"  Processing S3 Bucket Public Access Block: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "block_public_acls": block_config["BlockPublicAcls"],
                        "block_public_policy": block_config["BlockPublicPolicy"],
                        "ignore_public_acls": block_config["IgnorePublicAcls"],
                        "restrict_public_buckets": block_config["RestrictPublicBuckets"],
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_public_access_block", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "NoSuchPublicAccessBlockConfiguration":
                    raise

    def aws_s3_bucket_replication_configuration(self):
        print("Processing S3 Bucket Replication Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]

            try:
                replication_configuration = self.s3_session.get_bucket_replication(
                    Bucket=bucket_name)
                config = replication_configuration.get(
                    "ReplicationConfiguration")

                if config:
                    print(
                        f"  Processing S3 Bucket Replication Configuration: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "replication_configuration": config,
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_replication_configuration", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "ReplicationConfigurationNotFoundError":
                    raise

    def aws_s3_bucket_request_payment_configuration(self):
        print("Processing S3 Bucket Request Payment Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]

            try:
                request_payment_configuration = self.s3_session.get_bucket_request_payment(
                    Bucket=bucket_name)
                config = request_payment_configuration.get("Payer")

                if config:
                    print(
                        f"  Processing S3 Bucket Request Payment Configuration: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "payer": config,
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_request_payment_configuration", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "NoSuchRequestPaymentConfiguration":
                    raise

    def aws_s3_bucket_server_side_encryption_configuration(self):
        print("Processing S3 Bucket Server Side Encryption Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]

            try:
                encryption_configuration = self.s3_session.get_bucket_encryption(
                    Bucket=bucket_name)
                config = encryption_configuration.get(
                    "ServerSideEncryptionConfiguration")

                if config:
                    print(
                        f"  Processing S3 Bucket Server Side Encryption Configuration: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "server_side_encryption_configuration": config,
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_server_side_encryption_configuration", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "ServerSideEncryptionConfigurationNotFoundError":
                    raise

    def aws_s3_bucket_versioning(self):
        print("Processing S3 Bucket Versioning Configurations...")

        response = self.s3_session.list_buckets()
        buckets = response["Buckets"]

        for bucket in buckets:
            bucket_name = bucket["Name"]

            try:
                versioning_configuration = self.s3_session.get_bucket_versioning(
                    Bucket=bucket_name)
                config = versioning_configuration.get("Status")

                if config:
                    print(
                        f"  Processing S3 Bucket Versioning Configuration: {bucket_name}")

                    attributes = {
                        "id": bucket_name,
                        "bucket": bucket_name,
                        "status": config,
                    }
                    self.hcl.process_resource(
                        "aws_s3_bucket_versioning", bucket_name.replace("-", "_"), attributes)
            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "NoSuchVersioningConfiguration":
                    raise

    def aws_s3_bucket_website_configuration(self):
        print("Processing S3 Bucket Website Configurations...")

        buckets = self.s3_session.list_buckets()["Buckets"]
        for bucket in buckets:
            bucket_name = bucket["Name"]
            try:
                website_config = self.s3_session.get_bucket_website(
                    Bucket=bucket_name)
                print(
                    f"  Processing S3 Bucket Website Configuration: {bucket_name}")

                attributes = {
                    "id": bucket_name,
                    # "bucket": bucket_name,
                }

                # if "IndexDocument" in website_config:
                #     attributes["index_document"] = website_config["IndexDocument"]["Suffix"]

                # if "ErrorDocument" in website_config:
                #     attributes["error_document"] = website_config["ErrorDocument"]["Key"]

                # if "RedirectAllRequestsTo" in website_config:
                #     attributes["redirect_all_requests_to"] = {
                #         "hostname": website_config["RedirectAllRequestsTo"]["HostName"],
                #         "protocol": website_config["RedirectAllRequestsTo"]["Protocol"],
                #     }

                # if "RoutingRules" in website_config:
                #     attributes["routing_rules"] = json.dumps(
                #         website_config["RoutingRules"])

                self.hcl.process_resource(
                    "aws_s3_bucket_website_configuration", bucket_name.replace("-", "_"), attributes)

            except self.s3_session.exceptions.ClientError as e:
                if e.response["Error"]["Code"] == "NoSuchWebsiteConfiguration":
                    print(
                        f"  No website configuration found for bucket: {bucket_name}")
                else:
                    raise
