import os
from utils.hcl import HCL


class WAFV2:
    def __init__(self, wafv2_client, script_dir, provider_name, schema_data, region):
        self.wafv2_client = wafv2_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def wafv2(self):
        self.hcl.prepare_folder(os.path.join("generated", "wafv2"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_wafv2_ip_set(self):
        print("Processing WAFv2 IP Sets...")

        scope = 'REGIONAL'
        ip_sets = self.wafv2_client.list_ip_sets(Scope=scope)["IPSets"]

        for ip_set in ip_sets:
            ip_set_id = ip_set["Id"]
            print(f"  Processing WAFv2 IP Set: {ip_set_id}")

            ip_set_info = self.wafv2_client.get_ip_set(
                Id=ip_set_id, Scope=scope)["IPSet"]
            attributes = {
                "id": ip_set_id,
                "name": ip_set_info["Name"],
                "description": ip_set_info.get("Description", ""),
                "scope": scope,
            }
            self.hcl.process_resource(
                "aws_wafv2_ip_set", ip_set_id.replace("-", "_"), attributes)

    def aws_wafv2_regex_pattern_set(self):
        print("Processing WAFv2 Regex Pattern Sets...")

        scope = 'REGIONAL'
        regex_pattern_sets = self.wafv2_client.list_regex_pattern_sets(Scope=scope)[
            "RegexPatternSets"]

        for regex_pattern_set in regex_pattern_sets:
            regex_pattern_set_id = regex_pattern_set["Id"]
            print(
                f"  Processing WAFv2 Regex Pattern Set: {regex_pattern_set_id}")

            regex_pattern_set_info = self.wafv2_client.get_regex_pattern_set(
                Id=regex_pattern_set_id, Scope=scope)["RegexPatternSet"]
            attributes = {
                "id": regex_pattern_set_id,
                "name": regex_pattern_set_info["Name"],
                "description": regex_pattern_set_info.get("Description", ""),
                "scope": scope,
            }
            self.hcl.process_resource(
                "aws_wafv2_regex_pattern_set", regex_pattern_set_id.replace("-", "_"), attributes)

    def aws_wafv2_rule_group(self):
        print("Processing WAFv2 Rule Groups...")

        scope = 'REGIONAL'
        rule_groups = self.wafv2_client.list_rule_groups(Scope=scope)[
            "RuleGroups"]

        for rule_group in rule_groups:
            rule_group_id = rule_group["Id"]
            print(f"  Processing WAFv2 Rule Group: {rule_group_id}")

            rule_group_info = self.wafv2_client.get_rule_group(
                Id=rule_group_id, Scope=scope)["RuleGroup"]
            attributes = {
                "id": rule_group_id,
                "name": rule_group_info["Name"],
                "description": rule_group_info.get("Description", ""),
                "scope": scope,
            }
            self.hcl.process_resource(
                "aws_wafv2_rule_group", rule_group_id.replace("-", "_"), attributes)

    def aws_wafv2_web_acl(self):
        print("Processing WAFv2 Web ACLs...")

        scope = 'REGIONAL'
        web_acls = self.wafv2_client.list_web_acls(Scope=scope)["WebACLs"]

        for web_acl in web_acls:
            web_acl_id = web_acl["Id"]
            print(f"  Processing WAFv2 Web ACL: {web_acl_id}")

            web_acl_info = self.wafv2_client.get_web_acl(
                Id=web_acl_id, Scope=scope)["WebACL"]
            attributes = {
                "id": web_acl_id,
                "name": web_acl_info["Name"],
                "description": web_acl_info.get("Description", ""),
                "scope": scope,
            }
            self.hcl.process_resource(
                "aws_wafv2_web_acl", web_acl_id.replace("-", "_"), attributes)

    def aws_wafv2_web_acl_association(self):
        print("Processing WAFv2 Web ACL Associations...")

        scope = 'REGIONAL'
        web_acls = self.wafv2_client.list_web_acls(Scope=scope)["WebACLs"]

        for web_acl in web_acls:
            web_acl_id = web_acl["Id"]
            associations = self.wafv2_client.list_associations(
                Scope=scope, WebAclId=web_acl_id)["Associations"]

            for association in associations:
                resource_arn = association["ResourceArn"]
                association_id = f"{web_acl_id}-{resource_arn}"
                print(
                    f"  Processing WAFv2 Web ACL Association: {association_id}")

                attributes = {
                    "id": association_id,
                    "web_acl_id": web_acl_id,
                    "resource_arn": resource_arn,
                }
                self.hcl.process_resource(
                    "aws_wafv2_web_acl_association", association_id.replace("-", "_"), attributes)

    def aws_wafv2_web_acl_logging_configuration(self):
        print("Processing WAFv2 Web ACL Logging Configurations...")

        scope = 'REGIONAL'
        web_acls = self.wafv2_client.list_web_acls(Scope=scope)["WebACLs"]

        for web_acl in web_acls:
            web_acl_id = web_acl["Id"]

            try:
                logging_config = self.wafv2_client.get_logging_configuration(ResourceArn=web_acl["ARN"])[
                    "LoggingConfiguration"]
                log_destination_configs = logging_config["LogDestinationConfigs"]

                for index, log_destination in enumerate(log_destination_configs):
                    config_id = f"{web_acl_id}-{index}"
                    print(
                        f"  Processing WAFv2 Web ACL Logging Configuration: {config_id}")

                    attributes = {
                        "id": config_id,
                        "web_acl_id": web_acl_id,
                        "log_destination_configs": log_destination_configs,
                    }
                    self.hcl.process_resource(
                        "aws_wafv2_web_acl_logging_configuration", config_id.replace("-", "_"), attributes)
            except self.wafv2_client.exceptions.WAFNonexistentItemException:
                print(
                    f"  No logging configuration found for Web ACL: {web_acl_id}")
