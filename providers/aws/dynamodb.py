import os
from utils.hcl import HCL


class Dynamodb:
    def __init__(self, dynamodb_client, account_id, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key):
        self.dynamodb_client = dynamodb_client
        self.account_id = account_id
        self.transform_rules = {
            "aws_dynamodb_table": {
                "hcl_drop_blocks": {"ttl": {"enabled": False}},
                "hcl_keep_fields": {"write_capacity": True, "read_capacity": True, "hash_key": True},
            },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key)
        self.resource_list = {}

    def dynamodb(self):
        self.hcl.prepare_folder(os.path.join("generated", "dynamodb"))

        # self.aws_dynamodb_contributor_insights() #import error
        self.aws_dynamodb_kinesis_streaming_destination()
        self.aws_dynamodb_global_table()
        self.aws_dynamodb_table()
        self.aws_dynamodb_table_replica()
        # self.aws_dynamodb_tag() #Terraform permissions issue

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_dynamodb_contributor_insights(self):
        print("Processing DynamoDB Contributor Insights...")

        paginator = self.dynamodb_client.get_paginator("list_tables")
        for page in paginator.paginate():
            for table_name in page["TableNames"]:
                try:
                    contributor_insights = self.dynamodb_client.describe_contributor_insights(
                        TableName=table_name)
                    status = contributor_insights["ContributorInsightsStatus"]

                    print(
                        f"  Processing DynamoDB Contributor Insights: {table_name}")

                    attributes = {
                        "id": table_name+"/"+self.account_id,
                        "table_name": table_name,
                        "contributor_insights_status": status,
                    }

                    self.hcl.process_resource(
                        "aws_dynamodb_contributor_insights", table_name.replace("-", "_"), attributes)
                except self.dynamodb_client.exceptions.ResourceNotFoundException:
                    print(
                        f"  No Contributor Insights found for DynamoDB Table: {table_name}")

    def aws_dynamodb_global_table(self):
        print("Processing DynamoDB Global Tables...")

        global_tables = self.dynamodb_client.list_global_tables()[
            "GlobalTables"]
        for global_table in global_tables:
            global_table_name = global_table["GlobalTableName"]

            global_table_description = self.dynamodb_client.describe_global_table(
                GlobalTableName=global_table_name)["GlobalTableDescription"]

            print(
                f"  Processing DynamoDB Global Table: {global_table_name}")

            attributes = {
                "id": global_table_name,
                "name": global_table_name,
                "replica": [{"region_name": replica["RegionName"]} for replica in global_table_description["ReplicaDescriptions"]],
            }

            self.hcl.process_resource(
                "aws_dynamodb_global_table", global_table_name.replace("-", "_"), attributes)

    def aws_dynamodb_kinesis_streaming_destination(self):
        print("Processing DynamoDB Kinesis Streaming Destinations...")

        table_names = self.dynamodb_client.list_tables()["TableNames"]
        for table_name in table_names:
            try:
                streaming_destination = self.dynamodb_client.describe_kinesis_streaming_destination(
                    TableName=table_name)
                destinations = streaming_destination["KinesisDataStreamDestinations"]

                for destination in destinations:
                    print(
                        f"  Processing DynamoDB Kinesis Streaming Destination: {table_name}")

                    attributes = {
                        "id": destination["StreamArn"],
                        "table_name": table_name,
                        "stream_arn": destination["StreamArn"],
                        "destination_status": destination["DestinationStatus"],
                    }

                    self.hcl.process_resource(
                        "aws_dynamodb_kinesis_streaming_destination", table_name.replace("-", "_"), attributes)
            except self.dynamodb_client.exceptions.ResourceNotFoundException:
                print(
                    f"  No Kinesis Streaming Destination found for DynamoDB Table: {table_name}")

    def aws_dynamodb_table(self):
        print("Processing DynamoDB Tables...")

        paginator = self.dynamodb_client.get_paginator("list_tables")
        for page in paginator.paginate():
            for table_name in page["TableNames"]:
                table_description = self.dynamodb_client.describe_table(
                    TableName=table_name)["Table"]

                print(f"  Processing DynamoDB Table: {table_name}")

                attributes = {
                    "id": table_name,
                    "name": table_name,
                    "read_capacity": table_description["ProvisionedThroughput"]["ReadCapacityUnits"],
                    "write_capacity": table_description["ProvisionedThroughput"]["WriteCapacityUnits"],
                }

                # Extract the key schema
                key_schema = table_description["KeySchema"]

                # Get the hash key
                hash_key = next(
                    key["AttributeName"] for key in key_schema if key["KeyType"] == "HASH")
                attributes["hash_key"] = hash_key

                # If there's a range key, get it
                range_key = next(
                    (key["AttributeName"] for key in key_schema if key["KeyType"] == "RANGE"), None)
                if range_key is not None:
                    attributes["range_key"] = range_key

                if "GlobalSecondaryIndexes" in table_description:
                    attributes["global_secondary_index"] = table_description["GlobalSecondaryIndexes"]

                if "LocalSecondaryIndexes" in table_description:
                    attributes["local_secondary_index"] = table_description["LocalSecondaryIndexes"]

                self.hcl.process_resource(
                    "aws_dynamodb_table", table_name.replace("-", "_"), attributes)

    def aws_dynamodb_table_replica(self):
        print("Processing DynamoDB Table Replicas...")

        paginator = self.dynamodb_client.get_paginator("list_tables")
        for page in paginator.paginate():
            for table_name in page["TableNames"]:
                table_description = self.dynamodb_client.describe_table(
                    TableName=table_name)["Table"]

                if "Replicas" in table_description:
                    for replica in table_description["Replicas"]:
                        print(
                            f"  Processing DynamoDB Table Replica: {table_name}")

                        attributes = {
                            "id": f"{table_name}-{replica['RegionName']}",
                            "table_name": table_name,
                            "region_name": replica["RegionName"],
                        }

                        self.hcl.process_resource(
                            "aws_dynamodb_table_replica", f"{table_name}-{replica['RegionName']}".replace("-", "_"), attributes)

    def aws_dynamodb_tag(self):
        print("Processing DynamoDB Tags...")

        paginator = self.dynamodb_client.get_paginator("list_tables")
        for page in paginator.paginate():
            for table_name in page["TableNames"]:
                tags = self.dynamodb_client.list_tags_of_resource(
                    ResourceArn=self.dynamodb_client.describe_table(TableName=table_name)["Table"]["TableArn"])["Tags"]

                for tag in tags:
                    print(
                        f"  Processing DynamoDB Tag: {tag['Key']} for Table: {table_name}")

                    attributes = {
                        "id": f"{table_name},{tag['Key']}",
                        "table_name": table_name,
                        "key": tag["Key"],
                        "value": tag["Value"],
                    }

                    self.hcl.process_resource(
                        "aws_dynamodb_tag", f"{table_name}-{tag['Key']}".replace("-", "_"), attributes)
