import {
  id = "test-spa-deep-linking"
  to = module.aws_iam_role-test-spa-deep-linking.aws_iam_role.default[0]
}

import {
  id = "test-spa-deep-linking/arn:aws:iam::070252509141:policy/test-spa-deep-linking-logs"
  to = module.aws_iam_role-test-spa-deep-linking.aws_iam_role_policy_attachment.managed["test-spa-deep-linking_test-spa-deep-linking-logs"]
}

