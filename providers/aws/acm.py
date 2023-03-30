import os
from utils.hcl import HCL


class ACM:
    def __init__(self, acm_client, script_dir, provider_name, schema_data, region):
        self.acm_client = acm_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def acm(self):
        self.hcl.prepare_folder(os.path.join("generated", "acm"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_acm_certificate(self):
        print("Processing ACM Certificates...")

        paginator = self.acm_client.get_paginator("list_certificates")
        for page in paginator.paginate():
            for cert_summary in page["CertificateSummaryList"]:
                cert_arn = cert_summary["CertificateArn"]
                cert = self.acm_client.describe_certificate(
                    CertificateArn=cert_arn)["Certificate"]
                print(f"  Processing ACM Certificate: {cert['CertificateId']}")

                attributes = {
                    "id": cert["CertificateId"],
                    "arn": cert_arn,
                    "domain_name": cert["DomainName"],
                }

                self.hcl.process_resource(
                    "aws_acm_certificate", cert["CertificateId"].replace("-", "_"), attributes)

    def aws_acm_certificate_validation(self):
        print("Processing ACM Certificate Validations...")

        paginator = self.acm_client.get_paginator("list_certificates")
        for page in paginator.paginate():
            for cert_summary in page["CertificateSummaryList"]:
                cert_arn = cert_summary["CertificateArn"]
                cert = self.acm_client.describe_certificate(
                    CertificateArn=cert_arn)["Certificate"]
                print(
                    f"  Processing ACM Certificate Validation: {cert['CertificateId']}")

                attributes = {
                    "id": cert["CertificateId"],
                    "certificate_arn": cert_arn,
                }

                if "ResourceRecord" in cert["DomainValidationOptions"][0]:
                    attributes["validation_record_fqdns"] = [
                        cert["DomainValidationOptions"][0]["ResourceRecord"]["Name"]]

                self.hcl.process_resource(
                    "aws_acm_certificate_validation", cert["CertificateId"].replace("-", "_"), attributes)
