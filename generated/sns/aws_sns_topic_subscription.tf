resource "aws_sns_topic_subscription" "_0563894b_3ee0_4c8c_82a2_4c6a6fa3f53f" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:market-handleContentDownloadEvent"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded"
}

resource "aws_sns_topic_subscription" "_082b0506_aa1c_414b_91c8_3bc5f0c9b39c" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-contentNotificationQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentUpdated"
}

resource "aws_sns_topic_subscription" "_0a881114_51fc_4320_bcae_44181d97f08e" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:slack-sendWebServiceMessage"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
}

resource "aws_sns_topic_subscription" "_0d170456_4c46_4b98_839f_2bb31456d729" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:builder-builderServiceUpdateQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-mediaAssetModified"
}

resource "aws_sns_topic_subscription" "_1020c922_e929_42d9_883d_8f70b5b1b06b" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:mail-manager-ses-notifications"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-delivery-allogy"
}

resource "aws_sns_topic_subscription" "_11c503c1_b16d_4dee_a5a3_f4536b2c49d6" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:slack-pushNotifications"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:notification-sendNotificationEvent"
}

resource "aws_sns_topic_subscription" "_1b4a5930_80cc_47a5_9e0b_3bf540d78c06" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:infrastructure-email-saveSesNotificationToKinesis"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-complaint-allogy"
}

resource "aws_sns_topic_subscription" "_1f0d5c4a_d562_4bda_ac4c_004b352fc82a" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:mediaPublication-media-metadata-update"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertSuccess"
}

resource "aws_sns_topic_subscription" "_21a979cd_bb85_4282_bf97_18f9030f88f0" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:infrastructure-email-saveSesNotificationToKinesis"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-delivery-allogy"
}

resource "aws_sns_topic_subscription" "_22c540a7_6ab7_4110_9f48_d5011d3c9314" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentsRemoved"
}

resource "aws_sns_topic_subscription" "_2ba13e3a_ff39_47da_9218_be25e94fdf81" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue"
  filter_policy        = <<EOF
{
  "type": [
    "scoreUpdated",
    "assessmentAttemptStarted"
  ],
  "assessmentScope": [
    "final"
  ]
}
EOF
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-AssessmentAttempt"
}

resource "aws_sns_topic_subscription" "_357f2dd3_4274_412b_a053_372159a273d1" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded"
}

resource "aws_sns_topic_subscription" "_431103ae_ae8c_46d4_9781_3abdd05d619c" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSubscriptionContentOrganizationQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentAddedToMarket"
}

resource "aws_sns_topic_subscription" "_43210503_ef4e_4072_9e55_f9b4140cfe99" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated"
}

resource "aws_sns_topic_subscription" "_439c6f65_b36f_48e0_8945_fc1161d41feb" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:slack-sendWebServiceMessage"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:infrastructure-lambdaFunctionErrors"
}

resource "aws_sns_topic_subscription" "_4edc3b6e_48bf_4b3a_80a0_094fb5d8f2a5" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:infrastructure-email-saveSesNotificationToKinesis"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-bounce-allogy"
}

resource "aws_sns_topic_subscription" "_671e16e7_c653_48a5_a4ec_e90495fc5ee0" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentUpdateQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentUpdated"
}

resource "aws_sns_topic_subscription" "_6c259d06_18b5_4a78_92f3_3fa9904cca2d" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:lstt-militaryValidatorQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-emailAddressValidated"
}

resource "aws_sns_topic_subscription" "_6f9c03cc_22b0_4d1b_9146_edf314ca4e33" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseProgressNodesUpdated"
  filter_policy        = <<EOF
{
  "type": [
    "scoreUpdated"
  ],
  "assessmentScope": [
    "module",
    "branchingScenario"
  ]
}
EOF
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-AssessmentAttempt"
}

resource "aws_sns_topic_subscription" "_73138b3f_41ec_4ce1_b635_2200788b989b" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:dbt-formSubmission"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-formInstanceSubmitted"
}

resource "aws_sns_topic_subscription" "_7466636c_7d70_456a_98a4_5c2142c7b576" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:builder-builderServiceUpdateQueue"
  filter_policy        = <<EOF
{
  "type": [
    "assessmentUpdated"
  ]
}
EOF
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-assessments-Assessment"
}

resource "aws_sns_topic_subscription" "_7696ed51_5e49_4454_bdda_e60f944eed49" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:mail-manager-ses-notifications"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-complaint-allogy"
}

resource "aws_sns_topic_subscription" "_7ce65003_4b4a_4cbd_8e60_161ee4ca0b21" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-CreateActivities"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-activitiesPosted"
}

resource "aws_sns_topic_subscription" "_7d6af436_15ce_4351_993b_ec12a9c92980" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courseProgressAggregateUpdated"
}

resource "aws_sns_topic_subscription" "_894f328c_54a1_4e0c_a8a9_f7c5a607eb59" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:mediaPublication-media-metadata-update"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-media-MetadataUpdate"
}

resource "aws_sns_topic_subscription" "_898178c5_e289_4cc9_88cd_76b52b66583f" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:mediaPublication-notifyTranscodingFailure"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertFailure"
}

resource "aws_sns_topic_subscription" "_8d52af2c_0369_4075_9fdd_35acff2d3401" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue"
  filter_policy        = <<EOF
{
  "courseManagementType": [
    "instructorLed"
  ],
  "type": [
    "courseCreated"
  ],
  "chatEnabled": [
    "true"
  ]
}
EOF
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCreated"
}

resource "aws_sns_topic_subscription" "_8dec0d44_b72e_465a_a310_af4525891fe5" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-xApiServiceEventQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-courseCompleted"
}

resource "aws_sns_topic_subscription" "_928af7da_1565_4f08_8e2c_65f9add4dbed" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:identity-identityUpdateQueue"
  filter_policy        = <<EOF
{
  "type": [
    "membershipDeleted"
  ],
  "teamMembershipCount": [
    {
      "numeric": [
        "=",
        0
      ]
    }
  ]
}
EOF
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-TeamMembershipUpdated"
}

resource "aws_sns_topic_subscription" "_97005c96_65b8_45bf_b39b_7d742b1bc5c8" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-performanceAssessments-evaluationContainerAttempt"
}

resource "aws_sns_topic_subscription" "_97190bb6_1d3f_4f57_9ed8_18aa6a078709" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue"
  filter_policy        = <<EOF
{
  "type": [
    "teamMembershipCreated"
  ],
  "role": [
    "instructor"
  ]
}
EOF
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-teams-teamMembershipCreated"
}

resource "aws_sns_topic_subscription" "a8dfa6ae_cc56_494d_9e35_fd432a6e7e97" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:slack-sendWebServiceMessage"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
}

resource "aws_sns_topic_subscription" "ae084603_5065_4206_b5f5_20f6a7ac30d7" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:mediaPublication-notifyTranscodingSuccess"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:LearningMediaMediaConvertSuccess"
}

resource "aws_sns_topic_subscription" "b399e256_acff_46eb_9060_60882fc80da6" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:collaboration-chat-chatAllogyQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-courses-studentEnrolled"
}

resource "aws_sns_topic_subscription" "bcba2aea_d2d0_44ff_bbb7_4f0169ce4098" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentUpdateQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentCreated"
}

resource "aws_sns_topic_subscription" "bd1065b2_64e7_43b1_8878_270b3e4dfbcf" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-contentDownloadsUpdateQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-bookContentDownloaded"
}

resource "aws_sns_topic_subscription" "c8dea6cb_a788_4296_afa9_9971efb507ae" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:learning-courseInstanceUpdateQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:documentation-surveyForm-CourseSurveyUpdate"
}

resource "aws_sns_topic_subscription" "c9990abf_d5fc_48e0_a93d_f8636f9cb6e6" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentOrganizationQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentAddedToMarket"
}

resource "aws_sns_topic_subscription" "cf956b5b_f5eb_425d_b832_2b8eabe07d52" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:identity-saveSignInEvent"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:identity-sign-in"
}

resource "aws_sns_topic_subscription" "d22eb80b_178b_45a9_8a9a_bfcb6879e240" {
  endpoint             = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:slack-sendWebServiceMessage"
  protocol             = "lambda"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
}

resource "aws_sns_topic_subscription" "d22f6ac5_57ff_4070_abd3_409f3b4e705c" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentOrganizationQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentRemovedFromMarket"
}

resource "aws_sns_topic_subscription" "d5048e7a_85a9_4833_aa7a_d8825b51abff" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:market-marketSearchContentUpdateQueue"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:market-contentMetadataUpdated"
}

resource "aws_sns_topic_subscription" "f9d3eeaf_f03b_46a4_a6b1_333ca1bc8bc6" {
  endpoint             = "arn:aws-us-gov:sqs:us-gov-west-1:050779347855:mail-manager-ses-notifications"
  protocol             = "sqs"
  raw_message_delivery = false
  topic_arn            = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:ses-bounce-allogy"
}

