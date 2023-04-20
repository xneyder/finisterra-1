resource "aws_iam_account_password_policy" "iam_account_password_policy" {
  allow_users_to_change_password = true
  minimum_password_length        = 15
}

