import os
from utils.hcl import HCL
import json
from botocore.exceptions import ClientError
# from utils.module_hcl import load_yaml_and_tfstate
from providers.aws.kms import KMS

from botocore.exceptions import ClientError


class S3:
    def __init__(self, aws_clients, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id,hcl = None):
        self.aws_clients = aws_clients
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.aws_account_id = aws_account_id

        self.workspace_id = workspace_id
        self.modules = modules
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        else:
            self.hcl = hcl

        self.resource_list = {}

        functions = {
            'aws_s3_bucket_acl_owner': self.aws_s3_bucket_acl_owner,
            'aws_s3_bucket_acl_grant': self.aws_s3_bucket_acl_grant,
            'aws_s3_bucket_website_configuration_website': self.aws_s3_bucket_website_configuration_website,
            'aws_s3_bucket_ownership_controls_object_ownership': self.aws_s3_bucket_ownership_controls_object_ownership,
            'aws_s3_filter_empty_fields': self.aws_s3_filter_empty_fields,
            'aws_s3_bucket_lifecycle_configuration_lifecycle_rule': self.aws_s3_bucket_lifecycle_configuration_lifecycle_rule,
            'aws_s3_bucket_versioning_versioning': self.aws_s3_bucket_versioning_versioning,
            'aws_s3_convert_dict_structure': self.aws_s3_convert_dict_structure,
            'aws_s3_server_side_encryption_configuration': self.aws_s3_server_side_encryption_configuration,
            'aws_s3_bucket_policy_policy': self.aws_s3_bucket_policy_policy,
            'aws_s3_build_logging': self.aws_s3_build_logging,
            'aws_s3_get_object_lock_configuration_rule': self.aws_s3_get_object_lock_configuration_rule,
            'aws_s3_build_replication_configuration': self.aws_s3_build_replication_configuration,
            'aws_s3_get_inventory_configuration': self.aws_s3_get_inventory_configuration,
            'aws_s3_get_analytics_configuration': self.aws_s3_get_analytics_configuration,
            's3_build_tiering': self.s3_build_tiering,
        }
        self.hcl.functions.update(functions)
        self.processed_resources = {}
        # self.kms_instance = KMS(self.aws_clients, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)

    def s3(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_s3_bucket()

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate","../providers/aws/", {}, self.region, self.aws_account_id)

        # load_yaml_and_tfstate("terraform-aws-modules/s3-bucket/aws", "3.14.0", "terraform.tfstate",
        #                       os.path.join(os.path.dirname(os.path.abspath(__file__)), "aws_s3_bucket.yaml"))
        # self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_s3_build_logging(self, state):
        result = {}

        tmp = state.get('target_bucket', '')
        if tmp:
            result['target_bucket'] = tmp

        tmp = state.get('target_prefix', '')
        if tmp:
            result['target_prefix'] = tmp

        return result

    def s3_build_tiering(self, state):
        result = {}
        name = state.get("name", "")
        result[name] = {}
        tiering = state.get("tiering", [])
        if tiering:
            result[name]["tiering"] = tiering
        filter = state.get("filter", [])
        if filter:
            result[name]["filter"] = filter
        status = state.get("status", "")
        if status:
            result[name]["status"] = status
        return result

    def aws_s3_get_inventory_configuration(self, state, arg):
        name = state.get("name", "")
        result = {}
        result[name] = {}
        result[name]["included_object_versions"] = state.get("included_object_versions", "")
        result[name]["enabled"] = state.get("enabled", [])
        result[name]["optional_fields"] = state.get("optional_fields", [])
        tmp = state.get("destination", [])
        if tmp:
            result[name]["destination"] = {}
            tmp2 = tmp[0].get("bucket", [])
            if tmp2:
                result[name]["destination"]["bucket_arn"] = tmp2[0].get("bucket_arn", "")
                result[name]["destination"]["format"] = tmp2[0].get("format", "")
                result[name]["destination"]["account_id"] = tmp2[0].get("account_id", "")
                result[name]["destination"]["prefix"] = tmp2[0].get("prefix", "")
                tmp3 = tmp2[0].get("encryption", [])
                if tmp3:
                    result[name]["destination"]["encryption"] = tmp3

        tmp = state.get("schedule", [])
        if tmp:
            result[name]["frequency"] = tmp[0].get("frequency", "")
        result[name]["filter"] = state.get("filter", [])
        return result
    
    def aws_s3_get_analytics_configuration(self, state, arg):
        name = state.get("name", "")
        result = {}
        result[name] = {}
        result[name]["filter"] = state.get("filter", [])

        tmp = state.get("storage_class_analysis", [])
        if tmp:
            result[name]["storage_class_analysis"] = {}
            tmp2 = tmp[0].get("data_export", [])
            if tmp2:
                result[name]["storage_class_analysis"]["output_schema_version"] = tmp2[0].get("output_schema_version", "")
                tmp3 = tmp2[0].get("destination", [])
                if tmp3:
                    tmp4 = tmp3[0].get("s3_bucket_destination", [])
                    if tmp4:
                        result[name]["storage_class_analysis"]["destination_bucket_arn"] = tmp4[0].get("bucket_arn", "")
                        result[name]["storage_class_analysis"]["export_format"] = tmp4[0].get("format", "")
                        result[name]["storage_class_analysis"]["destination_account_id"] = tmp4[0].get("bucket_account_id", "")
                        result[name]["storage_class_analysis"]["export_prefix"] = tmp4[0].get("prefix", "")
        return result


    def aws_s3_build_replication_configuration(self, state, arg):
        result = {}
        result["role"] = state.get("role", "")

        result["rule"] = []
        rules = state.get("rule")
        for rule in rules:
            record = {}
            tmp = rule.get("id", "")
            if tmp:
                record["id"] = tmp
            tmp = rule.get("prefix", "")
            if tmp:
                record["prefix"] = tmp
            tmp = rule.get("priority", "")
            if tmp:
                record["priority"] = tmp
            tmp = rule.get("status", "")
            if tmp:
                record["status"] = tmp
            #delete_marker_replication_status
            tmp = rule.get("delete_marker_replication")
            if tmp:
                record["delete_marker_replication_status"] = tmp[0].get("status", "")
            #existing_object_replication_status
            tmp = rule.get("existing_object_replication")
            if tmp:
                record["existing_object_replication_status"] = tmp[0].get("status", "")
            #destination
            tmp = rule.get("destination")
            if tmp:
                record["destination"] = {}
                tmp2 = tmp[0].get("bucket", "")
                if tmp2:
                    record["destination"]["bucket"] = tmp2
                tmp2 = tmp[0].get("storage_class", "")
                if tmp2:
                    record["destination"]["storage_class"] = tmp2
                record["destination"]["account"] = tmp[0].get("account")
                #access_control_translation
                tmp2 = tmp[0].get("access_control_translation")
                if tmp2:
                    record["destination"]["access_control_translation"] = {}
                    record["destination"]["access_control_translation"]["owner"] = tmp2[0].get("owner", "")
                #encryption_configuration
                tmp2 = tmp[0].get("encryption_configuration")
                if tmp2:
                    record["destination"]["encryption_configuration"] = {}
                    record["destination"]["encryption_configuration"]["replica_kms_key_id"] = tmp2[0].get("replica_kms_key_id", "")

                #replication_time
                tmp2 = tmp[0].get("replication_time")
                if tmp2:
                    record["destination"]["replication_time"] = {}
                    record["destination"]["replication_time"]["status"] = tmp2[0].get("status", "")
                    tmp3 = tmp2[0].get("time", [])
                    if tmp3:
                        record["destination"]["replication_time"]["minutes"] = tmp3[0].get("minutes", [])
                #metrics
                tmp2 = tmp[0].get("metrics")
                if tmp2:
                    record["destination"]["metrics"] = {}
                    record["destination"]["metrics"]["status"] = tmp2[0].get("status", "")
                    tmp3 = tmp2[0].get("event_threshold", [])
                    if tmp3:
                        record["destination"]["metrics"]["minutes"] = tmp3[0].get("minutes", [])
                    # tmp3 = tmp2[0].get("replica_modifications", [])
                    # if tmp3:
                    #     record["destination"]["metrics"]["replica_modifications"] = {}
                    #     record["destination"]["metrics"]["replica_modifications"]["status"] = tmp3[0].get("status", "")

            #source_selection_criteria
            tmp = rule.get("source_selection_criteria")
            if tmp:
                record["source_selection_criteria"] = {}
                #replica_modifications
                tmp2 = tmp[0].get("replica_modifications")
                if tmp2:
                    record["source_selection_criteria"]["replica_modifications"] = {}
                    record["source_selection_criteria"]["replica_modifications"]["status"] = tmp2[0].get("status", "")
                #sse_kms_encrypted_objects
                tmp2 = tmp[0].get("sse_kms_encrypted_objects")
                if tmp2:
                    record["source_selection_criteria"]["sse_kms_encrypted_objects"] = {}
                    record["source_selection_criteria"]["sse_kms_encrypted_objects"]["status"] = tmp2[0].get("status", "")
                #tag_filters
                tmp2 = tmp[0].get("tag_filters")
                if tmp2:
                    record["source_selection_criteria"]["tag_filters"] = {}
                    record["source_selection_criteria"]["tag_filters"]["and"] = tmp2[0].get("and", [])
                    record["source_selection_criteria"]["tag_filters"]["prefix"] = tmp2[0].get("prefix", "")
                    record["source_selection_criteria"]["tag_filters"]["tag"] = tmp2[0].get("tag", [])
                    record["source_selection_criteria"]["tag_filters"]["not_tag"] = tmp2[0].get("not_tag", [])
                    record["source_selection_criteria"]["tag_filters"]["delimiter"] = tmp2[0].get("delimiter", "")
            
            #filter
            tmp = rule.get("filter")
            if tmp:
                record["filter"] = {}
                tmp2 = tmp[0].get("prefix", "")
                if tmp2:
                    record["filter"]["prefix"] = tmp2
                tmp2 = tmp[0].get("tag", [])
                if tmp2:
                    record["filter"]["tag"] = tmp2
                tmp2 = tmp[0].get("and", [])
                if tmp2:
                    record["filter"]["and"] = tmp2
                tmp2 = tmp[0].get("not_tag", [])
                if tmp2:
                    record["filter"]["not_tag"] = tmp2
                tmp2 = tmp[0].get("delimiter", "")
                if tmp2:
                    record["filter"]["delimiter"] = tmp2
                if not record["filter"]:
                    del record["filter"]
            result["rule"].append(record)
                
        return result
    
    def aws_s3_get_object_lock_configuration_rule(self, state):
        rule = state.get('rule', [])
        if rule:
            default_retention=rule[0].get('default_retention', [])
            if default_retention:
                rule[0]['default_retention'] = default_retention[0]

        return rule

    def aws_s3_bucket_acl_owner(self, state):
        result = {}

        for item in state['access_control_policy']:
            result = item.get('owner', [{}])[0]
            if 'id' in result:
                del result['id']

        return result

    def aws_s3_bucket_acl_grant(self, state):
        result = []

        current_owner = {}

        for item in state['access_control_policy']:
            current_owner = item.get('owner', [{}])[0]

        for item in state['access_control_policy']:
            grant = item.get('grant', [{}])[0]
            grantee = grant.get('grantee', [{}])[0]
            permission = grant.get('permission', '')

            grantee['permission'] = permission
            if grantee.get('id', '') == current_owner.get('id', ''):
                grantee['type'] = 'CanonicalUser'
                del grantee['id']

            result.append(grantee)

        return result

    def aws_s3_bucket_website_configuration_website(self, state):
        result = {}

        tmp = state.get('index_document')
        if tmp:
            tmp2=tmp[0].get('suffix', '')
            result['index_document'] = tmp2

        tmp = state.get('error_document')
        if tmp:
            tmp2=tmp[0].get('key', '')
            result['error_document'] = tmp2

        tmp = state.get('redirect_all_requests_to')
        if tmp:
            result['redirect_all_requests_to'] = tmp[0]

        tmp = state.get('routing_rule')
        if tmp:
            result['routing_rules'] = tmp

        return result

    def aws_s3_bucket_ownership_controls_object_ownership(self, state):
        return state.get('rule', [{}])[0].get('object_ownership', '')

    def aws_s3_filter_empty_fields(self, input_data):
        if isinstance(input_data, dict):
            # Create a new dictionary by recursively calling aws_s3_filter_empty_fields and excluding 
            # keys with values that are None, empty strings, empty lists, or empty dicts
            filtered_dict = {k: self.aws_s3_filter_empty_fields(v) for k, v in input_data.items() if v not in [None, '', [], {}]}
            # Further filter out any keys that have None as their values after recursive filtering
            filtered_dict = {k: v for k, v in filtered_dict.items() if v is not None}
            return filtered_dict if filtered_dict else None
        elif isinstance(input_data, list):
            # Filter each element, excluding None, empty strings, empty lists, and empty dicts
            filtered_list = [self.aws_s3_filter_empty_fields(elem) for elem in input_data if elem not in [None, '', [], {}]]
            # Remove any None values that might have been introduced by filtering nested structures
            filtered_list = [elem for elem in filtered_list if elem is not None]
            return filtered_list if filtered_list else None
        else:
            return input_data


    def aws_s3_bucket_lifecycle_configuration_lifecycle_rule(self, state):
        rules = state["rule"]

        result = []
        # i = 0
        for rule in rules:
            transformed_rule = self.aws_s3_filter_empty_fields(rule)
            for filter in transformed_rule.get('filter', []):
                if 'and' in filter:
                    object_size_less_than = filter['and'][0].get('object_size_less_than', 0)
                    if object_size_less_than == 0:
                        del filter['and'][0]['object_size_less_than']
            result.append(transformed_rule)

        return result

    def aws_s3_bucket_versioning_versioning(self, state):
        result = {}

        tmp = state.get('mfa', '')
        if tmp:
            result['mfa'] = tmp

        tmp = state.get('error_document', [{}])[0].get(
            'key', '') if state.get('error_document', [{}]) else ''
        if tmp:
            result['error_document'] = tmp

        tmp = state.get('versioning_configuration', [{}])[0].get(
            'mfa_delete', '')
        if tmp:
            result['mfa_delete'] = tmp

        tmp = state.get('versioning_configuration', [{}])[0].get(
            'status', '')
        if tmp:
            result['status'] = tmp

        return result

    def aws_s3_convert_dict_structure(self, input_dict):
        if isinstance(input_dict, dict):
            for key, value in input_dict.items():
                if isinstance(value, list) and len(value) > 0 and isinstance(value[0], dict):
                    input_dict[key] = value[0]
                    self.aws_s3_convert_dict_structure(input_dict[key])
        return input_dict

    def aws_s3_server_side_encryption_configuration(self, state):
        result = {}

        tmp = state.get('rule', '')
        if tmp:
            result['rule'] = tmp

        return self.aws_s3_convert_dict_structure(result)

    def aws_s3_bucket_policy_policy(self, state, arg):
        # convert the string to a dict
        input_string = state.get(arg, '{}')
        json_dict = json.loads(input_string)

        # convert the dict back to a string, pretty printed
        pretty_json = json.dumps(json_dict, indent=4)

        if pretty_json == '{}':
            return None

        # create the final string with the 'EOF' tags
        result = pretty_json

        return result

    def aws_s3_bucket(self, selected_s3_bucket=None, ftstack=None):
        resource_name = "aws_s3_bucket"
        print("Processing S3 Buckets...")

        if selected_s3_bucket and ftstack:
            if self.hcl.id_resource_processed(resource_name, selected_s3_bucket, ftstack):
                print(f"  Skipping S3 Bucket: {selected_s3_bucket} - already processed")
                return
            self.process_single_s3_bucket(selected_s3_bucket, ftstack)
            return

        response = self.aws_clients.s3_client.list_buckets()
        all_buckets = response["Buckets"]

        for bucket in all_buckets:
            bucket_name = bucket["Name"]
            bucket_location_response = self.aws_clients.s3_client.get_bucket_location(Bucket=bucket_name)
            bucket_region = bucket_location_response['LocationConstraint']
            if bucket_region is None:
                bucket_region = 'us-east-1'

            if bucket_region == self.region:
                self.process_single_s3_bucket(bucket_name, ftstack)
                
    def process_single_s3_bucket(self, bucket_name, ftstack=None):
        print(f"  Processing S3 Bucket: {bucket_name}")
        resource_type = "aws_s3_bucket"

        # if bucket_name != "kh-data-deepintent-import-backup":
        #     return

        # Retrieve the region of the bucket
        bucket_location_response = self.aws_clients.s3_client.get_bucket_location(Bucket=bucket_name)
        bucket_region = bucket_location_response['LocationConstraint']

        # If bucket_region is None, set it to us-east-1
        if bucket_region is None:
            bucket_region = 'us-east-1'

        # Skip processing if the bucket's region does not match self.region
        if bucket_region != self.region:
            print(f"  Skipping S3 Bucket (different region): {bucket_name}")
            return

        # Describe the bucket and get the tags
        if not ftstack:
            ftstack = "s3"
            try:
                response = self.aws_clients.s3_client.get_bucket_tagging(Bucket=bucket_name)
                tags = response.get('TagSet', {})
                for tag in tags:
                    if tag['Key'] == 'ftstack':
                        if tag['Value'] != 's3':
                            ftstack = "stack_" + tag['Value']
                        break
            except ClientError as e:
                if e.response['Error']['Code'] == 'NoSuchTagSet':
                    pass
                else:
                    raise e

        id = bucket_name

        attributes = {
            "id": id,
            "bucket": bucket_name,
        }

        self.hcl.process_resource(resource_type, bucket_name, attributes)
        self.hcl.add_stack(resource_type, id, ftstack)

        # Add calls to various aws_s3_bucket_* functions
        if "gov" not in self.region:
            self.aws_s3_bucket_accelerate_configuration(bucket_name)
            self.aws_s3_bucket_intelligent_tiering_configuration(bucket_name)

        self.aws_s3_bucket_acl(bucket_name)
        self.aws_s3_bucket_analytics_configuration(bucket_name)
        self.aws_s3_bucket_cors_configuration(bucket_name)
        self.aws_s3_bucket_inventory(bucket_name)
        self.aws_s3_bucket_lifecycle_configuration(bucket_name)
        self.aws_s3_bucket_logging(bucket_name)
        self.aws_s3_bucket_metric(bucket_name)
        # self.aws_s3_bucket_notification(bucket_name) #will be called from other modules
        self.aws_s3_bucket_object_lock_configuration(bucket_name)
        self.aws_s3_bucket_ownership_controls(bucket_name)
        self.aws_s3_bucket_policy(bucket_name)
        self.aws_s3_bucket_public_access_block(bucket_name)
        self.aws_s3_bucket_replication_configuration(bucket_name)
        self.aws_s3_bucket_request_payment_configuration(bucket_name)
        self.aws_s3_bucket_server_side_encryption_configuration(bucket_name)
        self.aws_s3_bucket_versioning(bucket_name)
        self.aws_s3_bucket_website_configuration(bucket_name)

    def aws_s3_bucket_accelerate_configuration(self, bucket_name):
        print("Processing S3 Bucket Accelerate Configurations...")

        try:
            accelerate_config = self.aws_clients.s3_client.get_bucket_accelerate_configuration(
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
                    "aws_s3_bucket_accelerate_configuration", bucket_name, attributes)
            else:
                print(
                    f"  No Accelerate Configuration found for S3 Bucket: {bucket_name}")
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] == "NoSuchAccelerateConfiguration":
                print(
                    f"  No Accelerate Configuration found for S3 Bucket: {bucket_name}")
            else:
                raise

    def aws_s3_bucket_acl(self, bucket_name):
        print("Processing S3 Bucket ACLs...")

        # Get the Canonical User ID of your AWS account
        account_canonical_id = self.aws_clients.s3_client.list_buckets()['Owner']['ID']


        # Try to get the object ownership control of the bucket
        try:
            ownership_controls = self.aws_clients.s3_client.get_bucket_ownership_controls(
                Bucket=bucket_name)
            object_ownership = ownership_controls['OwnershipControls']['Rules'][0]['ObjectOwnership']
        except ClientError as e:
            if e.response['Error']['Code'] == 'OwnershipControlsNotFoundError':
                # If the bucket does not have ownership controls, skip it and continue with the next bucket
                print(
                    f"  Skipping S3 Bucket: {bucket_name} - No ownership controls found.")
                return
            else:
                # If some other error occurred, re-raise the exception
                raise

        acl = self.aws_clients.s3_client.get_bucket_acl(Bucket=bucket_name)

        # Check if the bucket's owner is someone external
        bucket_owner_canonical_id = acl['Owner']['ID']

        # Only process the ACL if bucket's owner is someone external
        # and object_ownership is not BucketOwnerEnforced
        if bucket_owner_canonical_id != account_canonical_id and object_ownership != 'BucketOwnerEnforced':
            print(f"  Processing S3 Bucket ACL: {bucket_name}")

            attributes = {
                "id": bucket_name,
                "bucket": bucket_name,
                # "acl": acl["Grants"],
            }
            self.hcl.process_resource(
                "aws_s3_bucket_acl", bucket_name, attributes)

    def aws_s3_bucket_analytics_configuration(self, bucket_name):
        print("Processing S3 Bucket Analytics Configurations...")

        analytics_configs = self.aws_clients.s3_client.list_bucket_analytics_configurations(
            Bucket=bucket_name)

        if "AnalyticsConfigurationList" not in analytics_configs:
            return

        for config in analytics_configs["AnalyticsConfigurationList"]:
            config_id = config["Id"]
            print(
                f"  Processing S3 Bucket Analytics Configuration: {config_id} for bucket {bucket_name}")

            attributes = {
                "id": bucket_name+":"+config_id,
                # "bucket": bucket_name,
                # "name": config_id,
                # "filter": config["Filter"],
                # "storage_class_analysis": config["StorageClassAnalysis"],
            }
            self.hcl.process_resource(
                "aws_s3_bucket_analytics_configuration",
                f"{bucket_name}-{config_id}".replace("-", "_"),
                attributes
            )

    def aws_s3_bucket_cors_configuration(self, bucket_name):
        print("Processing S3 Bucket CORS Configurations...")

        try:
            cors = self.aws_clients.s3_client.get_bucket_cors(Bucket=bucket_name)
            print(
                f"  Processing S3 Bucket CORS Configuration: {bucket_name}")

            attributes = {
                "id": bucket_name,
                "bucket": bucket_name,
                "rule": cors["CORSRules"],
            }
            self.hcl.process_resource(
                "aws_s3_bucket_cors_configuration", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] == "NoSuchCORSConfiguration":
                print(
                    f"  No CORS Configuration for bucket: {bucket_name}")
            else:
                raise

    def aws_s3_bucket_intelligent_tiering_configuration(self, bucket_name):
        print("Processing S3 Bucket Intelligent Tiering Configurations...")

        intelligent_tiering_configs = self.aws_clients.s3_client.list_bucket_intelligent_tiering_configurations(
            Bucket=bucket_name)

        if "IntelligentTieringConfigurationList" not in intelligent_tiering_configs:
            return

        for config in intelligent_tiering_configs["IntelligentTieringConfigurationList"]:
            config_id = config["Id"]
            print(
                f"  Processing S3 Bucket Intelligent Tiering Configuration: {config_id} for bucket {bucket_name}")
            
            attributes = {
                "id": bucket_name+":"+config_id,
                "bucket": bucket_name,
                "name": config_id,
                # "filter": config["Filter"],
                # "status": config["Status"],
                # "tierings": config["Tierings"],
            }
            self.hcl.process_resource("aws_s3_bucket_intelligent_tiering_configuration",
                                      f"{bucket_name}-{config_id}".replace("-", "_"), attributes)

    def aws_s3_bucket_inventory(self, bucket_name):
        print("Processing S3 Bucket Inventories...")

        inventory_configs = self.aws_clients.s3_client.list_bucket_inventory_configurations(
            Bucket=bucket_name)

        if "InventoryConfigurationList" not in inventory_configs:
            return

        for config in inventory_configs["InventoryConfigurationList"]:
            config_id = config["Id"]
            print(
                f"  Processing S3 Bucket Inventory: {config_id} for bucket {bucket_name}")

            attributes = {
                "id": bucket_name+":"+config_id,
                "bucket": bucket_name,
                # "name": config_id,
                # "destination": config["Destination"],
                # "schedule": config["Schedule"],
                # "included_object_versions": config["IncludedObjectVersions"],
                # "optional_fields": config["OptionalFields"] if "OptionalFields" in config else [],
                # "filter": config["Filter"] if "Filter" in config else None,
            }
            self.hcl.process_resource(
                "aws_s3_bucket_inventory", f"{bucket_name}-{config_id}".replace("-", "_"), attributes)

    def aws_s3_bucket_lifecycle_configuration(self, bucket_name):
        print("Processing S3 Bucket Lifecycle Configurations...")
        try:
            lifecycle = self.aws_clients.s3_client.get_bucket_lifecycle_configuration(
                Bucket=bucket_name)
            print(
                f"  Processing S3 Bucket Lifecycle Configuration: {bucket_name}")
            attributes = {
                "id": bucket_name,
                "bucket": bucket_name,
                "rule": lifecycle["Rules"],
            }
            self.hcl.process_resource(
                "aws_s3_bucket_lifecycle_configuration", bucket_name, attributes)
        except ClientError as e:
            if e.response['Error']['Code'] == 'NoSuchLifecycleConfiguration':
                print(
                    f"  No Lifecycle Configuration for bucket: {bucket_name}")
            else:
                raise

    def aws_s3_bucket_logging(self, bucket_name):
        print("Processing S3 Bucket Logging...")
        logging = self.aws_clients.s3_client.get_bucket_logging(
            Bucket=bucket_name)
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
                "aws_s3_bucket_logging", bucket_name, attributes)

    def aws_s3_bucket_metric(self, bucket_name):
        print("Processing S3 Bucket Metrics...")
        metrics = self.aws_clients.s3_client.list_bucket_metrics_configurations(
            Bucket=bucket_name)
        if "MetricsConfigurationList" not in metrics:
            return
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

    def aws_s3_bucket_notification(self, bucket_name):
        print("Processing S3 Bucket Notifications...")
        notifications = self.aws_clients.s3_client.get_bucket_notification_configuration(
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
                    "aws_s3_bucket_notification", bucket_name, attributes)

    def aws_s3_bucket_object(self, bucket_name):
        print("Processing S3 Bucket Objects...")
        objects = self.aws_clients.s3_client.list_objects(Bucket=bucket_name)
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

    def aws_s3_bucket_object_lock_configuration(self, bucket_name):
        print("Processing S3 Bucket Object Lock Configurations...")
        try:
            object_lock_configuration = self.aws_clients.s3_client.get_object_lock_configuration(
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
                    "aws_s3_bucket_object_lock_configuration", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] != "ObjectLockConfigurationNotFoundError":
                raise
            else:
                print(
                    f"  No Object Lock Configuration for bucket: {bucket_name}")

    def aws_s3_bucket_ownership_controls(self, bucket_name):
        print("Processing S3 Bucket Ownership Controls...")
        try:
            ownership_controls = self.aws_clients.s3_client.get_bucket_ownership_controls(
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
                    "aws_s3_bucket_ownership_controls", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] != "OwnershipControlsNotFoundError":
                raise
            else:
                print(
                    f"  No Ownership Controls for bucket: {bucket_name}")

    def aws_s3_bucket_policy(self, bucket_name):
        print("Processing S3 Bucket Policies...")
        try:
            bucket_policy = self.aws_clients.s3_client.get_bucket_policy(
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
                    "aws_s3_bucket_policy", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] != "NoSuchBucketPolicy":
                raise

    def aws_s3_bucket_public_access_block(self, bucket_name):
        print("Processing S3 Bucket Public Access Blocks...")
        try:
            public_access_block = self.aws_clients.s3_client.get_public_access_block(
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
                    "aws_s3_bucket_public_access_block", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] != "NoSuchPublicAccessBlockConfiguration":
                raise

    def aws_s3_bucket_replication_configuration(self, bucket_name):
        print("Processing S3 Bucket Replication Configurations...")
        try:
            replication_configuration = self.aws_clients.s3_client.get_bucket_replication(
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
                    "aws_s3_bucket_replication_configuration", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] != "ReplicationConfigurationNotFoundError":
                raise

    def aws_s3_bucket_request_payment_configuration(self, bucket_name):
        print("Processing S3 Bucket Request Payment Configurations...")
        try:
            request_payment_configuration = self.aws_clients.s3_client.get_bucket_request_payment(
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
                    "aws_s3_bucket_request_payment_configuration", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] != "NoSuchRequestPaymentConfiguration":
                raise

    def aws_s3_bucket_server_side_encryption_configuration(self, bucket_name):
        print("Processing S3 Bucket Server Side Encryption Configurations...")
        try:
            encryption_configuration = self.aws_clients.s3_client.get_bucket_encryption(
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
                    "aws_s3_bucket_server_side_encryption_configuration", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] != "ServerSideEncryptionConfigurationNotFoundError":
                raise

    def aws_s3_bucket_versioning(self, bucket_name):
        print("Processing S3 Bucket Versioning Configurations...")


        try:
            versioning_configuration = self.aws_clients.s3_client.get_bucket_versioning(
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
                    "aws_s3_bucket_versioning", bucket_name, attributes)
        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] != "NoSuchVersioningConfiguration":
                raise

    def aws_s3_bucket_website_configuration(self, bucket_name):
        print("Processing S3 Bucket Website Configurations...")

        try:
            website_config = self.aws_clients.s3_client.get_bucket_website(
                Bucket=bucket_name)
            print(
                f"  Processing S3 Bucket Website Configuration: {bucket_name}")

            attributes = {
                "id": bucket_name,
            }
            self.hcl.process_resource(
                "aws_s3_bucket_website_configuration", bucket_name, attributes)

        except self.aws_clients.s3_client.exceptions.ClientError as e:
            if e.response["Error"]["Code"] == "NoSuchWebsiteConfiguration":
                pass
                print(
                    f"  No website configuration found for bucket: {bucket_name}")
            else:
                raise
