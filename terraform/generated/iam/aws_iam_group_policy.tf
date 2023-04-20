resource "aws_iam_group_policy" "jenkins_deployment_iam_get_pass_roll" {
  group  = "jenkins-deployment"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:GetRole",
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
}

