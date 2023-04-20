resource "aws_iam_virtual_mfa_device" "Administrator" {
  path                    = "/"
  virtual_mfa_device_name = "Administrator"
}

