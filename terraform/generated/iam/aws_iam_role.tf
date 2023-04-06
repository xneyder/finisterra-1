resource "aws_iam_role" "AWSReservedSSO_administrators_0904d7a089e60584" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:saml-provider/AWSSSO_c3353b8cf127d54f_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
  description          = "PermissionSet for administrators to AWS resources."
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/"
}

resource "aws_iam_role" "AWSReservedSSO_developers_0847e649a00cc5e7" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:saml-provider/AWSSSO_c3353b8cf127d54f_DO_NOT_DELETE"
      },
      "Action": [
        "sts:AssumeRoleWithSAML",
        "sts:TagSession"
      ],
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
  description          = "PermissionSet for developers to AWS resources."
  max_session_duration = 43200
  path                 = "/aws-reserved/sso.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForAmazonEKS" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows Amazon EKS to call AWS services on your behalf."
  max_session_duration = 3600
  path                 = "/aws-service-role/eks.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForAmazonEKSForFargate" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks-fargate.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "This policy grants necessary permissions to Amazon EKS to run fargate tasks"
  max_session_duration = 3600
  path                 = "/aws-service-role/eks-fargate.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForAmazonEKSNodegroup" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks-nodegroup.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "This policy allows Amazon EKS to create and manage Nodegroups"
  max_session_duration = 3600
  path                 = "/aws-service-role/eks-nodegroup.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForAmazonGuardDuty" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
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

resource "aws_iam_role" "AWSServiceRoleForBackup" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "backup.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/backup.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForClientVPN" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "clientvpn.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Service Linked Role for Client VPN"
  max_session_duration = 3600
  path                 = "/aws-service-role/clientvpn.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForClientVPNConnections" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "clientvpn-connections.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Service Linked Role for Client VPN connections"
  max_session_duration = 3600
  path                 = "/aws-service-role/clientvpn-connections.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForCloudFormationStackSetsOrgMember" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "member.org.stacksets.cloudformation.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Service linked role for CloudFormation StackSets (Organization Member)"
  max_session_duration = 3600
  path                 = "/aws-service-role/member.org.stacksets.cloudformation.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForCloudFrontLogger" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "logger.cloudfront.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/logger.cloudfront.amazonaws.com/"
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

resource "aws_iam_role" "AWSServiceRoleForGlobalAccelerator" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "globalaccelerator.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Allows Global Accelerator to call AWS services on customer's behalf"
  max_session_duration = 3600
  path                 = "/aws-service-role/globalaccelerator.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForKafka" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "kafka.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/kafka.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForKafkaConnect" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "kafkaconnect.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/kafkaconnect.amazonaws.com/"
}

resource "aws_iam_role" "AWSServiceRoleForLambdaReplicator" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "replicator.lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/aws-service-role/replicator.lambda.amazonaws.com/"
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
  description          = "A service-linked role required for AWS Security Hub to access your resources."
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

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_ap_northeast_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-ap-northeast-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-northeast-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-northeast-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_ap_northeast_2_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-ap-northeast-2-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-northeast-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-northeast-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_ap_south_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-ap-south-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-south-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-south-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_ap_southeast_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-ap-southeast-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-southeast-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-southeast-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_ap_southeast_2_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-ap-southeast-2-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-southeast-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-southeast-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_ca_central_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-ca-central-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ca-central-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ca-central-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_eu_central_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-eu-central-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-central-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-central-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_eu_north_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-eu-north-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-north-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-north-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_eu_west_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-eu-west-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_eu_west_2_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-eu-west-2-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_eu_west_3_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-eu-west-3-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-3-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-3-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_sa_east_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-sa-east-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-sa-east-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-sa-east-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_us_east_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-us-east-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-east-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-east-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_us_east_2_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-us-east-2-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-east-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-east-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_us_west_1_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-us-west-1-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-west-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-west-1-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AWS_QuickSetup_HostMgmtRole_us_west_2_j1ic5" {
  assume_role_policy = <<EOF
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
  inline_policy {
    name   = "AWS-QuickSetup-SSMHostMgmt-CreateAndAttachRoleInlinePolicy-us-west-2-j1ic5"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetAutomationExecution",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:DescribeInstances",
        "ssm:StartAutomationExecution",
        "iam:GetInstanceProfile",
        "iam:ListInstanceProfilesForRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-west-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    },
    {
      "Action": [
        "iam:PassRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-west-2-j1ic5"
      ]
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ]
    }
  ]
}
EOF
  }
  inline_policy {
    name   = "SSMQuickSetupEnableExplorerInlinePolicy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:ListRoles",
        "config:DescribeConfigurationRecorders",
        "compute-optimizer:GetEnrollmentStatus",
        "support:DescribeTrustedAdvisorChecks"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ]
    },
    {
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    QuickSetupID = "j1ic5"

    QuickSetupType = "Host Management"

    QuickSetupVersion = "2.2"

  }
}

resource "aws_iam_role" "AmazonEKS_EBS_CSI_DriverRole" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    "alpha.eksctl.io/cluster-name" = "posthog-dev"

    "alpha.eksctl.io/eksctl-version" = "0.114.0-dev+48660cbd1.2022-10-08T02:21:31Z"

    "alpha.eksctl.io/iamserviceaccount-name" = "kube-system/ebs-csi-controller-sa"

    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "posthog-dev"

  }
}

resource "aws_iam_role" "DrataAutopilotRole" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::269135526815:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "805315dd-8452-461b-850d-fb1957ecb803"
        }
      }
    }
  ]
}
EOF
  description          = "Cross-account read-only access for Drata Autopilot"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "OrganizationAccountAccessRole" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::795637471508:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_20220818161915282900000006" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_20220823125548116500000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_20221020153002485400000006" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_20221102203257004000000009" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_20221110172120390200000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_20230124155745065400000006" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_2023031716524215360000000b" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_20230324104144291700000006" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_2023032411460326330000000e" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_4xlarge_eks_node_group_2023040311534749630000000c" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_arm64_eks_node_group_20230119111552802300000008" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "az1_arm64_eks_node_group_20230124155745066900000009" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_arm64_eks_node_group_2023031716524216890000000c" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_arm64_eks_node_group_20230324104144295600000008" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_arm64_eks_node_group_2023032411460262940000000b" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az1_arm64_eks_node_group_20230403115346682300000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20220818161915279400000004" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20220823125548127600000009" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20221020153002486200000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20221102203256999900000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20221110172120391000000008" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_2023012415574590030000000f" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20230317165241279100000006" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20230324104144296000000009" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20230324114603621900000010" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_4xlarge_eks_node_group_20230403115348617400000011" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_br_eks_node_group_20230320085759617700000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_br_eks_node_group_20230320151316428000000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "az2_arm64_br_eks_node_group_20230324104144290800000005" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_br_eks_node_group_2023032411460319150000000d" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_br_eks_node_group_2023040311534853840000000e" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_eks_node_group_20230119111552577000000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "az2_arm64_eks_node_group_20230124155745059900000005" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_eks_node_group_2023031716524286450000000d" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_eks_node_group_20230324104144293600000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_eks_node_group_2023032411460269400000000c" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az2_arm64_eks_node_group_20230403115348557700000010" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_20220818161915283400000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_20220823125548120400000008" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_20221020153002486900000008" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_20221102203256987300000004" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_20221110172120392000000009" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_20230124155745058300000004" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_2023031716524301070000000f" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_2023032410414490570000000b" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_2023032411460362100000000f" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_4xlarge_eks_node_group_2023040311534820340000000d" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_arm64_eks_node_group_20230119111552912300000009" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "az3_arm64_eks_node_group_20230124155745066600000008" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_arm64_eks_node_group_2023031716524290590000000e" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_arm64_eks_node_group_2023032410414449660000000a" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_arm64_eks_node_group_20230324114602108600000006" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "az3_arm64_eks_node_group_2023040311534854510000000f" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "clickhouse_ec2" {
  assume_role_policy   = <<EOF
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
  description          = "Role for ClickHouse EC2 instances"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "cognito_auth_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAwsToAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "edgelambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  inline_policy {
    name   = "cognito_authat-edge"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:PutLogEvents",
        "logs:CreateLogStream",
        "logs:CreateLogGroup"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": ""
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "default_20220523131651400000000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks-fargate-pods.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Fargate profile IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "ec2_default" {
  assume_role_policy   = <<EOF
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
  description          = "Default role that an EC2 instance can assume"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "github_terraform_infra_role" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": [
            "repo:PostHog/posthog-cloud-infra:*",
            "repo:PostHog/billing:*",
            "repo:PostHog/posthog:*"
          ]
        }
      }
    }
  ]
}
EOF
  max_session_duration = 7200
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "grafana" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:sub": "system:serviceaccount:posthog:grafana"
        }
      }
    }
  ]
}
EOF
  inline_policy {
    name   = "terraform-20220620141036775900000001"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudwatch:DescribeAlarmsForMetric",
        "cloudwatch:DescribeAlarmHistory",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricData",
        "cloudwatch:GetInsightRuleReport"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "AllowReadingMetricsFromCloudWatch"
    },
    {
      "Action": [
        "logs:DescribeLogGroups",
        "logs:GetLogGroupFields",
        "logs:StartQuery",
        "logs:StopQuery",
        "logs:GetQueryResults",
        "logs:GetLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "AllowReadingLogsFromCloudWatch"
    },
    {
      "Action": [
        "ec2:DescribeTags",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "AllowReadingTagsInstancesRegionsFromEC2"
    },
    {
      "Action": "tag:GetResources",
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "AllowReadingResourcesForTags"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "kube_system_20220523131651399400000001" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks-fargate-pods.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Fargate profile IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "loki" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:sub": "system:serviceaccount:posthog:loki"
        }
      }
    }
  ]
}
EOF
  inline_policy {
    name   = "terraform-20220705145329518800000001"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-loki/*"
    },
    {
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-loki"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "nodes_eks_node_group_20220523131651404200000007" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "nodes_eks_node_group_20220602125147928200000004" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "nodes_eks_node_group_20220616115441134600000003" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSNodeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "EKS managed node group IAM role"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "posthog_dev_cluster_20220429143555706600000004" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/8BD6E1D2FEBDE47C8177E29CAC9E6C61:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "rds_backup_service_role_us_east_1" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "backup.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "secrettest_role_4c20jvwx" {
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
  path                 = "/service-role/"
}

resource "aws_iam_role" "spacelift" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::324880187172:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "posthog@01GWSVZ609S3170B4JY9R7WA6E@aws-accnt-dev@write"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "stacksets_exec_a2fbe04951ccdbbedf46c50187226295" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Id": "stacksets-exec-a2fbe04951ccdbbedf46c50187226295-assume-role-policy",
  "Statement": [
    {
      "Sid": "1",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::795637471508:role/aws-service-role/stacksets.cloudformation.amazonaws.com/AWSServiceRoleForCloudFormationStackSetsOrgAdmin"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  description          = "Role created by AWSCloudFormation StackSets"
  max_session_duration = 3600
  path                 = "/"
}

resource "aws_iam_role" "terraform_20221006010416860700000001" {
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
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "terraform_20221006013829304700000001" {
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
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "terraform_20221128125119272600000001" {
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
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_role" "test_ch_pr_1377_clickhouse_ec2" {
  assume_role_policy   = <<EOF
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
  description          = "Role for ClickHouse EC2 instances"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_1377_update_remote_servers_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
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
    name   = "attach-to-network"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "InstanceOperations"
    },
    {
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-1:169684386827:secret:test-ch-pr-1377-internal_password-CUwVhu"
      ],
      "Sid": "GetClickHousePassword"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_170_update_remote_servers_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
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
    name   = "attach-to-network"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "InstanceOperations"
    },
    {
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-1:169684386827:secret:test-ch-pr-170-internal_password-S0OdbQ"
      ],
      "Sid": "GetClickHousePassword"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_218_clickhouse_ec2" {
  assume_role_policy   = <<EOF
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
  description          = "Role for ClickHouse EC2 instances"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_218_update_remote_servers_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
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
    name   = "attach-to-network"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "InstanceOperations"
    },
    {
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-1:169684386827:secret:test-ch-pr-218-internal_password-wKTrNN"
      ],
      "Sid": "GetClickHousePassword"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_229_clickhouse_ec2" {
  assume_role_policy   = <<EOF
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
  description          = "Role for ClickHouse EC2 instances"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_229_update_remote_servers_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
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
    name   = "attach-to-network"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "InstanceOperations"
    },
    {
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-1:169684386827:secret:test-ch-pr-229-internal_password-omgAsy"
      ],
      "Sid": "GetClickHousePassword"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_230_clickhouse_ec2" {
  assume_role_policy   = <<EOF
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
  description          = "Role for ClickHouse EC2 instances"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_230_update_remote_servers_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
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
    name   = "attach-to-network"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "InstanceOperations"
    },
    {
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-1:169684386827:secret:test-ch-pr-230-internal_password-9mmmUu"
      ],
      "Sid": "GetClickHousePassword"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_485_clickhouse_ec2" {
  assume_role_policy   = <<EOF
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
  description          = "Role for ClickHouse EC2 instances"
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_ch_pr_485_update_remote_servers_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
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
    name   = "attach-to-network"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "InstanceOperations"
    },
    {
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-1:169684386827:secret:test-ch-pr-485-internal_password-d0CtpA"
      ],
      "Sid": "GetClickHousePassword"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1337_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1337_posthog_dev_cluster_20230317165241239800000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1337_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1337_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa",
          "oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1337_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7CF400FB19749D88A8408CF610027FE9:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1376_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1376_posthog_dev_cluster_20230324104144267900000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1376_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1376_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1376_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7CA6B5E783111BB20A7F250A61D53AFE:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1377_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1377_posthog_dev_cluster_20230403115346600800000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1377_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1377_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa",
          "oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1377_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7A4C903B3A7D6AAEB3ED9EC430637E6A:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1379_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1379_posthog_dev_cluster_20230324114602000300000003" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1379_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1379_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_1379_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/EE6D2FD1BDCDB994C4197E0912552CAC:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_193_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/C9F5CCF1FC68C8726485F82F7C83618B"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/C9F5CCF1FC68C8726485F82F7C83618B:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_193_posthog_dev_cluster_20220523131651400500000003" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_193_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/C9F5CCF1FC68C8726485F82F7C83618B"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/C9F5CCF1FC68C8726485F82F7C83618B:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_193_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/C9F5CCF1FC68C8726485F82F7C83618B"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/C9F5CCF1FC68C8726485F82F7C83618B:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_245_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/35F65FD794250919329F08A46F9E1175"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/35F65FD794250919329F08A46F9E1175:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_245_posthog_dev_cluster_20220602125147921600000001" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_245_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/35F65FD794250919329F08A46F9E1175"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/35F65FD794250919329F08A46F9E1175:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_245_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/35F65FD794250919329F08A46F9E1175"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/35F65FD794250919329F08A46F9E1175:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_279_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/331016B575DE5D9ADFC3D19C90DD54B1"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/331016B575DE5D9ADFC3D19C90DD54B1:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_279_posthog_dev_cluster_20220616115441135200000004" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_279_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/331016B575DE5D9ADFC3D19C90DD54B1"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/331016B575DE5D9ADFC3D19C90DD54B1:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_279_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/331016B575DE5D9ADFC3D19C90DD54B1"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/331016B575DE5D9ADFC3D19C90DD54B1:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_458_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EF7CCD654E4E696EFFE46F86F2C9CE34"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/EF7CCD654E4E696EFFE46F86F2C9CE34:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_458_posthog_dev_cluster_20220818161915270700000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_458_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EF7CCD654E4E696EFFE46F86F2C9CE34"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/EF7CCD654E4E696EFFE46F86F2C9CE34:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_458_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EF7CCD654E4E696EFFE46F86F2C9CE34"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/EF7CCD654E4E696EFFE46F86F2C9CE34:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_687_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_687_posthog_dev_cluster_20221020153002461400000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_687_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_687_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_687_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/B42FF7017C7DB2440175EAEA95E00DCF:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_750_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_750_posthog_dev_cluster_20221102203256974100000003" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_750_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_750_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa",
          "oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_750_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/2F099E7638097C2D1EB9060400DA36B1:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_777_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_777_posthog_dev_cluster_20221110172120366000000001" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_777_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_777_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_777_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/7402A303BBBB77B20862CCF35A516DD8:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_788_posthog_dev_cluster_20221115143713688800000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_788_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/FC2CFEE911E543667E4C4BC09DECC7E9"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/FC2CFEE911E543667E4C4BC09DECC7E9:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa",
          "oidc.eks.us-east-1.amazonaws.com/id/FC2CFEE911E543667E4C4BC09DECC7E9:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_993_posthog_dev_aws_load_balancer_controller" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_993_posthog_dev_cluster_20230124155745013700000002" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EKSClusterAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_993_posthog_dev_cluster_autoscaler" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_993_posthog_dev_ebs_csi_driver" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "test_eks_pr_993_posthog_dev_external_dns" {
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::169684386827:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/977BC6DA2360F1DBAC05750DCEB6EC85:sub": "system:serviceaccount:kube-system:external-dns"
        }
      }
    }
  ]
}
EOF
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_role" "update_remote_servers_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
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
    name   = "attach-to-network"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*",
      "Sid": "InstanceOperations"
    },
    {
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-1:169684386827:secret:internal_password-sqppaQ"
      ],
      "Sid": "GetClickHousePassword"
    }
  ]
}
EOF
  }
  max_session_duration = 3600
  path                 = "/"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

