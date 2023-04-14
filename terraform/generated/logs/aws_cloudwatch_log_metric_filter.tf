resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLErrorMetricFilter_43rpAefKnujD" {
  log_group_name = "market-production-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/market-service-green"
    value     = "1"
  }
  name    = "AWSEBCWLErrorMetricFilter-43rpAefKnujD"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLErrorMetricFilter_4NuaSx6FHZ3p" {
  log_group_name = "book-service-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/book-service-blue"
    value     = "1"
  }
  name    = "AWSEBCWLErrorMetricFilter-4NuaSx6FHZ3p"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLErrorMetricFilter_PhUeIl5XUY6Z" {
  log_group_name = "capillary-web-ui-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
    value     = "1"
  }
  name    = "AWSEBCWLErrorMetricFilter-PhUeIl5XUY6Z"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLErrorMetricFilter_TBfnSfXMnGgf" {
  log_group_name = "mobile-client-gateway-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/mobile-client-gateway-blue"
    value     = "1"
  }
  name    = "AWSEBCWLErrorMetricFilter-TBfnSfXMnGgf"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLErrorMetricFilter_rdkQySic1jBi" {
  log_group_name = "capillary-web-ui-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-green"
    value     = "1"
  }
  name    = "AWSEBCWLErrorMetricFilter-rdkQySic1jBi"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp4xxMetricFilter_T5mvihQ0iDKn" {
  log_group_name = "mobile-client-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/mobile-client-gateway-blue"
    value     = "1"
  }
  name    = "AWSEBCWLHttp4xxMetricFilter-T5mvihQ0iDKn"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp4xxMetricFilter_UzGRtRCKRi3L" {
  log_group_name = "capillary-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-green"
    value     = "1"
  }
  name    = "AWSEBCWLHttp4xxMetricFilter-UzGRtRCKRi3L"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp4xxMetricFilter_cwm4uEGH2oD1" {
  log_group_name = "book-service-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/book-service-blue"
    value     = "1"
  }
  name    = "AWSEBCWLHttp4xxMetricFilter-cwm4uEGH2oD1"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp4xxMetricFilter_dD1OIbjgkE6m" {
  log_group_name = "market-production-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/market-service-green"
    value     = "1"
  }
  name    = "AWSEBCWLHttp4xxMetricFilter-dD1OIbjgkE6m"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp4xxMetricFilter_zKArt4iru2GW" {
  log_group_name = "capillary-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
    value     = "1"
  }
  name    = "AWSEBCWLHttp4xxMetricFilter-zKArt4iru2GW"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp5xxMetricFilter_DPQOHOSTsOxf" {
  log_group_name = "market-production-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/market-service-green"
    value     = "1"
  }
  name    = "AWSEBCWLHttp5xxMetricFilter-DPQOHOSTsOxf"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp5xxMetricFilter_QVnfk45KQMcp" {
  log_group_name = "capillary-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
    value     = "1"
  }
  name    = "AWSEBCWLHttp5xxMetricFilter-QVnfk45KQMcp"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp5xxMetricFilter_dSlic4j85G17" {
  log_group_name = "capillary-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-green"
    value     = "1"
  }
  name    = "AWSEBCWLHttp5xxMetricFilter-dSlic4j85G17"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp5xxMetricFilter_n19nDjjwY4Wq" {
  log_group_name = "mobile-client-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/mobile-client-gateway-blue"
    value     = "1"
  }
  name    = "AWSEBCWLHttp5xxMetricFilter-n19nDjjwY4Wq"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttp5xxMetricFilter_w3mgHeL7B6nc" {
  log_group_name = "book-service-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/book-service-blue"
    value     = "1"
  }
  name    = "AWSEBCWLHttp5xxMetricFilter-w3mgHeL7B6nc"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon4xxMetricFilter_4mHcIQYBIaF7" {
  log_group_name = "market-production-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/market-service-green"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon4xxMetricFilter-4mHcIQYBIaF7"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon4xxMetricFilter_WeTk7jCMrvoM" {
  log_group_name = "capillary-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon4xxMetricFilter-WeTk7jCMrvoM"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon4xxMetricFilter_kRavSX9K2wpx" {
  log_group_name = "mobile-client-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/mobile-client-gateway-blue"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon4xxMetricFilter-kRavSX9K2wpx"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon4xxMetricFilter_oWu3k3w06LUv" {
  log_group_name = "book-service-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/book-service-blue"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon4xxMetricFilter-oWu3k3w06LUv"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon4xxMetricFilter_sidFMi47449l" {
  log_group_name = "capillary-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-green"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon4xxMetricFilter-sidFMi47449l"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon5xxMetricFilter_K2Pz0aMNNEn6" {
  log_group_name = "book-service-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/book-service-blue"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon5xxMetricFilter-K2Pz0aMNNEn6"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon5xxMetricFilter_OZdbzWervXHT" {
  log_group_name = "market-production-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/market-service-green"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon5xxMetricFilter-OZdbzWervXHT"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon5xxMetricFilter_Ow3hfNqTd52w" {
  log_group_name = "mobile-client-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/mobile-client-gateway-blue"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon5xxMetricFilter-Ow3hfNqTd52w"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon5xxMetricFilter_dzdArjRLtQvX" {
  log_group_name = "capillary-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-green"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon5xxMetricFilter-dzdArjRLtQvX"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLHttpNon5xxMetricFilter_yOQlVABUwwRV" {
  log_group_name = "capillary-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
    value     = "0"
  }
  name    = "AWSEBCWLHttpNon5xxMetricFilter-yOQlVABUwwRV"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLServiceNonErrorMetricFilter_DPGuCTweX125" {
  log_group_name = "market-production-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/market-service-green"
    value     = "0"
  }
  name    = "AWSEBCWLServiceNonErrorMetricFilter-DPGuCTweX125"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLServiceNonErrorMetricFilter_NyJSKwx4y6oa" {
  log_group_name = "capillary-web-ui-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
    value     = "0"
  }
  name    = "AWSEBCWLServiceNonErrorMetricFilter-NyJSKwx4y6oa"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLServiceNonErrorMetricFilter_Z545el3otHbh" {
  log_group_name = "mobile-client-gateway-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/mobile-client-gateway-blue"
    value     = "0"
  }
  name    = "AWSEBCWLServiceNonErrorMetricFilter-Z545el3otHbh"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLServiceNonErrorMetricFilter_sNEZCD40H0mc" {
  log_group_name = "capillary-web-ui-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/capillary-web-ui-gateway-green"
    value     = "0"
  }
  name    = "AWSEBCWLServiceNonErrorMetricFilter-sNEZCD40H0mc"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "AWSEBCWLServiceNonErrorMetricFilter_uWBa5At50FOm" {
  log_group_name = "book-service-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/book-service-blue"
    value     = "0"
  }
  name    = "AWSEBCWLServiceNonErrorMetricFilter-uWBa5At50FOm"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "ServiceError_Error" {
  log_group_name = "assessment-service"
  metric_transformation {
    name      = "ServiceError"
    namespace = "ECSService/assessment-service"
    value     = "1"
  }
  name    = "ServiceError-Error"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "ServiceError_NotError" {
  log_group_name = "assessment-service"
  metric_transformation {
    name      = "ServiceError"
    namespace = "ECSService/assessment-service"
    value     = "0"
  }
  name    = "ServiceError-NotError"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "ServiceWarning_NotWarning" {
  log_group_name = "assessment-service"
  metric_transformation {
    name      = "ServiceWarning"
    namespace = "ECSService/assessment-service"
    value     = "0"
  }
  name    = "ServiceWarning-NotWarning"
  pattern = "[date, time, level!=WARN, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "ServiceWarning_Warning" {
  log_group_name = "assessment-service"
  metric_transformation {
    name      = "ServiceWarning"
    namespace = "ECSService/assessment-service"
    value     = "1"
  }
  name    = "ServiceWarning-Warning"
  pattern = "[date, time, level=WARN, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_32xzmdus8p_stack_AWSEBCWLErrorMetricFilter_JX0M4OLT1SP6" {
  log_group_name = "services-gateway-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/services-gateway-blue"
    value     = "1"
  }
  name    = "awseb-e-32xzmdus8p-stack-AWSEBCWLErrorMetricFilter-JX0M4OLT1SP6"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_32xzmdus8p_stack_AWSEBCWLHttp4xxMetricFilter_EBS0JG9XATWE" {
  log_group_name = "services-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/services-gateway-blue"
    value     = "1"
  }
  name    = "awseb-e-32xzmdus8p-stack-AWSEBCWLHttp4xxMetricFilter-EBS0JG9XATWE"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_32xzmdus8p_stack_AWSEBCWLHttp5xxMetricFilter_1V6DWGU8MO4QO" {
  log_group_name = "services-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/services-gateway-blue"
    value     = "1"
  }
  name    = "awseb-e-32xzmdus8p-stack-AWSEBCWLHttp5xxMetricFilter-1V6DWGU8MO4QO"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_32xzmdus8p_stack_AWSEBCWLHttpNon4xxMetricFilter_1KS5CWW1I89IH" {
  log_group_name = "services-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/services-gateway-blue"
    value     = "0"
  }
  name    = "awseb-e-32xzmdus8p-stack-AWSEBCWLHttpNon4xxMetricFilter-1KS5CWW1I89IH"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_32xzmdus8p_stack_AWSEBCWLHttpNon5xxMetricFilter_1343BAZAG2WPG" {
  log_group_name = "services-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/services-gateway-blue"
    value     = "0"
  }
  name    = "awseb-e-32xzmdus8p-stack-AWSEBCWLHttpNon5xxMetricFilter-1343BAZAG2WPG"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_32xzmdus8p_stack_AWSEBCWLServiceNonErrorMetricFilter_1LJ21G7X0MG7O" {
  log_group_name = "services-gateway-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/services-gateway-blue"
    value     = "0"
  }
  name    = "awseb-e-32xzmdus8p-stack-AWSEBCWLServiceNonErrorMetricFilter-1LJ21G7X0MG7O"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_3evreti3za_stack_AWSEBCWLErrorMetricFilter_F9O1WKA5ZC2Z" {
  log_group_name = "collaboration-person-production-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/collaboration-person-blue"
    value     = "1"
  }
  name    = "awseb-e-3evreti3za-stack-AWSEBCWLErrorMetricFilter-F9O1WKA5ZC2Z"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_3evreti3za_stack_AWSEBCWLHttp4xxMetricFilter_9W192HBWCQJV" {
  log_group_name = "collaboration-person-production-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/collaboration-person-blue"
    value     = "1"
  }
  name    = "awseb-e-3evreti3za-stack-AWSEBCWLHttp4xxMetricFilter-9W192HBWCQJV"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_3evreti3za_stack_AWSEBCWLHttp5xxMetricFilter_1FIUPP8F5G9EJ" {
  log_group_name = "collaboration-person-production-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/collaboration-person-blue"
    value     = "1"
  }
  name    = "awseb-e-3evreti3za-stack-AWSEBCWLHttp5xxMetricFilter-1FIUPP8F5G9EJ"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_3evreti3za_stack_AWSEBCWLHttpNon4xxMetricFilter_4TPZI85B3B9D" {
  log_group_name = "collaboration-person-production-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/collaboration-person-blue"
    value     = "0"
  }
  name    = "awseb-e-3evreti3za-stack-AWSEBCWLHttpNon4xxMetricFilter-4TPZI85B3B9D"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_3evreti3za_stack_AWSEBCWLHttpNon5xxMetricFilter_19QEWB5XE8MMB" {
  log_group_name = "collaboration-person-production-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/collaboration-person-blue"
    value     = "0"
  }
  name    = "awseb-e-3evreti3za-stack-AWSEBCWLHttpNon5xxMetricFilter-19QEWB5XE8MMB"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_3evreti3za_stack_AWSEBCWLServiceNonErrorMetricFilter_1PNPQJY0XK5ND" {
  log_group_name = "collaboration-person-production-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/collaboration-person-blue"
    value     = "0"
  }
  name    = "awseb-e-3evreti3za-stack-AWSEBCWLServiceNonErrorMetricFilter-1PNPQJY0XK5ND"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_59p3bpnwec_stack_AWSEBCWLErrorMetricFilter_1NYKZMW6XP1MU" {
  log_group_name = "learner-web-ui-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-blue"
    value     = "1"
  }
  name    = "awseb-e-59p3bpnwec-stack-AWSEBCWLErrorMetricFilter-1NYKZMW6XP1MU"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_59p3bpnwec_stack_AWSEBCWLHttp4xxMetricFilter_18ROOOAPXSNVL" {
  log_group_name = "learner-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-blue"
    value     = "1"
  }
  name    = "awseb-e-59p3bpnwec-stack-AWSEBCWLHttp4xxMetricFilter-18ROOOAPXSNVL"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_59p3bpnwec_stack_AWSEBCWLHttp5xxMetricFilter_1CFA5EJYHSVN8" {
  log_group_name = "learner-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-blue"
    value     = "1"
  }
  name    = "awseb-e-59p3bpnwec-stack-AWSEBCWLHttp5xxMetricFilter-1CFA5EJYHSVN8"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_59p3bpnwec_stack_AWSEBCWLHttpNon4xxMetricFilter_UBAO3CB7HNFP" {
  log_group_name = "learner-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-blue"
    value     = "0"
  }
  name    = "awseb-e-59p3bpnwec-stack-AWSEBCWLHttpNon4xxMetricFilter-UBAO3CB7HNFP"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_59p3bpnwec_stack_AWSEBCWLHttpNon5xxMetricFilter_SIF83ZT1AU0S" {
  log_group_name = "learner-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-blue"
    value     = "0"
  }
  name    = "awseb-e-59p3bpnwec-stack-AWSEBCWLHttpNon5xxMetricFilter-SIF83ZT1AU0S"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_59p3bpnwec_stack_AWSEBCWLServiceNonErrorMetricFilter_JJPB451FBHHQ" {
  log_group_name = "learner-web-ui-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-blue"
    value     = "0"
  }
  name    = "awseb-e-59p3bpnwec-stack-AWSEBCWLServiceNonErrorMetricFilter-JJPB451FBHHQ"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_bmqqxwyjst_stack_AWSEBCWLErrorMetricFilter_EQ59DLZB6ERX" {
  log_group_name = "form-production-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/form-service-blue"
    value     = "1"
  }
  name    = "awseb-e-bmqqxwyjst-stack-AWSEBCWLErrorMetricFilter-EQ59DLZB6ERX"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_bmqqxwyjst_stack_AWSEBCWLHttp4xxMetricFilter_1U4BPKMZGT9S0" {
  log_group_name = "form-production-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/form-service-blue"
    value     = "1"
  }
  name    = "awseb-e-bmqqxwyjst-stack-AWSEBCWLHttp4xxMetricFilter-1U4BPKMZGT9S0"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_bmqqxwyjst_stack_AWSEBCWLHttp5xxMetricFilter_J1F9EGG20D4Q" {
  log_group_name = "form-production-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/form-service-blue"
    value     = "1"
  }
  name    = "awseb-e-bmqqxwyjst-stack-AWSEBCWLHttp5xxMetricFilter-J1F9EGG20D4Q"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_bmqqxwyjst_stack_AWSEBCWLHttpNon4xxMetricFilter_1R7VZGWMR2MW1" {
  log_group_name = "form-production-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/form-service-blue"
    value     = "0"
  }
  name    = "awseb-e-bmqqxwyjst-stack-AWSEBCWLHttpNon4xxMetricFilter-1R7VZGWMR2MW1"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_bmqqxwyjst_stack_AWSEBCWLHttpNon5xxMetricFilter_S5GSYP323HBG" {
  log_group_name = "form-production-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/form-service-blue"
    value     = "0"
  }
  name    = "awseb-e-bmqqxwyjst-stack-AWSEBCWLHttpNon5xxMetricFilter-S5GSYP323HBG"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_bmqqxwyjst_stack_AWSEBCWLServiceNonErrorMetricFilter_KJMFUM7J366V" {
  log_group_name = "form-production-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/form-service-blue"
    value     = "0"
  }
  name    = "awseb-e-bmqqxwyjst-stack-AWSEBCWLServiceNonErrorMetricFilter-KJMFUM7J366V"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_jgrjparfpf_stack_AWSEBCWLErrorMetricFilter_1RPS6HQI23V0T" {
  log_group_name = "dbt-clinician-web-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/dbt-clinician-web-green"
    value     = "1"
  }
  name    = "awseb-e-jgrjparfpf-stack-AWSEBCWLErrorMetricFilter-1RPS6HQI23V0T"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_jgrjparfpf_stack_AWSEBCWLHttp4xxMetricFilter_1D699D6RVO8A3" {
  log_group_name = "dbt-clinician-web-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/dbt-clinician-web-green"
    value     = "1"
  }
  name    = "awseb-e-jgrjparfpf-stack-AWSEBCWLHttp4xxMetricFilter-1D699D6RVO8A3"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_jgrjparfpf_stack_AWSEBCWLHttp5xxMetricFilter_CESOZ6RB3FCY" {
  log_group_name = "dbt-clinician-web-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/dbt-clinician-web-green"
    value     = "1"
  }
  name    = "awseb-e-jgrjparfpf-stack-AWSEBCWLHttp5xxMetricFilter-CESOZ6RB3FCY"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_jgrjparfpf_stack_AWSEBCWLHttpNon4xxMetricFilter_1BIQZR3C34W3U" {
  log_group_name = "dbt-clinician-web-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/dbt-clinician-web-green"
    value     = "0"
  }
  name    = "awseb-e-jgrjparfpf-stack-AWSEBCWLHttpNon4xxMetricFilter-1BIQZR3C34W3U"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_jgrjparfpf_stack_AWSEBCWLHttpNon5xxMetricFilter_GUVSZUH67BUJ" {
  log_group_name = "dbt-clinician-web-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/dbt-clinician-web-green"
    value     = "0"
  }
  name    = "awseb-e-jgrjparfpf-stack-AWSEBCWLHttpNon5xxMetricFilter-GUVSZUH67BUJ"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_jgrjparfpf_stack_AWSEBCWLServiceNonErrorMetricFilter_T2846FYKU8DE" {
  log_group_name = "dbt-clinician-web-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/dbt-clinician-web-green"
    value     = "0"
  }
  name    = "awseb-e-jgrjparfpf-stack-AWSEBCWLServiceNonErrorMetricFilter-T2846FYKU8DE"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_rwv222b3qp_stack_AWSEBCWLErrorMetricFilter_ZFXC9NQ6WB7E" {
  log_group_name = "learner-web-ui-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-green"
    value     = "1"
  }
  name    = "awseb-e-rwv222b3qp-stack-AWSEBCWLErrorMetricFilter-ZFXC9NQ6WB7E"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_rwv222b3qp_stack_AWSEBCWLHttp4xxMetricFilter_YHB2XG4N0ELI" {
  log_group_name = "learner-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-green"
    value     = "1"
  }
  name    = "awseb-e-rwv222b3qp-stack-AWSEBCWLHttp4xxMetricFilter-YHB2XG4N0ELI"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_rwv222b3qp_stack_AWSEBCWLHttp5xxMetricFilter_1LM5QOW63WBEJ" {
  log_group_name = "learner-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-green"
    value     = "1"
  }
  name    = "awseb-e-rwv222b3qp-stack-AWSEBCWLHttp5xxMetricFilter-1LM5QOW63WBEJ"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_rwv222b3qp_stack_AWSEBCWLHttpNon4xxMetricFilter_VMNDJP0BZQ1M" {
  log_group_name = "learner-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-green"
    value     = "0"
  }
  name    = "awseb-e-rwv222b3qp-stack-AWSEBCWLHttpNon4xxMetricFilter-VMNDJP0BZQ1M"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_rwv222b3qp_stack_AWSEBCWLHttpNon5xxMetricFilter_1GO2M9CUDJIE6" {
  log_group_name = "learner-web-ui-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-green"
    value     = "0"
  }
  name    = "awseb-e-rwv222b3qp-stack-AWSEBCWLHttpNon5xxMetricFilter-1GO2M9CUDJIE6"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_rwv222b3qp_stack_AWSEBCWLServiceNonErrorMetricFilter_OC6AYYMGMF9N" {
  log_group_name = "learner-web-ui-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/learner-web-ui-gateway-green"
    value     = "0"
  }
  name    = "awseb-e-rwv222b3qp-stack-AWSEBCWLServiceNonErrorMetricFilter-OC6AYYMGMF9N"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_udanqbam3f_stack_AWSEBCWLErrorMetricFilter_1GWIVI0UU1FMP" {
  log_group_name = "identity-production-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/identity-service-blue"
    value     = "1"
  }
  name    = "awseb-e-udanqbam3f-stack-AWSEBCWLErrorMetricFilter-1GWIVI0UU1FMP"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_udanqbam3f_stack_AWSEBCWLHttp4xxMetricFilter_79VJ3467HT89" {
  log_group_name = "identity-production-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/identity-service-blue"
    value     = "1"
  }
  name    = "awseb-e-udanqbam3f-stack-AWSEBCWLHttp4xxMetricFilter-79VJ3467HT89"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_udanqbam3f_stack_AWSEBCWLHttp5xxMetricFilter_1VG6368M5C7ZA" {
  log_group_name = "identity-production-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/identity-service-blue"
    value     = "1"
  }
  name    = "awseb-e-udanqbam3f-stack-AWSEBCWLHttp5xxMetricFilter-1VG6368M5C7ZA"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_udanqbam3f_stack_AWSEBCWLHttpNon4xxMetricFilter_1OQEC7KH7FDI6" {
  log_group_name = "identity-production-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/identity-service-blue"
    value     = "0"
  }
  name    = "awseb-e-udanqbam3f-stack-AWSEBCWLHttpNon4xxMetricFilter-1OQEC7KH7FDI6"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_udanqbam3f_stack_AWSEBCWLHttpNon5xxMetricFilter_M8IKJYJXSPGL" {
  log_group_name = "identity-production-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/identity-service-blue"
    value     = "0"
  }
  name    = "awseb-e-udanqbam3f-stack-AWSEBCWLHttpNon5xxMetricFilter-M8IKJYJXSPGL"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_udanqbam3f_stack_AWSEBCWLServiceNonErrorMetricFilter_1QFEC1BS3D65R" {
  log_group_name = "identity-production-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/identity-service-blue"
    value     = "0"
  }
  name    = "awseb-e-udanqbam3f-stack-AWSEBCWLServiceNonErrorMetricFilter-1QFEC1BS3D65R"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_xmec4epg3c_stack_AWSEBCWLErrorMetricFilter_1WUYQXT4RGXQY" {
  log_group_name = "book-service-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/book-service-green"
    value     = "1"
  }
  name    = "awseb-e-xmec4epg3c-stack-AWSEBCWLErrorMetricFilter-1WUYQXT4RGXQY"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_xmec4epg3c_stack_AWSEBCWLHttp4xxMetricFilter_1VLCUIZC9V6G4" {
  log_group_name = "book-service-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/book-service-green"
    value     = "1"
  }
  name    = "awseb-e-xmec4epg3c-stack-AWSEBCWLHttp4xxMetricFilter-1VLCUIZC9V6G4"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_xmec4epg3c_stack_AWSEBCWLHttp5xxMetricFilter_3PU0MPW3TVW6" {
  log_group_name = "book-service-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/book-service-green"
    value     = "1"
  }
  name    = "awseb-e-xmec4epg3c-stack-AWSEBCWLHttp5xxMetricFilter-3PU0MPW3TVW6"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_xmec4epg3c_stack_AWSEBCWLHttpNon4xxMetricFilter_1V5V82GNS420W" {
  log_group_name = "book-service-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/book-service-green"
    value     = "0"
  }
  name    = "awseb-e-xmec4epg3c-stack-AWSEBCWLHttpNon4xxMetricFilter-1V5V82GNS420W"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_xmec4epg3c_stack_AWSEBCWLHttpNon5xxMetricFilter_14SLSXXX8NFHO" {
  log_group_name = "book-service-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/book-service-green"
    value     = "0"
  }
  name    = "awseb-e-xmec4epg3c-stack-AWSEBCWLHttpNon5xxMetricFilter-14SLSXXX8NFHO"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_xmec4epg3c_stack_AWSEBCWLServiceNonErrorMetricFilter_CPS6DT57N408" {
  log_group_name = "book-service-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/book-service-green"
    value     = "0"
  }
  name    = "awseb-e-xmec4epg3c-stack-AWSEBCWLServiceNonErrorMetricFilter-CPS6DT57N408"
  pattern = "[date, time, level!=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLErrorMetricFilter_N1EQ1YASFPD8" {
  log_group_name = "internal-services-gateway-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/internal-services-gateway-green"
    value     = "1"
  }
  name    = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLErrorMetricFilter-N1EQ1YASFPD8"
  pattern = "[date, time, level=ERROR, ...]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLHttp4xxMetricFilter_MOWB3JUF2YRO" {
  log_group_name = "internal-services-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/internal-services-gateway-green"
    value     = "1"
  }
  name    = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLHttp4xxMetricFilter-MOWB3JUF2YRO"
  pattern = "[..., status=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLHttp5xxMetricFilter_19W7YD82NSU84" {
  log_group_name = "internal-services-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/internal-services-gateway-green"
    value     = "1"
  }
  name    = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLHttp5xxMetricFilter-19W7YD82NSU84"
  pattern = "[..., status=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLHttpNon4xxMetricFilter_3TOCKNG36MXN" {
  log_group_name = "internal-services-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp4xx"
    namespace = "ElasticBeanstalk/internal-services-gateway-green"
    value     = "0"
  }
  name    = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLHttpNon4xxMetricFilter-3TOCKNG36MXN"
  pattern = "[..., status!=4*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLHttpNon5xxMetricFilter_Z4DUGTGCVU1N" {
  log_group_name = "internal-services-gateway-webrequests"
  metric_transformation {
    name      = "CWLHttp5xx"
    namespace = "ElasticBeanstalk/internal-services-gateway-green"
    value     = "0"
  }
  name    = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLHttpNon5xxMetricFilter-Z4DUGTGCVU1N"
  pattern = "[..., status!=5*, size, trace, referer, agent]"
}

resource "aws_cloudwatch_log_metric_filter" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLServiceNonErrorMetricFilter_XBVXDZPMDA5G" {
  log_group_name = "internal-services-gateway-spring"
  metric_transformation {
    name      = "CWLServiceError"
    namespace = "ElasticBeanstalk/internal-services-gateway-green"
    value     = "0"
  }
  name    = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLServiceNonErrorMetricFilter-XBVXDZPMDA5G"
  pattern = "[date, time, level!=ERROR, ...]"
}

