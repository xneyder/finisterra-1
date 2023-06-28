import os
from utils.hcl import HCL


class ELBV2:
    def __init__(self, elbv2_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key):
        self.elbv2_client = elbv2_client
        self.transform_rules = {
            "aws_lb_target_group": {
                "hcl_drop_blocks": {"target_failover": {"on_deregistration": None}},
            },
            "aws_lb": {
                "hcl_drop_blocks": {"access_logs": {"enabled": False}},
            },
            "aws_lb_listener_rule": {
                "hcl_drop_fields": {"action.order": 0},
            },
            "aws_lb_listener": {
                "hcl_drop_fields": {"default_action.order": 0},
            },


        }
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key)
        self.resource_list = {}

    def elbv2(self):
        self.hcl.prepare_folder(os.path.join("generated", "elbv2"))

        self.aws_lb()
        self.aws_lb_listener()
        self.aws_lb_listener_certificate()
        self.aws_lb_listener_rule()
        self.aws_lb_target_group()
        self.aws_lb_target_group_attachment()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

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

    def aws_lb_listener(self):
        print("Processing Load Balancer Listeners...")
        load_balancer_arns = set()
        listener_arns = set()

        paginator = self.elbv2_client.get_paginator("describe_load_balancers")
        for page in paginator.paginate():
            for lb in page["LoadBalancers"]:
                load_balancer_arns.add(lb["LoadBalancerArn"])

        for lb_arn in load_balancer_arns:
            paginator = self.elbv2_client.get_paginator("describe_listeners")
            for page in paginator.paginate(LoadBalancerArn=lb_arn):
                for listener in page["Listeners"]:
                    listener_arns.add(listener["ListenerArn"])

        for listener_arn in listener_arns:
            print(f"  Processing Listener: {listener_arn}")

            attributes = {
                "id": listener_arn,
                # "load_balancer_arn": listener_arn.split("/")[-2],
                # "port": self.elbv2_client.describe_listeners(ListenerArns=[listener_arn])["Listeners"][0]["Port"],
                # "protocol": self.elbv2_client.describe_listeners(ListenerArns=[listener_arn])["Listeners"][0]["Protocol"],
                # "ssl_policy": self.elbv2_client.describe_listeners(ListenerArns=[listener_arn]).get("SslPolicy", ""),
                # "default_actions": self.elbv2_client.describe_listeners(ListenerArns=[listener_arn])["Listeners"][0]["DefaultActions"],
            }

            self.hcl.process_resource(
                "aws_lb_listener", listener_arn.split("/")[-1], attributes)

    def aws_lb_listener_certificate(self):
        print("Processing Load Balancer Listener Certificates...")

        load_balancers = self.elbv2_client.describe_load_balancers()[
            "LoadBalancers"]

        for lb in load_balancers:
            lb_arn = lb["LoadBalancerArn"]
            listeners = self.elbv2_client.describe_listeners(
                LoadBalancerArn=lb_arn)["Listeners"]

            for listener in listeners:
                listener_arn = listener["ListenerArn"]
                listener_certificates = self.elbv2_client.describe_listener_certificates(
                    ListenerArn=listener_arn)

                if "Certificates" in listener_certificates:
                    certificates = listener_certificates["Certificates"]

                    for cert in certificates:
                        cert_arn = cert["CertificateArn"]
                        cert_id = cert_arn.split("/")[-1]
                        print(
                            f"  Processing Load Balancer Listener Certificate: {cert_id} for Listener ARN: {listener_arn}")

                        id = listener_arn+"_"+cert_arn
                        attributes = {
                            "id": id,
                            "arn": cert_arn,
                            "listener_arn": listener_arn,
                        }

                        self.hcl.process_resource(
                            "aws_lb_listener_certificate", id, attributes)
                else:
                    print(
                        f"No certificates found for Listener ARN: {listener_arn}")

    def aws_lb_listener_rule(self):
        print("Processing Load Balancer Listener Rules...")

        load_balancers = self.elbv2_client.describe_load_balancers()[
            "LoadBalancers"]

        for lb in load_balancers:
            lb_arn = lb["LoadBalancerArn"]
            print(f"Processing Load Balancer: {lb_arn}")

            listeners = self.elbv2_client.describe_listeners(
                LoadBalancerArn=lb_arn)["Listeners"]

            for listener in listeners:
                listener_arn = listener["ListenerArn"]
                print(f"  Processing Load Balancer Listener: {listener_arn}")

                rules = self.elbv2_client.describe_rules(
                    ListenerArn=listener_arn)["Rules"]

                for rule in rules:
                    rule_arn = rule["RuleArn"]
                    rule_id = rule_arn.split("/")[-1]
                    if len(rule["Conditions"]) == 0:
                        continue
                    print(
                        f"    Processing Load Balancer Listener Rule: {rule_id}")

                    attributes = {
                        "id": rule_arn,
                        # "arn": rule_arn,
                        # "listener_arn": listener_arn,
                        # "priority": rule["Priority"],
                        "condition": rule["Conditions"],
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

    def aws_lb_target_group_attachment(self):
        print("Processing Load Balancer Target Group Attachments...")

        target_groups = self.elbv2_client.describe_target_groups()[
            "TargetGroups"]

        for target_group in target_groups:
            target_group_arn = target_group["TargetGroupArn"]
            print(
                f"  Processing Load Balancer Target Group Attachments for Target Group ARN: {target_group_arn}")

            health_descriptions = self.elbv2_client.describe_target_health(
                TargetGroupArn=target_group_arn)["TargetHealthDescriptions"]

            for health_description in health_descriptions:
                target = health_description["Target"]
                target_id = target["Id"]
                attachment_id = f"{target_group_arn}-{target_id}"

                print(
                    f"    Processing Load Balancer Target Group Attachment: {attachment_id}")

                attributes = {
                    "id": attachment_id,
                    "target_group_arn": target_group_arn,
                    "target_id": target_id,
                }

                if "Port" in target:
                    attributes["port"] = target["Port"]

                self.hcl.process_resource(
                    "aws_lb_target_group_attachment", attachment_id, attributes)
