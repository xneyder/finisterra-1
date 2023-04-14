resource "aws_ecs_service" "collections_space_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  desired_count                      = 2
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "collections-space-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  task_definition     = "collections-space-service:3"
}

resource "aws_ecs_service" "course_certificate_pdf_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 2
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "course-certificate-pdf-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  service_registries {
    container_name = "course-certificate-pdf-service"
    container_port = 8283
    port           = 0
    registry_arn   = "arn:aws-us-gov:servicediscovery:us-gov-west-1:050779347855:service/srv-7gcyyi74sjumqjws"
  }
  task_definition = "course-certificate-pdf-service:7"
}

resource "aws_ecs_service" "external_app_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "external-app-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  task_definition     = "external-app-service:4"
}

resource "aws_ecs_service" "market_search_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 3
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "market-search-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  task_definition     = "market-search-service:5"
}

resource "aws_ecs_service" "performance_assessment_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "performance-assessment-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  task_definition     = "performance-assessment-service:4"
}

resource "aws_ecs_service" "publication_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  desired_count                      = 2
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "publication-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  task_definition     = "publication-service:7"
}

resource "aws_ecs_service" "single_step_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  desired_count                      = 2
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "single-step-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  task_definition     = "single-step-service:7"
}

resource "aws_ecs_service" "spring_config_server" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  desired_count                      = 3
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 60
  load_balancer {
    container_name   = "spring-config-server"
    container_port   = 8888
    target_group_arn = "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/ecs-default-spring-config-server/f97e706dd938b351"
  }
  name = "spring-config-server"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "TASK_DEFINITION"
  scheduling_strategy = "REPLICA"
  task_definition     = "spring-config-server:4"
}

resource "aws_ecs_service" "team_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 66
  desired_count                      = 3
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "team-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  service_registries {
    container_name = "team-service"
    container_port = 8256
    port           = 0
    registry_arn   = "arn:aws-us-gov:servicediscovery:us-gov-west-1:050779347855:service/srv-egzxeaajyplbuguq"
  }
  task_definition = "team-service:3"
}

resource "aws_ecs_service" "tenant_configuration_service" {
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 2
  enable_ecs_managed_tags            = true
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  name                               = "tenant-configuration-service"
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"
  task_definition     = "tenant-configuration-service:8"
}

