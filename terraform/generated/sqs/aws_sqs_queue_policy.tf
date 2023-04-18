resource "aws_sqs_queue_policy" "builder_builderServiceUpdateQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "UpdateQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:builder-builderServiceUpdateQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": [
            "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-mediaAssetModified",
            "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-Assessment"
          ]
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/builder-builderServiceUpdateQueue"
}

resource "aws_sqs_queue_policy" "collaboration_chat_chatAllogyQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "InputQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-CourseCreated-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCreated"
        }
      }
    },
    {
      "Sid": "SendMessage-From-StudentEnrolled-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentEnrolled"
        }
      }
    },
    {
      "Sid": "SendMessage-From-TeamMembershipCreated-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-teamMembershipCreated"
        }
      }
    },
    {
      "Sid": "SendMessage-From-StudentsRemoved-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentsRemoved"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/collaboration-chat-chatAllogyQueue"
}

resource "aws_sqs_queue_policy" "dbt_formSubmission" {
  policy    = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws-us-gov:iam::050779347855:root"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:dbt-formSubmission",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:us-gov-west-1:050779347855:documentation-formInstanceSubmitted"
        }
      }
    },
    {
      "Sid": "topic-subscription-arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-formInstanceSubmitted",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SQS:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:dbt-formSubmission",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-formInstanceSubmitted"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/dbt-formSubmission"
}

resource "aws_sqs_queue_policy" "identity_identityUpdateQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "InputQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-TeamIdentityUpdated-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:identity-identityUpdateQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-TeamMembershipUpdated"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/identity-identityUpdateQueue"
}

resource "aws_sqs_queue_policy" "learning_contentDownloadsUpdateQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "InputQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-BookService-ContentDownload-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-contentDownloadsUpdateQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/learning-contentDownloadsUpdateQueue"
}

resource "aws_sqs_queue_policy" "learning_courseInstanceUpdateQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "InputQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-AggregateCourseProgress-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressAggregateUpdated"
        }
      }
    },
    {
      "Sid": "SendMessage-From-AssessmentAttempt-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-AssessmentAttempt"
        }
      }
    },
    {
      "Sid": "SendMessage-From-EvaluationContainerAttempt-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainerAttempt"
        }
      }
    },
    {
      "Sid": "SendMessage-From-CourseSurveyUpdate-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-surveyForm-CourseSurveyUpdate"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/learning-courseInstanceUpdateQueue"
}

resource "aws_sqs_queue_policy" "learning_courseProgressNodesUpdated" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "UpdateQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated"
        }
      }
    },
    {
      "Sid": "SendMessage-From-AssessmentAttempt-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-AssessmentAttempt"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/learning-courseProgressNodesUpdated"
}

resource "aws_sqs_queue_policy" "learning_xApiServiceEventQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "InputQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-CourseCompleted-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-xApiServiceEventQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCompleted"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/learning-xApiServiceEventQueue"
}

resource "aws_sqs_queue_policy" "lstt_militaryValidatorQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "InputQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-EmailAddressValidated-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:lstt-militaryValidatorQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-emailAddressValidated"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/lstt-militaryValidatorQueue"
}

resource "aws_sqs_queue_policy" "mail_manager_ses_notifications" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "AccessQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-SNS1",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "SQS:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:mail-manager-ses-notifications",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-delivery-allogy"
        }
      }
    },
    {
      "Sid": "SendMessage-From-SNS2",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "SQS:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:mail-manager-ses-notifications",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-complaint-allogy"
        }
      }
    },
    {
      "Sid": "SendMessage-From-SNS3",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "SQS:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:mail-manager-ses-notifications",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-bounce-allogy"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/mail-manager-ses-notifications"
}

resource "aws_sqs_queue_policy" "market_contentNotificationQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "UpdateQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-contentNotificationQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentUpdated"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/market-contentNotificationQueue"
}

resource "aws_sqs_queue_policy" "market_marketSearchContentOrganizationQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "UpdateQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentOrganizationQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": [
            "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentRemovedFromMarket",
            "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentAddedToMarket"
          ]
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/market-marketSearchContentOrganizationQueue"
}

resource "aws_sqs_queue_policy" "market_marketSearchContentUpdateQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "UpdateQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentUpdateQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentUpdated"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/market-marketSearchContentUpdateQueue"
}

resource "aws_sqs_queue_policy" "market_marketSubscriptionContentOrganizationQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "UpdateQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionContentOrganizationQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentAddedToMarket"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/market-marketSubscriptionContentOrganizationQueue"
}

resource "aws_sqs_queue_policy" "market_marketSubscriptionQueue" {
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Id": "UpdateQueuePolicy",
  "Statement": [
    {
      "Sid": "SendMessage-From-SNS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded"
        }
      }
    }
  ]
}
EOF
  queue_url = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/market-marketSubscriptionQueue"
}

