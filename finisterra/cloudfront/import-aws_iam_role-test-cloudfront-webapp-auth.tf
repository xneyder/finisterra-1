import {
  id = "test-cloudfront-webapp-auth"
  to = module.aws_iam_role-test-cloudfront-webapp-auth.aws_iam_role.default[0]
}

import {
  id = "test-cloudfront-webapp-auth/arn:aws:iam::070252509141:policy/test-cloudfront-webapp-auth-logs"
  to = module.aws_iam_role-test-cloudfront-webapp-auth.aws_iam_role_policy_attachment.managed["test-cloudfront-webapp-auth_test-cloudfront-webapp-auth-logs"]
}

