resource "aws_iam_user_group_membership" "jenkins_deployment_user_jenkins_deployment" {
  groups = [
    "jenkins-deployment"
  ]
  user = "jenkins-deployment-user"
}

