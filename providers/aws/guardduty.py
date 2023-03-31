import os
from utils.hcl import HCL


class Guarduty:
    def __init__(self, guardduty_client, script_dir, provider_name, schema_data, region):
        self.guardduty_client = guardduty_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def guardduty(self):
        self.hcl.prepare_folder(os.path.join("generated", "guardduty"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_guardduty_detector(self):
        print("Processing GuardDuty Detectors...")

        detectors = self.guardduty_client.list_detectors()["DetectorIds"]

        for detector_id in detectors:
            print(f"  Processing GuardDuty Detector: {detector_id}")

            attributes = {
                "id": detector_id,
            }

            self.hcl.process_resource(
                "aws_guardduty_detector", detector_id, attributes)

            self.aws_guardduty_filter(detector_id)

    def aws_guardduty_filter(self, detector_id):
        print(f"Processing GuardDuty Filters for Detector ID: {detector_id}")

        paginator = self.guardduty_client.get_paginator("list_filters")
        page_iterator = paginator.paginate(DetectorId=detector_id)

        for page in page_iterator:
            for filter_name in page["FilterNames"]:
                print(f"  Processing GuardDuty Filter: {filter_name}")

                filter_details = self.guardduty_client.get_filter(
                    DetectorId=detector_id, FilterName=filter_name)

                attributes = {
                    "detector_id": detector_id,
                    "name": filter_name,
                    "action": filter_details["Action"],
                    "rank": filter_details["Rank"],
                    "finding_criteria": filter_details["FindingCriteria"],
                }

                self.hcl.process_resource(
                    "aws_guardduty_filter", filter_name, attributes)

    def aws_guardduty_invite_accepter(self):
        print("Processing GuardDuty Invite Accepters...")

        invitations = self.guardduty_client.list_invitations()["Invitations"]

        for invitation in invitations:
            print(
                f"  Processing GuardDuty Invite Accepter: {invitation['AccountId']}")

            attributes = {
                "detector_id": invitation["DetectorId"],
                "master_account_id": invitation["AccountId"],
                "depends_on": ["aws_guardduty_detector.guardduty_detector"],
            }

            self.hcl.process_resource(
                "aws_guardduty_invite_accepter", invitation["AccountId"], attributes)

    def aws_guardduty_ipset(self, detector_id):
        print(f"Processing GuardDuty IP Sets for Detector ID: {detector_id}")

        paginator = self.guardduty_client.get_paginator("list_ip_sets")
        page_iterator = paginator.paginate(DetectorId=detector_id)

        for page in page_iterator:
            for ip_set_id in page["IpSetIds"]:
                print(f"  Processing GuardDuty IP Set: {ip_set_id}")

                ip_set = self.guardduty_client.get_ip_set(
                    DetectorId=detector_id, IpSetId=ip_set_id)

                attributes = {
                    "detector_id": detector_id,
                    "name": ip_set["Name"],
                    "format": ip_set["Format"],
                    "location": ip_set["Location"],
                    "activate": ip_set["Status"] == "ACTIVE",
                }

                self.hcl.process_resource(
                    "aws_guardduty_ipset", ip_set["Name"], attributes)

    def aws_guardduty_member(self, detector_id):
        print(f"Processing GuardDuty Members for Detector ID: {detector_id}")

        paginator = self.guardduty_client.get_paginator("list_members")
        page_iterator = paginator.paginate(DetectorId=detector_id)

        for page in page_iterator:
            for member in page["Members"]:
                print(f"  Processing GuardDuty Member: {member['AccountId']}")

                attributes = {
                    "detector_id": detector_id,
                    "account_id": member["AccountId"],
                    "email": member["Email"],
                    "depends_on": ["aws_guardduty_detector.guardduty_detector"],
                }

                self.hcl.process_resource(
                    "aws_guardduty_member", member["AccountId"], attributes)

    def aws_guardduty_organization_admin_account(self):
        print("Processing GuardDuty Organization Admin Accounts...")

        paginator = self.guardduty_client.get_paginator(
            "list_organization_admin_accounts")

        for page in paginator.paginate():
            for admin_account in page["AdminAccounts"]:
                print(
                    f"  Processing GuardDuty Organization Admin Account: {admin_account['AdminAccountId']}")

                attributes = {
                    "admin_account_id": admin_account["AdminAccountId"],
                }

                self.hcl.process_resource(
                    "aws_guardduty_organization_admin_account", admin_account["AdminAccountId"], attributes)

    def aws_guardduty_organization_configuration(self, detector_id):
        print(
            f"Processing GuardDuty Organization Configuration for Detector ID: {detector_id}")

        org_config = self.guardduty_client.describe_organization_configuration(
            DetectorId=detector_id)

        if org_config:
            attributes = {
                "detector_id": detector_id,
                "auto_enable": org_config["AutoEnable"],
                "depends_on": ["aws_guardduty_detector.guardduty_detector"],
            }

            self.hcl.process_resource(
                "aws_guardduty_organization_configuration", detector_id, attributes)

    def aws_guardduty_publishing_destination(self, detector_id):
        print(
            f"Processing GuardDuty Publishing Destinations for Detector ID: {detector_id}")

        paginator = self.guardduty_client.get_paginator(
            "list_publishing_destinations")
        page_iterator = paginator.paginate(DetectorId=detector_id)

        for page in page_iterator:
            for destination in page["Destinations"]:
                print(
                    f"  Processing GuardDuty Publishing Destination: {destination['DestinationId']}")

                attributes = {
                    "detector_id": detector_id,
                    "destination_type": destination["DestinationType"],
                    "kms_key_arn": destination["KmsKeyArn"],
                    "destination_arn": destination["DestinationArn"],
                    "depends_on": ["aws_guardduty_detector.guardduty_detector"],
                }

                self.hcl.process_resource(
                    "aws_guardduty_publishing_destination", destination["DestinationId"], attributes)

    def aws_guardduty_threatintelset(self, detector_id):
        print(
            f"Processing GuardDuty ThreatIntelSets for Detector ID: {detector_id}")

        paginator = self.guardduty_client.get_paginator(
            "list_threat_intel_sets")
        page_iterator = paginator.paginate(DetectorId=detector_id)

        for page in page_iterator:
            for threat_intel_set in page["ThreatIntelSetIds"]:
                print(
                    f"  Processing GuardDuty ThreatIntelSet: {threat_intel_set}")

                set_details = self.guardduty_client.get_threat_intel_set(
                    DetectorId=detector_id, ThreatIntelSetId=threat_intel_set)
                attributes = {
                    "detector_id": detector_id,
                    "name": set_details["Name"],
                    "format": set_details["Format"],
                    "location": set_details["Location"],
                    "activate": set_details["Status"] == "ACTIVE",
                    "depends_on": ["aws_guardduty_detector.guardduty_detector"],
                }

                self.hcl.process_resource(
                    "aws_guardduty_threatintelset", threat_intel_set, attributes)
