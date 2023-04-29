resource "aws_lambda_function" "identity_authorizeGatewayRequest" {
  ephemeral_storage {
  }
  function_name                  = "identity-authorizeGatewayRequest"
  handler                        = "com.allogy.identity.lambda.authorizer.StandardAuthorizer"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/lambda-basic"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 10
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_function" "identity_saveSignInEvent" {
  ephemeral_storage {
  }
  function_name                  = "identity-saveSignInEvent"
  handler                        = "com.allogy.identity.lambda.SnsHandler"
  memory_size                    = 512
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/lambda-identity-sign-in"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 120
  tracing_config {
    mode = "PassThrough"
  }
  vpc_config {
    security_group_ids = [
      "sg-05da8fce7414d294c"
    ]
    subnet_ids = [
      "subnet-04e27b7af0a76d7ee", "subnet-05203dc92b0823553", "subnet-096303542f2113a20"
    ]
  }
}

resource "aws_lambda_function" "infrastructure_email_saveSesNotificationToKinesis" {
  ephemeral_storage {
  }
  function_name                  = "infrastructure-email-saveSesNotificationToKinesis"
  handler                        = "com.allogy.infrastructure.email.SnsNotificationHandler"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/ses-notification-recorder"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 20
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "learning_bookExtractor_GovCloud" {
  description = "Extracts components within Book bundle within S3 bucket to allow the Book to be served as HTML via CloudFront"
  ephemeral_storage {
  }
  function_name                  = "learning-bookExtractor-GovCloud"
  handler                        = "com.allogy.learning.handler.BookExtractionHandler"
  memory_size                    = 512
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/learning-book-extractor-role"
  runtime                        = "java11"
  skip_destroy                   = false
  timeout                        = 300
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "learning_createActivities" {
  environment {
    variables = {
      PRODUCTION_QUEUE_URL = "https://sqs.us-gov-west-1.amazonaws.com/050779347855/learning-CreateActivities"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "learning-createActivities"
  handler                        = "com.allogy.learning.activity.lambda.PostActivitiesHandler"
  memory_size                    = 512
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/lambda-learning-activity-service"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_function" "learning_image_encoder_function" {
  environment {
    variables = {
      DESTINATION_BUCKET = "allogy-gov-learning-image-distribution"

      SOURCE_BUCKET = "allogy-gov-learning-image"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "learning-image-encoder-function"
  handler                        = "com.allogy.learning.handler.ImageEncodeHandler"
  memory_size                    = 2048
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/learning-media-lambda-image-role"
  runtime                        = "java11"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "learning_image_publisher" {
  environment {
    variables = {
      MEDIA_SERVICE_URL = "https://internal-services.allogy.com/learning-media"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "learning-image-publisher"
  handler                        = "com.allogy.learning.handler.ImagePublicationHandler"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/learning-media-lambda-image-role"
  runtime                        = "java11"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
  vpc_config {
    security_group_ids = [
      "sg-09ec086d4a18f2267"
    ]
    subnet_ids = [
      "subnet-04e27b7af0a76d7ee", "subnet-05203dc92b0823553", "subnet-096303542f2113a20"
    ]
  }
}

resource "aws_lambda_function" "learning_processPdf" {
  description = "Process PDF files by extracing thumbnails from the PDF."
  environment {
    variables = {
      MEDIA_SERVICE_URL = "https://internal-services.allogy.com/learning-media"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "learning-processPdf"
  handler                        = "com.allogy.learning.media.pdf.PdfProcessingHandler"
  memory_size                    = 3008
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/learning-media-pdf-processor-role"
  runtime                        = "java11"
  skip_destroy                   = false
  timeout                        = 300
  tracing_config {
    mode = "PassThrough"
  }
  vpc_config {
    security_group_ids = [
      "sg-09ec086d4a18f2267"
    ]
    subnet_ids = [
      "subnet-04e27b7af0a76d7ee", "subnet-05203dc92b0823553", "subnet-096303542f2113a20"
    ]
  }
}

resource "aws_lambda_function" "market_handleContentDownloadEvent" {
  description = "aws:states:opt-out"
  ephemeral_storage {
  }
  function_name                  = "market-handleContentDownloadEvent"
  handler                        = "com.allogy.market.download.handler.DownloadHandler"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/lambda-market-download-tracking-service"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 30
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "mediaPublication_checkTranscodingState" {
  ephemeral_storage {
  }
  function_name                  = "mediaPublication-checkTranscodingState"
  handler                        = "com.allogy.learning.media.handler.CheckTranscodingStateHandlerImpl"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/MediaStepsLambdaRole"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "mediaPublication_media_metadata_update" {
  environment {
    variables = {
      METADATA_UPDATE_TOPIC_ARN = "arn:aws-us-gov:sns:us-gov-west-1:050779347855:learning-media-MetadataUpdate"

      S3_OUTPUT_BUCKET_NAME = "allogy-gov-learning-media-distribution"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "mediaPublication-media-metadata-update"
  handler                        = "com.allogy.learning.handler.MediaMetadataUpdateHandler"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/LearningMediaMetadataUpdateRole"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "mediaPublication_notifyTranscodingFailure" {
  environment {
    variables = {
      MEDIA_CONVERT_ENDPOINT = "https://huuog059b.mediaconvert.us-gov-west-1.amazonaws.com"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "mediaPublication-notifyTranscodingFailure"
  handler                        = "com.allogy.learning.media.handler.NotifyTranscodingFailureHandlerImpl"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/MediaStepsLambdaRole"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "mediaPublication_notifyTranscodingSuccess" {
  ephemeral_storage {
  }
  function_name                  = "mediaPublication-notifyTranscodingSuccess"
  handler                        = "com.allogy.learning.media.handler.NotifyTranscodingSuccessHandlerImpl"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/MediaStepsLambdaRole"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "mediaPublication_publicationTrigger" {
  environment {
    variables = {
      STATE_MACHINE_ARN = "arn:aws-us-gov:states:us-gov-west-1:050779347855:stateMachine:MediaPublisher"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "mediaPublication-publicationTrigger"
  handler                        = "com.allogy.learning.media.handler.PublicationTriggerHandlerImpl"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/MediaStepsLambdaRole"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "mediaPublication_putPublicationItem" {
  ephemeral_storage {
  }
  function_name                  = "mediaPublication-putPublicationItem"
  handler                        = "com.allogy.learning.media.handler.PutPublicationItemHandlerImpl"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/MediaStepsLambdaRole"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "mediaPublication_startTranscoding" {
  environment {
    variables = {
      MEDIA_CONVERT_ENDPOINT = "https://huuog059b.mediaconvert.us-gov-west-1.amazonaws.com"

      MEDIA_CONVERT_ROLE_ARN = "arn:aws-us-gov:iam::050779347855:role/MediaConvertRole"

      QUEUE_ARN = "arn:aws-us-gov:mediaconvert:us-gov-west-1:050779347855:queues/Default"

      S3_INPUT_BUCKET_NAME = "allogy-gov-learning-media"

      S3_OUTPUT_BUCKET_NAME = "allogy-gov-learning-media-distribution"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "mediaPublication-startTranscoding"
  handler                        = "com.allogy.learning.media.handler.TranscodeHandlerImpl"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/MediaStepsLambdaRole"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "mediaPublication_updateMediaState" {
  environment {
    variables = {
      MEDIA_SERVICE_HOST_URI = "https://learning-media.allogy.com"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "mediaPublication-updateMediaState"
  handler                        = "com.allogy.learning.media.handler.UpdateMediaStateHandlerImpl"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/MediaStepsLambdaRole"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 60
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "slack_pushNotifications" {
  ephemeral_storage {
  }
  function_name                  = "slack-pushNotifications"
  handler                        = "com.allogy.collaboration.notification.slack.SnsHandler"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/slack-lambda"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 30
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "slack_sendWebServiceMessage" {
  environment {
    variables = {
      CLOUDWATCH_URL = "https://console.amazonaws-us-gov.com/cloudwatch/home?region=us-gov-west-1#alarm:name={alarmName}"

      ECS_SERVICE_URL = "https://console.amazonaws-us-gov.com/ecs/v2/clusters/production/services/{ecsService}/health?region=us-gov-west-1"

      WEB_HOOK_URL = "https://hooks.slack.com/services/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"

    }
  }
  ephemeral_storage {
  }
  function_name                  = "slack-sendWebServiceMessage"
  handler                        = "com.allogy.infrastructure.slack.SnsHandler"
  memory_size                    = 256
  package_type                   = "Zip"
  publish                        = false
  reserved_concurrent_executions = -1
  role                           = "arn:aws-us-gov:iam::050779347855:role/slack-lambda"
  runtime                        = "java8"
  skip_destroy                   = false
  timeout                        = 30
  tracing_config {
    mode = "PassThrough"
  }
}

