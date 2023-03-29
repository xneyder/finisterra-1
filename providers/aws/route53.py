import os
from utils.hcl import HCL


class Route53:
    def __init__(self, session, script_dir, provider_name, schema_data, region):
        self.session = session
        self.        self.transform_rules = {
            "aws_route53_zone": {
                "hcl_transform_fields": {
                    "force_destroy": {'source': None, 'target': False},
                    "comment": {'source': "", 'target': ""},
                },
            },
            "aws_route53_record": {
                "hcl_drop_fields": {
                    "multivalue_answer_routing_policy": False,
                    "ttl": 0,
                },
            },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def route53(self):
        self.hcl.prepare_folder(os.path.join("generated", "route53"))

        self.aws_route53_delegation_set()
        self.aws_route53_health_check()
        self.aws_route53_hosted_zone_dnssec()
        self.aws_route53_key_signing_key()
        self.aws_route53_query_log()
        self.aws_route53_record()
        self.aws_route53_traffic_policy()
        self.aws_route53_traffic_policy_instance()
        self.aws_route53_vpc_association_authorization()
        self.aws_route53_zone()
        self.aws_route53_zone_association()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    # def process_route53(self):
    #     route53 = self.session.client("route53", region_name=self.region)

    #     print("Processing Route53 hosted zones and records...")
    #     paginator = route53.get_paginator("list_hosted_zones")
    #     for page in paginator.paginate():
    #         for hosted_zone in page["HostedZones"]:
    #             zone_id = hosted_zone["Id"].split("/")[-1]
    #             zone_name = hosted_zone["Name"].rstrip(".")

    #             attributes = {
    #                 "id": zone_id,
    #             }
    #             print(f"Processing hosted zone: {zone_name} (ID: {zone_id})")

    #             self.hcl.process_resource("aws_route53_zone",
    #                             zone_id+"_"+zone_name.replace(".", "_"), attributes)

    #             record_paginator = route53.get_paginator(
    #                 "list_resource_record_sets")
    #             for record_page in record_paginator.paginate(HostedZoneId=hosted_zone["Id"]):
    #                 for record in record_page["ResourceRecordSets"]:
    #                     record_name = record["Name"].rstrip(".")
    #                     record_type = record["Type"]

    #                     if record_type in ["SOA", "NS"]:
    #                         continue

    #                     print(
    #                         f"  Processing record: {record_name} ({record_type})")

    #                     resource_name = f"{zone_name}_{record_name}_{record_type}".replace(
    #                         ".", "_")
    #                     resource_id = f"{zone_id}_{record_name}_{record_type}"
    #                     attributes = {
    #                         "id": resource_id,
    #                         "type": record_type,
    #                         "name": record_name,
    #                         "zone_id": zone_id,
    #                     }
    #                     self.hcl.process_resource("aws_route53_record",
    #                                     resource_name, attributes)

    def aws_route53_delegation_set(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Delegation Sets...")

        delegation_sets = route53.list_reusable_delegation_sets()[
            "DelegationSets"]
        for delegation_set in delegation_sets:
            delegation_set_id = delegation_set["Id"]
            print(f"  Processing Route53 Delegation Set: {delegation_set_id}")

            attributes = {
                "id": delegation_set_id,
                "caller_reference": delegation_set["CallerReference"],
                "name_servers": delegation_set["NameServers"],
            }

            self.hcl.process_resource(
                "aws_route53_delegation_set", delegation_set_id.replace("-", "_"), attributes)

    def aws_route53_health_check(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Health Checks...")

        paginator = route53.get_paginator("list_health_checks")
        for page in paginator.paginate():
            health_checks = page["HealthChecks"]
            for health_check in health_checks:
                health_check_id = health_check["Id"]
                print(f"  Processing Route53 Health Check: {health_check_id}")

                config = health_check["HealthCheckConfig"]
                attributes = {
                    "id": health_check_id,
                    "type": config["Type"],
                }

                if "IPAddress" in config:
                    attributes["ip_address"] = config["IPAddress"]
                if "Port" in config:
                    attributes["port"] = config["Port"]
                if "ResourcePath" in config:
                    attributes["resource_path"] = config["ResourcePath"]
                if "FullyQualifiedDomainName" in config:
                    attributes["fully_qualified_domain_name"] = config["FullyQualifiedDomainName"]
                if "RequestInterval" in config:
                    attributes["request_interval"] = config["RequestInterval"]
                if "FailureThreshold" in config:
                    attributes["failure_threshold"] = config["FailureThreshold"]

                self.hcl.process_resource(
                    "aws_route53_health_check", health_check_id.replace("-", "_"), attributes)

    def aws_route53_hosted_zone_dnssec(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Hosted Zone DNSSEC...")

        paginator = route53.get_paginator("list_hosted_zones")
        for page in paginator.paginate():
            hosted_zones = page["HostedZones"]
            for hosted_zone in hosted_zones:
                hosted_zone_id = hosted_zone["Id"]
                dnssec_resp = route53.get_dnssec(hosted_zone_id)
                dnssec = dnssec_resp["DNSSEC"]

                if dnssec["Status"] != "DISABLED":
                    print(
                        f"  Processing Route53 Hosted Zone DNSSEC for Hosted Zone: {hosted_zone_id}")

                    attributes = {
                        "id": dnssec["Id"],
                        "hosted_zone_id": hosted_zone_id,
                        "status": dnssec["Status"],
                    }

                    if "KeySigningKey" in dnssec:
                        attributes["key_signing_key"] = dnssec["KeySigningKey"]

                    if "ZSK" in dnssec:
                        attributes["zsk"] = dnssec["ZSK"]

                    self.hcl.process_resource(
                        "aws_route53_hosted_zone_dnssec", hosted_zone_id.replace("/", "_"), attributes)

    def aws_route53_key_signing_key(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Key Signing Key...")

        paginator = route53.get_paginator("list_hosted_zones")
        for page in paginator.paginate():
            hosted_zones = page["HostedZones"]
            for hosted_zone in hosted_zones:
                hosted_zone_id = hosted_zone["Id"]
                paginator_ksk = route53.get_paginator("list_key_signing_keys")

                for ksk_page in paginator_ksk.paginate(HostedZoneId=hosted_zone_id):
                    key_signing_keys = ksk_page["KeySigningKeys"]
                    for ksk in key_signing_keys:
                        ksk_id = ksk["KeySigningKeyId"]
                        print(
                            f"  Processing Route53 Key Signing Key: {ksk_id} for Hosted Zone: {hosted_zone_id}")

                        attributes = {
                            "id": ksk_id,
                            "hosted_zone_id": hosted_zone_id,
                            "name": ksk["Name"],
                            "status": ksk["Status"],
                            "key_management_service_arn": ksk["KmsArn"],
                            "digest_algorithm_mnemonic": ksk["DigestAlgorithmMnemonic"],
                            "digest_algorithm_type": ksk["DigestAlgorithmType"],
                            "key_tag": ksk["KeyTag"],
                            "public_key": ksk["PublicKey"],
                            "signing_algorithm_mnemonic": ksk["SigningAlgorithmMnemonic"],
                            "signing_algorithm_type": ksk["SigningAlgorithmType"],
                        }

                        self.hcl.process_resource(
                            "aws_route53_key_signing_key", ksk_id.replace("-", "_"), attributes)

    def aws_route53_query_log(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Query Logs...")

        paginator = route53.get_paginator("list_hosted_zones")
        for page in paginator.paginate():
            hosted_zones = page["HostedZones"]
            for hosted_zone in hosted_zones:
                hosted_zone_id = hosted_zone["Id"]

                try:
                    query_logging_config = route53.list_query_logging_configs(
                        HostedZoneId=hosted_zone_id)
                    configs = query_logging_config["QueryLoggingConfigs"]

                    for config in configs:
                        config_id = config["Id"]
                        print(
                            f"  Processing Route53 Query Log: {config_id} for Hosted Zone: {hosted_zone_id}")

                        attributes = {
                            "id": config_id,
                            "zone_id": hosted_zone_id,
                            "cloudwatch_log_group_arn": config["CloudWatchLogsLogGroupArn"],
                        }

                        self.hcl.process_resource(
                            "aws_route53_query_log", config_id.replace("-", "_"), attributes)

                except route53.exceptions.NoSuchQueryLoggingConfig:
                    print(
                        f"  No Route53 Query Log found for Hosted Zone: {hosted_zone_id}")

    def aws_route53_record(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Records...")

        paginator = route53.get_paginator("list_hosted_zones")
        for page in paginator.paginate():
            hosted_zones = page["HostedZones"]
            for hosted_zone in hosted_zones:
                hosted_zone_id = hosted_zone["Id"]

                paginator_records = route53.get_paginator(
                    "list_resource_record_sets")
                for record_page in paginator_records.paginate(HostedZoneId=hosted_zone_id):
                    record_sets = record_page["ResourceRecordSets"]

                    for record in record_sets:
                        record_name = record["Name"]
                        record_type = record["Type"]

                        record_id = f"{hosted_zone_id}-{record_name}-{record_type}"
                        print(
                            f"  Processing Route53 Record: {record_name} with Type: {record_type} in Hosted Zone: {hosted_zone_id}")

                        attributes = {
                            "id": record_id,
                            "zone_id": hosted_zone_id,
                            "name": record_name,
                            "type": record_type,
                            "ttl": record.get("TTL", None),
                            "records": [rr["Value"] for rr in record.get("ResourceRecords", [])],
                        }

                        self.hcl.process_resource(
                            "aws_route53_record", record_id.replace("-", "_"), attributes)

    def aws_route53_traffic_policy(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Traffic Policies...")

        paginator = route53.get_paginator("list_traffic_policies")
        for page in paginator.paginate():
            traffic_policies = page["TrafficPolicySummaries"]
            for traffic_policy in traffic_policies:
                traffic_policy_id = traffic_policy["Id"]
                traffic_policy_version = traffic_policy["LatestVersion"]

                print(
                    f"  Processing Route53 Traffic Policy: {traffic_policy_id} Version: {traffic_policy_version}")

                traffic_policy_detail = route53.get_traffic_policy(
                    Id=traffic_policy_id,
                    Version=traffic_policy_version
                )["TrafficPolicy"]

                attributes = {
                    "id": traffic_policy_id,
                    "name": traffic_policy_detail["Name"],
                    "version": traffic_policy_version,
                    "document": traffic_policy_detail["Document"],
                }

                self.hcl.process_resource(
                    "aws_route53_traffic_policy", traffic_policy_id.replace("-", "_"), attributes)

    def aws_route53_traffic_policy_instance(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Traffic Policy Instances...")

        paginator = route53.get_paginator("list_traffic_policy_instances")
        for page in paginator.paginate():
            traffic_policy_instances = page["TrafficPolicyInstances"]
            for instance in traffic_policy_instances:
                instance_id = instance["Id"]
                policy_id = instance["TrafficPolicyId"]
                policy_version = instance["TrafficPolicyVersion"]

                print(
                    f"  Processing Route53 Traffic Policy Instance: {instance_id}")

                attributes = {
                    "id": instance_id,
                    "traffic_policy_id": policy_id,
                    "traffic_policy_version": policy_version,
                    "hosted_zone_id": instance["HostedZoneId"],
                    "name": instance["Name"],
                    "ttl": instance["TTL"],
                }

                self.hcl.process_resource(
                    "aws_route53_traffic_policy_instance", instance_id.replace("-", "_"), attributes)

    def aws_route53_vpc_association_authorization(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 VPC Association Authorizations...")

        paginator = route53.get_paginator("list_hosted_zones")
        for page in paginator.paginate():
            hosted_zones = page["HostedZones"]
            for hosted_zone in hosted_zones:
                hosted_zone_id = hosted_zone["Id"]

                vpc_association_authorizations = route53.list_vpc_association_authorizations(
                    HostedZoneId=hosted_zone_id
                )["VPCs"]

                for vpc_assoc_auth in vpc_association_authorizations:
                    vpc_id = vpc_assoc_auth["VPCId"]
                    vpc_region = vpc_assoc_auth["VPCRegion"]

                    print(
                        f"  Processing Route53 VPC Association Authorization: Hosted Zone: {hosted_zone_id}, VPC: {vpc_id}")

                    attributes = {
                        "id": f"{hosted_zone_id}:{vpc_id}",
                        "zone_id": hosted_zone_id,
                        "vpc_id": vpc_id,
                        "vpc_region": vpc_region,
                    }

                    self.hcl.process_resource("aws_route53_vpc_association_authorization",
                                              f"{hosted_zone_id.replace('/', '_')}-{vpc_id.replace('-', '_')}", attributes)

    def aws_route53_zone(self):
        route53 = self.session.client("route53", region_name=self.region)
        print("Processing Route53 Zones...")

        paginator = route53.get_paginator("list_hosted_zones")
        for page in paginator.paginate():
            hosted_zones = page["HostedZones"]
            for hosted_zone in hosted_zones:
                hosted_zone_id = hosted_zone["Id"]
                name = hosted_zone["Name"]
                private_zone = hosted_zone["Config"]["PrivateZone"]

                print(
                    f"  Processing Route53 Zone: {name} (ID: {hosted_zone_id})")

                attributes = {
                    "id": hosted_zone_id,
                    "name": name,
                    "private_zone": private_zone,
                }

                self.hcl.process_resource(
                    "aws_route53_zone", hosted_zone_id.replace("/", "_"), attributes)

    def aws_route53_zone_association(self):
        route53 = self.session.client("route53", region_name=self.region)
        ec2 = self.session.client("ec2", region_name=self.region)
        print("Processing Route53 Zone Associations...")

        paginator = route53.get_paginator("list_hosted_zones")
        for page in paginator.paginate():
            hosted_zones = page["HostedZones"]
            for hosted_zone in hosted_zones:
                hosted_zone_id = hosted_zone["Id"]

                if hosted_zone["Config"]["PrivateZone"]:
                    associations = route53.list_vpc_association_authorizations(
                        HostedZoneId=hosted_zone_id)

                    for association in associations["VPCs"]:
                        vpc_id = association["VPCId"]
                        association_id = f"{hosted_zone_id}-{vpc_id}"

                        print(
                            f"  Processing Route53 Zone Association: Hosted Zone {hosted_zone_id} with VPC {vpc_id}")

                        attributes = {
                            "id": association_id,
                            "zone_id": hosted_zone_id,
                            "vpc_id": vpc_id,
                        }

                        self.hcl.process_resource(
                            "aws_route53_zone_association", association_id.replace("/", "_"), attributes)
