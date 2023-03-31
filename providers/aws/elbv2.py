import os
from utils.hcl import HCL


class ELBV2:
    def __init__(self, elbv2_client, script_dir, provider_name, schema_data, region):
        self.elbv2_client = elbv2_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def elbv2(self):
        self.hcl.prepare_folder(os.path.join("generated", "elbv2"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_lb(self):
        print("Processing Load Balancers...")

        load_balancers = self.elbv2_client.describe_load_balancers()[
            "LoadBalancers"]

        for lb in load_balancers:
            lb_arn = lb["LoadBalancerArn"]
            lb_name = lb["LoadBalancerName"]
            print(f"  Processing Load Balancer: {lb_name}")

            attributes = {
                "id": lb_arn,
                "name": lb_name,
                "type": lb["Type"],
                "arn": lb_arn,
            }

            self.hcl.process_resource("aws_lb", lb_name, attributes)
            self.aws_lb_listener(lb_arn)

    def aws_lb_listener(self, lb_arn):
        print(
            f"Processing Load Balancer Listeners for Load Balancer ARN: {lb_arn}")

        listeners = self.elbv2_client.describe_listeners(
            LoadBalancerArn=lb_arn)["Listeners"]

        for listener in listeners:
            listener

    def aws_lb_listener_certificate(self, listener_arn):
        print(
            f"Processing Load Balancer Listener Certificates for Listener ARN: {listener_arn}")

        certificates = self.elbv2_client.describe_listener_certificates(
            ListenerArn=listener_arn)["Certificates"]

        for cert in certificates:
            cert_arn = cert["CertificateArn"]
            cert_id = cert_arn.split("/")[-1]
            print(
                f"  Processing Load Balancer Listener Certificate: {cert_id}")

            attributes = {
                "id": cert_arn,
                "arn": cert_arn,
                "listener_arn": listener_arn,
            }

            self.hcl.process_resource(
                "aws_lb_listener_certificate", cert_id, attributes)

    def aws_lb_listener_rule(self, listener_arn):
        print(
            f"Processing Load Balancer Listener Rules for Listener ARN: {listener_arn}")

        rules = self.elbv2_client.describe_rules(
            ListenerArn=listener_arn)["Rules"]

        for rule in rules:
            rule_arn = rule["RuleArn"]
            rule_id = rule_arn.split("/")[-1]
            print(f"  Processing Load Balancer Listener Rule: {rule_id}")

            attributes = {
                "id": rule_arn,
                "arn": rule_arn,
                "listener_arn": listener_arn,
                "priority": rule["Priority"],
            }

            self.hcl.process_resource(
                "aws_lb_listener_rule", rule_id, attributes)

    def aws_lb_target_group(self):
        print("Processing Load Balancer Target Groups...")

        paginator = self.elbv2_client.get_paginator("describe_target_groups")
        page_iterator = paginator.paginate()

        for page in page_iterator:
            for target_group in page["TargetGroups"]:
                tg_arn = target_group["TargetGroupArn"]
                tg_name = target_group["TargetGroupName"]
                print(f"  Processing Load Balancer Target Group: {tg_name}")

                attributes = {
                    "id": tg_arn,
                    "arn": tg_arn,
                    "name": tg_name,
                }

                self.hcl.process_resource(
                    "aws_lb_target_group", tg_name, attributes)
                self.aws_lb_target_group_attachment(tg_arn)

    def aws_lb_target_group_attachment(self, target_group_arn):
        print(
            f"Processing Load Balancer Target Group Attachments for Target Group ARN: {target_group_arn}")

        health_descriptions = self.elbv2_client.describe_target_health(
            TargetGroupArn=target_group_arn)["TargetHealthDescriptions"]

        for health_description in health_descriptions:
            target = health_description["Target"]
            target_id = target["Id"]
            attachment_id = f"{target_group_arn}-{target_id}"

            print(
                f"  Processing Load Balancer Target Group Attachment: {attachment_id}")

            attributes = {
                "id": attachment_id,
                "target_group_arn": target_group_arn,
                "target_id": target_id,
            }

            if "Port" in target:
                attributes["port"] = target["Port"]

            self.hcl.process_resource(
                "aws_lb_target_group_attachment", attachment_id, attributes)
