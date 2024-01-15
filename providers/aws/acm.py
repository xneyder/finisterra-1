import os
from utils.hcl import HCL
import datetime


class ACM:
    def __init__(self, acm_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl = None):
        self.acm_client = acm_client
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
            'get_field_from_attrs': self.get_field_from_attrs,
            'get_validation_method': self.get_validation_method,
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

    def get_validation_method(self, attributes):
        validation_method = attributes.get("validation_method", None)
        if validation_method == "NONE":
            return None
        return validation_method


    def acm(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        # aws_acm_certificate.this	resource
        # aws_acm_certificate_validation.this	resource
        # aws_route53_record.validation	resource

        self.aws_acm_certificate()



        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate", os.path.join(
            os.path.dirname(os.path.abspath(__file__)), "acm.yaml"), {}, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

    def aws_acm_certificate(self, acm_arn=None, ftstack=None):
        resource_name = "aws_acm_certificate"
        print("Processing ACM Certificates...")
        if acm_arn and ftstack:
            if self.hcl.id_resource_processed(resource_name, acm_arn, ftstack):
                print(f"  Skipping ACM Certificate: {acm_arn} already processed")
                return

        paginator = self.acm_client.get_paginator("list_certificates")
        for page in paginator.paginate():
            for cert_summary in page["CertificateSummaryList"]:
                cert_arn = cert_summary["CertificateArn"]
                cert_domain = cert_summary["DomainName"]

                # Skip processing if a specific ACM ARN is provided and it doesn't match
                if acm_arn and cert_arn != acm_arn:
                    continue

                # Get certificate details to check for expiration and type
                cert_details = self.acm_client.describe_certificate(
                    CertificateArn=cert_arn)["Certificate"]
                certificate_type = cert_details["Type"]

                # Skip imported certificates
                # if certificate_type == "IMPORTED":
                #     continue

                # Skip not issued certificates
                status = cert_details["Status"]
                if status != "ISSUED":
                    continue

                expiration_date = cert_details["NotAfter"]

                # Skip expired certificates 
                if expiration_date < datetime.datetime.now(tz=datetime.timezone.utc):
                    continue

                print(f"  Processing ACM Certificate: {cert_arn}")

                if not ftstack:
                    ftstack = "acm"
                    try:
                        response = self.acm_client.list_tags_for_certificate(CertificateArn=cert_arn)
                        tags = response.get('Tags', {})
                        for tag in tags:
                            if tag['Key'] == 'ftstack':
                                if tag['Value'] != 'acm':
                                    ftstack = "stack_" + tag['Value']
                                break
                    except Exception as e:
                        print("Error occurred: ", e)

                id = cert_arn

                attributes = {
                    "id": id,
                    "domain_name": cert_domain,
                }

                self.hcl.process_resource(
                    resource_name, cert_arn.replace("-", "_"), attributes)
                
                self.hcl.add_stack(resource_name, id, ftstack)

                # self.aws_acm_certificate_validation(cert_arn, cert_details)

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
