resource "aws_dynamodb_table" "allogy_db_migrate" {
  attribute {
    name = "Date"
    type = "S"
  }
  attribute {
    name = "User"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "allogy.db.migrate"
  point_in_time_recovery {
    enabled = false
  }
  range_key      = "Date"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "documentation_Form" {
  attribute {
    name = "LanguageVersion"
    type = "S"
  }
  attribute {
    name = "TenantFormId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "documentation.Form"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "LanguageVersion"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "documentation_Instance" {
  attribute {
    name = "LanguageVersion"
    type = "S"
  }
  attribute {
    name = "TenantFormId"
    type = "S"
  }
  attribute {
    name = "TenantInstanceId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  global_secondary_index {
    name            = "learning.documentation.Instance.TenantFormIdIndex"
    projection_type = "ALL"
    range_key       = "LanguageVersion"
  }
  name = "documentation.Instance"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "forms_Form" {
  attribute {
    name = "LanguageVersion"
    type = "S"
  }
  attribute {
    name = "TenantFormId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "forms.Form"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "LanguageVersion"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "forms_Instance" {
  attribute {
    name = "ClientSubmit"
    type = "S"
  }
  attribute {
    name = "TenantIdentityId"
    type = "S"
  }
  attribute {
    name = "TenantInstanceId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  global_secondary_index {
    name = "TenantId-IdentityId-Index"
    non_key_attributes = [
      "FormLabel", "InstanceId", "TenantId", "Type"
    ]
    projection_type = "INCLUDE"
    range_key       = "ClientSubmit"
  }
  name = "forms.Instance"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "learning_Book" {
  attribute {
    name = "TenantBookId"
    type = "S"
  }
  attribute {
    name = "Version"
    type = "N"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "learning.Book"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "Version"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "learning_Book_Development" {
  attribute {
    name = "TenantBookId"
    type = "S"
  }
  attribute {
    name = "Version"
    type = "N"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "learning.Book-Development"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "Version"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "learning_Book_Integration" {
  attribute {
    name = "TenantBookId"
    type = "S"
  }
  attribute {
    name = "Version"
    type = "N"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "learning.Book-Integration"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "Version"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "learning_DomainModel" {
  attribute {
    name = "PK"
    type = "S"
  }
  attribute {
    name = "SK"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "learning.DomainModel"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "SK"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "learning_Image_Development" {
  attribute {
    name = "Id"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "learning.Image-Development"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "learning_MediaSteps" {
  attribute {
    name = "PK"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "learning.MediaSteps"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "market_download_Content" {
  attribute {
    name = "CanonicalId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "market.download.Content"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "market_download_Content_Development" {
  attribute {
    name = "CanonicalId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "market.download.Content-Development"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "market_download_Download" {
  attribute {
    name = "DownloadId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "market.download.Download"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "market_download_Download_Development" {
  attribute {
    name = "CanonicalId"
    type = "S"
  }
  attribute {
    name = "DownloadId"
    type = "S"
  }
  attribute {
    name = "Identity"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  global_secondary_index {
    name            = "Identity-CanonicalId-index"
    projection_type = "KEYS_ONLY"
    range_key       = "CanonicalId"
  }
  name = "market.download.Download-Development"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "media_ImageReference" {
  attribute {
    name = "Id"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "media.ImageReference"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_development_ApplicationEndpoint" {
  attribute {
    name = "ApplicationId"
    type = "S"
  }
  attribute {
    name = "PlatformType"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "notification.development.ApplicationEndpoint"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "PlatformType"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_development_ClientEndpoint" {
  attribute {
    name = "ClientId"
    type = "S"
  }
  attribute {
    name = "PlatformType"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "notification.development.ClientEndpoint"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "PlatformType"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_development_DeviceRegistration" {
  attribute {
    name = "ApplicationId"
    type = "S"
  }
  attribute {
    name = "ClientId"
    type = "S"
  }
  attribute {
    name = "DeviceToken"
    type = "S"
  }
  attribute {
    name = "Id"
    type = "S"
  }
  attribute {
    name = "IdentityId"
    type = "S"
  }
  attribute {
    name = "TenantId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  global_secondary_index {
    name = "DeviceToken-ApplicationId-index"
    non_key_attributes = [
      "EndpointARN"
    ]
    projection_type = "INCLUDE"
    range_key       = "ApplicationId"
  }
  global_secondary_index {
    name = "DeviceToken-ClientId-index"
    non_key_attributes = [
      "EndpointArn"
    ]
    projection_type = "INCLUDE"
    range_key       = "ClientId"
  }
  global_secondary_index {
    name = "IdentityId-TenantId-index"
    non_key_attributes = [
      "EndpointArn"
    ]
    projection_type = "INCLUDE"
    range_key       = "TenantId"
  }
  name = "notification.development.DeviceRegistration"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_development_NotificationFeed" {
  attribute {
    name = "Date"
    type = "S"
  }
  attribute {
    name = "User"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "notification.development.NotificationFeed"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "Date"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_production_ApplicationEndpoint" {
  attribute {
    name = "ApplicationId"
    type = "S"
  }
  attribute {
    name = "PlatformType"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "notification.production.ApplicationEndpoint"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "PlatformType"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_production_ClientEndpoint" {
  attribute {
    name = "ClientId"
    type = "S"
  }
  attribute {
    name = "PlatformType"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "notification.production.ClientEndpoint"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "PlatformType"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_production_DeviceRegistration" {
  attribute {
    name = "ApplicationId"
    type = "S"
  }
  attribute {
    name = "ClientId"
    type = "S"
  }
  attribute {
    name = "DeviceToken"
    type = "S"
  }
  attribute {
    name = "Id"
    type = "S"
  }
  attribute {
    name = "IdentityId"
    type = "S"
  }
  attribute {
    name = "TenantId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  global_secondary_index {
    name = "DeviceToken-ApplicationId-index"
    non_key_attributes = [
      "EndpointArn"
    ]
    projection_type = "INCLUDE"
    range_key       = "ApplicationId"
  }
  global_secondary_index {
    name = "DeviceToken-ClientId-index"
    non_key_attributes = [
      "EndpointArn"
    ]
    projection_type = "INCLUDE"
    range_key       = "ClientId"
  }
  global_secondary_index {
    name = "IdentityId-TenantId-index"
    non_key_attributes = [
      "EndpointArn"
    ]
    projection_type = "INCLUDE"
    range_key       = "TenantId"
  }
  name = "notification.production.DeviceRegistration"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_production_NotificationFeed" {
  attribute {
    name = "Date"
    type = "S"
  }
  attribute {
    name = "User"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  name                        = "notification.production.NotificationFeed"
  point_in_time_recovery {
    enabled = true
  }
  range_key      = "Date"
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "userCodes_Code" {
  attribute {
    name = "Code"
    type = "S"
  }
  attribute {
    name = "GeneratedAt"
    type = "N"
  }
  attribute {
    name = "TenantId-IdentityId"
    type = "S"
  }
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  global_secondary_index {
    name            = "codeGSI"
    projection_type = "ALL"
    range_key       = "GeneratedAt"
  }
  name = "userCodes.Code"
  point_in_time_recovery {
    enabled = true
  }
  stream_enabled = false
  table_class    = "STANDARD"
  ttl {
    enabled = false
  }
}

