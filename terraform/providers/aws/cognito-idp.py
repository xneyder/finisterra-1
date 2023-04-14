import os
from utils.hcl import HCL


class CognitIDP:
    def __init__(self, cognito_idp_client, script_dir, provider_name, schema_data, region):
        self.cognito_idp_client = cognito_idp_client
        self.transform_rules = {}
        self.provider_name = provider_name
        self.script_dir = script_dir
        self.schema_data = schema_data
        self.hcl = HCL(self.schema_data, self.provider_name,
                       self.script_dir, self.transform_rules)
        self.region = region

    def cognito_idp(self):
        self.hcl.prepare_folder(os.path.join("generated", "cognito_idp"))

        self.hcl.refresh_state()
        self.hcl.generate_hcl_file()

    def aws_cognito_identity_provider(self):
        print("Processing Cognito Identity Providers...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                providers = self.cognito_idp_client.list_identity_providers(UserPoolId=pool_id)[
                    "Providers"]
                for provider in providers:
                    attributes = {
                        "id": provider["ProviderName"],
                        "user_pool_id": pool_id,
                        "provider_name": provider["ProviderName"],
                        "provider_type": provider["ProviderType"],
                    }
                    self.hcl.process_resource(
                        "aws_cognito_identity_provider", provider["ProviderName"].replace("-", "_"), attributes)

    def aws_cognito_managed_user_pool_client(self):
        print("Processing Cognito Managed User Pool Clients...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                clients = self.cognito_idp_client.list_user_pool_clients(UserPoolId=pool_id)[
                    "UserPoolClients"]
                for client in clients:
                    attributes = {
                        "id": client["ClientId"],
                        "user_pool_id": pool_id,
                        "client_name": client["ClientName"],
                        "client_id": client["ClientId"],
                    }
                    self.hcl.process_resource(
                        "aws_cognito_managed_user_pool_client", client["ClientId"].replace("-", "_"), attributes)

    def aws_cognito_resource_server(self):
        print("Processing Cognito Resource Servers...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                resource_servers = self.cognito_idp_client.list_resource_servers(
                    UserPoolId=pool_id)["ResourceServers"]
                for server in resource_servers:
                    attributes = {
                        "id": server["Identifier"],
                        "user_pool_id": pool_id,
                        "identifier": server["Identifier"],
                        "name": server["Name"],
                        "scopes": server["Scopes"],
                    }
                    self.hcl.process_resource(
                        "aws_cognito_resource_server", server["Identifier"].replace("-", "_"), attributes)

    def aws_cognito_risk_configuration(self):
        print("Processing Cognito Risk Configurations...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                try:
                    risk_config = self.cognito_idp_client.describe_risk_configuration(
                        UserPoolId=pool_id)["RiskConfiguration"]
                    attributes = {
                        "id": risk_config["ClientId"],
                        "user_pool_id": pool_id,
                        "client_id": risk_config["ClientId"],
                        "compromised_credentials_risk_configuration": risk_config["CompromisedCredentialsRiskConfiguration"],
                        "account_takeover_risk_configuration": risk_config["AccountTakeoverRiskConfiguration"],
                    }
                    self.hcl.process_resource(
                        "aws_cognito_risk_configuration", risk_config["ClientId"].replace("-", "_"), attributes)
                except self.cognito_idp_client.exceptions.ResourceNotFoundException:
                    print(
                        f"  No Risk Configuration found for user pool: {pool_id}")

    def aws_cognito_user(self):
        print("Processing Cognito Users...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                user_paginator = self.cognito_idp_client.get_paginator(
                    "list_users")
                for user_page in user_paginator.paginate(UserPoolId=pool_id):
                    for user in user_page["Users"]:
                        attributes = {
                            "id": user["Username"],
                            "user_pool_id": pool_id,
                            "username": user["Username"],
                            "attributes": user["Attributes"],
                        }
                        self.hcl.process_resource(
                            "aws_cognito_user", user["Username"].replace("-", "_"), attributes)

    def aws_cognito_user_group(self):
        print("Processing Cognito User Groups...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                group_paginator = self.cognito_idp_client.get_paginator(
                    "list_groups")
                for group_page in group_paginator.paginate(UserPoolId=pool_id):
                    for group in group_page["Groups"]:
                        attributes = {
                            "id": group["GroupName"],
                            "user_pool_id": pool_id,
                            "name": group["GroupName"],
                            "description": group.get("Description", ""),
                            "role_arn": group.get("RoleArn", ""),
                            "precedence": group.get("Precedence", ""),
                        }
                        self.hcl.process_resource(
                            "aws_cognito_user_group", group["GroupName"].replace("-", "_"), attributes)

    def aws_cognito_user_in_group(self):
        print("Processing Cognito Users in Groups...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                group_paginator = self.cognito_idp_client.get_paginator(
                    "list_groups")
                for group_page in group_paginator.paginate(UserPoolId=pool_id):
                    for group in group_page["Groups"]:
                        user_paginator = self.cognito_idp_client.get_paginator(
                            "list_users_in_group")
                        for user_page in user_paginator.paginate(UserPoolId=pool_id, GroupName=group["GroupName"]):
                            for user in user_page["Users"]:
                                attributes = {
                                    "id": f"{pool_id}-{group['GroupName']}-{user['Username']}",
                                    "user_pool_id": pool_id,
                                    "username": user["Username"],
                                    "group_name": group["GroupName"],
                                }
                                self.hcl.process_resource(
                                    "aws_cognito_user_in_group", user["Username"].replace("-", "_"), attributes)

    def aws_cognito_user_pool(self):
        print("Processing Cognito User Pools...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                user_pool = self.cognito_idp_client.describe_user_pool(UserPoolId=pool_id)[
                    "UserPool"]
                attributes = {
                    "id": pool_id,
                    "name": user_pool["Name"],
                    "admin_create_user_config": user_pool["AdminCreateUserConfig"],
                    "auto_verified_attributes": user_pool["AutoVerifiedAttributes"],
                    "email_verification_message": user_pool["EmailVerificationMessage"],
                    "email_verification_subject": user_pool["EmailVerificationSubject"],
                    "sms_authentication_message": user_pool["SmsAuthenticationMessage"],
                    "sms_verification_message": user_pool["SmsVerificationMessage"],
                    "verification_message_template": user_pool["VerificationMessageTemplate"],
                    "mfa_configuration": user_pool["MfaConfiguration"],
                    "password_policy": user_pool["Policies"]["PasswordPolicy"],
                }
                self.hcl.process_resource(
                    "aws_cognito_user_pool", user_pool["Name"].replace("-", "_"), attributes)

    def aws_cognito_user_pool_client(self):
        print("Processing Cognito User Pool Clients...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                client_paginator = self.cognito_idp_client.get_paginator(
                    "list_user_pool_clients")
                for client_page in client_paginator.paginate(UserPoolId=pool_id, MaxResults=60):
                    for client in client_page["UserPoolClients"]:
                        client_details = self.cognito_idp_client.describe_user_pool_client(
                            UserPoolId=pool_id, ClientId=client["ClientId"])["UserPoolClient"]
                        attributes = {
                            "id": client["ClientId"],
                            "name": client["ClientName"],
                            "user_pool_id": pool_id,
                            "explicit_auth_flows": client_details["ExplicitAuthFlows"],
                            "supported_identity_providers": client_details["SupportedIdentityProviders"],
                        }
                        self.hcl.process_resource(
                            "aws_cognito_user_pool_client", client["ClientName"].replace("-", "_"), attributes)

    def aws_cognito_user_pool_domain(self):
        print("Processing Cognito User Pool Domains...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                domain_paginator = self.cognito_idp_client.get_paginator(
                    "list_user_pool_domains")
                for domain_page in domain_paginator.paginate(UserPoolId=pool_id, MaxResults=60):
                    for domain in domain_page["Domains"]:
                        domain_description = self.cognito_idp_client.describe_user_pool_domain(
                            Domain=domain["Domain"], UserPoolId=pool_id)["DomainDescription"]
                        attributes = {
                            "id": domain_description["Domain"],
                            "domain": domain_description["Domain"],
                            "user_pool_id": pool_id,
                        }
                        self.hcl.process_resource(
                            "aws_cognito_user_pool_domain", domain_description["Domain"].replace("-", "_"), attributes)

    def aws_cognito_user_pool_ui_customization(self):
        print("Processing Cognito User Pool UI Customizations...")

        paginator = self.cognito_idp_client.get_paginator("list_user_pools")
        for page in paginator.paginate(MaxResults=60):
            for pool in page["UserPools"]:
                pool_id = pool["Id"]
                try:
                    ui_customization = self.cognito_idp_client.get_ui_customization(
                        UserPoolId=pool_id)["UICustomization"]
                    print(
                        f"  Processing Cognito User Pool UI Customization: {pool_id}")

                    attributes = {
                        "id": pool_id,
                        "user_pool_id": pool_id,
                        "client_id": ui_customization["ClientId"],
                        "css": ui_customization["CSS"],
                        "image_url": ui_customization["ImageUrl"],
                    }
                    self.hcl.process_resource(
                        "aws_cognito_user_pool_ui_customization", pool_id.replace("-", "_"), attributes)
                except self.cognito_idp_client.exceptions.ResourceNotFoundException:
                    print(
                        f"  No UI customization found for user pool: {pool_id}")