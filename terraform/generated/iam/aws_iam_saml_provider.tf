resource "aws_iam_saml_provider" "AWSSSO_c3353b8cf127d54f_DO_NOT_DELETE" {
  name                   = "AWSSSO_c3353b8cf127d54f_DO_NOT_DELETE"
  saml_metadata_document = file("AWSSSO_c3353b8cf127d54f_DO_NOT_DELETE.xml")
}

