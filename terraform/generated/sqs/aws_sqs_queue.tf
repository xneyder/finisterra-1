resource "aws_sqs_queue" "builder_builderServiceUpdateQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "builder_builderServiceUpdateQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "collaboration_chat_chatAllogyQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "collaboration_chat_chatAllogyQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "dbt_dataSqs_fifo" {
  content_based_deduplication = true
  delay_seconds               = 0
  fifo_queue                  = true
  max_message_size            = 262144
  message_retention_seconds   = 345600
  receive_wait_time_seconds   = 0
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "dbt_formSubmission" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 345600
  receive_wait_time_seconds   = 0
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "identity_identityUpdateQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "identity_identityUpdateQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "identity_tenant_dataSqs" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 345600
  receive_wait_time_seconds   = 0
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "learning_CreateActivities" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 345600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 180
}

resource "aws_sqs_queue" "learning_CreateActivitiesFailedMessages" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "learning_contentDownloadsUpdateQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "learning_contentDownloadsUpdateQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "learning_courseInstanceUpdateQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "learning_courseInstanceUpdateQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "learning_courseProgressNodesUpdated" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "learning_courseProgressNodesUpdated_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "learning_xApiServiceEventQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "learning_xApiServiceEventQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "lstt_militaryValidatorQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "lstt_militaryValidatorQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "mail_manager_ses_notifications" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 345600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "market_contentNotificationQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "market_contentNotificationQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "market_marketSearchContentOrganizationQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "market_marketSearchContentOrganizationQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "market_marketSearchContentUpdateQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "market_marketSearchContentUpdateQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "market_marketSubscriptionContentOrganizationQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "market_marketSubscriptionContentOrganizationQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "market_marketSubscriptionInternalDeadLetterQueue_DLQ_fifo" {
  content_based_deduplication = true
  delay_seconds               = 0
  fifo_queue                  = true
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "market_marketSubscriptionInternalQueue_fifo" {
  content_based_deduplication = true
  delay_seconds               = 0
  fifo_queue                  = true
  max_message_size            = 262144
  message_retention_seconds   = 172800
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "market_marketSubscriptionQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "market_marketSubscriptionQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "market_marketSubscriptionTenantIdentityActivationQueue" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "market_marketSubscriptionTenantIdentityActivationQueue_DLQ" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = false
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 30
}

resource "aws_sqs_queue" "notification_backgroundProcessing_fifo" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = true
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

resource "aws_sqs_queue" "notification_sendNotification_fifo" {
  content_based_deduplication = false
  delay_seconds               = 0
  fifo_queue                  = true
  max_message_size            = 262144
  message_retention_seconds   = 1209600
  receive_wait_time_seconds   = 20
  visibility_timeout_seconds  = 60
}

