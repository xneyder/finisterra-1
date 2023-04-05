import os
from utils.hcl import HCL
import datetime


class ACM:
    def __init__(self, acm_client, script_dir, provider_name, schema_data, region):
        self.acm_client = acm_client
        self.transform_rules = {
            "aws_acm_certificate": {
                "hcl_keep_fields": {"domain_name": True},
            },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def acm(self):
        self.hcl.prepare_folder(os.path.join("generated", "acm"))

        self.aws_acm_certificate()
        self.aws_acm_certificate_validation()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_acm_certificate(self):
        print("Processing ACM Certificates...")

        paginator = self.acm_client.get_paginator("list_certificates")
        for page in paginator.paginate():
            for cert_summary in page["CertificateSummaryList"]:
                cert_arn = cert_summary["CertificateArn"]
                cert_domain = cert_summary["DomainName"]

                # Get certificate details to check for expiration
                cert_details = self.acm_client.describe_certificate(
                    CertificateArn=cert_arn)["Certificate"]
                expiration_date = cert_details["NotAfter"]

                # Skip expired certificates
                if expiration_date < datetime.datetime.now(tz=datetime.timezone.utc):
                    continue

                print(f"  Processing ACM Certificate: {cert_arn}")

                attributes = {
                    "id": cert_arn,
                    "domain_name": cert_domain,
                }

                self.hcl.process_resource(
                    "aws_acm_certificate", cert_arn.replace("-", "_"), attributes)

    def aws_acm_certificate_validation(self):
        print("Processing ACM Certificate Validations...")

        paginator = self.acm_client.get_paginator("list_certificates")
        for page in paginator.paginate():
            for cert_summary in page["CertificateSummaryList"]:
                cert_arn = cert_summary["CertificateArn"]
                cert = self.acm_client.describe_certificate(
                    CertificateArn=cert_arn)["Certificate"]
                expiration_date = cert["NotAfter"]

                # Skip expired certificates
                if expiration_date < datetime.datetime.now(tz=datetime.timezone.utc):
                    continue

                print(
                    f"  Processing ACM Certificate Validation: {cert_arn}")

                attributes = {
                    "id": cert_arn,
                    "certificate_arn": cert_arn,
                }

                if "ResourceRecord" in cert["DomainValidationOptions"][0]:
                    attributes["validation_record_fqdns"] = [
                        cert["DomainValidationOptions"][0]["ResourceRecord"]["Name"]]

                self.hcl.process_resource(
                    "aws_acm_certificate_validation", cert_arn.replace("-", "_"), attributes)
