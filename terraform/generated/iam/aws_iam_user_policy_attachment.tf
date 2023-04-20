resource "aws_iam_user_policy_attachment" "jenkins_deployment_user_CloudWatchFullAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/CloudWatchFullAccess"
  user       = "jenkins-deployment-user"
}

