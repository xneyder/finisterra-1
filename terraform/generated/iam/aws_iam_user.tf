resource "aws_iam_user" "Administrator" {
  name = "Administrator"
  path = "/"
}

resource "aws_iam_user" "jenkins_deployment_user" {
  name = "jenkins-deployment-user"
  path = "/"
}

