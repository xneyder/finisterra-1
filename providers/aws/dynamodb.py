import os
from utils.hcl import HCL


class Dynamodb:
    def __init__(self, aws_clients, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id,hcl = None):
        self.aws_clients = aws_clients
        self.transform_rules = {        }
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

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
            'get_name_from_arn': self.get_name_from_arn,
            'aws_appautoscaling_target_name': self.aws_appautoscaling_target_name,
            'autoscaling_read': self.autoscaling_read,
            'autoscaling_write': self.autoscaling_write,
            'aws_appautoscaling_policy_name': self.aws_appautoscaling_policy_name,
            'table_read_policy_name': self.table_read_policy_name,
            'table_write_policy_name': self.table_write_policy_name,
            'index_read_policy_name': self.index_read_policy_name,
            'index_write_policy_name': self.index_write_policy_name,
            'autoscaling_read_enabled': self.autoscaling_read_enabled,
            'autoscaling_write_enabled': self.autoscaling_write_enabled,
            'aws_dyanmodb_target_name': self.aws_dyanmodb_target_name,
            'aws_appautoscaling_policy_import_id': self.aws_appautoscaling_policy_import_id,
            'aws_appautoscaling_target_import_id': self.aws_appautoscaling_target_import_id,
            'is_not_read_capacity': self.is_not_read_capacity,
            'is_not_write_capacity': self.is_not_write_capacity,
            'is_not_read_index_capacity': self.is_not_read_index_capacity,
            'is_not_write_index_capacity': self.is_not_write_index_capacity,
            'build_autoscaling': self.build_autoscaling,
            'build_autoscaling_policy': self.build_autoscaling_policy,
            'get_autosaling_type': self.get_autosaling_type,
        }

        self.hcl.functions.update(functions)        

    def get_field_from_attrs(self, attributes, arg):
        keys = arg.split(".")
        result = attributes
        for key in keys:
            if isinstance(result, list):
                result = [sub_result.get(key, None) if isinstance(
                    sub_result, dict) else None for sub_result in result]
                if len(result) == 1:
                    result = result[0]
            else:
                result = result.get(key, None)
            if result is None:
                return None
        return result

    def aws_appautoscaling_policy_import_id(self, attributes):
        return f"{attributes.get('service_namespace')}/{attributes.get('resource_id')}/{attributes.get('scalable_dimension')}/{attributes.get('name')}"

    def aws_appautoscaling_target_import_id(self, attributes):
        return f"{attributes.get('service_namespace')}/{attributes.get('resource_id')}/{attributes.get('scalable_dimension')}"

    def get_name_from_arn(self, attributes, arg):
        arn = attributes.get(arg)
        if arn is not None:
            # split the string by '/' and take the last part as the cluster_arn
            return arn.split('/')[-1]
        return None
    
    def is_not_write_capacity(self, attributes, arg):
        scalable_dimension = attributes.get("scalable_dimension", "")
        if scalable_dimension != "dynamodb:table:WriteCapacityUnits":
            return True
        
    def is_not_write_index_capacity(self, attributes, arg):
        scalable_dimension = attributes.get("scalable_dimension", "")
        if scalable_dimension != "dynamodb:index:WriteCapacityUnits":
            return True
        
    def is_not_read_index_capacity(self, attributes, arg):
        scalable_dimension = attributes.get("scalable_dimension", "")
        if scalable_dimension != "dynamodb:index:ReadCapacityUnits":
            return True

    def is_not_read_capacity(self, attributes, arg):
        scalable_dimension = attributes.get("scalable_dimension", "")
        if scalable_dimension != "dynamodb:table:ReadCapacityUnits":
            return True
        
    def aws_appautoscaling_target_name(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:table:ReadCapacityUnits":
            return "table_read"
        elif attributes.get("scalable_dimension", "") == "dynamodb:table:WriteCapacityUnits":
            return "table_write"
        elif attributes.get("scalable_dimension", "") == "dynamodb:index:ReadCapacityUnits":
            return "index_read"
        elif attributes.get("scalable_dimension", "") == "dynamodb:index:WriteCapacityUnits":
            return "index_write"
        return None

    def aws_dyanmodb_target_name(self, attributes):
        table_name = attributes.get("name", "")
        service_namespace = 'dynamodb'
        resource_id = f'table/{table_name}'
        print(
            f"Processing AppAutoScaling targets for DynamoDB Table: {table_name}")

        try:
            response = self.aws_clients.appautoscaling_client.describe_scalable_targets(
                ServiceNamespace=service_namespace,
                ResourceIds=[resource_id]
            )
            scalable_targets = response.get('ScalableTargets', [])
            if len(scalable_targets) > 0:
                return "autoscaled_gsi_ignore"
            else:
                return "this"
        except Exception as e:
            print(f"Error: {e}")
            return "this"

    def autoscaling_read(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:table:ReadCapacityUnits":
            target_tracking_scaling_policy_configuration = attributes.get(
                "target_tracking_scaling_policy_configuration", [{}])[0]
            return {
                key: target_tracking_scaling_policy_configuration.get(key)
                for key in ["scale_in_cooldown", "scale_out_cooldown", "target_value"]
                if target_tracking_scaling_policy_configuration.get(key) is not None
            }
        return None

    def autoscaling_write(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:table:WriteCapacityUnits":
            target_tracking_scaling_policy_configuration = attributes.get(
                "target_tracking_scaling_policy_configuration", [{}])[0]
            return {
                key: target_tracking_scaling_policy_configuration.get(key)
                for key in ["scale_in_cooldown", "scale_out_cooldown", "target_value"]
                if target_tracking_scaling_policy_configuration.get(key) is not None
            }
        return None

    def table_read_policy_name(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:table:ReadCapacityUnits":
            return attributes.get("name", "")
        return None

    def table_write_policy_name(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:table:WriteCapacityUnits":
            return attributes.get("name", "")
        return None

    def index_read_policy_name(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:index:ReadCapacityUnits":
            return attributes.get("name", "")
        return None

    def index_write_policy_name(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:index:WriteCapacityUnits":
            return attributes.get("name", "")
        return None

    def aws_appautoscaling_policy_name(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:table:ReadCapacityUnits":
            return "table_read_policy"
        elif attributes.get("scalable_dimension", "") == "dynamodb:table:WriteCapacityUnits":
            return "table_write_policy"
        elif attributes.get("scalable_dimension", "") == "dynamodb:index:ReadCapacityUnits":
            return "index_read_policy"
        elif attributes.get("scalable_dimension", "") == "dynamodb:index:WriteCapacityUnits":
            return "index_write_policy"
        return None

    def autoscaling_read_enabled(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:table:ReadCapacityUnits":
            return True
        return None

    def autoscaling_write_enabled(self, attributes):
        if attributes.get("scalable_dimension", "") == "dynamodb:table:WriteCapacityUnits":
            return True
        return None
    
    def build_autoscaling(self, attributes,arg):
        scalable_dimension = attributes.get("scalable_dimension", "")
        name = self.get_scalable_dimension(scalable_dimension)
        
        result = {}
        result[name] = {}
        result[name]["max_capacity"] = attributes.get("max_capacity", None)
        result[name]["min_capacity"] = attributes.get("min_capacity", None)
        result[name]["scalable_dimension"] = scalable_dimension
        return result
    
    def get_scalable_dimension(self, scalable_dimension):
        if scalable_dimension == "dynamodb:table:ReadCapacityUnits":
            name = "table_read_policy"
        elif scalable_dimension == "dynamodb:table:WriteCapacityUnits":
            name = "table_write_policy"
        elif scalable_dimension == "dynamodb:index:ReadCapacityUnits":
            name = "index_read_policy"
        elif scalable_dimension == "dynamodb:index:WriteCapacityUnits":
            name = "index_write_policy"

        return name
    
    def get_autosaling_type(self, attributes):
        scalable_dimension = attributes.get("scalable_dimension", "")
        return self.get_scalable_dimension(scalable_dimension)

    
    def build_autoscaling_policy(self, attributes,arg):
        scalable_dimension = attributes.get("scalable_dimension", "")
        name = self.get_scalable_dimension(scalable_dimension)
        result = {}
        result[name] = {}
        result[name]["policy_name"] = attributes.get("name", None)
        tmp = attributes.get("target_tracking_scaling_policy_configuration", [])
        if tmp:
            tmp2 = tmp[0].get("predefined_metric_specification", [])
            if tmp2:
                result[name]["predefined_metric_type"] = tmp2[0].get("predefined_metric_type", None)
            result[name]["scale_in_cooldown"] = tmp[0].get("scale_in_cooldown", None)
            result[name]["scale_out_cooldown"] = tmp[0].get("scale_out_cooldown", None)
            result[name]["target_value"] = tmp[0].get("target_value", None)

        return result

    def dynamodb(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        # aws_appautoscaling_policy.index_read_policy
        # aws_appautoscaling_policy.index_write_policy
        # aws_appautoscaling_policy.table_read_policy
        # aws_appautoscaling_policy.table_write_policy
        # aws_appautoscaling_target.index_read
        # aws_appautoscaling_target.index_write
        # aws_appautoscaling_target.table_read
        # aws_appautoscaling_target.table_write
        # aws_dynamodb_table.autoscaled
        # aws_dynamodb_table.autoscaled_gsi_ignore
        # aws_dynamodb_table.this

        # self.aws_dynamodb_contributor_insights() #import error
        # self.aws_dynamodb_kinesis_streaming_destination()
        # self.aws_dynamodb_global_table()
        # self.aws_dynamodb_table_replica()
        # self.aws_dynamodb_tag() #Terraform permissions issue

        self.aws_dynamodb_table()


        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate","../providers/aws/", {}, self.region, self.aws_account_id, {}, {})

        # self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_dynamodb_table(self):
        resource_type = "aws_dynamodb_table"
        print("Processing DynamoDB Tables...")

        paginator = self.aws_clients.dynamodb_client.get_paginator("list_tables")
        for page in paginator.paginate():
            for table_name in page["TableNames"]:
                table_description = self.aws_clients.dynamodb_client.describe_table(TableName=table_name)["Table"]

                # if table_name != "staging_WallFeedItem":
                #     continue

                print(f"  Processing DynamoDB Table: {table_name}")
                id = table_name

                ftstack = "dynamodb"
                try:
                    response = self.aws_clients.dynamodb_client.list_tags_of_resource(ResourceArn=table_description["TableArn"])
                    tags = response.get('Tags', [])
                    for tag in tags:
                        if tag['Key'] == 'ftstack':
                            if tag['Value'] != 'dynamodb':
                                ftstack = "stack_"+tag['Value']
                            break
                except Exception as e:
                    print("Error occurred: ", e)

                attributes = {
                    "id": id,
                    "name": table_name,
                    "read_capacity": table_description["ProvisionedThroughput"]["ReadCapacityUnits"],
                    "write_capacity": table_description["ProvisionedThroughput"]["WriteCapacityUnits"],
                }

                if "GlobalSecondaryIndexes" in table_description:
                    for gsi in table_description["GlobalSecondaryIndexes"]:
                        index_name = gsi["IndexName"]
                        index_resource_id = f'table/{table_name}/index/{index_name}'
                        self.aws_appautoscaling_target(index_resource_id)

                self.hcl.process_resource(
                    resource_type, table_name.replace("-", "_"), attributes)
                self.hcl.add_stack(resource_type, id, ftstack)

                self.aws_appautoscaling_target(table_name)

    def aws_appautoscaling_target(self, table_name):
        service_namespace = 'dynamodb'
        resource_id = f'table/{table_name}'
        print(
            f"Processing AppAutoScaling targets for DynamoDB Table: {table_name}")

        try:
            response = self.aws_clients.appautoscaling_client.describe_scalable_targets(
                ServiceNamespace=service_namespace,
                ResourceIds=[resource_id]
            )
            scalable_targets = response.get('ScalableTargets', [])

            for target in scalable_targets:
                print(
                    f"  Processing DynamoDB AppAutoScaling Target: {resource_id} with dimension: {target['ScalableDimension']}")

                resource_name = f"{service_namespace}-{resource_id.replace('/', '-')}-{target['ScalableDimension']}"
                attributes = {
                    "id": resource_id,
                    "resource_id": resource_id,
                    "service_namespace": service_namespace,
                    "scalable_dimension": target['ScalableDimension'],
                }
                self.hcl.process_resource(
                    "aws_appautoscaling_target", resource_name, attributes)

                # Processing scaling policies for the target
                self.aws_appautoscaling_policy(
                    service_namespace, resource_id, target['ScalableDimension'])

            if not scalable_targets:
                print(
                    f"No AppAutoScaling targets found for DynamoDB Table: {table_name}")

        except Exception as e:
            print(
                f"Error processing AppAutoScaling targets for DynamoDB Table: {table_name}: {str(e)}")

    def aws_appautoscaling_policy(self, service_namespace, resource_id, scalable_dimension):
        print(
            f"Processing AppAutoScaling policies for resource: {resource_id} with dimension: {scalable_dimension}...")

        try:
            response = self.aws_clients.appautoscaling_client.describe_scaling_policies(
                ServiceNamespace=service_namespace,
                ResourceId=resource_id,
                ScalableDimension=scalable_dimension
            )
            scaling_policies = response.get('ScalingPolicies', [])

            for policy in scaling_policies:
                print(
                    f"  Processing AppAutoScaling Policy: {policy['PolicyName']} for resource: {resource_id}")

                resource_name = f"{service_namespace}-{resource_id.replace('/', '-')}-{policy['PolicyName']}"
                attributes = {
                    "id": f"{policy['PolicyName']}",
                    "resource_id": resource_id,
                    "service_namespace": service_namespace,
                    "scalable_dimension": scalable_dimension,
                    "name": policy['PolicyName'],
                }
                self.hcl.process_resource(
                    "aws_appautoscaling_policy", resource_name, attributes)
        except Exception as e:
            print(
                f"Error processing AppAutoScaling policies for resource: {resource_id} with dimension: {scalable_dimension}: {str(e)}")

    # def aws_dynamodb_contributor_insights(self):
    #     print("Processing DynamoDB Contributor Insights...")

    #     paginator = self.aws_clients.dynamodb_client.get_paginator("list_tables")
    #     for page in paginator.paginate():
    #         for table_name in page["TableNames"]:
    #             try:
    #                 contributor_insights = self.aws_clients.dynamodb_client.describe_contributor_insights(
    #                     TableName=table_name)
    #                 status = contributor_insights["ContributorInsightsStatus"]

    #                 print(
    #                     f"  Processing DynamoDB Contributor Insights: {table_name}")

    #                 attributes = {
    #                     "table_name": table_name,
    #                     "contributor_insights_status": status,
    #                 }

    #                 self.hcl.process_resource(
    #                     "aws_dynamodb_contributor_insights", table_name.replace("-", "_"), attributes)
    #             except self.aws_clients.dynamodb_client.exceptions.ResourceNotFoundException:
    #                 print(
    #                     f"  No Contributor Insights found for DynamoDB Table: {table_name}")

    # def aws_dynamodb_global_table(self):
    #     print("Processing DynamoDB Global Tables...")

    #     global_tables = self.aws_clients.dynamodb_client.list_global_tables()[
    #         "GlobalTables"]
    #     for global_table in global_tables:
    #         global_table_name = global_table["GlobalTableName"]

    #         global_table_description = self.aws_clients.dynamodb_client.describe_global_table(
    #             GlobalTableName=global_table_name)["GlobalTableDescription"]

    #         print(
    #             f"  Processing DynamoDB Global Table: {global_table_name}")

    #         attributes = {
    #             "id": global_table_name,
    #             "name": global_table_name,
    #             "replica": [{"region_name": replica["RegionName"]} for replica in global_table_description["ReplicaDescriptions"]],
    #         }

    #         self.hcl.process_resource(
    #             "aws_dynamodb_global_table", global_table_name.replace("-", "_"), attributes)

    # def aws_dynamodb_kinesis_streaming_destination(self):
    #     print("Processing DynamoDB Kinesis Streaming Destinations...")

    #     table_names = self.aws_clients.dynamodb_client.list_tables()["TableNames"]
    #     for table_name in table_names:
    #         try:
    #             streaming_destination = self.aws_clients.dynamodb_client.describe_kinesis_streaming_destination(
    #                 TableName=table_name)
    #             destinations = streaming_destination["KinesisDataStreamDestinations"]

    #             for destination in destinations:
    #                 print(
    #                     f"  Processing DynamoDB Kinesis Streaming Destination: {table_name}")

    #                 attributes = {
    #                     "id": destination["StreamArn"],
    #                     "table_name": table_name,
    #                     "stream_arn": destination["StreamArn"],
    #                     "destination_status": destination["DestinationStatus"],
    #                 }

    #                 self.hcl.process_resource(
    #                     "aws_dynamodb_kinesis_streaming_destination", table_name.replace("-", "_"), attributes)
    #         except self.aws_clients.dynamodb_client.exceptions.ResourceNotFoundException:
    #             print(
    #                 f"  No Kinesis Streaming Destination found for DynamoDB Table: {table_name}")

    # def aws_dynamodb_table_replica(self):
    #     print("Processing DynamoDB Table Replicas...")

    #     paginator = self.aws_clients.dynamodb_client.get_paginator("list_tables")
    #     for page in paginator.paginate():
    #         for table_name in page["TableNames"]:
    #             table_description = self.aws_clients.dynamodb_client.describe_table(
    #                 TableName=table_name)["Table"]

    #             if "Replicas" in table_description:
    #                 for replica in table_description["Replicas"]:
    #                     print(
    #                         f"  Processing DynamoDB Table Replica: {table_name}")

    #                     attributes = {
    #                         "id": f"{table_name}-{replica['RegionName']}",
    #                         "table_name": table_name,
    #                         "region_name": replica["RegionName"],
    #                     }

    #                     self.hcl.process_resource(
    #                         "aws_dynamodb_table_replica", f"{table_name}-{replica['RegionName']}".replace("-", "_"), attributes)

    # def aws_dynamodb_tag(self):
    #     print("Processing DynamoDB Tags...")

    #     paginator = self.aws_clients.dynamodb_client.get_paginator("list_tables")
    #     for page in paginator.paginate():
    #         for table_name in page["TableNames"]:
    #             tags = self.aws_clients.dynamodb_client.list_tags_of_resource(
    #                 ResourceArn=self.aws_clients.dynamodb_client.describe_table(TableName=table_name)["Table"]["TableArn"])["Tags"]

    #             for tag in tags:
    #                 print(
    #                     f"  Processing DynamoDB Tag: {tag['Key']} for Table: {table_name}")

    #                 attributes = {
    #                     "id": f"{table_name},{tag['Key']}",
    #                     "table_name": table_name,
    #                     "key": tag["Key"],
    #                     "value": tag["Value"],
    #                 }

    #                 self.hcl.process_resource(
    #                     "aws_dynamodb_tag", f"{table_name}-{tag['Key']}".replace("-", "_"), attributes)
