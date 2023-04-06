resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_northeast_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_ap_northeast_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-northeast-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-northeast-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-northeast-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_northeast_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-northeast-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_northeast_2_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_ap_northeast_2_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-northeast-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-northeast-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-northeast-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_northeast_2_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-northeast-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_south_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_ap_south_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-south-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-south-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-south-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_south_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-south-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_southeast_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_ap_southeast_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-southeast-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-southeast-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-southeast-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_southeast_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-southeast-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_southeast_2_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_ap_southeast_2_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-southeast-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ap-southeast-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-southeast-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ap_southeast_2_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ap-southeast-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ca_central_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_ca_central_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ca-central-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-ca-central-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ca-central-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_ca_central_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-ca-central-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_central_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_eu_central_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-central-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-central-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-central-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_central_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-central-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_north_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_eu_north_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-north-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-north-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-north-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_north_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-north-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_west_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_eu_west_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-west-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_west_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-west-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_west_2_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_eu_west_2_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-west-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_west_2_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-west-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_west_3_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_eu_west_3_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-3-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-eu-west-3-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-west-3-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_eu_west_3_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-eu-west-3-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_sa_east_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_sa_east_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-sa-east-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-sa-east-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-sa-east-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_sa_east_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-sa-east-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_us_east_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_us_east_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-east-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-east-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-us-east-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_us_east_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-us-east-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_us_east_2_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_us_east_2_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-east-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-east-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-us-east-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_us_east_2_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-us-east-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_us_west_1_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_us_west_1_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-west-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-west-1-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-us-west-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_us_west_1_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-us-west-1-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_us_west_2_j1ic5_AWS_QuickSetup_SSMHostMgmt_CreateAndAttachRoleInlinePolicy_us_west_2_j1ic5" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Condition": {
        "ArnEquals": {
          "iam:PolicyARN": [
            "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
            "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
          ]
        }
      },
      "Action": [
        "iam:AttachRolePolicy"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:AddRoleToInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:NewInstanceProfile": "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateInstanceProfile"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:instance-profile/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:GetRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup",
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-west-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ec2.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": [
            "ssm.amazonaws.com"
          ]
        }
      },
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AWS-QuickSetup-HostMgmtRole-us-west-2-j1ic5"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole"
      ],
      "Resource": [
        "arn:aws:iam::169684386827:role/AmazonSSMRoleForInstancesQuickSetup"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-us-west-2-j1ic5"
}

resource "aws_iam_role_policy" "AWS_QuickSetup_HostMgmtRole_us_west_2_j1ic5_SSMQuickSetupEnableExplorerInlinePolicy" {
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
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ssm:UpdateServiceSetting",
        "ssm:GetServiceSetting"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/ssm-patchmanager",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsitem/EC2",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ExplorerOnboarded",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/Association",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ComputeOptimizer",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/ConfigCompliance",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/OpsData-TrustedAdvisor",
        "arn:aws:ssm:*:*:servicesetting/ssm/opsdata/SupportCenterCase"
      ],
      "Effect": "Allow"
    },
    {
      "Condition": {
        "StringEquals": {
          "iam:AWSServiceName": "ssm.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM",
      "Effect": "Allow"
    }
  ]
}
EOF
  role   = "AWS-QuickSetup-HostMgmtRole-us-west-2-j1ic5"
}

resource "aws_iam_role_policy" "cognito_auth_role_cognito_authat_edge" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "logs:PutLogEvents",
        "logs:CreateLogStream",
        "logs:CreateLogGroup"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  role   = "cognito_auth-role"
}

resource "aws_iam_role_policy" "grafana_terraform_20220620141036775900000001" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowReadingMetricsFromCloudWatch",
      "Effect": "Allow",
      "Action": [
        "cloudwatch:DescribeAlarmsForMetric",
        "cloudwatch:DescribeAlarmHistory",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricData",
        "cloudwatch:GetInsightRuleReport"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowReadingLogsFromCloudWatch",
      "Effect": "Allow",
      "Action": [
        "logs:DescribeLogGroups",
        "logs:GetLogGroupFields",
        "logs:StartQuery",
        "logs:StopQuery",
        "logs:GetQueryResults",
        "logs:GetLogEvents"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowReadingTagsInstancesRegionsFromEC2",
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeTags",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowReadingResourcesForTags",
      "Effect": "Allow",
      "Action": "tag:GetResources",
      "Resource": "*"
    }
  ]
}
EOF
  role   = "grafana"
}

resource "aws_iam_role_policy" "loki_terraform_20220705145329518800000001" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-loki/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::posthog-cloud-dev-us-east-1-loki"
    }
  ]
}
EOF
  role   = "loki"
}

resource "aws_iam_role_policy" "test_ch_pr_1377_update_remote_servers_role_attach_to_network" {
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
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Resource": "*",
      "Effect": "Allow",
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
  role   = "test-ch-pr-1377-update_remote_servers_role"
}

resource "aws_iam_role_policy" "test_ch_pr_170_update_remote_servers_role_attach_to_network" {
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
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Resource": "*",
      "Effect": "Allow",
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
  role   = "test-ch-pr-170-update_remote_servers_role"
}

resource "aws_iam_role_policy" "test_ch_pr_218_update_remote_servers_role_attach_to_network" {
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
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Resource": "*",
      "Effect": "Allow",
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
  role   = "test-ch-pr-218-update_remote_servers_role"
}

resource "aws_iam_role_policy" "test_ch_pr_229_update_remote_servers_role_attach_to_network" {
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
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Resource": "*",
      "Effect": "Allow",
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
  role   = "test-ch-pr-229-update_remote_servers_role"
}

resource "aws_iam_role_policy" "test_ch_pr_230_update_remote_servers_role_attach_to_network" {
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
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Resource": "*",
      "Effect": "Allow",
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
  role   = "test-ch-pr-230-update_remote_servers_role"
}

resource "aws_iam_role_policy" "test_ch_pr_485_update_remote_servers_role_attach_to_network" {
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
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Resource": "*",
      "Effect": "Allow",
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
  role   = "test-ch-pr-485-update_remote_servers_role"
}

resource "aws_iam_role_policy" "update_remote_servers_role_attach_to_network" {
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
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "VpcOperations"
    },
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Resource": "*",
      "Effect": "Allow",
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
  role   = "update_remote_servers_role"
}

