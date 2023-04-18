resource "aws_sns_topic_policy" "LearningMediaMediaConvertFailure_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertFailure"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertFailure",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sns:Publish",
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertFailure"
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "LearningMediaMediaConvertSuccess_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertSuccess"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertSuccess",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sns:Publish",
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertSuccess"
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "documentation_formInstanceSubmitted_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-formInstanceSubmitted"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-formInstanceSubmitted",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "documentation_surveyForm_CourseSurveyUpdate_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-surveyForm-CourseSurveyUpdate"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-surveyForm-CourseSurveyUpdate",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "identity_emailAddressValidated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-emailAddressValidated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-emailAddressValidated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "identity_sign_in_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-sign-in"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-sign-in",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "identity_teams_TeamMembershipUpdated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-TeamMembershipUpdated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-TeamMembershipUpdated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "identity_teams_teamMembershipCreated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-teamMembershipCreated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-teamMembershipCreated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "infrastructure_lambdaFunctionErrors_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:infrastructure-lambdaFunctionErrors"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:infrastructure-lambdaFunctionErrors",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_activitiesPosted_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-activitiesPosted"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-activitiesPosted",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_assessments_AssessmentAttempt_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-AssessmentAttempt"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-AssessmentAttempt",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_assessments_Assessment_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-Assessment"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-Assessment",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_bookContentDownloaded_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_courseProgressAggregateUpdated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressAggregateUpdated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressAggregateUpdated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_courseProgressNodesUpdated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_courses_courseCompleted_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCompleted"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCompleted",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_courses_courseCreated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCreated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCreated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_courses_studentEnrolled_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentEnrolled"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentEnrolled",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_courses_studentsRemoved_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentsRemoved"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentsRemoved",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_mediaAssetModified_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-mediaAssetModified"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-mediaAssetModified",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_media_MetadataUpdate_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-media-MetadataUpdate"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "media-metadata-update-topic-access-policy",
  "Statement": [
    {
      "Sid": "default-access-policy-for-resource-owner",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "sns:GetTopicAttributes",
        "sns:SetTopicAttributes",
        "sns:AddPermission",
        "sns:RemovePermission",
        "sns:DeleteTopic",
        "sns:Subscribe",
        "sns:ListSubscriptionsByTopic",
        "sns:Publish",
        "sns:Receive"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-media-MetadataUpdate",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    },
    {
      "Sid": "publish-access-policy-for-cloudwatch-events",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sns:Publish",
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-media-MetadataUpdate"
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_performanceAssessments_evaluationContainerAttempt_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainerAttempt"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainerAttempt",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "learning_performanceAssessments_evaluationContainer_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainer"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainer",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "market_contentAddedToMarket_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentAddedToMarket"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentAddedToMarket",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "market_contentCreated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentCreated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentCreated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "market_contentMetadataUpdated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentMetadataUpdated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentMetadataUpdated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "market_contentRemovedFromMarket_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentRemovedFromMarket"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentRemovedFromMarket",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "market_contentUpdated_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentUpdated"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentUpdated",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "market_externalApps_ExternalApp_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-externalApps-ExternalApp"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-externalApps-ExternalApp",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "notification_sendNotificationEvent_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:notification-sendNotificationEvent"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:notification-sendNotificationEvent",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "ses_bounce_allogy_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-bounce-allogy"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-bounce-allogy",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "ses_complaint_allogy_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-complaint-allogy"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-complaint-allogy",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "ses_delivery_allogy_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-delivery-allogy"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-delivery-allogy",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "web_service_4xx_client_errors_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "web_service_5xx_server_errors_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

resource "aws_sns_topic_policy" "web_service_logging_errors_policy" {
  arn    = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "050779347855"
        }
      }
    }
  ]
}
EOF
}

