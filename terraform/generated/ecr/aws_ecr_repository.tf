resource "aws_ecr_repository" "assessment_form_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "assessment-form-service"
}

resource "aws_ecr_repository" "assessment_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "assessment-service"
}

resource "aws_ecr_repository" "aws_xray_daemon" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "aws-xray-daemon"
}

resource "aws_ecr_repository" "badge_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "badge-service"
}

resource "aws_ecr_repository" "book_tree_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "book-tree-service"
}

resource "aws_ecr_repository" "builder_publisher_task" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "builder-publisher-task"
}

resource "aws_ecr_repository" "builder_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "builder-service"
}

resource "aws_ecr_repository" "builder_sqs_task" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "builder-sqs-task"
}

resource "aws_ecr_repository" "chat_allogy_server" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "chat-allogy-server"
}

resource "aws_ecr_repository" "code_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "code-service"
}

resource "aws_ecr_repository" "collaboration_person_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "collaboration-person-service"
}

resource "aws_ecr_repository" "collections_space_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "collections-space-service"
}

resource "aws_ecr_repository" "content_download_analytics_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "content-download-analytics-service"
}

resource "aws_ecr_repository" "course_certificate_pdf_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "course-certificate-pdf-service"
}

resource "aws_ecr_repository" "course_content_progress_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "course-content-progress-service"
}

resource "aws_ecr_repository" "course_instance_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "course-instance-service"
}

resource "aws_ecr_repository" "creator_graphql_api" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "creator-graphql-api"
}

resource "aws_ecr_repository" "creator_settings_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "creator-settings-service"
}

resource "aws_ecr_repository" "creator_user_settings_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "creator-user-settings-service"
}

resource "aws_ecr_repository" "dbt_form_processor" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "dbt-form-processor"
}

resource "aws_ecr_repository" "domain_model_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "domain-model-service"
}

resource "aws_ecr_repository" "eureka_discovery_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "eureka-discovery-service"
}

resource "aws_ecr_repository" "event_tracking_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "event-tracking-service"
}

resource "aws_ecr_repository" "external_app_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "external-app-service"
}

resource "aws_ecr_repository" "image_reference_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "image-reference-service"
}

resource "aws_ecr_repository" "image_scaling_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "image-scaling-service"
}

resource "aws_ecr_repository" "instructor_graphql_api" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "instructor-graphql-api"
}

resource "aws_ecr_repository" "ip_geo_location_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "ip-geo-location-service"
}

resource "aws_ecr_repository" "learner_graphql_api" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "learner-graphql-api"
}

resource "aws_ecr_repository" "learning_activity_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "learning-activity-service"
}

resource "aws_ecr_repository" "learning_media_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "learning-media-service"
}

resource "aws_ecr_repository" "market_publisher_task" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "market-publisher-task"
}

resource "aws_ecr_repository" "market_search_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "market-search-service"
}

resource "aws_ecr_repository" "market_subscription_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "market-subscription-service"
}

resource "aws_ecr_repository" "media_asset_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "media-asset-service"
}

resource "aws_ecr_repository" "military_user_validator" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "military-user-validator"
}

resource "aws_ecr_repository" "notification_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "notification-service"
}

resource "aws_ecr_repository" "patient_code_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "patient-code-service"
}

resource "aws_ecr_repository" "performance_assessment_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "performance-assessment-service"
}

resource "aws_ecr_repository" "publication_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "publication-service"
}

resource "aws_ecr_repository" "registration_validation_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "registration-validation-service"
}

resource "aws_ecr_repository" "simple_email_manager" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "simple-email-manager"
}

resource "aws_ecr_repository" "single_step_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "single-step-service"
}

resource "aws_ecr_repository" "spring_config_server" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "spring-config-server"
}

resource "aws_ecr_repository" "survey_form_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "survey-form-service"
}

resource "aws_ecr_repository" "team_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "team-service"
}

resource "aws_ecr_repository" "tenant_code_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "tenant-code-service"
}

resource "aws_ecr_repository" "tenant_configuration_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "tenant-configuration-service"
}

resource "aws_ecr_repository" "tenant_host_domain_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "tenant-host-domain-service"
}

resource "aws_ecr_repository" "tenant_user_configuration_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "tenant-user-configuration-service"
}

resource "aws_ecr_repository" "user_data_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  name                 = "user-data-service"
}

resource "aws_ecr_repository" "xapi_service" {
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = false
  }
  image_tag_mutability = "MUTABLE"
  name                 = "xapi-service"
}

