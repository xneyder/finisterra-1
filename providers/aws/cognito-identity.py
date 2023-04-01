def aws_cognito_identity_pool(self):
    print("Processing Cognito Identity Pools...")

    paginator = self.cognito_identity_client.get_paginator(
        "list_identity_pools")
    for page in paginator.paginate(MaxResults=60):
        for pool in page["IdentityPools"]:
            pool_id = pool["IdentityPoolId"]
            identity_pool = self.cognito_identity_client.describe_identity_pool(
                IdentityPoolId=pool_id)["IdentityPool"]

            print(f"  Processing Cognito Identity Pool: {pool_id}")

            attributes = {
                "id": pool_id,
                "identity_pool_name": identity_pool["IdentityPoolName"],
                "allow_unauthenticated_identities": identity_pool["AllowUnauthenticatedIdentities"],
            }
            self.hcl.process_resource(
                "aws_cognito_identity_pool", pool_id.replace("-", "_"), attributes)


def aws_cognito_identity_pool_provider_principal_tag(self):
    print("Processing Cognito Identity Pool Provider Principal Tags...")

    paginator = self.cognito_identity_client.get_paginator(
        "list_identity_pools")
    for page in paginator.paginate(MaxResults=60):
        for pool in page["IdentityPools"]:
            pool_id = pool["IdentityPoolId"]
            tags = self.cognito_identity_client.list_tags_for_resource(
                ResourceArn=pool["IdentityPoolArn"])["Tags"]

            if tags:
                for tag_key, tag_value in tags.items():
                    print(
                        f"  Processing Cognito Identity Pool Provider Principal Tag: {tag_key}")

                    attributes = {
                        "id": f"{pool_id}:{tag_key}",
                        "identity_pool_id": pool_id,
                        "tag_key": tag_key,
                        "tag_value": tag_value,
                    }
                    self.hcl.process_resource(
                        "aws_cognito_identity_pool_provider_principal_tag", f"{pool_id}_{tag_key}".replace("-", "_"), attributes)


def aws_cognito_identity_pool_roles_attachment(self):
    print("Processing Cognito Identity Pool Roles Attachments...")

    paginator = self.cognito_identity_client.get_paginator(
        "list_identity_pools")
    for page in paginator.paginate(MaxResults=60):
        for pool in page["IdentityPools"]:
            pool_id = pool["IdentityPoolId"]
            identity_pool = self.cognito_identity_client.describe_identity_pool(
                IdentityPoolId=pool_id)["IdentityPool"]

            if "Roles" in identity_pool:
                print(
                    f"  Processing Cognito Identity Pool Roles Attachment: {pool_id}")

                attributes = {
                    "id": pool_id,
                    "identity_pool_id": pool_id,
                    "roles": identity_pool["Roles"],
                }

                if "RoleMappings" in identity_pool:
                    attributes["role_mapping"] = identity_pool["RoleMappings"]

                self.hcl.process_resource(
                    "aws_cognito_identity_pool_roles_attachment", pool_id.replace("-", "_"), attributes)
