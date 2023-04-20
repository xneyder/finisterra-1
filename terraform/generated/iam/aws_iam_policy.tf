resource "aws_iam_policy" "AWSGlueServiceRole_CrawlerGOVCloud" {
  description = "This policy will be used for Glue Crawler and Job execution. Please do NOT delete!"
  path        = "/service-role/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "s3:*",
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "AWSLambdaTracerAccessExecutionRole_5581a3b0_4107_4af2_97db_c9db00661e1f" {
  path   = "/service-role/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords"
      ],
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "AWSLambdaTracerAccessExecutionRole_6a3ce6fa_3ed7_4eb4_a9fc_a93ef03bfbb1" {
  path   = "/service-role/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords"
      ],
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "AmazonElasticTranscoder_JobsSubmitter" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:ListBucket",
        "iam:ListRoles",
        "sns:ListTopics"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "CloudFormationManageStacks" {
  description = "Provides the ability to create and update CloudFormation stacks. This policy does not grant the ability to delete stacks."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "cloudformation:CreateUploadBucket",
        "cloudformation:ListExports",
        "cloudformation:CancelUpdateStack",
        "cloudformation:UpdateStackInstances",
        "cloudformation:ListStackSetOperations",
        "cloudformation:ListStackInstances",
        "cloudformation:DescribeStackResource",
        "cloudformation:UpdateStackSet",
        "cloudformation:CreateChangeSet",
        "cloudformation:CreateStackInstances",
        "cloudformation:ContinueUpdateRollback",
        "cloudformation:ListStackSetOperationResults",
        "cloudformation:EstimateTemplateCost",
        "cloudformation:DescribeStackEvents",
        "cloudformation:DescribeStackSetOperation",
        "cloudformation:UpdateStack",
        "cloudformation:DescribeAccountLimits",
        "cloudformation:StopStackSetOperation",
        "cloudformation:DescribeChangeSet",
        "cloudformation:CreateStackSet",
        "cloudformation:ExecuteChangeSet",
        "cloudformation:ListStackResources",
        "cloudformation:ListStacks",
        "cloudformation:ListImports",
        "cloudformation:DescribeStackInstance",
        "cloudformation:DescribeStackResources",
        "cloudformation:SignalResource",
        "cloudformation:GetTemplateSummary",
        "cloudformation:DescribeStacks",
        "cloudformation:GetStackPolicy",
        "cloudformation:DescribeStackSet",
        "cloudformation:ListStackSets",
        "cloudformation:CreateStack",
        "cloudformation:GetTemplate",
        "cloudformation:ValidateTemplate",
        "cloudformation:ListChangeSets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "CloudWatchLogsWriteLogs" {
  description = "Provides access to write logs to CloudWatch Logs"
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:logs:*:*:*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "CloudWatchWriteMetrics" {
  description = "Put any metrics"
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "cloudwatch:PutMetricData"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "DB_Migrate_071122" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": "glue:*",
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "DynamoDBAutoscalePolicy" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "dynamodb:DescribeTable",
        "dynamodb:UpdateTable",
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:SetAlarmState",
        "cloudwatch:DeleteAlarms"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ECRDeployer" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeImages",
        "ecr:GetAuthorizationToken",
        "ecr:DescribeRepositories",
        "ecr:UploadLayerPart",
        "ecr:ListImages",
        "ecr:InitiateLayerUpload",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetRepositoryPolicy",
        "ecr:PutImage"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ECRServerDeveloper" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ecr:CreateRepository",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:DescribeImages",
        "ecr:GetAuthorizationToken",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetRepositoryPolicy"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ECSFullReadAccess" {
  description = "Provides full read access within ECS"
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ecs:List*",
        "ecs:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ECSTaskDefinitionFullAccess" {
  description = "Provides full access for accessing EC2 Container Service Task Definitions."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ecs:ListTaskDefinitionFamilies",
        "ecs:RegisterTaskDefinition",
        "ecs:ListTaskDefinitions",
        "ecs:DescribeTaskDefinition"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": "iam:PassRole",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:iam::050779347855:role/*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ECSUpdateServices" {
  description = "Lets developers update ECS services"
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ecs:List*",
        "ecs:Describe*",
        "ecs:UpdateService",
        "ecs:RunTask",
        "ecs:StartTask",
        "ecs:StopTask"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ElasticBeanstalkDeployedService" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "xray:GetSamplingStatisticSummaries",
        "ec2:Describe*",
        "autoscaling:Describe*",
        "xray:PutTelemetryRecords",
        "cloudwatch:*",
        "logs:*",
        "xray:GetSamplingRules",
        "xray:GetSamplingTargets",
        "xray:PutTraceSegments"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    },
    {
      "Action": "elasticbeanstalk:PutInstanceStatistics",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:elasticbeanstalk:*:050779347855:environment/*/*",
        "arn:aws-us-gov:elasticbeanstalk:*:050779347855:application/*"
      ],
      "Sid": "VisualEditor1"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:s3:::elasticbeanstalk-us-gov-west-1-050779347855/*",
      "Sid": "VisualEditor2"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ElasticBeanstalkReadOnlyAccess" {
  description = "Provides read only access to Elastic Beanstalk environments."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "elasticbeanstalk:Check*",
        "elasticbeanstalk:Describe*",
        "elasticbeanstalk:List*",
        "elasticbeanstalk:RequestEnvironmentInfo",
        "elasticbeanstalk:RetrieveEnvironmentInfo",
        "ec2:Describe*",
        "elasticloadbalancing:Describe*",
        "autoscaling:Describe*",
        "cloudwatch:Describe*",
        "cloudwatch:List*",
        "cloudwatch:Get*",
        "sns:Get*",
        "sns:List*",
        "cloudformation:Describe*",
        "cloudformation:Get*",
        "cloudformation:List*",
        "cloudformation:Validate*",
        "cloudformation:Estimate*",
        "rds:Describe*",
        "sqs:Get*",
        "sqs:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::elasticbeanstalk-*",
        "arn:aws-us-gov:s3:::cf-templates-*",
        "arn:aws-us-gov:s3:::allogy-web-services",
        "arn:aws-us-gov:s3:::allogy-web-services/*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ElasticBeanstalkUpdateApplication" {
  description = "Update existing applications. Does not permit deploying new application versions."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "elasticbeanstalk:DescribeAccountAttributes",
        "elasticbeanstalk:TerminateEnvironment",
        "elasticbeanstalk:DescribeEnvironmentManagedActionHistory",
        "elasticbeanstalk:ValidateConfigurationSettings",
        "elasticbeanstalk:CheckDNSAvailability",
        "elasticbeanstalk:ListTagsForResource",
        "elasticbeanstalk:DescribeEnvironmentResources",
        "elasticbeanstalk:RequestEnvironmentInfo",
        "elasticbeanstalk:RebuildEnvironment",
        "elasticbeanstalk:DescribeEnvironments",
        "elasticbeanstalk:DescribeInstancesHealth",
        "elasticbeanstalk:DescribeApplicationVersions",
        "elasticbeanstalk:DescribeEnvironmentHealth",
        "elasticbeanstalk:DescribeApplications",
        "elasticbeanstalk:DescribePlatformVersion",
        "elasticbeanstalk:RestartAppServer",
        "elasticbeanstalk:DescribeConfigurationSettings",
        "elasticbeanstalk:ListAvailableSolutionStacks",
        "elasticbeanstalk:ListPlatformVersions",
        "elasticbeanstalk:UpdateApplication",
        "elasticbeanstalk:DescribeEnvironmentManagedActions",
        "elasticbeanstalk:SwapEnvironmentCNAMEs",
        "elasticbeanstalk:DescribeConfigurationOptions",
        "elasticbeanstalk:DescribeEvents",
        "cloudformation:DeleteStack",
        "elasticbeanstalk:UpdateEnvironment",
        "elasticbeanstalk:RetrieveEnvironmentInfo"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ElasticSearchFullDomainAccess_ElasticSearchShared01" {
  description = "Provides full access to the ElasticSearch domain shared-01. The access is for HTTP methods."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": "es:ESHttp*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:es:us-gov-west-1:050779347855:domain/*",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ElasticSearchFullDomainAccess_ElasticSearchShared02" {
  description = "Provides full access to the ElasticSearch domain shared-02. The access is for HTTP methods."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": "es:ESHttp*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:es:us-gov-west-1:050779347855:domain/shared-02",
        "arn:aws-us-gov:es:us-gov-west-1:050779347855:domain/shared-02/*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "NotificationServiceSnsAccountFullAccess" {
  description = "Provides the necessary permissions to access the Allogy account used for SNS access."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:iam::051043551360:role/allogy-access-sns",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "ReadWebClientProjects" {
  description = "Provides access for reading all Web client projects."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "cloudfront:Get*",
        "cloudfront:List*",
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "s3:Head*",
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::*-web-ui",
        "arn:aws-us-gov:s3:::*-web-ui/*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "SessionManagerMinimum" {
  description = "Minimum Policies for Session Manager"
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ssm:UpdateInstanceInformation",
        "ssmmessages:CreateControlChannel",
        "ssmmessages:CreateDataChannel",
        "ssmmessages:OpenControlChannel",
        "ssmmessages:OpenDataChannel"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "s3:GetEncryptionConfiguration"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "StatesExecutionPolicy" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "UpdateDeveloperSecurityGroupRules" {
  description = "Allows a developer to add or remove allowed security group rules for access."
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ec2:RevokeSecurityGroupIngress",
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:RevokeSecurityGroupEgress"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:ResourceTag/Access": "Developer"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "all_buckets_access" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "allogy_dms_policy" {
  description = "Policy to migrate the RDS DB"
  path        = "/"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "dms:DescribeOrderableReplicationInstances",
        "dms:CreateReplicationSubnetGroup",
        "dms:DescribeEndpointSettings",
        "dms:DescribeConnections",
        "dms:DescribeReplicationInstances",
        "dms:DescribeEndpoints",
        "dms:DescribeReplicationSubnetGroups",
        "dms:DescribeReplicationTasks",
        "dms:ModifyEventSubscription",
        "dms:ModifyReplicationSubnetGroup",
        "dms:CreateReplicationInstance",
        "dms:DescribeAccountAttributes",
        "dms:CreateEventSubscription",
        "dms:DescribeCertificates",
        "dms:DescribeEvents",
        "dms:DescribeEventSubscriptions",
        "dms:ImportCertificate",
        "dms:CreateEndpoint",
        "dms:DescribeEndpointTypes",
        "dms:DescribeEventCategories"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    },
    {
      "Action": "dms:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:dms:*:050779347855:endpoint:*",
        "arn:aws-us-gov:dms:*:050779347855:cert:*",
        "arn:aws-us-gov:dms:*:050779347855:rep:*",
        "arn:aws-us-gov:dms:*:050779347855:subgrp:*",
        "arn:aws-us-gov:dms:*:050779347855:es:*",
        "arn:aws-us-gov:dms:*:050779347855:assessment-run:*",
        "arn:aws-us-gov:dms:*:050779347855:task:*"
      ],
      "Sid": "VisualEditor1"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_policy" "test" {
  path   = "/"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": "es:*",
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}

