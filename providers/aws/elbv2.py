import os
from utils.hcl import HCL


class ELBV2:
    def __init__(self, elbv2_client, ec2_client, acm_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id):
        self.elbv2_client = elbv2_client
        self.ec2_client = ec2_client
        self.acm_client = acm_client
        self.aws_account_id = aws_account_id
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
        self.workspace_id = workspace_id
        self.modules = modules
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        self.resource_list = {}
        self.listeners = {}

    def init_fields(self, attributes):
        self.listeners = {}

        return None

    def match_security_group(self, parent_attributes, child_attributes):
        child_security_group_id = child_attributes.get("id", None)
        for security_group in parent_attributes.get("security_groups", []):
            if security_group == child_security_group_id:
                return True
        return False

    def get_vpc_name(self, attributes, arg):
        vpc_id = attributes.get(arg)
        response = self.ec2_client.describe_vpcs(VpcIds=[vpc_id])
        vpc_name = next(
            (tag['Value'] for tag in response['Vpcs'][0]['Tags'] if tag['Key'] == 'Name'), None)
        return vpc_name

    def get_security_group_rules(self, attributes, arg):
        key = attributes[arg]
        result = {key: {}}
        for k in ['type', 'description', 'from_port', 'to_port', 'protocol', 'cidr_blocks']:
            val = attributes.get(k)
            if isinstance(val, str):
                val = val.replace('${', '$${')
            result[key][k] = val
        return result

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

    def get_security_group_names(self, attributes, arg):
        security_group_ids = attributes.get(arg)
        security_group_names = []

        for security_group_id in security_group_ids:
            response = self.ec2_client.describe_security_groups(
                GroupIds=[security_group_id])
            security_group = response['SecurityGroups'][0]

            security_group_name = security_group.get('GroupName')
            # Just to be extra safe, if GroupName is somehow missing, fall back to the security group ID
            if not security_group_name:
                security_group_name = security_group_id

            security_group_names.append(security_group_name)

        return security_group_names

    def get_listeners(self, attributes):
        domain_name = ""
        if attributes.get('certificate_arn'):
            response = self.acm_client.describe_certificate(
                CertificateArn=attributes.get('certificate_arn')
            )
            domain_name = response['Certificate']['DomainName']

        self.listeners[attributes.get('port')] = {
            'port': attributes.get('port'),
            'protocol': attributes.get('protocol'),
            'ssl_policy': attributes.get('ssl_policy'),
            'domain_name': domain_name,
            'additional_domains': [],
            'listener_fixed_response': attributes.get('default_action', [{}])[0].get('fixed_response', [{}])[0],
            'listener_additional_tags': attributes.get('tags'),
        }
        return self.listeners

    def get_port(self, attributes):
        return str(attributes.get('port'))

    def get_listener_certificate(self, attributes):
        listener_arn = attributes.get('listener_arn')

        # Get the port of the listener
        response_listener = self.elbv2_client.describe_listeners(
            ListenerArns=[listener_arn]
        )
        listener_port = response_listener['Listeners'][0]['Port']

        domain_name = ""
        if attributes.get('certificate_arn'):
            # Use the ACM client
            response = self.acm_client.describe_certificate(
                CertificateArn=attributes.get('certificate_arn')
            )
            domain_name = response['Certificate']['DomainName']

            if listener_port in self.listeners:
                self.listeners[listener_port]['additional_domains'].append(
                    domain_name)

        return self.listeners

    def get_port_domain_name(self, attributes):
        listener_arn = attributes.get('listener_arn')

        # Get the port of the listener
        response_listener = self.elbv2_client.describe_listeners(
            ListenerArns=[listener_arn]
        )
        listener_port = response_listener['Listeners'][0]['Port']

        domain_name = ""
        if attributes.get('certificate_arn'):
            # Use the ACM client
            response = self.acm_client.describe_certificate(
                CertificateArn=attributes.get('certificate_arn')
            )
            domain_name = response['Certificate']['DomainName']

        # Return in the format 'port-domain_name'
        return f"{listener_port}-{domain_name}"

    def get_subnet_names(self, attributes, arg):
        subnet_ids = attributes.get(arg)
        subnet_names = []
        for subnet_id in subnet_ids:
            response = self.ec2_client.describe_subnets(SubnetIds=[subnet_id])

            # Depending on how your subnets are tagged, you may need to adjust this line.
            # This assumes you have a tag 'Name' for your subnet names.
            subnet_name = next(
                (tag['Value'] for tag in response['Subnets'][0]['Tags'] if tag['Key'] == 'Name'), None)

            if subnet_name:
                subnet_names.append(subnet_name)

        return subnet_names

    def elbv2(self):
        self.hcl.prepare_folder(os.path.join("generated", "elbv2"))

        self.aws_lb()
        # self.aws_lb_listener()
        # self.aws_lb_listener_certificate()
        # self.aws_lb_listener_rule()
        # self.aws_lb_target_group()
        # self.aws_lb_target_group_attachment()

        functions = {
            'match_security_group': self.match_security_group,
            'get_vpc_name': self.get_vpc_name,
            'get_security_group_rules': self.get_security_group_rules,
            'get_field_from_attrs': self.get_field_from_attrs,
            'get_security_group_names': self.get_security_group_names,
            'get_subnet_names': self.get_subnet_names,
            'get_listeners': self.get_listeners,
            'get_listener_certificate': self.get_listener_certificate,
            'get_port_domain_name': self.get_port_domain_name,
            'get_port': self.get_port,
        }

        self.hcl.refresh_state()

        self.hcl.module_hcl_code("terraform.tfstate",
                                 os.path.join(os.path.dirname(os.path.abspath(__file__)), "elbv2.yaml"), functions, self.region, self.aws_account_id)

        exit()
        self.json_plan = self.hcl.json_plan

    def aws_lb(self):
        print("Processing Load Balancers...")

        load_balancers = self.elbv2_client.describe_load_balancers()[
            "LoadBalancers"]

        load_balancer_arns = []
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
            load_balancer_arns.append(lb_arn)

            # Extract the security group IDs associated with this load balancer
            security_group_ids = lb.get("SecurityGroups", [])

            # Call the aws_security_group function for each security group ID
            if security_group_ids:
                self.aws_security_group(security_group_ids)

        # Call the other functions for listeners and listener certificates
        listener_arns = self.aws_lb_listener(load_balancer_arns)
        self.aws_lb_listener_certificate(listener_arns)

    def aws_lb_listener(self, load_balancer_arns):
        print("Processing Load Balancer Listeners...")

        listener_arns = []

        for lb_arn in load_balancer_arns:
            paginator = self.elbv2_client.get_paginator("describe_listeners")
            for page in paginator.paginate(LoadBalancerArn=lb_arn):
                for listener in page["Listeners"]:
                    has_target_group = False
                    for action in listener.get('DefaultActions', []):
                        if action['Type'] == 'forward' and 'TargetGroupArn' in action:
                            has_target_group = True
                            break

                    # If the listener has a target group attached, ignore and continue
                    if has_target_group:
                        continue

                    listener_arn = listener["ListenerArn"]
                    listener_arns.append(listener_arn)

                    print(f"  Processing Listener: {listener_arn}")

                    attributes = {
                        "id": listener_arn,
                        # ... Other attributes can be uncommented as needed ...
                    }

                    self.hcl.process_resource(
                        "aws_lb_listener", listener_arn.split("/")[-1], attributes)

        return listener_arns

    def aws_lb_listener_certificate(self, listener_arns):
        print("Processing Load Balancer Listener Certificates...")

        for listener_arn in listener_arns:
            listener_certificates = self.elbv2_client.describe_listener_certificates(
                ListenerArn=listener_arn)

            if "Certificates" in listener_certificates:
                certificates = listener_certificates["Certificates"]

                for cert in certificates:
                    cert_arn = cert["CertificateArn"]
                    cert_id = cert_arn.split("/")[-1]
                    print(
                        f"  Processing Load Balancer Listener Certificate: {cert_id} for Listener ARN: {listener_arn}")

                    id = listener_arn + "_" + cert_arn
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

    def aws_security_group(self, security_group_ids):
        print("Processing Security Groups...")

        # Create a response dictionary to collect responses for all security groups
        response = self.ec2_client.describe_security_groups(
            GroupIds=security_group_ids
        )

        for security_group in response["SecurityGroups"]:
            print(
                f"  Processing Security Group: {security_group['GroupName']}")

            attributes = {
                "id": security_group["GroupId"],
                "name": security_group["GroupName"],
                "description": security_group.get("Description", ""),
                "vpc_id": security_group.get("VpcId", ""),
                "owner_id": security_group.get("OwnerId", ""),
            }

            self.hcl.process_resource(
                "aws_security_group", security_group["GroupName"].replace("-", "_"), attributes)

            # Process egress rules
            for rule in security_group.get('IpPermissionsEgress', []):
                self.aws_security_group_rule(
                    'egress', security_group, rule)

            # Process ingress rules
            for rule in security_group.get('IpPermissions', []):
                self.aws_security_group_rule(
                    'ingress', security_group, rule)

    def aws_security_group_rule(self, rule_type, security_group, rule):
        # Rule identifiers are often constructed by combining security group id, rule type, protocol, ports and security group references
        rule_id = f"{security_group['GroupId']}_{rule_type}_{rule.get('IpProtocol', 'all')}"
        print(f"Processing Security Groups Rule {rule_id}...")
        if rule.get('FromPort'):
            rule_id += f"_{rule['FromPort']}"
        if rule.get('ToPort'):
            rule_id += f"_{rule['ToPort']}"

        attributes = {
            "id": rule_id,
            "type": rule_type,
            "security_group_id": security_group['GroupId'],
            "protocol": rule.get('IpProtocol', '-1'),  # '-1' stands for 'all'
            "from_port": rule.get('FromPort', 0),
            "to_port": rule.get('ToPort', 0),
            "cidr_blocks": [ip_range['CidrIp'] for ip_range in rule.get('IpRanges', [])],
            "source_security_group_ids": [sg['GroupId'] for sg in rule.get('UserIdGroupPairs', [])]
        }

        self.hcl.process_resource(
            "aws_security_group_rule", rule_id.replace("-", "_"), attributes)

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
