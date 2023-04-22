resource "aws_api_gateway_integration_response" "m3u7aza1eh_gn08eh_POST_201" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_templates = {
    "application/json" : <<EOF
{}
    
EOF
  }
  rest_api_id = "m3u7aza1eh"
  status_code = "201"
}

resource "aws_api_gateway_integration_response" "m3u7aza1eh_gn08eh_POST_400" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_templates = {
    "application/json" : <<EOF
#set ($error = $util.parseJson($input.path('$.errorMessage')))
    {
    "status": $error.status
    #if ($error.developerMessage != $null)
    ,"developerMessage": "$error.developerMessage"
    #end
    #if $($error.error != $null)
    ,"error" : "$error.error"
    #end
    #if $($error.requestId != $null)
    ,"requestId" : "$error.requestId"
    #end
    }
    
EOF
  }
  rest_api_id       = "m3u7aza1eh"
  selection_pattern = ".*status\":400.*"
  status_code       = "400"
}

resource "aws_api_gateway_integration_response" "m3u7aza1eh_gn08eh_POST_401" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_templates = {
    "application/json" : <<EOF
#set ($error = $util.parseJson($input.path('$.errorMessage')))
    {
    "status": $error.status
    #if ($error.developerMessage != $null)
    ,"developerMessage": "$error.developerMessage"
    #end
    #if $($error.error != $null)
    ,"error" : "$error.error"
    #end
    #if $($error.requestId != $null)
    ,"requestId" : "$error.requestId"
    #end
    }
    
EOF
  }
  rest_api_id       = "m3u7aza1eh"
  selection_pattern = ".*status\":401.*"
  status_code       = "401"
}

resource "aws_api_gateway_integration_response" "m3u7aza1eh_gn08eh_POST_403" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_templates = {
    "application/json" : <<EOF
#set ($error = $util.parseJson($input.path('$.errorMessage')))
    {
    "status": $error.status
    #if ($error.developerMessage != $null)
    ,"developerMessage": "$error.developerMessage"
    #end
    #if $($error.error != $null)
    ,"error" : "$error.error"
    #end
    #if $($error.requestId != $null)
    ,"requestId" : "$error.requestId"
    #end
    }
    
EOF
  }
  rest_api_id       = "m3u7aza1eh"
  selection_pattern = ".*status\":403.*"
  status_code       = "403"
}

resource "aws_api_gateway_integration_response" "m3u7aza1eh_gn08eh_POST_500" {
  http_method = "POST"
  resource_id = "gn08eh"
  response_templates = {
    "application/json" : <<EOF
#set ($error = $util.parseJson($input.path('$.errorMessage')))
    {
    "status": $error.status
    #if ($error.developerMessage != $null)
    ,"developerMessage": "$error.developerMessage"
    #end
    #if $($error.error != $null)
    ,"error" : "$error.error"
    #end
    #if $($error.requestId != $null)
    ,"requestId" : "$error.requestId"
    #end
    }
    
EOF
  }
  rest_api_id       = "m3u7aza1eh"
  selection_pattern = ".*status\":500.*"
  status_code       = "500"
}

