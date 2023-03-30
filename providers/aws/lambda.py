import os
from utils.hcl import HCL


class Lambda:
    def __init__(self, lambda_client, script_dir, provider_name, schema_data, region):
        self.lambda_client = lambda_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def lambda_r(self):
        self.hcl.prepare_folder(os.path.join("generated", "lambda"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_lambda_alias(self):
        print("Processing Lambda Aliases...")

        functions = self.lambda_client.list_functions()["Functions"]

        for function in functions:
            function_name = function["FunctionName"]
            aliases = self.lambda_client.list_aliases(
                FunctionName=function_name)["Aliases"]
            for alias in aliases:
                alias_name = alias["Name"]
                print(
                    f"  Processing Lambda Alias: {alias_name} for Function: {function_name}")

                attributes = {
                    "id": alias["AliasArn"],
                    "function_name": function_name,
                    "name": alias_name,
                    "function_version": alias["FunctionVersion"],
                }
                self.hcl.process_resource(
                    "aws_lambda_alias", f"{function_name}_{alias_name}".replace("-", "_"), attributes)

    def aws_lambda_code_signing_config(self):
        print("Processing Lambda Code Signing Configs...")

        paginator = self.lambda_client.get_paginator(
            "list_code_signing_configs")

        for page in paginator.paginate():
            for config in page.get("CodeSigningConfigs", []):
                config_id = config["CodeSigningConfigId"]
                print(f"  Processing Lambda Code Signing Config: {config_id}")

                attributes = {
                    "id": config_id,
                    "allowed_publishers": config["AllowedPublishers"]["SigningProfileVersionArns"],
                    "policies": config["CodeSigningPolicies"]["UntrustedArtifactOnDeployment"],
                }
                if "Description" in config:
                    attributes["description"] = config["Description"]

                self.hcl.process_resource(
                    "aws_lambda_code_signing_config", config_id.replace("-", "_"), attributes)

    def aws_lambda_event_source_mapping(self):
        print("Processing Lambda Event Source Mappings...")

        functions = self.lambda_client.list_functions()["Functions"]

        for function in functions:
            function_name = function["FunctionName"]
            event_source_mappings = self.lambda_client.list_event_source_mappings(
                FunctionName=function_name)["EventSourceMappings"]

            for mapping in event_source_mappings:
                mapping_id = mapping["UUID"]
                print(
                    f"  Processing Lambda Event Source Mapping: {mapping_id} for Function: {function_name}")

                attributes = {
                    "id": mapping_id,
                    "function_name": function_name,
                    "event_source_arn": mapping["EventSourceArn"],
                }
                self.hcl.process_resource(
                    "aws_lambda_event_source_mapping", mapping_id.replace("-", "_"), attributes)

    def aws_lambda_function(self):
        print("Processing Lambda Functions...")

        functions = self.lambda_client.list_functions()["Functions"]

        for function in functions:
            function_name = function["FunctionName"]
            print(f"  Processing Lambda Function: {function_name}")

            attributes = {
                "id": function["FunctionArn"],
                "function_name": function_name,
                "runtime": function["Runtime"],
                "role": function["Role"],
                "handler": function["Handler"],
                "timeout": function["Timeout"],
                "memory_size": function["MemorySize"],
                "description": function.get("Description", ""),
                "publish": False,
            }
            self.hcl.process_resource(
                "aws_lambda_function", function_name.replace("-", "_"), attributes)

    def aws_lambda_function_event_invoke_config(self):
        print("Processing Lambda Function Event Invoke Configs...")

        functions = self.lambda_client.list_functions()["Functions"]

        for function in functions:
            function_name = function["FunctionName"]
            event_invoke_config = self.lambda_client.get_function_event_invoke_config(
                FunctionName=function_name)
            print(
                f"  Processing Event Invoke Config for Lambda Function: {function_name}")

            attributes = {
                "id": f"{function_name}:$LATEST",
                "function_name": function_name,
                "maximum_event_age_in_seconds": event_invoke_config.get("MaximumEventAgeInSeconds", ""),
                "maximum_retry_attempts": event_invoke_config.get("MaximumRetryAttempts", ""),
            }
            self.hcl.process_resource(
                "aws_lambda_function_event_invoke_config", function_name.replace("-", "_"), attributes)

    def aws_lambda_function_url(self):
        print("Processing Lambda Function URLs...")

        functions = self.lambda_client.list_functions()["Functions"]

        for function in functions:
            function_name = function["FunctionName"]
            qualifier = "$LATEST"
            url = self.lambda_client.get_function_url(
                FunctionName=function_name, Qualifier=qualifier)
            print(f"  Processing URL for Lambda Function: {function_name}")

            attributes = {
                "id": f"{function_name}:$LATEST",
                "function_name": function_name,
                "qualifier": qualifier,
                "url": url["url"],
            }
            self.hcl.process_resource(
                "aws_lambda_function_url", function_name.replace("-", "_"), attributes)

    def aws_lambda_layer_version(self):
        print("Processing Lambda Layer Versions...")

        layers = self.lambda_client.list_layers()["Layers"]

        for layer in layers:
            layer_name = layer["LayerName"]
            layer_versions = self.lambda_client.list_layer_versions(LayerName=layer_name)[
                "LayerVersions"]

            for layer_version in layer_versions:
                version = layer_version["Version"]
                print(
                    f"  Processing Layer Version {version} for Lambda Layer: {layer_name}")

                attributes = {
                    "id": f"{layer_name}:{version}",
                    "layer_name": layer_name,
                    "version": version,
                    "compatible_runtimes": layer_version.get("CompatibleRuntimes", []),
                }
                self.hcl.process_resource(
                    "aws_lambda_layer_version", f"{layer_name.replace('-', '_')}_version_{version}", attributes)

    def aws_lambda_layer_version_permission(self, layer_version_permission_arns):
        print("Processing Lambda Layer Version Permissions...")

        for permission_arn in layer_version_permission_arns:
            layer_name, version, statement_id = permission_arn.split(
                ':')[-1].split('/')[1:]

            print(
                f"  Processing Permission {statement_id} for Lambda Layer: {layer_name}, Version: {version}")

            attributes = {
                "id": permission_arn,
                "layer_name": layer_name,
                "version_number": version,
                "statement_id": statement_id,
            }
            self.hcl.process_resource("aws_lambda_layer_version_permission",
                                      f"{layer_name.replace('-', '_')}_version_{version}_permission_{statement_id}", attributes)

    def aws_lambda_permission(self):
        print("Processing Lambda Permissions...")

        functions = self.lambda_client.list_functions()["Functions"]

        for function in functions:
            function_name = function["FunctionName"]
            policy_response = self.lambda_client.get_policy(
                FunctionName=function_name)
            policy = json.loads(policy_response["Policy"])

            for statement in policy["Statement"]:
                statement_id = statement["Sid"]
                print(
                    f"  Processing Permission {statement_id} for Lambda Function: {function_name}")

                attributes = {
                    "id": f"{function_name}-{statement_id}",
                    "function_name": function_name,
                    "statement_id": statement_id,
                }
                self.hcl.process_resource(
                    "aws_lambda_permission", f"{function_name.replace('-', '_')}_permission_{statement_id}", attributes)

    def aws_lambda_provisioned_concurrency_config(self, function_arns):
        print("Processing Lambda Provisioned Concurrency Configurations...")

        for function_arn in function_arns:
            function_name = function_arn.split(':')[-1].split('/')[-1]
            try:
                concurrency_configs = self.lambda_client.list_provisioned_concurrency_configs(
                    FunctionName=function_name)["ProvisionedConcurrencyConfigs"]

                for config in concurrency_configs:
                    version = config["FunctionVersion"]
                    allocated_concurrent_executions = config["RequestedProvisionedConcurrentExecutions"]
                    print(
                        f"  Processing Provisioned Concurrency Configuration for Lambda Function: {function_name}, Version: {version}")

                    attributes = {
                        "id": f"{function_name}-{version}",
                        "function_name": function_name,
                        "qualifier": version,
                        "provisioned_concurrent_executions": allocated_concurrent_executions,
                    }
                    self.hcl.process_resource("aws_lambda_provisioned_concurrency_config",
                                              f"{function_name.replace('-', '_')}_provisioned_concurrency_{version}", attributes)
            except self.lambda_client.exceptions.ResourceNotFoundException:
                print(
                    f"  No provisioned concurrency configuration found for Lambda Function: {function_name}")
