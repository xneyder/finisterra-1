resource "aws_s3_bucket_notification" "allogy_gov_bundles" {
  bucket      = "allogy-gov-bundles"
  eventbridge = false
  lambda_function {
    events = [
      "s3:ObjectCreated:*"
    ]
    filter_suffix       = "zip"
    lambda_function_arn = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:learning-bookExtractor-GovCloud"
  }
}

resource "aws_s3_bucket_notification" "allogy_gov_learning_image" {
  bucket      = "allogy-gov-learning-image"
  eventbridge = false
  lambda_function {
    events = [
      "s3:ObjectCreated:*"
    ]
    lambda_function_arn = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:learning-image-encoder-function"
  }
}

resource "aws_s3_bucket_notification" "allogy_gov_learning_image_distribution" {
  bucket      = "allogy-gov-learning-image-distribution"
  eventbridge = false
  lambda_function {
    events = [
      "s3:ObjectCreated:*"
    ]
    filter_suffix       = "png"
    lambda_function_arn = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:learning-image-publisher"
  }
}

resource "aws_s3_bucket_notification" "allogy_gov_learning_media" {
  bucket      = "allogy-gov-learning-media"
  eventbridge = false
  lambda_function {
    events = [
      "s3:ObjectCreated:*"
    ]
    lambda_function_arn = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:mediaPublication-publicationTrigger"
  }
}

resource "aws_s3_bucket_notification" "allogy_gov_learning_pdf" {
  bucket      = "allogy-gov-learning-pdf"
  eventbridge = false
  lambda_function {
    events = [
      "s3:ObjectCreated:*"
    ]
    filter_suffix       = "pdf"
    lambda_function_arn = "arn:aws-us-gov:lambda:us-gov-west-1:050779347855:function:learning-processPdf"
  }
}

