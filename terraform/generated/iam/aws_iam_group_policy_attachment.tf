resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AWSCodeCommitReadOnly" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSCodeCommitReadOnly"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AWSLambda_FullAccess" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AWSWAFFullAccess" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSWAFFullAccess"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AdministratorAccess_AWSElasticBeanstalk" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AdministratorAccess-AWSElasticBeanstalk"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AmazonAPIGatewayAdministrator" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonAPIGatewayAdministrator"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AmazonDynamoDBFullAccess" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AmazonEC2ContainerRegistryFullAccess" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AmazonECS_FullAccess" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AmazonOpenSearchServiceFullAccess" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonOpenSearchServiceFullAccess"
}

resource "aws_iam_group_policy_attachment" "jenkins_deployment_policy_AmazonS3FullAccess" {
  group      = "jenkins-deployment"
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonS3FullAccess"
}

