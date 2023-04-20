resource "aws_iam_saml_provider" "AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE" {
  name                   = "AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
  saml_metadata_document = file("AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE.xml")
}

