import os
from utils.hcl import HCL
from providers.aws.security_group import SECURITY_GROUP


class ELBV2:
    def __init__(self, elbv2_client, ec2_client, acm_client, script_dir, provider_name, schema_data, region, s3Bucket,
                 dynamoDBTable, state_key, workspace_id, modules, aws_account_id, hcl=None):
        self.elbv2_client = elbv2_client
        self.ec2_client = ec2_client
        self.acm_client = acm_client
        self.aws_account_id = aws_account_id
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.region = region
        self.workspace_id = workspace_id
        self.s3Bucket = s3Bucket
        self.dynamoDBTable = dynamoDBTable
        self.state_key = state_key

        self.modules = modules
        if not hcl:
            self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules, self.region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules)
        else:
            self.hcl = hcl
        self.resource_list = {}
        self.listeners = {}

        functions = {
            'get_vpc_name_elbv2': self.get_vpc_name_elbv2,
            'get_security_group_names_elbv2': self.get_security_group_names_elbv2,
            'get_subnet_names_elbv2': self.get_subnet_names_elbv2,
            'get_listeners_elbv2': self.get_listeners_elbv2,
            'get_listener_certificate_elbv2': self.get_listener_certificate_elbv2,
            'get_port_domain_name_elbv2': self.get_port_domain_name_elbv2,
            'get_port_elbv2': self.get_port_elbv2,
            'get_vpc_id_elbv2': self.get_vpc_id_elbv2,
            'get_subnet_ids_elbv2': self.get_subnet_ids_elbv2,
            'init_fields_elbv2': self.init_fields_elbv2,
        }

        self.hcl.functions.update(functions)

        self.security_group_instance = SECURITY_GROUP(ec2_client, script_dir, provider_name, schema_data, region, s3Bucket, dynamoDBTable, state_key, workspace_id, modules, aws_account_id, self.hcl)

    def init_fields_elbv2(self, attributes):
        self.listeners = {}

        return None


    def get_security_group_names_elbv2(self, attributes, arg):
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

    def get_fixed_response(self, attributes):
        default_action = attributes.get('default_action')

        if default_action and isinstance(default_action, list) and default_action:
            fixed_response = default_action[0].get('fixed_response')
            return fixed_response

            # if fixed_response and isinstance(fixed_response, list) and fixed_response:
            #     return [fixed_response[0]]

        return []

    def get_redirect(self, attributes):
        default_action = attributes.get('default_action')

        if default_action and isinstance(default_action, list) and default_action:
            redirect = default_action[0].get('redirect')
            return redirect

            # if redirect and isinstance(redirect, list) and redirect:
            #     return [redirect[0]]

        return []  # default to an empty dictionary if conditions are not met

    def get_listeners_elbv2(self, attributes):
        listener = {
            'port': attributes.get('port'),
            'protocol': attributes.get('protocol'),
            'ssl_policy': attributes.get('ssl_policy'),
            'certificate_arn': attributes.get('certificate_arn'),
            # 'acm_domain_name': domain_name,
            'additional_certificates': [],
            'listener_fixed_response': self.get_fixed_response(attributes),
            'listener_redirect': self.get_redirect(attributes),
            'listener_additional_tags': attributes.get('tags'),
        }

        # Filter out keys with undesirable values
        # self.listeners[attributes.get('port')] = {k: v for k, v in listener.items() if v not in [{}, [], "", None]}
        self.listeners[attributes.get('port')] = {k: v for k, v in listener.items()}

        return self.listeners

    def get_port_elbv2(self, attributes):
        return str(attributes.get('port'))

    def get_listener_certificate_elbv2(self, attributes):
        listener_arn = attributes.get('listener_arn')
        # Get the port of the listener
        response_listener = self.elbv2_client.describe_listeners(
            ListenerArns=[listener_arn]
        )
        listener_port = response_listener['Listeners'][0]['Port']

        certificate_arn = attributes.get('certificate_arn')
        if certificate_arn:
            # Get the domain name for the certificate
            response = self.acm_client.describe_certificate(
                CertificateArn=certificate_arn)
            domain_name = response['Certificate']['DomainName']

            if listener_port in self.listeners:
                self.listeners[listener_port]['additional_certificates'].append(
                    {'certificate_arn': certificate_arn, 'domain_name': domain_name}
                )

        return self.listeners

    def get_port_domain_name_elbv2(self, attributes):
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

    def get_subnet_names_elbv2(self, attributes, arg):
        subnet_ids = attributes.get(arg)
        subnets_info = []
        for subnet_id in subnet_ids:
            response = self.ec2_client.describe_subnets(SubnetIds=[subnet_id])

            # Check if 'Subnets' key exists and it's not empty
            if not response or 'Subnets' not in response or not response['Subnets']:
                print(f"No subnet information found for Subnet ID: {subnet_id}")
                continue

            subnet_info = response['Subnets'][0]
            subnet_tags = subnet_info.get('Tags', [])

            # Extract the subnet name from the tags
            subnet_name = next(
                (tag['Value'] for tag in subnet_tags if tag['Key'] == 'Name'), None)

            # Extract the CIDR block
            subnet_cidr = subnet_info.get('CidrBlock', None)

            if subnet_name and subnet_cidr:
                subnets_info.append({'name': subnet_name, 'cidr_block': subnet_cidr})
            else:
                print(f"No 'Name' tag or CIDR block found for Subnet ID: {subnet_id}")

        return subnets_info


    def get_subnet_ids_elbv2(self, attributes, arg):
        subnet_names = self.get_subnet_names_elbv2(attributes, arg)
        if subnet_names:
            return ""
        else:
            return attributes.get(arg)

    def get_vpc_name_elbv2(self, attributes, arg):
        vpc_id = attributes.get(arg)
        response = self.ec2_client.describe_vpcs(VpcIds=[vpc_id])

        if not response or 'Vpcs' not in response or not response['Vpcs']:
            # Handle this case as required, for example:
            print(f"No VPC information found for VPC ID: {vpc_id}")
            return None

        vpc_tags = response['Vpcs'][0].get('Tags', [])
        vpc_name = next((tag['Value']
                        for tag in vpc_tags if tag['Key'] == 'Name'), None)

        if vpc_name is None:
            print(f"No 'Name' tag found for VPC ID: {vpc_id}")

        return vpc_name

    def get_vpc_id_elbv2(self, attributes, arg):
        vpc_name = self.get_vpc_name_elbv2(attributes, arg)
        if vpc_name is None:
            return attributes.get(arg)
        else:
            return ""


    def elbv2(self):
        self.hcl.prepare_folder(os.path.join("generated"))

        self.aws_lb()
        # self.aws_lb_listener()
        # self.aws_lb_listener_certificate()
        # self.aws_lb_listener_rule()
        # self.aws_lb_target_group()
        # self.aws_lb_target_group_attachment()



        self.hcl.refresh_state()

        config_file_list = ["elbv2.yaml", "security_group.yaml"]
        for index,config_file in enumerate(config_file_list):
            config_file_list[index] = os.path.join(os.path.dirname(os.path.abspath(__file__)),config_file )
        self.hcl.module_hcl_code("terraform.tfstate",config_file_list, {}, self.region, self.aws_account_id, {}, {})

        self.json_plan = self.hcl.json_plan

    def aws_lb(self, selected_lb_arn=None, ftstack=None):
        resource_type = "aws_lb"
        print("Processing Load Balancers...")

        load_balancers = self.elbv2_client.describe_load_balancers()[
            "LoadBalancers"]

        load_balancer_arns = []
        for lb in load_balancers:
            lb_arn = lb["LoadBalancerArn"]
            lb_name = lb["LoadBalancerName"]

            if selected_lb_arn and lb_arn != selected_lb_arn:
                continue

            # Check tags of the load balancer
            tags_response = self.elbv2_client.describe_tags(
                ResourceArns=[lb_arn])
            tags = tags_response["TagDescriptions"][0]["Tags"]

            # Filter out load balancers created by Elastic Beanstalk
            is_ebs_created = any(
                tag["Key"] == "elasticbeanstalk:environment-name" for tag in tags)

            # Filter out load balancers created by Kubernetes Ingress
            is_k8s_created = any(tag["Key"] in ["kubernetes.io/ingress-name",
                                 "kubernetes.io/ingress.class", "elbv2.k8s.aws/cluster"] for tag in tags)

            if is_ebs_created:
                print(f"  Skipping Elastic Beanstalk Load Balancer: {lb_name}")
                continue
            elif is_k8s_created:
                print(f"  Skipping Kubernetes Load Balancer: {lb_name}")
                continue

            print(f"  Processing Load Balancer: {lb_name}")

            if not ftstack:
                ftstack="elbv2"
                for tag in tags:
                    if tag['Key'] == 'ftstack':
                        if tag['Value'] != 'elbv2':
                            ftstack = "stack_"+tag['Value']
                        break

            id = lb_arn

            attributes = {
                "id": id,
                "name": lb_name,
                "type": lb["Type"],
                "arn": lb_arn,
            }

            self.hcl.process_resource(resource_type, lb_name, attributes)

            self.hcl.add_stack(resource_type, id, ftstack)

            load_balancer_arns.append(lb_arn)

            # Extract the security group IDs associated with this load balancer
            security_group_ids = lb.get("SecurityGroups", [])

            # Call the aws_security_group function for each security group ID
            # Block because we want to create the security groups in their own module
            for sg in security_group_ids:
                self.security_group_instance.aws_security_group(sg, ftstack)
                # self.aws_security_group(security_group_ids)

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
                    if cert.get("IsDefault", False):  # skip default certificates
                        continue

                    cert_arn = cert["CertificateArn"]
                    cert_id = cert_arn.split("/")[-1]
                    print(
                        f"  Processing Load Balancer Listener Certificate: {cert_id} for Listener ARN: {listener_arn}")

                    id = listener_arn + "_" + cert_arn
                    attributes = {
                        "id": id,
                        "certificate_arn": cert_arn,
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
