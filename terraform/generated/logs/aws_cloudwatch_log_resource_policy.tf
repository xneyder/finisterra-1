resource "aws_cloudwatch_log_resource_policy" "OpenSearchService_shared_01_Application_logs" {
  policy_document = <<EOF
{
  "Statement": [
    {
      "Action": [
        "logs:PutLogEvents",
        "logs:CreateLogStream"
      ],
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Resource": "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:/aws/OpenSearchService/domains/shared-01/application-logs:*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
  policy_name     = "OpenSearchService-shared-01-Application-logs"
}

