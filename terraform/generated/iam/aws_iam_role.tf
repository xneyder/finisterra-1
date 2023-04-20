resource "aws_iam_role" "AWSGlueServiceRole_CrawlerGOVCloud" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/service-role/"
}

resource "aws_iam_role" "AWSReservedSSO_AdministratorAccess_ba963073b9e50b41" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-us-gov:iam::050779347855:saml-provider/AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.amazonaws-us-gov.com/saml"
        }
      }
    }
  ]
}
EOF
  description          = "Full Unrestricted Administrator Access (unless otherwise restricted by Service Control Policy)"
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/us-gov-west-1/"
}

resource "aws_iam_role" "AWSReservedSSO_CodeCommitDeveloperAccess_695963510000a9f5" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-us-gov:iam::050779347855:saml-provider/AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.amazonaws-us-gov.com/saml"
        }
      }
    }
  ]
}
EOF
  description        = "This permission set gives the user access to work with CodeCommit for common developer tasks."
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "codecommit:GitPull",
        "codecommit:GitPush",
        "codecommit:ListRepositories"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "CodeCommitDeveloperAccess"
    }
  ]
}
EOF
  }
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/us-gov-west-1/"
}

resource "aws_iam_role" "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-us-gov:iam::050779347855:saml-provider/AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.amazonaws-us-gov.com/saml"
        }
      }
    }
  ]
}
EOF
  description          = "Allogy managed permission set for DevOpsConsultant"
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/us-gov-west-1/"
}

resource "aws_iam_role" "AWSReservedSSO_PowerUser_4840ab8c0aa8c0f7" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-us-gov:iam::050779347855:saml-provider/AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.amazonaws-us-gov.com/saml"
        }
      }
    }
  ]
}
EOF
  description          = "Allogy managed SSO permission set - PowerUser"
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/us-gov-west-1/"
}

resource "aws_iam_role" "AWSReservedSSO_SecurityAuditor_e2e2445e379226e2" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-us-gov:iam::050779347855:saml-provider/AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.amazonaws-us-gov.com/saml"
        }
      }
    }
  ]
}
EOF
  description          = "ViewOnly access with security level simulation abilities"
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/us-gov-west-1/"
}

resource "aws_iam_role" "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-us-gov:iam::050779347855:saml-provider/AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.amazonaws-us-gov.com/saml"
        }
      }
    }
  ]
}
EOF
  description        = "Allogy Managed SSO for ServerDevelopers"
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-book-*",
        "arn:aws-us-gov:s3:::allogy-book-*/*",
        "arn:aws-us-gov:s3:::allogy-learning-*",
        "arn:aws-us-gov:s3:::allogy-learning-*/*"
      ],
      "Sid": "AllogyProductionBucketsReadAccess"
    },
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
      "Sid": "ECRServerDeveloper"
    },
    {
      "Action": [
        "ecs:UpdateService",
        "ecs:CreateService",
        "servicediscovery:CreateService",
        "servicediscovery:UpdateService"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "ECSDeployToService"
    },
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
      "Resource": "*",
      "Sid": "ElasticBeanstalkReadOnlyAccess"
    },
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
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
      "Resource": "*",
      "Sid": "ElasticBeanstalkUpdateApplication"
    },
    {
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
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:codecommit:us-east-1:250188540659:cloud-config-repository-production",
        "arn:aws-us-gov:codecommit:us-east-1:250188540659:cloud-config-repository-integration"
      ],
      "Sid": "SpringCloudConfigProductionAccess"
    },
    {
      "Action": "codecommit:ListRepositories",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ec2:RevokeSecurityGroupIngress",
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
        "ec2:RevokeSecurityGroupEgress",
        "ec2:UpdateSecurityGroupRuleDescriptionsIngress"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:ec2:*:*:security-group/sg-220ca35a",
        "arn:aws-us-gov:ec2:*:*:security-group/sg-e5532482"
      ],
      "Sid": "VisualEditor0"
    },
    {
      "Action": "cloudwatch:PutDashboard",
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "BasicCloudWatchModifications"
    },
    {
      "Action": [
        "s3:PutAccountPublicAccessBlock",
        "s3:GetAccountPublicAccessBlock",
        "s3:ListAllMyBuckets",
        "s3:ListJobs",
        "s3:CreateJob"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "McdsRedirectLinks"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::mcds-redirect-links",
        "arn:aws-us-gov:s3:::mcds-redirect-links/*"
      ],
      "Sid": "VisualEditor1"
    }
  ]
}
EOF
  }
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/us-gov-west-1/"
}

resource "aws_iam_role" "AWSReservedSSO_SystemAdministrator_62d762355983f553" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-us-gov:iam::050779347855:saml-provider/AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.amazonaws-us-gov.com/saml"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/us-gov-west-1/"
}

resource "aws_iam_role" "AWSReservedSSO_WebClientDeveloper_9565f2e5528c3ce2" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-us-gov:iam::050779347855:saml-provider/AWSSSO_b1d09a718c9a0d64_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.amazonaws-us-gov.com/saml"
        }
      }
    }
  ]
}
EOF
  description        = "Allogy Managed SSO Role for WebClientDeveloper"
  inline_policy {
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
        "arn:aws-us-gov:s3:::*-web-ui",
        "arn:aws-us-gov:s3:::*-web-ui/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/us-gov-west-1/"
}

resource "aws_iam_role" "AWSServiceRoleForAPIGateway" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ops.apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "The Service Linked Role is used by Amazon API Gateway."
  max_session_duration = 3600
  path                 = "/aws-service-role/ops.apigateway.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForAmazonElasticsearchService" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Role for ES to access resources in my VPC"
  max_session_duration = 3600
  path                 = "/aws-service-role/es.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForAmazonGuardDuty" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "guardduty.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/guardduty.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForAmazonSSM" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Provides access to AWS Resources managed or used by Amazon SSM."
  max_session_duration = 3600
  path                 = "/aws-service-role/ssm.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "dynamodb.application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/dynamodb.application-autoscaling.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForApplicationAutoScaling_ECSService" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/ecs.application-autoscaling.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForAutoScaling" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Default Service-Linked Role enables access to AWS Services and Resources used or managed by Auto Scaling"
  max_session_duration = 3600
  path                 = "/aws-service-role/autoscaling.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForCloudTrail" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/cloudtrail.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForConfig" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/config.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForECS" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Role to enable Amazon ECS to manage your cluster."
  max_session_duration = 3600
  path                 = "/aws-service-role/ecs.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForElastiCache" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticache.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "This policy allows ElastiCache to manage AWS resources on your behalf as necessary for managing your cache."
  max_session_duration = 3600
  path                 = "/aws-service-role/elasticache.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForElasticBeanstalk" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/elasticbeanstalk.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForElasticLoadBalancing" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticloadbalancing.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows ELB to call AWS services on your behalf."
  max_session_duration = 3600
  path                 = "/aws-service-role/elasticloadbalancing.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForOrganizations" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "organizations.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Service-linked role used by AWS Organizations to enable integration of other AWS services with Organizations."
  max_session_duration = 3600
  path                 = "/aws-service-role/organizations.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForRDS" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows Amazon RDS to manage AWS resources on your behalf"
  max_session_duration = 3600
  path                 = "/aws-service-role/rds.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForSSO" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sso.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Service-linked role used by AWS SSO to manage AWS resources, including IAM roles, policies and SAML IdP on your behalf."
  max_session_duration = 3600
  path                 = "/aws-service-role/sso.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForSecurityHub" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "securityhub.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/securityhub.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForServiceQuotas" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "servicequotas.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "A service-linked role is required for Service Quotas to access your service limits."
  max_session_duration = 3600
  path                 = "/aws-service-role/servicequotas.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForSupport" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "support.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Enables resource access for AWS to provide billing, administrative and support services"
  max_session_duration = 3600
  path                 = "/aws-service-role/support.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForTrustedAdvisor" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "trustedadvisor.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Access for the AWS Trusted Advisor Service to help reduce cost, increase performance, and improve security of your AWS environment."
  max_session_duration = 3600
  path                 = "/aws-service-role/trustedadvisor.amazonaws.com/"
}

resource "aws_iam_role" "BastionServer" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "DeveloperTools_S3Proxy" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "DynamoDBAutoscaleRole" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "FlowLogger" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "JavaDockerServerDeveloper" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws-us-gov:iam::050779347855:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudwatch:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:cloudwatch:us-gov-west-1:050779347855:alarm:microservice-alpha-sample-*",
        "arn:aws-us-gov:cloudwatch:us-gov-west-1:050779347855:alarm:microservice-beta-sample-*",
        "arn:aws-us-gov:cloudwatch:us-gov-west-1:050779347855:alarm:microservice-gamma-sample-*"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:alpha-sample",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:alpha-sample:*",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:beta-sample",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:beta-sample:*",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:gamma-sample",
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:gamma-sample:*"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:ecr:us-gov-west-1:050779347855:repository/alpha-sample",
        "arn:aws-us-gov:ecr:us-gov-west-1:050779347855:repository/beta-sample",
        "arn:aws-us-gov:ecr:us-gov-west-1:050779347855:repository/gamma-sample"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/alpha-sample",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/alpha-sample:*",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/beta-sample",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/beta-sample:*",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/gamma-sample",
        "arn:aws-us-gov:ecs:us-gov-west-1:050779347855:task-definition/gamma-sample:*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "JenkinsMaster" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/DeveloperTools/"
}

resource "aws_iam_role" "JenkinsRubySlave" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "LearningMediaMetadataUpdateRole" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-media-MetadataUpdate"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "MediaConvertRole" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "mediaconvert.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media/*"
      ]
    },
    {
      "Action": [
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "MediaStepsLambdaRole" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "mediaconvert.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "mediaconvert:GetJob",
        "mediaconvert:CreateJob"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:jobTemplates/*",
        "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:presets/*",
        "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:jobs/*",
        "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:queues/Default"
      ],
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/learning.MediaSteps"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:iam::050779347855:role/MediaConvertRole"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:StartExecution"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:states:us-gov-west-1:050779347855:stateMachine:MediaPublisher"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "SessionManagerMinimum" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Minimum policy for Session Manager"
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "StatesExecutionRole" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows Step Functions to access AWS resources on your behalf."
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "allogy_rds_restore" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "dms.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows you to grant RDS access to additional resources on your behalf."
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "aws_api_gateway_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description        = "Allows API Gateway to push logs to CloudWatch Logs, and invoke lambda functions."
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "aws_elasticbeanstalk_service_role" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "elasticbeanstalk"
        }
      }
    }
  ]
}
EOF
  description          = "Allows Elastic Beanstalk to create and manage AWS resources on your behalf."
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "cognito_authenticated_role_AllogyInternalCognito" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "us-gov-west-1:7be71f68-3c09-4aea-9e4c-40715455fea7"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
  inline_policy {
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
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "cognito_unauthenticated_role_AllogyInternalCognito" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "us-gov-west-1:7be71f68-3c09-4aea-9e4c-40715455fea7"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "dms_cloudwatch_logs_role" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "dms.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "dms_vpc_role" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "dms.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "ecsAutoscaleRole" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "ecsInstanceRole" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description        = "Allows EC2 instances to call AWS services on your behalf."
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:Submit*"
      ],
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "ecsServiceRole" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "infrastructure_ecsMetricCollector" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecs:List*",
        "ecs:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "infrastructure_eureka_discovery_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "route53:ChangeResourceRecordSets",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:route53:::hostedzone/Z10007291701AVIAY46A3"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "internal_services_gateway" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "lambda_basic" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "lambda_identity_sign_in" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "lambda_learning_activity_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "sns:Publish"
    ],
    "Effect": "Allow",
    "Resource": [
      "arn:aws-us-gov:sns:*:*:learning-activitiesPosted"
    ]
  }
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "sqs:SendMessage"
    ],
    "Effect": "Allow",
    "Resource": [
      "arn:aws-us-gov:sqs:*:*:learning-CreateActivities"
    ]
  }
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "lambda_market_download_tracking_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:dynamodb::050779347855:table/market.download.Download",
        "arn:aws-us-gov:dynamodb::050779347855:table/market.download.Download/*",
        "arn:aws-us-gov:dynamodb::050779347855:table/market.download.Content",
        "arn:aws-us-gov:dynamodb::050779347855:table/market.download.Content/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "learning_book_extractor_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-bundles/*",
        "arn:aws-us-gov:s3:::allogy-gov-bundles",
        "arn:aws-us-gov:s3:::allogy-gov-contents/*",
        "arn:aws-us-gov:s3:::allogy-gov-contents"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "learning_media_lambda_image_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-image/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image-distribution/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-image-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon-distribution/*",
        "arn:aws-us-gov:s3:::allogy-gov-learning-icon-distribution"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "learning_media_metadata_update_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution",
        "arn:aws-us-gov:s3:::allogy-gov-learning-media-distribution/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "learning_media_pdf_processor_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-learning-pdf",
        "arn:aws-us-gov:s3:::allogy-gov-learning-pdf/*"
      ],
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "rds_monitoring_role" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "monitoring.rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "services_gateway" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "ses_notification_recorder" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description        = "Write SES email status notifications to S3 via Kinesis Firehose."
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "firehose:PutRecord",
        "firehose:PutRecordBatch"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:firehose:us-gov-west-1:050779347855:deliverystream/ses-email-notifications",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "ses_notifications_recorder_kinesis" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description        = "Allows Kinesis Firehose to transform and deliver data to your destinations using CloudWatch Logs, Lambda, and S3 on your behalf."
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ],
      "Condition": {
        "StringEquals": {
          "kms:ViaService": "s3.us-gov-west-1.amazonaws.com"
        },
        "StringLike": {
          "kms:EncryptionContext:aws-us-gov:s3:arn": "arn:aws-us-gov:s3:::allogy-gov-email/ses-notifications/*"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:kms:us-gov-west-1:050779347855:alias/aws/s3",
      "Sid": "VisualEditor0"
    },
    {
      "Action": "kms:Decrypt",
      "Condition": {
        "StringEquals": {
          "kms:ViaService": "kinesis.us-gov-west-1.amazonaws.com"
        },
        "StringLike": {
          "kms:EncryptionContext:aws-us-gov:kinesis:arn": "arn:aws-us-gov:kinesis:%REGION_NAME%:050779347855:stream%FIREHOSE_STREAM_NAME%"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:kms:us-gov-west-1:050779347855:key/%SSE_KEY_ARN%",
      "Sid": "VisualEditor1"
    },
    {
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
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:logs:us-gov-west-1:050779347855:log-group:/aws/kinesisfirehose/ses-email-notifications:log-stream:*",
        "arn:aws-us-gov:kinesis:us-gov-west-1:050779347855:stream/%FIREHOSE_STREAM_NAME%",
        "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:%FIREHOSE_DEFAULT_FUNCTION%:%FIREHOSE_DEFAULT_VERSION%",
        "arn:aws-us-gov:s3:::allogy-gov-email",
        "arn:aws-us-gov:s3:::allogy-gov-email/*",
        "arn:aws-us-gov:s3:::%FIREHOSE_BUCKET_NAME%",
        "arn:aws-us-gov:s3:::%FIREHOSE_BUCKET_NAME%/*"
      ],
      "Sid": "VisualEditor2"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "slack_lambda" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "temp_admin" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "temp admin for migration"
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "test" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows EC2 instances to call AWS services on your behalf."
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_assessment_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-Assessment",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-AssessmentAttempt"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_badge_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_bitbucket_repositories_archiver" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-repositories-backup",
        "arn:aws-us-gov:s3:::allogy-repositories-backup/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_book_parent_path_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_book_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/learning.Book"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-bundles",
        "arn:aws-us-gov:s3:::allogy-gov-bundles/*",
        "arn:aws-us-gov:s3:::allogy-gov-contents",
        "arn:aws-us-gov:s3:::allogy-gov-contents/*"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sns:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_book_tree_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_builder_find_bundled_works_task" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
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
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:findBundledWorks"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_builder_publish_bundled_works_task" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
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
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishBundledWorks",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:bundledWorksPublicationStatus"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_builder_publisher_task" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
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
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:findBundledWorks",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishBundledWorks",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:bundledWorksPublicationStatus",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishUsingBuilder",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:courseInstancePublisherTask",
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishToMarketService"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_builder_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows builder-service to send cloudwatch logs and metrics via ECS."
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_builder_sqs_task" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:builder-builderServiceUpdateQueue"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_chat_allogy_server" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_code_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/userCodes.Code",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/userCodes.Code/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_collaboration_person_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description        = "Allows EC2 instances to call AWS services on your behalf."
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:s3:::allogy-gov-person-images-upload",
        "arn:aws-us-gov:s3:::allogy-gov-person-images-upload/*",
        "arn:aws-us-gov:s3:::allogy-gov-person-images-scaled",
        "arn:aws-us-gov:s3:::allogy-gov-person-images-scaled/*"
      ],
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_collections_space_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_content_download_analytics_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-contentDownloadsUpdateQueue"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/market.download.Download"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_course_certificate_pdf_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_course_content_progress_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressAggregateUpdated"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_course_instance_publisher_task" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
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
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:courseInstancePublisherTask"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_course_instance_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCreated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentEnrolled",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentsRemoved",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCompleted"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_creator_graphql_api" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_creator_settings_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_creator_user_settings_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_dbt_clinician_web" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-dataSqs.fifo",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-dataSqs.fifo/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_dbt_form_processor" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:*:identity-tenant-dataSqs",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:identity-tenant-dataSqs/*",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-dataSqs.fifo",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-dataSqs.fifo/*",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-formSubmission",
        "arn:aws-us-gov:sqs:us-gov-west-1:*:dbt-formSubmission/*"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:*:activity:addToOnPremiseQueue",
        "arn:aws-us-gov:states:us-gov-west-1:*:activity:addToOnPremiseQueue/*",
        "arn:aws-us-gov:states:us-gov-west-1:*:stateMachine:FormSubmission",
        "arn:aws-us-gov:states:us-gov-west-1:*:stateMachine:FormSubmission/*"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_domain_model_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/learning.DomainModel"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_event_tracking_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_external_app_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-externalApps-ExternalApp"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_form_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description        = "Role for the form-service"
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sns:Publish",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sns:*:050779347855:documentation-*",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/documentation.Form",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/documentation.Instance",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/forms.Form",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/forms.Instance",
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/forms.Instance/index/*"
      ],
      "Sid": "Stmt1441829666000"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_gateway" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_identity_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description        = "Service Role for Identity Service"
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
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
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    },
    {
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/identity.RefreshToken",
      "Sid": "VisualEditor1"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
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
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:identity-identityUpdateQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:identity-identityUpdateQueue-DLQ"
      ],
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sns:Publish",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-sign-in",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-tenantIdentityActivation",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-emailAddressValidated"
      ],
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_image_reference_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/media.ImageReference"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_image_scaling_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows ECS tasks to call AWS services on your behalf."
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_instructor_graphql_api" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_ip_geo_location_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_learner_graphql_api" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_learning_activity_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-CreateActivities",
      "Sid": "VisualEditor1"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_learning_media_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description        = "Allows ECS tasks to call AWS services on your behalf."
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
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
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_market_publisher_task" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
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
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:states:us-gov-west-1:050779347855:activity:publishToMarketService"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_market_search_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentUpdateQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentOrganizationQueue"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_market_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentUpdateQueue",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-market-service/*"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sns:Publish",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentUpdated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentCreated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentAddedToMarket",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentRemovedFromMarket",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentMetadataUpdated"
      ],
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_market_subscription_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-contentNotificationQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionContentOrganizationQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionTenantIdentityActivationQueue",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionInternalQueue.fifo"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:SendMessage",
        "sqs:SendMessageBatch"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:notification-sendNotification.fifo"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_media_asset_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-mediaAssetModified"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_military_user_validator" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:lstt-militaryValidatorQueue"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:SendMessage",
        "sqs:SendMessageBatch"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:*:notification-sendNotification.fifo"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_mobile_client_gateway" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_notification_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sns:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:notification-*"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:dynamodb:us-gov-west-1:050779347855:table/notification.*",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sns:CreatePlatformEndpoint",
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VisualEditor0"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:notification-backgroundProcessing.fifo",
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:notification-sendNotification.fifo"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_opportunity_project_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_performance_assessment_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainer",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainerAttempt"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_publication_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_registration_validation_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_simple_email_manager" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:mail-manager-ses-notifications"
      ],
      "Sid": "Stmt1497974101000"
    }
  ]
}
EOF
  }
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": [
      "ses:SendEmail",
      "ses:SendRawEmail"
    ],
    "Effect": "Allow",
    "Resource": "*",
    "Sid": "Stmt1497652826000"
  }
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_single_step_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "states:DescribeExecution",
        "states:StartExecution"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_spring_config_server" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_survey_form_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-surveyForm-CourseSurveyUpdate"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_team_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-teamMembershipCreated",
        "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-TeamMembershipUpdated"
      ]
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_tenant_code_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_tenant_configuration_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:s3:::allogy-gov-tenant-configurations/*"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_tenant_host_domain_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_tenant_user_configuration_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_test_web_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows EC2 instances to call AWS services on your behalf."
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_user_data_service" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "web_app_xapi_service" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:Get*",
        "sqs:*Message*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-xApiServiceEventQueue"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "xray_daemon_role" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "The AWS X-Ray daemon sidecar task."
  max_session_duration = 3600
  path                 = "/"
}

