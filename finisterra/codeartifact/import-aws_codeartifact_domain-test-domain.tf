import {
  id = "arn:aws:codeartifact:us-east-1:070252509141:domain/test-domain"
  to = module.aws_codeartifact_domain-test-domain.aws_codeartifact_domain.this[0]
}

import {
  id = "arn:aws:codeartifact:us-east-1:070252509141:domain/test-domain"
  to = module.aws_codeartifact_domain-test-domain.aws_codeartifact_domain_permissions_policy.this[0]
}

import {
  id = "arn:aws:codeartifact:us-east-1:070252509141:repository/test-domain/test-repository"
  to = module.aws_codeartifact_domain-test-domain.aws_codeartifact_repository.this["test-repository"]
}

