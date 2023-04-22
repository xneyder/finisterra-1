resource "aws_api_gateway_model" "m3u7aza1eh_Activity" {
  content_type = "application/json"
  name         = "Activity"
  rest_api_id  = "m3u7aza1eh"
  schema       = <<EOF
{
  "type": "object",
  "required": [
    "activityType",
    "bookId",
    "id",
    "identityId",
    "startedAt",
    "tenantId"
  ],
  "properties": {
    "id": {
      "type": "string",
      "format": "uuid",
      "description": "The unique id of the activity. The client generates this value.\nThe generated value here must be a UUID.\n"
    },
    "identityId": {
      "type": "string",
      "description": "The identity Id of the user who performed the activity."
    },
    "tenantId": {
      "type": "string",
      "description": "The tenant Id"
    },
    "courseInstanceId": {
      "type": "string",
      "description": "The Id of the course instance if this activity happened within the context of a course."
    },
    "activityType": {
      "type": "string",
      "description": "Type identifier for the activity. Current types - \"book\", \"chapter\"."
    },
    "startedAt": {
      "type": "string",
      "format": "date-time",
      "description": "The date-time at which the activity started (ISO 8601)."
    },
    "endedAt": {
      "type": "string",
      "format": "date-time",
      "description": "The date-time at which the activity ended (ISO 8601)."
    },
    "duration": {
      "type": "string",
      "description": "A measurement of the total time taken to complete to activity.\nThis is represented as an ISO 8601 duration object. For example, a value\nof \"PT1M\" is one minute.\n"
    },
    "bookId": {
      "type": "string",
      "description": "The Id of the book, as it is known by the book-service."
    },
    "bookVersion": {
      "type": "integer",
      "description": "The version of the book"
    },
    "chapterId": {
      "type": "string",
      "description": "The Id of the chapter. This should only be used for activities within a chapter"
    },
    "elementId": {
      "type": "string",
      "description": "The Id of the element. This is relevent only for activities below the chapter level"
    },
    "parentActivityId": {
      "type": "string",
      "format": "uuid",
      "description": "If this activity is part of another activity, this is the Id of\nthe other activity. For example, if you have a \"book\" activity with an Id\nof \"xyz\" and this is a \"chapter\" activity within that, set the \"parentActivityId\"\nof the \"chapter\" Activity to \"xyz\" and the parent activity Id of the \"book\"\nActivity to null.\n"
    },
    "appIdentifier": {
      "description": "Information about the app which is providing the activity",
      "$ref": "https://apigateway.amazonaws.com/restapis/m3u7aza1eh/models/AppIdentifier"
    }
  }
}
EOF
}

resource "aws_api_gateway_model" "m3u7aza1eh_ApiError" {
  content_type = "application/json"
  name         = "ApiError"
  rest_api_id  = "m3u7aza1eh"
  schema       = <<EOF
{
  "type": "object",
  "required": [
    "status"
  ],
  "properties": {
    "status": {
      "type": "integer",
      "description": "The HTTP Status Code"
    },
    "error": {
      "type": "string",
      "description": "A more specific error message"
    },
    "developerMessage": {
      "type": "string",
      "description": "A message targeted at the developer using this API"
    },
    "requestId": {
      "type": "string",
      "description": "Provides a unique identifier for the request which can be used by the server development team to debug requests or issues."
    }
  }
}
EOF
}

resource "aws_api_gateway_model" "m3u7aza1eh_AppIdentifier" {
  content_type = "application/json"
  name         = "AppIdentifier"
  rest_api_id  = "m3u7aza1eh"
  schema       = <<EOF
{
  "type": "object",
  "properties": {
    "platformType": {
      "description": "The type of platform, such as iOS or Android",
      "$ref": "https://apigateway.amazonaws.com/restapis/m3u7aza1eh/models/PlatformType"
    },
    "applicationId": {
      "type": "string",
      "description": "The applicationId as supplied by the Identity Service."
    },
    "appVersion": {
      "type": "string",
      "description": "The version of the iOS/Android app."
    },
    "platformVersion": {
      "type": "string",
      "description": "The version of the platform, ie. iOS version or Android version."
    }
  }
}
EOF
}

resource "aws_api_gateway_model" "m3u7aza1eh_CreateActivitiesRequest" {
  content_type = "application/json"
  name         = "CreateActivitiesRequest"
  rest_api_id  = "m3u7aza1eh"
  schema       = <<EOF
{
  "type": "object",
  "properties": {
    "activities": {
      "type": "array",
      "description": "A collection of Activity objects. The API currently accepts up to 10 objects at a time.",
      "items": {
        "$ref": "https://apigateway.amazonaws.com/restapis/m3u7aza1eh/models/Activity"
      }
    },
    "test": {
      "type": "boolean",
      "description": "Testing flag. Set to true to prevent any persistence."
    }
  }
}
EOF
}

resource "aws_api_gateway_model" "m3u7aza1eh_CreateActivitiesResponse" {
  content_type = "application/json"
  name         = "CreateActivitiesResponse"
  rest_api_id  = "m3u7aza1eh"
  schema       = <<EOF
{
  "type": "object"
}
EOF
}

resource "aws_api_gateway_model" "m3u7aza1eh_PlatformType" {
  content_type = "application/json"
  description  = "A know platform type; such as iOS or Android"
  name         = "PlatformType"
  rest_api_id  = "m3u7aza1eh"
  schema       = <<EOF
{
  "type": "string",
  "description": "A know platform type; such as iOS or Android",
  "enum": [
    "ios",
    "android",
    "web"
  ]
}
EOF
}

