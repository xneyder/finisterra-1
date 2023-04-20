resource "aws_iam_role_policy_attachment" "AWSGlueServiceRole_CrawlerGOVCloud_policy_service_role_AWSGlueServiceRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSGlueServiceRole"
  role       = "AWSGlueServiceRole-CrawlerGOVCloud"
}

resource "aws_iam_role_policy_attachment" "AWSGlueServiceRole_CrawlerGOVCloud_policy_service_role_AWSGlueServiceRole_CrawlerGOVCloud" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/service-role/AWSGlueServiceRole-CrawlerGOVCloud"
  role       = "AWSGlueServiceRole-CrawlerGOVCloud"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_AdministratorAccess_ba963073b9e50b41_policy_AdministratorAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AdministratorAccess"
  role       = "AWSReservedSSO_AdministratorAccess_ba963073b9e50b41"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3_policy_AWSCloudMapReadOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSCloudMapReadOnlyAccess"
  role       = "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3_policy_ReadOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/ReadOnlyAccess"
  role       = "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3_policy_SecurityAudit" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/SecurityAudit"
  role       = "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3_policy_job_function_ViewOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/job-function/ViewOnlyAccess"
  role       = "AWSReservedSSO_DevOpsConsultant_e1d91335052207a3"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_PowerUser_4840ab8c0aa8c0f7_policy_PowerUserAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/PowerUserAccess"
  role       = "AWSReservedSSO_PowerUser_4840ab8c0aa8c0f7"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_PowerUser_4840ab8c0aa8c0f7_policy_job_function_ViewOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/job-function/ViewOnlyAccess"
  role       = "AWSReservedSSO_PowerUser_4840ab8c0aa8c0f7"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_SecurityAuditor_e2e2445e379226e2_policy_SecurityAudit" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/SecurityAudit"
  role       = "AWSReservedSSO_SecurityAuditor_e2e2445e379226e2"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_SecurityAuditor_e2e2445e379226e2_policy_job_function_ViewOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/job-function/ViewOnlyAccess"
  role       = "AWSReservedSSO_SecurityAuditor_e2e2445e379226e2"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6_policy_AWSSupportAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSSupportAccess"
  role       = "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6_policy_CloudWatchLogsReadOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/CloudWatchLogsReadOnlyAccess"
  role       = "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6_policy_ReadOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/ReadOnlyAccess"
  role       = "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6_policy_job_function_ViewOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/job-function/ViewOnlyAccess"
  role       = "AWSReservedSSO_ServerDeveloper_bb91c899fbe6b7a6"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_SystemAdministrator_62d762355983f553_policy_job_function_SystemAdministrator" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/job-function/SystemAdministrator"
  role       = "AWSReservedSSO_SystemAdministrator_62d762355983f553"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAPIGateway_policy_aws_service_role_APIGatewayServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/APIGatewayServiceRolePolicy"
  role       = "AWSServiceRoleForAPIGateway"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAmazonElasticsearchService_policy_aws_service_role_AmazonElasticsearchServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AmazonElasticsearchServiceRolePolicy"
  role       = "AWSServiceRoleForAmazonElasticsearchService"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAmazonGuardDuty_policy_aws_service_role_AmazonGuardDutyServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AmazonGuardDutyServiceRolePolicy"
  role       = "AWSServiceRoleForAmazonGuardDuty"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAmazonSSM_policy_aws_service_role_AmazonSSMServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AmazonSSMServiceRolePolicy"
  role       = "AWSServiceRoleForAmazonSSM"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable_policy_aws_service_role_AWSApplicationAutoscalingDynamoDBTablePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSApplicationAutoscalingDynamoDBTablePolicy"
  role       = "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForApplicationAutoScaling_ECSService_policy_aws_service_role_AWSApplicationAutoscalingECSServicePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSApplicationAutoscalingECSServicePolicy"
  role       = "AWSServiceRoleForApplicationAutoScaling_ECSService"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAutoScaling_policy_aws_service_role_AutoScalingServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AutoScalingServiceRolePolicy"
  role       = "AWSServiceRoleForAutoScaling"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForCloudTrail_policy_aws_service_role_CloudTrailServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/CloudTrailServiceRolePolicy"
  role       = "AWSServiceRoleForCloudTrail"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForConfig_policy_aws_service_role_AWSConfigServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSConfigServiceRolePolicy"
  role       = "AWSServiceRoleForConfig"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForECS_policy_aws_service_role_AmazonECSServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AmazonECSServiceRolePolicy"
  role       = "AWSServiceRoleForECS"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForElastiCache_policy_aws_service_role_ElastiCacheServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/ElastiCacheServiceRolePolicy"
  role       = "AWSServiceRoleForElastiCache"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForElasticBeanstalk_policy_aws_service_role_AWSElasticBeanstalkServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSElasticBeanstalkServiceRolePolicy"
  role       = "AWSServiceRoleForElasticBeanstalk"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForElasticLoadBalancing_policy_aws_service_role_AWSElasticLoadBalancingServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSElasticLoadBalancingServiceRolePolicy"
  role       = "AWSServiceRoleForElasticLoadBalancing"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForOrganizations_policy_aws_service_role_AWSOrganizationsServiceTrustPolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSOrganizationsServiceTrustPolicy"
  role       = "AWSServiceRoleForOrganizations"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForRDS_policy_aws_service_role_AmazonRDSServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AmazonRDSServiceRolePolicy"
  role       = "AWSServiceRoleForRDS"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForSSO_policy_aws_service_role_AWSSSOServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSSSOServiceRolePolicy"
  role       = "AWSServiceRoleForSSO"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForSecurityHub_policy_aws_service_role_AWSSecurityHubServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSSecurityHubServiceRolePolicy"
  role       = "AWSServiceRoleForSecurityHub"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForServiceQuotas_policy_aws_service_role_ServiceQuotasServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/ServiceQuotasServiceRolePolicy"
  role       = "AWSServiceRoleForServiceQuotas"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForSupport_policy_aws_service_role_AWSSupportServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSSupportServiceRolePolicy"
  role       = "AWSServiceRoleForSupport"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForTrustedAdvisor_policy_aws_service_role_AWSTrustedAdvisorServiceRolePolicy" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/aws-service-role/AWSTrustedAdvisorServiceRolePolicy"
  role       = "AWSServiceRoleForTrustedAdvisor"
}

resource "aws_iam_role_policy_attachment" "BastionServer_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "BastionServer"
}

resource "aws_iam_role_policy_attachment" "BastionServer_policy_service_role_AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = "BastionServer"
}

resource "aws_iam_role_policy_attachment" "DeveloperTools_S3Proxy_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "DeveloperTools-S3Proxy"
}

resource "aws_iam_role_policy_attachment" "DynamoDBAutoscaleRole_policy_DynamoDBAutoscalePolicy" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/DynamoDBAutoscalePolicy"
  role       = "DynamoDBAutoscaleRole"
}

resource "aws_iam_role_policy_attachment" "FlowLogger_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "FlowLogger"
}

resource "aws_iam_role_policy_attachment" "JavaDockerServerDeveloper_policy_ECRServerDeveloper" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ECRServerDeveloper"
  role       = "JavaDockerServerDeveloper"
}

resource "aws_iam_role_policy_attachment" "JavaDockerServerDeveloper_policy_ECSFullReadAccess" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ECSFullReadAccess"
  role       = "JavaDockerServerDeveloper"
}

resource "aws_iam_role_policy_attachment" "JavaDockerServerDeveloper_policy_ECSTaskDefinitionFullAccess" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ECSTaskDefinitionFullAccess"
  role       = "JavaDockerServerDeveloper"
}

resource "aws_iam_role_policy_attachment" "JenkinsMaster_policy_service_role_AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = "JenkinsMaster"
}

resource "aws_iam_role_policy_attachment" "JenkinsRubySlave_policy_ECRDeployer" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ECRDeployer"
  role       = "JenkinsRubySlave"
}

resource "aws_iam_role_policy_attachment" "LearningMediaMetadataUpdateRole_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "LearningMediaMetadataUpdateRole"
}

resource "aws_iam_role_policy_attachment" "MediaStepsLambdaRole_policy_AmazonS3ReadOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = "MediaStepsLambdaRole"
}

resource "aws_iam_role_policy_attachment" "MediaStepsLambdaRole_policy_AmazonSNSReadOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSNSReadOnlyAccess"
  role       = "MediaStepsLambdaRole"
}

resource "aws_iam_role_policy_attachment" "MediaStepsLambdaRole_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "MediaStepsLambdaRole"
}

resource "aws_iam_role_policy_attachment" "SessionManagerMinimum_policy_SessionManagerMinimum" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/SessionManagerMinimum"
  role       = "SessionManagerMinimum"
}

resource "aws_iam_role_policy_attachment" "StatesExecutionRole_policy_service_role_AWSLambdaRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSLambdaRole"
  role       = "StatesExecutionRole"
}

resource "aws_iam_role_policy_attachment" "allogy_rds_restore_policy_AmazonS3FullAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonS3FullAccess"
  role       = "allogy_rds_restore"
}

resource "aws_iam_role_policy_attachment" "allogy_rds_restore_policy_allogy_dms_policy" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/allogy-dms-policy"
  role       = "allogy_rds_restore"
}

resource "aws_iam_role_policy_attachment" "aws_api_gateway_role_policy_service_role_AmazonAPIGatewayPushToCloudWatchLogs" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = "aws-api-gateway-role"
}

resource "aws_iam_role_policy_attachment" "aws_elasticbeanstalk_service_role_policy_AWSElasticBeanstalkWebTier" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSElasticBeanstalkWebTier"
  role       = "aws-elasticbeanstalk-service-role"
}

resource "aws_iam_role_policy_attachment" "aws_elasticbeanstalk_service_role_policy_service_role_AWSElasticBeanstalkEnhancedHealth" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
  role       = "aws-elasticbeanstalk-service-role"
}

resource "aws_iam_role_policy_attachment" "aws_elasticbeanstalk_service_role_policy_service_role_AWSElasticBeanstalkService" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSElasticBeanstalkService"
  role       = "aws-elasticbeanstalk-service-role"
}

resource "aws_iam_role_policy_attachment" "dms_cloudwatch_logs_role_policy_service_role_AmazonDMSCloudWatchLogsRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
  role       = "dms-cloudwatch-logs-role"
}

resource "aws_iam_role_policy_attachment" "dms_vpc_role_policy_service_role_AmazonDMSVPCManagementRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
  role       = "dms-vpc-role"
}

resource "aws_iam_role_policy_attachment" "ecsAutoscaleRole_policy_service_role_AmazonEC2ContainerServiceAutoscaleRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
  role       = "ecsAutoscaleRole"
}

resource "aws_iam_role_policy_attachment" "ecsInstanceRole_policy_AWSXrayWriteOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSXrayWriteOnlyAccess"
  role       = "ecsInstanceRole"
}

resource "aws_iam_role_policy_attachment" "ecsInstanceRole_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "ecsInstanceRole"
}

resource "aws_iam_role_policy_attachment" "ecsInstanceRole_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "ecsInstanceRole"
}

resource "aws_iam_role_policy_attachment" "ecsInstanceRole_policy_service_role_AmazonEC2ContainerServiceforEC2Role" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role       = "ecsInstanceRole"
}

resource "aws_iam_role_policy_attachment" "ecsInstanceRole_policy_service_role_AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = "ecsInstanceRole"
}

resource "aws_iam_role_policy_attachment" "ecsServiceRole_policy_service_role_AmazonEC2ContainerServiceRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  role       = "ecsServiceRole"
}

resource "aws_iam_role_policy_attachment" "infrastructure_ecsMetricCollector_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "infrastructure-ecsMetricCollector"
}

resource "aws_iam_role_policy_attachment" "infrastructure_ecsMetricCollector_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "infrastructure-ecsMetricCollector"
}

resource "aws_iam_role_policy_attachment" "infrastructure_eureka_discovery_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "infrastructure-eureka-discovery-service"
}

resource "aws_iam_role_policy_attachment" "infrastructure_eureka_discovery_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "infrastructure-eureka-discovery-service"
}

resource "aws_iam_role_policy_attachment" "internal_services_gateway_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "internal-services-gateway"
}

resource "aws_iam_role_policy_attachment" "internal_services_gateway_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "internal-services-gateway"
}

resource "aws_iam_role_policy_attachment" "internal_services_gateway_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "internal-services-gateway"
}

resource "aws_iam_role_policy_attachment" "internal_services_gateway_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "internal-services-gateway"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "lambda-basic"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "lambda-basic"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_policy_service_role_AWSLambdaTracerAccessExecutionRole_5581a3b0_4107_4af2_97db_c9db00661e1f" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/service-role/AWSLambdaTracerAccessExecutionRole-5581a3b0-4107-4af2-97db-c9db00661e1f"
  role       = "lambda-basic"
}

resource "aws_iam_role_policy_attachment" "lambda_identity_sign_in_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "lambda-identity-sign-in"
}

resource "aws_iam_role_policy_attachment" "lambda_identity_sign_in_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "lambda-identity-sign-in"
}

resource "aws_iam_role_policy_attachment" "lambda_identity_sign_in_policy_service_role_AWSLambdaVPCAccessExecutionRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  role       = "lambda-identity-sign-in"
}

resource "aws_iam_role_policy_attachment" "lambda_learning_activity_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "lambda-learning-activity-service"
}

resource "aws_iam_role_policy_attachment" "lambda_learning_activity_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "lambda-learning-activity-service"
}

resource "aws_iam_role_policy_attachment" "lambda_learning_activity_service_policy_service_role_AWSLambdaTracerAccessExecutionRole_6a3ce6fa_3ed7_4eb4_a9fc_a93ef03bfbb1" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/service-role/AWSLambdaTracerAccessExecutionRole-6a3ce6fa-3ed7-4eb4-a9fc-a93ef03bfbb1"
  role       = "lambda-learning-activity-service"
}

resource "aws_iam_role_policy_attachment" "lambda_learning_activity_service_policy_service_role_AWSLambdaVPCAccessExecutionRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  role       = "lambda-learning-activity-service"
}

resource "aws_iam_role_policy_attachment" "lambda_market_download_tracking_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "lambda-market-download-tracking-service"
}

resource "aws_iam_role_policy_attachment" "lambda_market_download_tracking_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "lambda-market-download-tracking-service"
}

resource "aws_iam_role_policy_attachment" "learning_book_extractor_role_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "learning-book-extractor-role"
}

resource "aws_iam_role_policy_attachment" "learning_book_extractor_role_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "learning-book-extractor-role"
}

resource "aws_iam_role_policy_attachment" "learning_book_extractor_role_policy_service_role_AWSLambdaVPCAccessExecutionRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  role       = "learning-book-extractor-role"
}

resource "aws_iam_role_policy_attachment" "learning_media_lambda_image_role_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "learning-media-lambda-image-role"
}

resource "aws_iam_role_policy_attachment" "learning_media_lambda_image_role_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "learning-media-lambda-image-role"
}

resource "aws_iam_role_policy_attachment" "learning_media_lambda_image_role_policy_service_role_AWSLambdaVPCAccessExecutionRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  role       = "learning-media-lambda-image-role"
}

resource "aws_iam_role_policy_attachment" "learning_media_metadata_update_role_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "learning-media-metadata-update-role"
}

resource "aws_iam_role_policy_attachment" "learning_media_pdf_processor_role_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "learning-media-pdf-processor-role"
}

resource "aws_iam_role_policy_attachment" "learning_media_pdf_processor_role_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "learning-media-pdf-processor-role"
}

resource "aws_iam_role_policy_attachment" "learning_media_pdf_processor_role_policy_service_role_AWSLambdaVPCAccessExecutionRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  role       = "learning-media-pdf-processor-role"
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_role_policy_service_role_AmazonRDSEnhancedMonitoringRole" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  role       = "rds-monitoring-role"
}

resource "aws_iam_role_policy_attachment" "services_gateway_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "services-gateway"
}

resource "aws_iam_role_policy_attachment" "services_gateway_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "services-gateway"
}

resource "aws_iam_role_policy_attachment" "services_gateway_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "services-gateway"
}

resource "aws_iam_role_policy_attachment" "ses_notification_recorder_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "ses-notification-recorder"
}

resource "aws_iam_role_policy_attachment" "slack_lambda_policy_AmazonSNSReadOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSNSReadOnlyAccess"
  role       = "slack-lambda"
}

resource "aws_iam_role_policy_attachment" "slack_lambda_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "slack-lambda"
}

resource "aws_iam_role_policy_attachment" "temp_admin_policy_AdministratorAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AdministratorAccess"
  role       = "temp-admin"
}

resource "aws_iam_role_policy_attachment" "temp_admin_policy_SessionManagerMinimum" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/SessionManagerMinimum"
  role       = "temp-admin"
}

resource "aws_iam_role_policy_attachment" "test_policy_AmazonElasticTranscoder_JobsSubmitter" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/AmazonElasticTranscoder_JobsSubmitter"
  role       = "test"
}

resource "aws_iam_role_policy_attachment" "web_app_assessment_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-assessment-service"
}

resource "aws_iam_role_policy_attachment" "web_app_assessment_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-assessment-service"
}

resource "aws_iam_role_policy_attachment" "web_app_badge_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-badge-service"
}

resource "aws_iam_role_policy_attachment" "web_app_badge_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-badge-service"
}

resource "aws_iam_role_policy_attachment" "web_app_badge_service_policy_ElasticSearchFullDomainAccess_ElasticSearchShared01" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticSearchFullDomainAccess-ElasticSearchShared01"
  role       = "web-app-badge-service"
}

resource "aws_iam_role_policy_attachment" "web_app_bitbucket_repositories_archiver_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-bitbucket-repositories-archiver"
}

resource "aws_iam_role_policy_attachment" "web_app_book_parent_path_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-book-parent-path-service"
}

resource "aws_iam_role_policy_attachment" "web_app_book_parent_path_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-book-parent-path-service"
}

resource "aws_iam_role_policy_attachment" "web_app_book_service_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "web-app-book-service"
}

resource "aws_iam_role_policy_attachment" "web_app_book_service_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-book-service"
}

resource "aws_iam_role_policy_attachment" "web_app_book_tree_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-book-tree-service"
}

resource "aws_iam_role_policy_attachment" "web_app_book_tree_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-book-tree-service"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_find_bundled_works_task_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-builder-find-bundled-works-task"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_find_bundled_works_task_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-builder-find-bundled-works-task"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_publish_bundled_works_task_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-builder-publish-bundled-works-task"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_publish_bundled_works_task_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-builder-publish-bundled-works-task"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_publisher_task_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-builder-publisher-task"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_publisher_task_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-builder-publisher-task"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-builder-service"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-builder-service"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_sqs_task_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-builder-sqs-task"
}

resource "aws_iam_role_policy_attachment" "web_app_builder_sqs_task_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-builder-sqs-task"
}

resource "aws_iam_role_policy_attachment" "web_app_chat_allogy_server_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-chat-allogy-server"
}

resource "aws_iam_role_policy_attachment" "web_app_chat_allogy_server_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-chat-allogy-server"
}

resource "aws_iam_role_policy_attachment" "web_app_code_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-code-service"
}

resource "aws_iam_role_policy_attachment" "web_app_collaboration_person_service_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "web-app-collaboration-person-service"
}

resource "aws_iam_role_policy_attachment" "web_app_collaboration_person_service_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-collaboration-person-service"
}

resource "aws_iam_role_policy_attachment" "web_app_collections_space_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-collections-space-service"
}

resource "aws_iam_role_policy_attachment" "web_app_collections_space_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-collections-space-service"
}

resource "aws_iam_role_policy_attachment" "web_app_content_download_analytics_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-content-download-analytics-service"
}

resource "aws_iam_role_policy_attachment" "web_app_content_download_analytics_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-content-download-analytics-service"
}

resource "aws_iam_role_policy_attachment" "web_app_course_certificate_pdf_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-course-certificate-pdf-service"
}

resource "aws_iam_role_policy_attachment" "web_app_course_certificate_pdf_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-course-certificate-pdf-service"
}

resource "aws_iam_role_policy_attachment" "web_app_course_content_progress_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-course-content-progress-service"
}

resource "aws_iam_role_policy_attachment" "web_app_course_content_progress_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-course-content-progress-service"
}

resource "aws_iam_role_policy_attachment" "web_app_course_instance_publisher_task_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-course-instance-publisher-task"
}

resource "aws_iam_role_policy_attachment" "web_app_course_instance_publisher_task_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-course-instance-publisher-task"
}

resource "aws_iam_role_policy_attachment" "web_app_course_instance_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-course-instance-service"
}

resource "aws_iam_role_policy_attachment" "web_app_course_instance_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-course-instance-service"
}

resource "aws_iam_role_policy_attachment" "web_app_creator_graphql_api_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-creator-graphql-api"
}

resource "aws_iam_role_policy_attachment" "web_app_creator_graphql_api_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-creator-graphql-api"
}

resource "aws_iam_role_policy_attachment" "web_app_creator_settings_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-creator-settings-service"
}

resource "aws_iam_role_policy_attachment" "web_app_creator_user_settings_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-creator-user-settings-service"
}

resource "aws_iam_role_policy_attachment" "web_app_creator_user_settings_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-creator-user-settings-service"
}

resource "aws_iam_role_policy_attachment" "web_app_dbt_clinician_web_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "web-app-dbt-clinician-web"
}

resource "aws_iam_role_policy_attachment" "web_app_dbt_clinician_web_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-dbt-clinician-web"
}

resource "aws_iam_role_policy_attachment" "web_app_dbt_clinician_web_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-dbt-clinician-web"
}

resource "aws_iam_role_policy_attachment" "web_app_dbt_form_processor_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-dbt-form-processor"
}

resource "aws_iam_role_policy_attachment" "web_app_domain_model_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-domain-model-service"
}

resource "aws_iam_role_policy_attachment" "web_app_domain_model_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-domain-model-service"
}

resource "aws_iam_role_policy_attachment" "web_app_event_tracking_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-event-tracking-service"
}

resource "aws_iam_role_policy_attachment" "web_app_event_tracking_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-event-tracking-service"
}

resource "aws_iam_role_policy_attachment" "web_app_external_app_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-external-app-service"
}

resource "aws_iam_role_policy_attachment" "web_app_external_app_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-external-app-service"
}

resource "aws_iam_role_policy_attachment" "web_app_form_service_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "web-app-form-service"
}

resource "aws_iam_role_policy_attachment" "web_app_form_service_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-form-service"
}

resource "aws_iam_role_policy_attachment" "web_app_gateway_policy_AWSElasticBeanstalkWebTier" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSElasticBeanstalkWebTier"
  role       = "web-app-gateway"
}

resource "aws_iam_role_policy_attachment" "web_app_gateway_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "web-app-gateway"
}

resource "aws_iam_role_policy_attachment" "web_app_gateway_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-gateway"
}

resource "aws_iam_role_policy_attachment" "web_app_gateway_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-gateway"
}

resource "aws_iam_role_policy_attachment" "web_app_gateway_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-gateway"
}

resource "aws_iam_role_policy_attachment" "web_app_identity_service_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "web-app-identity-service"
}

resource "aws_iam_role_policy_attachment" "web_app_identity_service_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-identity-service"
}

resource "aws_iam_role_policy_attachment" "web_app_identity_service_policy_service_role_AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = "web-app-identity-service"
}

resource "aws_iam_role_policy_attachment" "web_app_image_reference_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-image-reference-service"
}

resource "aws_iam_role_policy_attachment" "web_app_image_scaling_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-image-scaling-service"
}

resource "aws_iam_role_policy_attachment" "web_app_image_scaling_service_policy_all_buckets_access" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/all-buckets-access"
  role       = "web-app-image-scaling-service"
}

resource "aws_iam_role_policy_attachment" "web_app_instructor_graphql_api_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-instructor-graphql-api"
}

resource "aws_iam_role_policy_attachment" "web_app_ip_geo_location_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-ip-geo-location-service"
}

resource "aws_iam_role_policy_attachment" "web_app_ip_geo_location_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-ip-geo-location-service"
}

resource "aws_iam_role_policy_attachment" "web_app_learner_graphql_api_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-learner-graphql-api"
}

resource "aws_iam_role_policy_attachment" "web_app_learning_activity_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-learning-activity-service"
}

resource "aws_iam_role_policy_attachment" "web_app_learning_activity_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-learning-activity-service"
}

resource "aws_iam_role_policy_attachment" "web_app_learning_media_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-learning-media-service"
}

resource "aws_iam_role_policy_attachment" "web_app_learning_media_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-learning-media-service"
}

resource "aws_iam_role_policy_attachment" "web_app_market_publisher_task_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-market-publisher-task"
}

resource "aws_iam_role_policy_attachment" "web_app_market_search_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-market-search-service"
}

resource "aws_iam_role_policy_attachment" "web_app_market_search_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-market-search-service"
}

resource "aws_iam_role_policy_attachment" "web_app_market_search_service_policy_ElasticSearchFullDomainAccess_ElasticSearchShared01" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticSearchFullDomainAccess-ElasticSearchShared01"
  role       = "web-app-market-search-service"
}

resource "aws_iam_role_policy_attachment" "web_app_market_service_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "web-app-market-service"
}

resource "aws_iam_role_policy_attachment" "web_app_market_service_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-market-service"
}

resource "aws_iam_role_policy_attachment" "web_app_market_subscription_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-market-subscription-service"
}

resource "aws_iam_role_policy_attachment" "web_app_market_subscription_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-market-subscription-service"
}

resource "aws_iam_role_policy_attachment" "web_app_market_subscription_service_policy_NotificationServiceSnsAccountFullAccess" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/NotificationServiceSnsAccountFullAccess"
  role       = "web-app-market-subscription-service"
}

resource "aws_iam_role_policy_attachment" "web_app_media_asset_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-media-asset-service"
}

resource "aws_iam_role_policy_attachment" "web_app_media_asset_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-media-asset-service"
}

resource "aws_iam_role_policy_attachment" "web_app_media_asset_service_policy_ElasticSearchFullDomainAccess_ElasticSearchShared01" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticSearchFullDomainAccess-ElasticSearchShared01"
  role       = "web-app-media-asset-service"
}

resource "aws_iam_role_policy_attachment" "web_app_military_user_validator_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-military-user-validator"
}

resource "aws_iam_role_policy_attachment" "web_app_military_user_validator_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-military-user-validator"
}

resource "aws_iam_role_policy_attachment" "web_app_mobile_client_gateway_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "web-app-mobile-client-gateway"
}

resource "aws_iam_role_policy_attachment" "web_app_mobile_client_gateway_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-mobile-client-gateway"
}

resource "aws_iam_role_policy_attachment" "web_app_mobile_client_gateway_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-mobile-client-gateway"
}

resource "aws_iam_role_policy_attachment" "web_app_notification_service_policy_AWSXrayWriteOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSXrayWriteOnlyAccess"
  role       = "web-app-notification-service"
}

resource "aws_iam_role_policy_attachment" "web_app_notification_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-notification-service"
}

resource "aws_iam_role_policy_attachment" "web_app_notification_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-notification-service"
}

resource "aws_iam_role_policy_attachment" "web_app_notification_service_policy_NotificationServiceSnsAccountFullAccess" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/NotificationServiceSnsAccountFullAccess"
  role       = "web-app-notification-service"
}

resource "aws_iam_role_policy_attachment" "web_app_opportunity_project_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-opportunity-project-service"
}

resource "aws_iam_role_policy_attachment" "web_app_performance_assessment_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-performance-assessment-service"
}

resource "aws_iam_role_policy_attachment" "web_app_performance_assessment_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-performance-assessment-service"
}

resource "aws_iam_role_policy_attachment" "web_app_publication_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-publication-service"
}

resource "aws_iam_role_policy_attachment" "web_app_publication_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-publication-service"
}

resource "aws_iam_role_policy_attachment" "web_app_registration_validation_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-registration-validation-service"
}

resource "aws_iam_role_policy_attachment" "web_app_registration_validation_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-registration-validation-service"
}

resource "aws_iam_role_policy_attachment" "web_app_single_step_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-single-step-service"
}

resource "aws_iam_role_policy_attachment" "web_app_spring_config_server_policy_AWSCodeCommitReadOnly" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSCodeCommitReadOnly"
  role       = "web-app-spring-config-server"
}

resource "aws_iam_role_policy_attachment" "web_app_spring_config_server_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-spring-config-server"
}

resource "aws_iam_role_policy_attachment" "web_app_spring_config_server_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-spring-config-server"
}

resource "aws_iam_role_policy_attachment" "web_app_survey_form_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-survey-form-service"
}

resource "aws_iam_role_policy_attachment" "web_app_survey_form_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-survey-form-service"
}

resource "aws_iam_role_policy_attachment" "web_app_team_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-team-service"
}

resource "aws_iam_role_policy_attachment" "web_app_team_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-team-service"
}

resource "aws_iam_role_policy_attachment" "web_app_tenant_code_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-tenant-code-service"
}

resource "aws_iam_role_policy_attachment" "web_app_tenant_configuration_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-tenant-configuration-service"
}

resource "aws_iam_role_policy_attachment" "web_app_tenant_configuration_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-tenant-configuration-service"
}

resource "aws_iam_role_policy_attachment" "web_app_tenant_host_domain_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-tenant-host-domain-service"
}

resource "aws_iam_role_policy_attachment" "web_app_tenant_host_domain_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-tenant-host-domain-service"
}

resource "aws_iam_role_policy_attachment" "web_app_tenant_user_configuration_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-tenant-user-configuration-service"
}

resource "aws_iam_role_policy_attachment" "web_app_tenant_user_configuration_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-tenant-user-configuration-service"
}

resource "aws_iam_role_policy_attachment" "web_app_test_web_service_policy_AWSXRayDaemonWriteAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSXRayDaemonWriteAccess"
  role       = "web-app-test-web-service"
}

resource "aws_iam_role_policy_attachment" "web_app_test_web_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-test-web-service"
}

resource "aws_iam_role_policy_attachment" "web_app_test_web_service_policy_ElasticBeanstalkDeployedService" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/ElasticBeanstalkDeployedService"
  role       = "web-app-test-web-service"
}

resource "aws_iam_role_policy_attachment" "web_app_user_data_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-user-data-service"
}

resource "aws_iam_role_policy_attachment" "web_app_user_data_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-user-data-service"
}

resource "aws_iam_role_policy_attachment" "web_app_xapi_service_policy_CloudWatchLogsWriteLogs" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchLogsWriteLogs"
  role       = "web-app-xapi-service"
}

resource "aws_iam_role_policy_attachment" "web_app_xapi_service_policy_CloudWatchWriteMetrics" {
  policy_arn = "arn:aws-us-gov:iam::050779347855:policy/CloudWatchWriteMetrics"
  role       = "web-app-xapi-service"
}

resource "aws_iam_role_policy_attachment" "xray_daemon_role_policy_AWSXrayWriteOnlyAccess" {
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AWSXrayWriteOnlyAccess"
  role       = "xray-daemon-role"
}

