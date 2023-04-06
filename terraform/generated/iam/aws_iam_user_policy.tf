resource "aws_iam_user_policy" "posthog_app_posthog_app_s3" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::posthog-cloud-dev-us-east-1-app-assets",
        "arn:aws:s3:::posthog-cloud-dev-us-east-1-app-assets/*"
      ]
    }
  ]
}
EOF
  user   = "posthog-app"
}

