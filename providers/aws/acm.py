import os
from utils.hcl import HCL
import datetime


class ACM:
    def __init__(self, acm_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, aws_partition):
        self.acm_client = acm_client
        self.transform_rules = {
            "aws_acm_certificate": {
                "hcl_keep_fields": {"domain_name": True},
            },
        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.aws_account_id = aws_account_id
        self.aws_partition = aws_partition
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}

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

    def acm(self):
        self.hcl.prepare_folder(os.path.join("generated", "acm"))

        # aws_acm_certificate.this	resource
        # aws_acm_certificate_validation.this	resource
        # aws_route53_record.validation	resource

        self.aws_acm_certificate()

        functions = {
            'get_field_from_attrs': self.get_field_from_attrs,
        }

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "acm.yaml"), functions, self.region, self.aws_account_id, self.aws_partition)

        self.json_plan = self.hcl.json_plan

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

                self.aws_acm_certificate_validation(cert_arn, cert_details)

    def aws_acm_certificate_validation(self, cert_arn, cert):
        print(f"  Processing ACM Certificate Validation: {cert_arn}")

        attributes = {
            "id": cert_arn,
            "certificate_arn": cert_arn,
        }

        if "ResourceRecord" in cert["DomainValidationOptions"][0]:
            attributes["validation_record_fqdns"] = [
                cert["DomainValidationOptions"][0]["ResourceRecord"]["Name"]]

        self.hcl.process_resource(
            "aws_acm_certificate_validation", cert_arn.replace("-", "_"), attributes)
