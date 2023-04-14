resource "aws_cloudwatch_log_group" "API_Gateway_Execution_Logs_m3u7aza1eh_production" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "DeveloperToolsVpcFlowLogs" {
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "ProductionVPCFlowLogs" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "RDSOSMetrics" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "ThirdPartyVpcFlowLogs" {
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "_aws_OpenSearchService_domains_shared_01_application_logs" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_apigateway_welcome" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_ecs_containerinsights_production_performance" {
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_book_service_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_book_service_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_book_service_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_book_service_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_capillary_web_ui_gateway_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_capillary_web_ui_gateway_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_capillary_web_ui_gateway_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_capillary_web_ui_gateway_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_collaboration_person_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_collaboration_person_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_collaboration_person_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_collaboration_person_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_dbt_clinician_web_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_dbt_clinician_web_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_dbt_clinician_web_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_dbt_clinician_web_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_form_service_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_form_service_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_identity_service_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_identity_service_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_identity_service_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_identity_service_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_internal_services_gateway_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_internal_services_gateway_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_internal_services_gateway_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_internal_services_gateway_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_learner_web_ui_gateway_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_learner_web_ui_gateway_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_learner_web_ui_gateway_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_learner_web_ui_gateway_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_market_service_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_market_service_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_market_service_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_market_service_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_mobile_client_gateway_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_mobile_client_gateway_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_mobile_client_gateway_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_mobile_client_gateway_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_services_gateway_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_services_gateway_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_services_gateway_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_services_gateway_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_1_15_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_1_15_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_1_7_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_1_7_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_1_8_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_1_8_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_blue_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_blue_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_green_var_log_dmesg" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_elasticbeanstalk_test_web_service_green_var_log_messages" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_glue_crawlers" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_glue_jobs_error" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_glue_jobs_logs_v2" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_glue_jobs_output" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_glue_sessions_error" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_glue_sessions_output" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_kinesisfirehose_ses_email_notifications" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_identity_authorizeGatewayRequest" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_identity_saveSignInEvent" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_infrastructure_email_saveSesNotificationToKinesis" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_learning_bookExtractor_GovCloud" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_learning_createActivities" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_learning_image_encoder_function" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_learning_image_publisher" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_learning_processPdf" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_market_handleContentDownloadEvent" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_mediaPublication_checkTranscodingState" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_mediaPublication_media_metadata_update" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_mediaPublication_notifyTranscodingFailure" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_mediaPublication_notifyTranscodingSuccess" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_mediaPublication_publicationTrigger" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_mediaPublication_putPublicationItem" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_mediaPublication_startTranscoding" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_mediaPublication_updateMediaState" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_media_metadata_update_function" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_slack_pushNotifications" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_lambda_slack_sendWebServiceMessage" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_rds_instance_allogy_core_postgresql_postgresql" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_rds_instance_allogy_default_postgresql_01_postgresql" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "_aws_rds_instance_allogy_secure_postgresql_01_postgresql" {
  retention_in_days = 0
}

resource "aws_cloudwatch_log_group" "assessment_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "badge_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "book_service_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "book_service_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "book_tree_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "builder_publisher_task" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "builder_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "builder_sqs_task" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "capillary_web_ui_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "capillary_web_ui_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "chat_allogy_server" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "code_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "collaboration_person_production_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "collaboration_person_production_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "collections_space_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "content_download_analytics_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "course_certificate_pdf_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "course_content_progress_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "course_instance_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "creator_graphql_api" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "creator_settings_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "creator_user_settings_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "dbt_clinician_web_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "dbt_clinician_web_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "dbt_form_processor" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "domain_model_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "ecs_aws_xray_daemon" {
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "eureka_discovery_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "event_tracking_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "external_app_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "form_production_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "form_production_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "identity_production_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "identity_production_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "image_reference_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "image_scaling_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "instructor_graphql_api" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "internal_services_gateway_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "internal_services_gateway_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "ip_geo_location_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "learner_graphql_api" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "learner_web_ui_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "learner_web_ui_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "learning_activity_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "learning_media_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "market_production_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "market_production_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "market_search_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "market_subscription_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "media_asset_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "military_user_validator" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "mobile_client_gateway_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "mobile_client_gateway_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "notification_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "performance_assessment_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "publication_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "registration_validation_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "services_gateway_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "services_gateway_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "simple_email_manager" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "single_step_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "spring_config_server" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "survey_form_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "team_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "tenant_configuration_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "tenant_host_domain_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "tenant_user_configuration_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "test_web_service_spring" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "test_web_service_webrequests" {
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "user_data_service" {
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "xapi_service" {
  retention_in_days = 90
}

