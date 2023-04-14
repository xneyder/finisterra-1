import os
from utils.hcl import HCL


class Logs:
    def __init__(self, logs_client, script_dir, provider_name, schema_data, region):
        self.logs_client = logs_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def logs(self):
        self.hcl.prepare_folder(os.path.join("generated", "logs"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_cloudwatch_log_data_protection_policy(self):
        print("Processing CloudWatch Log Data Protection Policies...")

        paginator = self.logs_client.get_paginator(
            "describe_resource_policies")
        for page in paginator.paginate():
            for policy in page["resourcePolicies"]:
                policy_name = policy["policyName"]
                print(
                    f"  Processing CloudWatch Log Data Protection Policy: {policy_name}")

                attributes = {
                    "id": policy_name,
                    "policy_name": policy_name,
                    "policy_document": policy["policyDocument"],
                }

                self.hcl.process_resource(
                    "aws_cloudwatch_log_data_protection_policy", policy_name.replace("-", "_"), attributes)

    def aws_cloudwatch_log_destination(self):
        print("Processing CloudWatch Log Destinations...")

        paginator = self.logs_client.get_paginator("describe_destinations")
        for page in paginator.paginate():
            for destination in page["destinations"]:
                destination_name = destination["destinationName"]
                print(
                    f"  Processing CloudWatch Log Destination: {destination_name}")

                attributes = {
                    "id": destination_name,
                    "name": destination_name,
                    "arn": destination["destinationArn"],
                    "role_arn": destination["roleArn"],
                    "target_arn": destination["targetArn"],
                }

                self.hcl.process_resource(
                    "aws_cloudwatch_log_destination", destination_name.replace("-", "_"), attributes)

    def aws_cloudwatch_log_destination_policy(self):
        print("Processing CloudWatch Log Destination Policies...")

        paginator = self.logs_client.get_paginator("describe_destinations")
        for page in paginator.paginate():
            for destination in page["destinations"]:
                destination_name = destination["destinationName"]

                try:
                    destination_policy = self.logs_client.get_destination_policy(
                        destinationName=destination_name)
                    print(
                        f"  Processing CloudWatch Log Destination Policy: {destination_name}")

                    attributes = {
                        "id": destination_name,
                        "destination_name": destination_name,
                        "access_policy": destination_policy["accessPolicy"],
                    }

                    self.hcl.process_resource(
                        "aws_cloudwatch_log_destination_policy", destination_name.replace("-", "_"), attributes)
                except self.logs_client.exceptions.ResourceNotFoundException:
                    print(
                        f"  No Destination Policy found for Log Destination: {destination_name}")

    def aws_cloudwatch_log_group(self):
        print("Processing CloudWatch Log Groups...")

        paginator = self.logs_client.get_paginator("describe_log_groups")
        for page in paginator.paginate():
            for log_group in page["logGroups"]:
                log_group_name = log_group["logGroupName"]
                print(f"  Processing CloudWatch Log Group: {log_group_name}")

                attributes = {
                    "id": log_group_name,
                    "name": log_group_name,
                }

                if "kmsKeyId" in log_group:
                    attributes["kms_key_id"] = log_group["kmsKeyId"]

                if "retentionInDays" in log_group:
                    attributes["retention_in_days"] = log_group["retentionInDays"]

                if "tags" in log_group:
                    attributes["tags"] = log_group["tags"]

                self.hcl.process_resource(
                    "aws_cloudwatch_log_group", log_group_name.replace("-", "_"), attributes)

    def aws_cloudwatch_log_metric_filter(self):
        print("Processing CloudWatch Log Metric Filters...")

        paginator = self.logs_client.get_paginator("describe_log_groups")
        for page in paginator.paginate():
            for log_group in page["logGroups"]:
                log_group_name = log_group["logGroupName"]

                paginator_filters = self.logs_client.get_paginator(
                    "describe_metric_filters")
                for filter_page in paginator_filters.paginate(logGroupName=log_group_name):
                    for metric_filter in filter_page["metricFilters"]:
                        filter_name = metric_filter["filterName"]
                        print(
                            f"  Processing CloudWatch Log Metric Filter: {filter_name}")

                        attributes = {
                            "id": filter_name,
                            "name": filter_name,
                            "log_group_name": log_group_name,
                            "pattern": metric_filter["filterPattern"],
                            "metric_transformation": metric_filter["metricTransformations"],
                        }

                        self.hcl.process_resource(
                            "aws_cloudwatch_log_metric_filter", filter_name.replace("-", "_"), attributes)

    def aws_cloudwatch_log_resource_policy(self):
        print("Processing CloudWatch Log Resource Policies...")

        paginator = self.logs_client.get_paginator(
            "describe_resource_policies")
        for page in paginator.paginate():
            for resource_policy in page["resourcePolicies"]:
                policy_name = resource_policy["policyName"]
                print(
                    f"  Processing CloudWatch Log Resource Policy: {policy_name}")

                attributes = {
                    "id": policy_name,
                    "name": policy_name,
                    "policy_document": resource_policy["policyDocument"],
                }

                self.hcl.process_resource(
                    "aws_cloudwatch_log_resource_policy", policy_name.replace("-", "_"), attributes)

    def aws_cloudwatch_log_stream(self):
        print("Processing CloudWatch Log Streams...")

        paginator = self.logs_client.get_paginator("describe_log_groups")
        for page in paginator.paginate():
            for log_group in page["logGroups"]:
                log_group_name = log_group["logGroupName"]

                paginator_streams = self.logs_client.get_paginator(
                    "describe_log_streams")
                for stream_page in paginator_streams.paginate(logGroupName=log_group_name):
                    for log_stream in stream_page["logStreams"]:
                        stream_name = log_stream["logStreamName"]
                        print(
                            f"  Processing CloudWatch Log Stream: {stream_name}")

                        attributes = {
                            "id": stream_name,
                            "name": stream_name,
                            "log_group_name": log_group_name,
                        }

                        self.hcl.process_resource(
                            "aws_cloudwatch_log_stream", stream_name.replace("-", "_"), attributes)

    def aws_cloudwatch_log_subscription_filter(self):
        print("Processing CloudWatch Log Subscription Filters...")

        paginator = self.logs_client.get_paginator("describe_log_groups")
        for page in paginator.paginate():
            for log_group in page["logGroups"]:
                log_group_name = log_group["logGroupName"]

                paginator_filters = self.logs_client.get_paginator(
                    "describe_subscription_filters")
                for filter_page in paginator_filters.paginate(logGroupName=log_group_name):
                    for subscription_filter in filter_page["subscriptionFilters"]:
                        filter_name = subscription_filter["filterName"]
                        print(
                            f"  Processing CloudWatch Log Subscription Filter: {filter_name}")

                        attributes = {
                            "id": filter_name,
                            "name": filter_name,
                            "log_group_name": log_group_name,
                            "filter_pattern": subscription_filter["filterPattern"],
                            "destination_arn": subscription_filter["destinationArn"],
                            "role_arn": subscription_filter.get("roleArn", ""),
                        }

                        self.hcl.process_resource(
                            "aws_cloudwatch_log_subscription_filter", filter_name.replace("-", "_"), attributes)

    def aws_cloudwatch_query_definition(self):
        print("Processing CloudWatch Query Definitions...")

        paginator = self.logs_client.get_paginator(
            "describe_query_definitions")
        for page in paginator.paginate():
            for query_definition in page["queryDefinitions"]:
                query_definition_id = query_definition["queryDefinitionId"]
                print(
                    f"  Processing CloudWatch Query Definition: {query_definition_id}")

                attributes = {
                    "id": query_definition_id,
                    "name": query_definition["name"],
                    "query_string": query_definition["queryString"],
                }

                if "logGroupNames" in query_definition:
                    attributes["log_group_names"] = query_definition["logGroupNames"]

                self.hcl.process_resource(
                    "aws_cloudwatch_query_definition", query_definition_id.replace("-", "_"), attributes)