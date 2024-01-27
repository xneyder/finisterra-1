import {
  id = "cognito_auth_sandbox-role"
  to = module.aws_iam_role-cognito_auth_sandbox-role.aws_iam_role.default[0]
}

import {
  id = "cognito_auth_sandbox-role/arn:aws:iam::070252509141:policy/cognito_auth_sandbox-ssm-policy"
  to = module.aws_iam_role-cognito_auth_sandbox-role.aws_iam_role_policy_attachment.managed["cognito_auth_sandbox-role_cognito_auth_sandbox-ssm-policy"]
}

