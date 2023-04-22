resource "aws_api_gateway_documentation_part" "_1rjgut" {
  location {
    name = "Activity.duration"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"A measurement of the total time taken to complete to activity.\\nThis is represented as an ISO 8601 duration object. For example, a value\\nof \\\"PT1M\\\" is one minute.\\n\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "_1xha44" {
  location {
    name = "Activity.tenantId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The tenant Id\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "_1zi39l" {
  location {
    name = "Activity.courseInstanceId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The Id of the course instance if this activity happened within the context of a course.\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "_2vtla4" {
  location {
    name = "Activity.id"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The unique id of the activity. The client generates this value.\\nThe generated value here must be a UUID.\\n\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "_4wawta" {
  location {
    method = "POST"
    path   = "/api/v1/activities"
    type   = "METHOD"
  }
  properties  = "{  \"tags\" : [ \"mobile\" ],  \"summary\" : \"Create learning activities\",  \"description\" : \"Creates learning activities on the server\\n\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "_5697nn" {
  location {
    name = "Activity.identityId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The identity Id of the user who performed the activity.\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "_96knhc" {
  location {
    name = "ApiError.status"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The HTTP Status Code\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "_9u29y2" {
  location {
    name = "Activity.elementId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The Id of the element. This is relevent only for activities below the chapter level\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "_9z5uce" {
  location {
    name = "ApiError.requestId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"Provides a unique identifier for the request which can be used by the server development team to debug requests or issues.\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "cpitnj" {
  location {
    name = "ApiError.error"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"A more specific error message\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "k1hgsr" {
  location {
    name = "CreateActivitiesRequest.activities"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"A collection of Activity objects. The API currently accepts up to 10 objects at a time.\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "kprc2b" {
  location {
    name = "Activity.endedAt"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The date-time at which the activity ended (ISO 8601).\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "m4k6xa" {
  location {
    name = "AppIdentifier.applicationId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The applicationId as supplied by the Identity Service.\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "mlicok" {
  location {
    name = "Activity.activityType"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"Type identifier for the activity. Current types - \\\"book\\\", \\\"chapter\\\".\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "o4qnji" {
  location {
    name = "AppIdentifier.platformType"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The type of platform, such as iOS or Android\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "p57nk8" {
  location {
    name = "Activity.parentActivityId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"If this activity is part of another activity, this is the Id of\\nthe other activity. For example, if you have a \\\"book\\\" activity with an Id\\nof \\\"xyz\\\" and this is a \\\"chapter\\\" activity within that, set the \\\"parentActivityId\\\"\\nof the \\\"chapter\\\" Activity to \\\"xyz\\\" and the parent activity Id of the \\\"book\\\"\\nActivity to null.\\n\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "qpcf9h" {
  location {
    type = "API"
  }
  properties  = "{  \"info\" : {    \"description\" : \"Handles learning activities from mobile and web clients.\",    \"contact\" : {      \"name\" : \"Allogy Interactive\"    },    \"license\" : {      \"name\" : \"Copyright (c) 2016. Allogy Interactive\"    }  }}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "ruahq2" {
  location {
    name = "AppIdentifier.platformVersion"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The version of the platform, ie. iOS version or Android version.\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "smoz1t" {
  location {
    name = "ApiError.developerMessage"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"A message targeted at the developer using this API\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "tbvjx3" {
  location {
    name = "Activity.chapterId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The Id of the chapter. This should only be used for activities within a chapter\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "vvxgoi" {
  location {
    name = "Activity.bookId"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The Id of the book, as it is known by the book-service.\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "wz2lz0" {
  location {
    name = "Activity.appIdentifier"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"Information about the app which is providing the activity\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "xto5yh" {
  location {
    name = "AppIdentifier.appVersion"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The version of the iOS/Android app.\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "zksrtr" {
  location {
    name = "Activity.startedAt"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The date-time at which the activity started (ISO 8601).\"}"
  rest_api_id = "m3u7aza1eh"
}

resource "aws_api_gateway_documentation_part" "zmoeko" {
  location {
    name = "Activity.bookVersion"
    type = "MODEL"
  }
  properties  = "{  \"description\" : \"The version of the book\"}"
  rest_api_id = "m3u7aza1eh"
}

