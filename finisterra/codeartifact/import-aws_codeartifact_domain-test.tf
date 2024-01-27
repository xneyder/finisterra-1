import {
  id = "arn:aws:codeartifact:us-east-1:070252509141:domain/test"
  to = module.aws_codeartifact_domain-test.aws_codeartifact_domain.this[0]
}

import {
  id = "arn:aws:codeartifact:us-east-1:070252509141:domain/test"
  to = module.aws_codeartifact_domain-test.aws_codeartifact_domain_permissions_policy.this[0]
}

import {
  id = "arn:aws:codeartifact:us-east-1:070252509141:repository/test/codeartifact_test"
  to = module.aws_codeartifact_domain-test.aws_codeartifact_repository.this["codeartifact_test"]
}

import {
  id = "arn:aws:codeartifact:us-east-1:070252509141:repository/test/test"
  to = module.aws_codeartifact_domain-test.aws_codeartifact_repository.this["test"]
}

import {
  id = "arn:aws:codeartifact:us-east-1:070252509141:repository/test/test"
  to = module.aws_codeartifact_domain-test.aws_codeartifact_repository_permissions_policy.this["test"]
}

