resource "aws_iam_user_policy" "Administrator_AdminUser" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
  user   = "Administrator"
}

