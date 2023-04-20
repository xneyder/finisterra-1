resource "aws_iam_role_policy" "AWSReservedSSO_CodeCommitDeveloperAccess_695963510000a9f5_AwsSSOInlinePolicy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CodeCommitDeveloperAccess",
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull",
        "codecommit:GitPush",
        "codecommit:ListRepositories"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  role   = "AWSReservedSSO_CodeCommitDeveloperAccess_695963510000a9f5"
}

resource "aws_iam_role_policy" "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6_AwsSSOInlinePolicy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllogyProductionBucketsReadAccess",
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-book-*",
        "arn:aws-us-gov:s3:::allogy-book-*/*",
        "arn:aws-us-gov:s3:::allogy-learning-*",
        "arn:aws-us-gov:s3:::allogy-learning-*/*"
      ]
    },
    {
      "Sid": "ECRServerDeveloper",
      "Effect": "Allow",
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
      "Resource": "*"
    },
    {
      "Sid": "ECSDeployToService",
      "Effect": "Allow",
      "Action": [
        "ecs:UpdateService",
        "ecs:CreateService",
        "servicediscovery:CreateService",
        "servicediscovery:UpdateService"
      ],
      "Resource": "*"
    },
    {
      "Sid": "ElasticBeanstalkReadOnlyAccess",
      "Effect": "Allow",
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
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::elasticbeanstalk-us-east-1-250188540659",
        "arn:aws-us-gov:s3:::elasticbeanstalk-us-east-1-250188540659/*",
        "arn:aws-us-gov:s3:::cf-templates-pwv9stqkd2gy-us-east-1",
        "arn:aws-us-gov:s3:::cf-templates-pwv9stqkd2gy-us-east-1/*",
        "arn:aws-us-gov:s3:::allogy-web-services",
        "arn:aws-us-gov:s3:::allogy-web-services/*",
        "*"
      ]
    },
    {
      "Sid": "ElasticBeanstalkUpdateApplication",
      "Effect": "Allow",
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
      "Resource": "*"
    },
    {
      "Sid": "SpringCloudConfigProductionAccess",
      "Effect": "Allow",
      "Action": [
        "codecommit:GetTree",
        "codecommit:ListPullRequests",
        "codecommit:GetBlob",
        "codecommit:PutFile",
        "codecommit:GetReferences",
        "codecommit:GetCommentsForComparedCommit",
        "codecommit:GetCommit",
        "codecommit:GetComment",
        "codecommit:GetCommitHistory",
        "codecommit:GetCommitsFromMergeBase",
        "codecommit:DescribePullRequestEvents",
        "codecommit:GetPullRequest",
        "codecommit:ListBranches",
        "codecommit:GetRepositoryTriggers",
        "codecommit:GitPull",
        "codecommit:BatchGetRepositories",
        "codecommit:GetCommentsForPullRequest",
        "codecommit:GetObjectIdentifier",
        "codecommit:CancelUploadArchive",
        "codecommit:BatchGetPullRequests",
        "codecommit:GetUploadArchiveStatus",
        "codecommit:GetDifferences",
        "codecommit:GetRepository",
        "codecommit:GetBranch",
        "codecommit:GetMergeConflicts",
        "codecommit:GitPush"
      ],
      "Resource": [
        "arn:aws-us-gov:codecommit:us-east-1:250188540659:cloud-config-repository-production",
        "arn:aws-us-gov:codecommit:us-east-1:250188540659:cloud-config-repository-integration"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "codecommit:ListRepositories",
      "Resource": "*"
    },
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "ec2:RevokeSecurityGroupIngress",
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
        "ec2:RevokeSecurityGroupEgress",
        "ec2:UpdateSecurityGroupRuleDescriptionsIngress"
      ],
      "Resource": [
        "arn:aws-us-gov:ec2:*:*:security-group/sg-220ca35a",
        "arn:aws-us-gov:ec2:*:*:security-group/sg-e5532482"
      ]
    },
    {
      "Sid": "BasicCloudWatchModifications",
      "Effect": "Allow",
      "Action": "cloudwatch:PutDashboard",
      "Resource": "*"
    },
    {
      "Sid": "McdsRedirectLinks",
      "Effect": "Allow",
      "Action": [
        "s3:PutAccountPublicAccessBlock",
        "s3:GetAccountPublicAccessBlock",
        "s3:ListAllMyBuckets",
        "s3:ListJobs",
        "s3:CreateJob"
      ],
      "Resource": "*"
    },
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws-us-gov:s3:::mcds-redirect-links",
        "arn:aws-us-gov:s3:::mcds-redirect-links/*"
      ]
    }
  ]
}
EOF
  role   = "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6"
}

resource "aws_iam_role_policy" "AWSReservedSSO_WebClientDeveloper_9565f2e5528c3ce2_AwsSSOInlinePolicy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudfront:Get*",
        "cloudfront:List*",
        "s3:ListAllMyBuckets"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::*-web-ui",
        "arn:aws-us-gov:s3:::*-web-ui/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWSReservedSSO_WebClientDeveloper_9565f2e5528c3ce2"
}

resource "aws_iam_role_policy" "JavaDockerServerDeveloper_SampleProjectsAlarms" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudwatch:*"
      ],
      "Resource": [
        "arn:aws-us-gov:cloudwatch:us-gov-west-1:050779347855:alarm:microservice-alpha-sample-*",
        "arn:aws-us-gov:cloudwatch:us-gov-west-1:050779347855:alarm:microservice-beta-sample-*",
        "arn:aws-us-gov:cloudwatch:us-gov-west-1:050779347855:alarm:microservice-gamma-sample-*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "JavaDockerServerDeveloper"
}

resource "aws_iam_role_policy" "JavaDockerServerDeveloper_SampleProjectsLogs" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*"
      ],
      "Resource": [
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:alpha-sample",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:alpha-sample:*",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:beta-sample",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:beta-sample:*",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:gamma-sample",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:gamma-sample:*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "JavaDockerServerDeveloper"
}

resource "aws_iam_role_policy" "JavaDockerServerDeveloper_SampleProjectsRepositories" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:*"
      ],
      "Resource": [
        "arn:aws-us-gov:ecr:us-gov-west-1:050779347855:repository/alpha-sample",
        "arn:aws-us-gov:ecr:us-gov-west-1:050779347855:repository/beta-sample",
        "arn:aws-us-gov:ecr:us-gov-west-1:050779347855:repository/gamma-sample"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "JavaDockerServerDeveloper"
}

resource "aws_iam_role_policy" "JavaDockerServerDeveloper_SampleProjectsTasks" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:*"
      ],
      "Resource": [
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/alpha-sample",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/alpha-sample:*",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/beta-sample",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/beta-sample:*",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/gamma-sample",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/gamma-sample:*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "JavaDockerServerDeveloper"
}

resource "aws_iam_role_policy" "LearningMediaMetadataUpdateRole_learning_media_MetadataUpdateTopic_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-media-MetadataUpdate"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "LearningMediaMetadataUpdateRole"
}

resource "aws_iam_role_policy" "LearningMediaMetadataUpdateRole_learning_media_distribution_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "LearningMediaMetadataUpdateRole"
}

resource "aws_iam_role_policy" "MediaConvertRole_media_convert_s3_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "MediaConvertRole"
}

resource "aws_iam_role_policy" "MediaStepsLambdaRole_media_convert_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "mediaconvert:GetJob",
        "mediaconvert:CreateJob"
      ],
      "Resource": [
        "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:jobTemplates/*",
        "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:presets/*",
        "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:jobs/*",
        "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:queues/Default"
      ]
    }
  ]
}
EOF
  role   = "MediaStepsLambdaRole"
}

resource "aws_iam_role_policy" "MediaStepsLambdaRole_media_step_functions_dynamodb" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Resource": "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/learning.MediaSteps",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "MediaStepsLambdaRole"
}

resource "aws_iam_role_policy" "MediaStepsLambdaRole_media_step_functions_lambda_passrole_to_media_convert" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:PassRole"
      ],
      "Resource": "arn:aws-us-gov:iam::050779347855:role/MediaConvertRole",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "MediaStepsLambdaRole"
}

resource "aws_iam_role_policy" "MediaStepsLambdaRole_media_step_functions_start_execution" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:StartExecution"
      ],
      "Resource": "arn:aws-us-gov:states:us-gov-west-1:050779347855:stateMachine:MediaPublisher",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "MediaStepsLambdaRole"
}

resource "aws_iam_role_policy" "aws_api_gateway_role_api_gateway_invoke_lambda_functions" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "lambda:InvokeFunction",
      "Resource": "*"
    }
  ]
}
EOF
  role   = "aws-api-gateway-role"
}

resource "aws_iam_role_policy" "cognito_authenticated_role_AllogyInternalCognito_CognitoAuthenticatedPolicy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "cognito-identity:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "cognito-authenticated-role-AllogyInternalCognito"
}

resource "aws_iam_role_policy" "cognito_unauthenticated_role_AllogyInternalCognito_CognitoUnAuthenticatedPolicy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "cognito-unauthenticated-role-AllogyInternalCognito"
}

resource "aws_iam_role_policy" "ecsInstanceRole_ecsInstanceRole" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:Submit*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
  role   = "ecsInstanceRole"
}

resource "aws_iam_role_policy" "infrastructure_ecsMetricCollector_ECSRead" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:List*",
        "ecs:Describe*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "infrastructure-ecsMetricCollector"
}

resource "aws_iam_role_policy" "infrastructure_eureka_discovery_service_UpdateRoute53DNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "route53:ChangeResourceRecordSets",
      "Resource": "arn:aws-us-gov:route53:::hostedzone/Z10007291701AVIAY46A3",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "infrastructure-eureka-discovery-service"
}

resource "aws_iam_role_policy" "lambda_learning_activity_service_LambdaLearningActivitySNSRole" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "sns:Publish"
    ],
    "Resource": [
      "arn:aws-us-gov:sns:*:*:learning-activitiesPosted"
    ],
    "Effect": "Allow"
  }
}
EOF
  role   = "lambda-learning-activity-service"
}

resource "aws_iam_role_policy" "lambda_learning_activity_service_LambdaLearningActivitySendSqsRole" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "sqs:SendMessage"
    ],
    "Resource": [
      "arn:aws-us-gov:sqs:*:*:learning-CreateActivities"
    ],
    "Effect": "Allow"
  }
}
EOF
  role   = "lambda-learning-activity-service"
}

resource "aws_iam_role_policy" "lambda_market_download_tracking_service_LambdaMarketDownloadDynamoDbAccess" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Resource": [
        "arn:aws-us-gov:dynamodb::050779347855:table/market.download.Download",
        "arn:aws-us-gov:dynamodb::050779347855:table/market.download.Download/*",
        "arn:aws-us-gov:dynamodb::050779347855:table/market.download.Content",
        "arn:aws-us-gov:dynamodb::050779347855:table/market.download.Content/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "lambda-market-download-tracking-service"
}

resource "aws_iam_role_policy" "learning_book_extractor_role_learning_book_extractor_s3_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-bundles/*",
        "arn:aws-us-gov:s3:::allogy-gov-bundles",
        "arn:aws-us-gov:s3:::allogy-gov-contents/*",
        "arn:aws-us-gov:s3:::allogy-gov-contents"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "learning-book-extractor-role"
}

resource "aws_iam_role_policy" "learning_media_lambda_image_role_LearningImageS3Access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-image/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image-distribution/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon-distribution/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon-distribution"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "learning-media-lambda-image-role"
}

resource "aws_iam_role_policy" "learning_media_metadata_update_role_learning_media_distribution_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "learning-media-metadata-update-role"
}

resource "aws_iam_role_policy" "learning_media_pdf_processor_role_learning_media_pdf_s3_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-pdf",
        "arn:aws-us-gov:s3:::allogy-gov-learning-pdf/*"
      ]
    }
  ]
}
EOF
  role   = "learning-media-pdf-processor-role"
}

resource "aws_iam_role_policy" "ses_notification_recorder_firehose_put_record" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "firehose:PutRecord",
        "firehose:PutRecordBatch"
      ],
      "Resource": "arn:aws-us-gov:firehose:us-gov-west-1:050779347855:deliverystream/ses-email-notifications"
    }
  ]
}
EOF
  role   = "ses-notification-recorder"
}

resource "aws_iam_role_policy" "ses_notifications_recorder_kinesis_firehose_delivery_Role" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ],
      "Resource": "arn:aws-us-gov:kms:us-gov-west-1:050779347855:alias/aws/s3",
      "Condition": {
        "StringEquals": {
          "kms:ViaService": "s3.us-gov-west-1.amazonaws.com"
        },
        "StringLike": {
          "kms:EncryptionContext:aws-us-gov:s3:arn": "arn:aws-us-gov:s3:::allogy-gov-email/ses-notifications/*"
        }
      }
    },
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": "kms:Decrypt",
      "Resource": "arn:aws-us-gov:kms:us-gov-west-1:050779347855:key/%SSE_KEY_ARN%",
      "Condition": {
        "StringEquals": {
          "kms:ViaService": "kinesis.us-gov-west-1.amazonaws.com"
        },
        "StringLike": {
          "kms:EncryptionContext:aws-us-gov:kinesis:arn": "arn:aws-us-gov:kinesis:%REGION_NAME%:050779347855:stream%FIREHOSE_STREAM_NAME%"
        }
      }
    },
    {
      "Sid": "VisualEditor2",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucketMultipartUploads",
        "s3:AbortMultipartUpload",
        "lambda:InvokeFunction",
        "kinesis:GetShardIterator",
        "kinesis:GetRecords",
        "kinesis:DescribeStream",
        "lambda:GetFunctionConfiguration",
        "s3:ListBucket",
        "logs:PutLogEvents",
        "s3:GetBucketLocation"
      ],
      "Resource": [
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:/aws/kinesisfirehose/ses-email-notifications:log-stream:*",
        "arn:aws-us-gov:kinesis:us-gov-west-1:050779347855:stream/%FIREHOSE_STREAM_NAME%",
        "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:%FIREHOSE_DEFAULT_FUNCTION%:%FIREHOSE_DEFAULT_VERSION%",
        "arn:aws-us-gov:s3:::allogy-gov-email",
        "arn:aws-us-gov:s3:::allogy-gov-email/*",
        "arn:aws-us-gov:s3:::%FIREHOSE_BUCKET_NAME%",
        "arn:aws-us-gov:s3:::%FIREHOSE_BUCKET_NAME%/*"
      ]
    }
  ]
}
EOF
  role   = "ses-notifications-recorder-kinesis"
}

resource "aws_iam_role_policy" "web_app_assessment_service_PublishSNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-Assessment",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-AssessmentAttempt"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-assessment-service"
}

resource "aws_iam_role_policy" "web_app_bitbucket_repositories_archiver_web_app_bitbucket_repositories_archiver" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-repositories-backup",
        "arn:aws-us-gov:s3:::allogy-repositories-backup/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-bitbucket-repositories-archiver"
}

resource "aws_iam_role_policy" "web_app_book_service_book_service_dynamodb_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "dynamodb:*",
      "Resource": "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/learning.Book",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-book-service"
}

resource "aws_iam_role_policy" "web_app_book_service_book_service_s3_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-bundles",
        "arn:aws-us-gov:s3:::allogy-gov-bundles/*",
        "arn:aws-us-gov:s3:::allogy-gov-contents",
        "arn:aws-us-gov:s3:::allogy-gov-contents/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-book-service"
}

resource "aws_iam_role_policy" "web_app_book_service_book_service_sns_notifications" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "sns:*",
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded"
    }
  ]
}
EOF
  role   = "web-app-book-service"
}

resource "aws_iam_role_policy" "web_app_builder_find_bundled_works_task_read_update_publication_task" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:GetActivityTask",
        "states:SendTaskFailure",
        "states:SendTaskHeartbeat",
        "states:SendTaskSuccess"
      ],
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:findBundledWorks"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-builder-find-bundled-works-task"
}

resource "aws_iam_role_policy" "web_app_builder_publish_bundled_works_task_read_update_publication_task" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:GetActivityTask",
        "states:SendTaskFailure",
        "states:SendTaskHeartbeat",
        "states:SendTaskSuccess"
      ],
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishBundledWorks",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:bundledWorksPublicationStatus"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-builder-publish-bundled-works-task"
}

resource "aws_iam_role_policy" "web_app_builder_publisher_task_read_update_publication_task" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:GetActivityTask",
        "states:SendTaskFailure",
        "states:SendTaskHeartbeat",
        "states:SendTaskSuccess"
      ],
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:findBundledWorks",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishBundledWorks",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:bundledWorksPublicationStatus",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishUsingBuilder",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:courseInstancePublisherTask",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishToMarketService"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-builder-publisher-task"
}

resource "aws_iam_role_policy" "web_app_builder_sqs_task_ProcessUpdateQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:builder-builderServiceUpdateQueue",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-builder-sqs-task"
}

resource "aws_iam_role_policy" "web_app_chat_allogy_server_ProcessChatQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-chat-allogy-server"
}

resource "aws_iam_role_policy" "web_app_code_service_dynamoDB" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "dynamodb:*",
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/userCodes.Code",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/userCodes.Code/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-code-service"
}

resource "aws_iam_role_policy" "web_app_collaboration_person_service_person_images_s3_buckets" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-person-images-upload",
        "arn:aws-us-gov:s3:::allogy-gov-person-images-upload/*",
        "arn:aws-us-gov:s3:::allogy-gov-person-images-scaled",
        "arn:aws-us-gov:s3:::allogy-gov-person-images-scaled/*"
      ]
    }
  ]
}
EOF
  role   = "web-app-collaboration-person-service"
}

resource "aws_iam_role_policy" "web_app_content_download_analytics_service_ProcessDownloadQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-contentDownloadsUpdateQueue",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-content-download-analytics-service"
}

resource "aws_iam_role_policy" "web_app_content_download_analytics_service_content_download_analytics_service_dynamodb" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/market.download.Download"
      ]
    }
  ]
}
EOF
  role   = "web-app-content-download-analytics-service"
}

resource "aws_iam_role_policy" "web_app_course_content_progress_service_ProcessProgressQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-course-content-progress-service"
}

resource "aws_iam_role_policy" "web_app_course_content_progress_service_PublishSNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressAggregateUpdated"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-course-content-progress-service"
}

resource "aws_iam_role_policy" "web_app_course_instance_publisher_task_read_update_publication_task" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:GetActivityTask",
        "states:SendTaskFailure",
        "states:SendTaskHeartbeat",
        "states:SendTaskSuccess"
      ],
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:courseInstancePublisherTask"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-course-instance-publisher-task"
}

resource "aws_iam_role_policy" "web_app_course_instance_service_ProcessUpdateQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-course-instance-service"
}

resource "aws_iam_role_policy" "web_app_course_instance_service_PublishSNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCreated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentEnrolled",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentsRemoved",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCompleted"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-course-instance-service"
}

resource "aws_iam_role_policy" "web_app_dbt_clinician_web_amazonSqs" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-dataSqs.fifo",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-dataSqs.fifo/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-dbt-clinician-web"
}

resource "aws_iam_role_policy" "web_app_dbt_form_processor_amazonSqs" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:*:identity-tenant-dataSqs",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:identity-tenant-dataSqs/*",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-dataSqs.fifo",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-dataSqs.fifo/*",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-formSubmission",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-formSubmission/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-dbt-form-processor"
}

resource "aws_iam_role_policy" "web_app_dbt_form_processor_awsStepFunction" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:*"
      ],
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:*:activity:addToOnPremiseQueue",
        "arn:aws-us-gov:states:us-gov-west-1:*:activity:addToOnPremiseQueue/*",
        "arn:aws-us-gov:states:us-gov-west-1:*:stateMachine:FormSubmission",
        "arn:aws-us-gov:states:us-gov-west-1:*:stateMachine:FormSubmission/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-dbt-form-processor"
}

resource "aws_iam_role_policy" "web_app_domain_model_service_domain_model_dynamodb" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/learning.DomainModel"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-domain-model-service"
}

resource "aws_iam_role_policy" "web_app_external_app_service_PublishSNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-externalApps-ExternalApp"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-external-app-service"
}

resource "aws_iam_role_policy" "web_app_form_service_PublishDocumentationSns" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "sns:Publish",
      "Resource": "arn:aws-us-gov:sns:*:050779347855:documentation-*"
    }
  ]
}
EOF
  role   = "web-app-form-service"
}

resource "aws_iam_role_policy" "web_app_form_service_dynamodb_tables" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1441829666000",
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/documentation.Form",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/documentation.Instance",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/forms.Form",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/forms.Instance",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/forms.Instance/index/*"
      ]
    }
  ]
}
EOF
  role   = "web-app-form-service"
}

resource "aws_iam_role_policy" "web_app_identity_service_IdentityServiceUpdateQueueAccess" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "sqs:DeleteMessage",
        "sqs:GetQueueUrl",
        "sqs:ListDeadLetterSourceQueues",
        "sqs:ChangeMessageVisibility",
        "sqs:PurgeQueue",
        "sqs:ReceiveMessage",
        "sqs:SendMessage",
        "sqs:GetQueueAttributes",
        "sqs:ListQueueTags"
      ],
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:identity-identityUpdateQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:identity-identityUpdateQueue-DLQ"
      ]
    }
  ]
}
EOF
  role   = "web-app-identity-service"
}

resource "aws_iam_role_policy" "web_app_identity_service_Identity_Service_DynamoDB_RefreshToken" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "dynamodb:ListContributorInsights",
        "dynamodb:DescribeReservedCapacityOfferings",
        "dynamodb:ListGlobalTables",
        "dynamodb:ListTables",
        "dynamodb:DescribeReservedCapacity",
        "dynamodb:ListBackups",
        "dynamodb:PurchaseReservedCapacityOfferings",
        "dynamodb:DescribeLimits",
        "dynamodb:ListExports",
        "dynamodb:ListStreams"
      ],
      "Resource": "*"
    },
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": "dynamodb:*",
      "Resource": "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/identity.RefreshToken"
    }
  ]
}
EOF
  role   = "web-app-identity-service"
}

resource "aws_iam_role_policy" "web_app_identity_service_identity_service_publish_event" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "sns:Publish",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-sign-in",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-tenantIdentityActivation",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-emailAddressValidated"
      ]
    }
  ]
}
EOF
  role   = "web-app-identity-service"
}

resource "aws_iam_role_policy" "web_app_identity_service_identity_service_ses_send_email" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  role   = "web-app-identity-service"
}

resource "aws_iam_role_policy" "web_app_image_reference_service_image_reference_dynamodb" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/media.ImageReference"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-image-reference-service"
}

resource "aws_iam_role_policy" "web_app_learning_activity_service_ReadActivityInputQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": "sqs:*",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-CreateActivities"
    }
  ]
}
EOF
  role   = "web-app-learning-activity-service"
}

resource "aws_iam_role_policy" "web_app_learning_media_service_s3_learning_media_service" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image-distribution/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-pdf/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-pdf",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon-distribution/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon-distribution"
      ]
    }
  ]
}
EOF
  role   = "web-app-learning-media-service"
}

resource "aws_iam_role_policy" "web_app_market_publisher_task_MarketPublicationActivityAccess" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:GetActivityTask",
        "states:SendTaskFailure",
        "states:SendTaskHeartbeat",
        "states:SendTaskSuccess"
      ],
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishToMarketService"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-market-publisher-task"
}

resource "aws_iam_role_policy" "web_app_market_search_service_market_search_sqs_full_access_search_queues" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentUpdateQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentOrganizationQueue"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-market-search-service"
}

resource "aws_iam_role_policy" "web_app_market_service_market_search_sqs_access_search_queues" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "sqs:*",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentUpdateQueue"
    }
  ]
}
EOF
  role   = "web-app-market-service"
}

resource "aws_iam_role_policy" "web_app_market_service_market_service_s3_bucket_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-market-service/*",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-market-service"
}

resource "aws_iam_role_policy" "web_app_market_service_market_service_sns_topics" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "sns:Publish",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentUpdated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentCreated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentAddedToMarket",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentRemovedFromMarket",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentMetadataUpdated"
      ]
    }
  ]
}
EOF
  role   = "web-app-market-service"
}

resource "aws_iam_role_policy" "web_app_market_subscription_service_market_subscription_sqs_queues" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sqs:*",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-contentNotificationQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionContentOrganizationQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionTenantIdentityActivationQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionInternalQueue.fifo"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-market-subscription-service"
}

resource "aws_iam_role_policy" "web_app_market_subscription_service_write_to_sendNotification_queue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:SendMessage",
        "sqs:SendMessageBatch"
      ],
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:notification-sendNotification.fifo"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-market-subscription-service"
}

resource "aws_iam_role_policy" "web_app_media_asset_service_PublishSNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-mediaAssetModified"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-media-asset-service"
}

resource "aws_iam_role_policy" "web_app_military_user_validator_FullAccessToInternalQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:lstt-militaryValidatorQueue",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-military-user-validator"
}

resource "aws_iam_role_policy" "web_app_military_user_validator_WriteToSendNotificationQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:SendMessage",
        "sqs:SendMessageBatch"
      ],
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:*:notification-sendNotification.fifo"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-military-user-validator"
}

resource "aws_iam_role_policy" "web_app_notification_service_allogy_production_sns_notification_full_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sns:*",
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:notification-*",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-notification-service"
}

resource "aws_iam_role_policy" "web_app_notification_service_dynamodb_notification_tables" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "dynamodb:*",
      "Resource": "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/notification.*"
    }
  ]
}
EOF
  role   = "web-app-notification-service"
}

resource "aws_iam_role_policy" "web_app_notification_service_sns_notification_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "sns:CreatePlatformEndpoint",
      "Resource": "*"
    }
  ]
}
EOF
  role   = "web-app-notification-service"
}

resource "aws_iam_role_policy" "web_app_notification_service_sqs_queues_full_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sqs:*",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:notification-backgroundProcessing.fifo",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:notification-sendNotification.fifo"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-notification-service"
}

resource "aws_iam_role_policy" "web_app_performance_assessment_service_PublishSNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainer",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainerAttempt"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-performance-assessment-service"
}

resource "aws_iam_role_policy" "web_app_simple_email_manager_mail_manager_ses_notifications" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:mail-manager-ses-notifications"
      ],
      "Effect": "Allow",
      "Sid": "Stmt1497974101000"
    }
  ]
}
EOF
  role   = "web-app-simple-email-manager"
}

resource "aws_iam_role_policy" "web_app_simple_email_manager_send_emails_ses" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "ses:SendEmail",
      "ses:SendRawEmail"
    ],
    "Resource": "*",
    "Effect": "Allow",
    "Sid": "Stmt1497652826000"
  }
}
EOF
  role   = "web-app-simple-email-manager"
}

resource "aws_iam_role_policy" "web_app_single_step_service_step_functions" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:DescribeExecution",
        "states:StartExecution"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-single-step-service"
}

resource "aws_iam_role_policy" "web_app_survey_form_service_PublishSNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-surveyForm-CourseSurveyUpdate"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-survey-form-service"
}

resource "aws_iam_role_policy" "web_app_team_service_PublishSNS" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-teamMembershipCreated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-TeamMembershipUpdated"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-team-service"
}

resource "aws_iam_role_policy" "web_app_tenant_configuration_service_tenant_configuration_s3_access" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-tenant-configurations/*",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-tenant-configuration-service"
}

resource "aws_iam_role_policy" "web_app_xapi_service_xApiEventQueue" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-xApiServiceEventQueue",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "web-app-xapi-service"
}

