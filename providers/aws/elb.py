import os
from utils.hcl import HCL


class ELB:
    def __init__(self, aws_clients, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id,hcl = None):
        self.aws_clients = aws_clients
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}

    def elb(self):
        self.hcl.prepare_folder(os.path.join("generated", "elb"))

        self.aws_app_cookie_stickiness_policy()
        self.aws_elb()
        self.aws_elb_attachment()
        self.aws_lb_cookie_stickiness_policy()
        self.aws_lb_ssl_negotiation_policy()
        self.aws_load_balancer_backend_server_policy()
        self.aws_load_balancer_listener_policy()
        self.aws_load_balancer_policy()
        self.aws_proxy_protocol_policy()

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()
        self.json_plan = self.hcl.json_plan

    def aws_app_cookie_stickiness_policy(self):
        print("Processing App Cookie Stickiness Policies...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            policies = self.aws_clients.elb_client.describe_load_balancer_policies(
                LoadBalancerName=lb_name)["PolicyDescriptions"]

            for policy in policies:
                if policy["PolicyTypeName"] == "AppCookieStickinessPolicyType":
                    policy_id = f"{lb_name}-{policy['PolicyName']}"
                    print(
                        f"  Processing App Cookie Stickiness Policy: {policy_id}")

                    attributes = {
                        "id": policy_id,
                        "name": policy["PolicyName"],
                        "load_balancer": lb_name,
                    }
                    self.hcl.process_resource(
                        "aws_app_cookie_stickiness_policy", policy_id, attributes)

    def aws_elb(self):
        print("Processing Elastic Load Balancers...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            print(f"  Processing Elastic Load Balancer: {lb_name}")

            attributes = {
                "id": lb_name,
                "name": lb_name,
                "availability_zones": lb["AvailabilityZones"],
                "security_groups": lb["SecurityGroups"],
                "subnets": lb["Subnets"],
            }
            self.hcl.process_resource("aws_elb", lb_name, attributes)

    def aws_elb_attachment(self):
        print("Processing ELB Attachments...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            instance_ids = [instance["InstanceId"]
                            for instance in lb["Instances"]]

            for instance_id in instance_ids:
                attachment_id = f"{lb_name}-{instance_id}"
                print(f"  Processing ELB Attachment: {attachment_id}")

                attributes = {
                    "id": attachment_id,
                    "elb": lb_name,
                    "instance": instance_id,
                }
                self.hcl.process_resource(
                    "aws_elb_attachment", attachment_id, attributes)

    def aws_lb_cookie_stickiness_policy(self):
        print("Processing Load Balancer Cookie Stickiness Policies...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            policies = self.aws_clients.elb_client.describe_load_balancer_policies(
                LoadBalancerName=lb_name)["PolicyDescriptions"]

            for policy in policies:
                if policy["PolicyTypeName"] == "LBCookieStickinessPolicyType":
                    policy_id = f"{lb_name}-{policy['PolicyName']}"
                    print(
                        f"  Processing Load Balancer Cookie Stickiness Policy: {policy_id}")

                    attributes = {
                        "id": policy_id,
                        "name": policy["PolicyName"],
                        "load_balancer": lb_name,
                    }
                    self.hcl.process_resource(
                        "aws_lb_cookie_stickiness_policy", policy_id, attributes)

    def aws_lb_ssl_negotiation_policy(self):
        print("Processing Load Balancer SSL Negotiation Policies...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            policies = self.aws_clients.elb_client.describe_load_balancer_policies(
                LoadBalancerName=lb_name)["PolicyDescriptions"]

            for policy in policies:
                if policy["PolicyTypeName"] == "SSLNegotiationPolicyType":
                    policy_id = f"{lb_name}-{policy['PolicyName']}"
                    print(
                        f"  Processing Load Balancer SSL Negotiation Policy: {policy_id}")

                    attributes = {
                        "id": policy_id,
                        "name": policy["PolicyName"],
                        "load_balancer": lb_name,
                    }
                    self.hcl.process_resource(
                        "aws_lb_ssl_negotiation_policy", policy_id, attributes)

    def aws_load_balancer_backend_server_policy(self):
        print("Processing Load Balancer Backend Server Policies...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            policies = self.aws_clients.elb_client.describe_load_balancer_policies(
                LoadBalancerName=lb_name)["PolicyDescriptions"]

            for policy in policies:
                if policy["PolicyTypeName"] == "BackendServerAuthenticationPolicyType":
                    policy_id = f"{lb_name}-{policy['PolicyName']}"
                    print(
                        f"  Processing Load Balancer Backend Server Policy: {policy_id}")

                    attributes = {
                        "id": policy_id,
                        "name": policy["PolicyName"],
                        "load_balancer": lb_name,
                    }
                    self.hcl.process_resource(
                        "aws_load_balancer_backend_server_policy", policy_id, attributes)

    def aws_load_balancer_listener_policy(self):
        print("Processing Load Balancer Listener Policies...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            lb_listeners = lb["ListenerDescriptions"]

            for listener in lb_listeners:
                listener_policies = listener["PolicyNames"]

                for policy_name in listener_policies:
                    policy_id = f"{lb_name}-{policy_name}"
                    print(
                        f"  Processing Load Balancer Listener Policy: {policy_id}")

                    attributes = {
                        "id": policy_id,
                        "load_balancer": lb_name,
                        "policy_name": policy_name,
                        "port": listener["Listener"]["LoadBalancerPort"],
                    }
                    self.hcl.process_resource(
                        "aws_load_balancer_listener_policy", policy_id, attributes)

    def aws_load_balancer_policy(self):
        print("Processing Load Balancer Policies...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            policies = self.aws_clients.elb_client.describe_load_balancer_policies(
                LoadBalancerName=lb_name)["PolicyDescriptions"]

            for policy in policies:
                policy_id = f"{lb_name}-{policy['PolicyName']}"
                print(f"  Processing Load Balancer Policy: {policy_id}")

                attributes = {
                    "id": policy_id,
                    "name": policy["PolicyName"],
                    "load_balancer": lb_name,
                    "policy_type": policy["PolicyTypeName"],
                }
                self.hcl.process_resource(
                    "aws_load_balancer_policy", policy_id, attributes)

    def aws_proxy_protocol_policy(self):
        print("Processing Proxy Protocol Policies...")

        load_balancers = self.aws_clients.elb_client.describe_load_balancers()[
            "LoadBalancerDescriptions"]

        for lb in load_balancers:
            lb_name = lb["LoadBalancerName"]
            policies = self.aws_clients.elb_client.describe_load_balancer_policies(
                LoadBalancerName=lb_name)["PolicyDescriptions"]

            for policy in policies:
                if policy["PolicyTypeName"] == "ProxyProtocolPolicyType":
                    policy_id = f"{lb_name}-{policy['PolicyName']}"
                    print(f"  Processing Proxy Protocol Policy: {policy_id}")

                    attributes = {
                        "id": policy_id,
                        "name": policy["PolicyName"],
                        "load_balancer": lb_name,
                    }

                    for attr in policy["PolicyAttributeDescriptions"]:
                        if attr["AttributeName"] == "ProxyProtocol":
                            attributes["proxy_protocol"] = attr["AttributeValue"]

                    self.hcl.process_resource(
                        "aws_proxy_protocol_policy", policy_id, attributes)
