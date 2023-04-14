resource "aws_ecs_task_definition" "assessment_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx640m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/assessment-service:1.0-111",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "assessment-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-111"
      }
    },
    "memoryReservation": 896,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "assessment-service",
    "portMappings": [
      {
        "containerPort": 8204,
        "hostPort": 8204,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "assessment-service"
  tags = {
    Version = "1.0-111"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-assessment-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "aws_xray_daemon" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/aws-xray-daemon:3.0-12",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "ecs-aws-xray-daemon",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "3.0-12"
      }
    },
    "memoryReservation": 128,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": false,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "aws-xray-daemon",
    "portMappings": [
      {
        "containerPort": 2000,
        "hostPort": 2000,
        "protocol": "udp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "aws-xray-daemon"
  task_role_arn         = "arn:aws-us-gov:iam::050779347855:role/xray-daemon-role"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "badge_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/badge-service:1.0-24",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "badge-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-24"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "badge-service",
    "portMappings": [
      {
        "containerPort": 8293,
        "hostPort": 8293,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "badge-service"
  tags = {
    Version = "1.0-24"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-badge-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "book_tree_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx384m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/book-tree-service:1.0-43",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "book-tree-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-43"
      }
    },
    "memoryReservation": 544,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "book-tree-service",
    "portMappings": [
      {
        "containerPort": 8272,
        "hostPort": 8272,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "book-tree-service"
  tags = {
    Version = "1.0-43"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-book-tree-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "builder_publisher_task" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx640m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/builder-publisher-task:1.0-75",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "builder-publisher-task",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-75"
      }
    },
    "memoryReservation": 896,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "builder-publisher-task",
    "portMappings": [
      {
        "containerPort": 8252,
        "hostPort": 8252,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "builder-publisher-task"
  tags = {
    Version = "1.0-75"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-builder-publisher-task"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "builder_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx640m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/builder-service:1.0-815",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "builder-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-815"
      }
    },
    "memoryReservation": 896,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "builder-service",
    "portMappings": [
      {
        "containerPort": 8219,
        "hostPort": 8219,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "builder-service"
  tags = {
    Version = "1.0-815"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-builder-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "builder_sqs_task" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/builder-sqs-task:1.0-33",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "builder-sqs-task",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-33"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "builder-sqs-task",
    "portMappings": [
      {
        "containerPort": 8280,
        "hostPort": 8280,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "builder-sqs-task"
  tags = {
    Version = "1.0-33"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-builder-sqs-task"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "chat_allogy_server" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/chat-allogy-server:1.0-49",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "chat-allogy-server",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-49"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "chat-allogy-server",
    "portMappings": [
      {
        "containerPort": 8223,
        "hostPort": 8223,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "chat-allogy-server"
  tags = {
    Version = "1.0-49"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-chat-allogy-server"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "code_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/code-service:1.0-89",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "code-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-89"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "code-service",
    "portMappings": [
      {
        "containerPort": 8257,
        "hostPort": 8257,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "code-service"
  tags = {
    Version = "1.0-89"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-code-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "collections_space_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/collections-space-service:1.0-43",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "collections-space-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-43"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "collections-space-service",
    "portMappings": [
      {
        "containerPort": 8255,
        "hostPort": 8255,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "collections-space-service"
  tags = {
    Version = "1.0-43"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-collections-space-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "content_download_analytics_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/content-download-analytics-service:1.0-testing-2",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "content-download-analytics-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-testing-2"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "content-download-analytics-service",
    "portMappings": [
      {
        "containerPort": 8227,
        "hostPort": 8227,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "content-download-analytics-service"
  tags = {
    Version = "1.0-testing-2"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-content-download-analytics-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "course_certificate_pdf_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/course-certificate-pdf-service:1.0-67",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "course-certificate-pdf-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-67"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "course-certificate-pdf-service",
    "portMappings": [
      {
        "containerPort": 8283,
        "hostPort": 8283,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "course-certificate-pdf-service"
  tags = {
    Version = "1.0-67"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-course-certificate-pdf-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "course_content_progress_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/course-content-progress-service:1.0-169",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "course-content-progress-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-169"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "course-content-progress-service",
    "portMappings": [
      {
        "containerPort": 8277,
        "hostPort": 8277,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "course-content-progress-service"
  tags = {
    Version = "1.0-169"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-course-content-progress-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "course_instance_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx640m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/course-instance-service:1.0-361",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "course-instance-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-361"
      }
    },
    "memoryReservation": 896,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "course-instance-service",
    "portMappings": [
      {
        "containerPort": 8265,
        "hostPort": 8265,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "course-instance-service"
  tags = {
    Version = "1.0-361"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-course-instance-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "creator_graphql_api" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/creator-graphql-api:1.0-testing-2",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "creator-graphql-api",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-testing-2"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "creator-graphql-api",
    "portMappings": [
      {
        "containerPort": 8290,
        "hostPort": 8290,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "creator-graphql-api"
  tags = {
    Version = "1.0-testing-2"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-creator-graphql-api"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "creator_settings_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/creator-settings-service:1.0-27",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "creator-settings-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-27"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "creator-settings-service",
    "portMappings": [
      {
        "containerPort": 8258,
        "hostPort": 8258,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "creator-settings-service"
  tags = {
    Version = "1.0-27"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-creator-settings-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "creator_user_settings_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/creator-user-settings-service:1.0-39",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "creator-user-settings-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-39"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "creator-user-settings-service",
    "portMappings": [
      {
        "containerPort": 8286,
        "hostPort": 8286,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "creator-user-settings-service"
  tags = {
    Version = "1.0-39"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-creator-user-settings-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "dbt_form_processor" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/dbt-form-processor:1.0-71",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "dbt-form-processor",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-71"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "dbt-form-processor",
    "portMappings": [
      {
        "containerPort": 8248,
        "hostPort": 8248,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "dbt-form-processor"
  tags = {
    Version = "1.0-71"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-dbt-form-processor"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "domain_model_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/domain-model-service:1.0-44",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "domain-model-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-44"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "domain-model-service",
    "portMappings": [
      {
        "containerPort": 8259,
        "hostPort": 8259,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "domain-model-service"
  tags = {
    Version = "1.0-44"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-domain-model-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "eureka_discovery_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/eureka-discovery-service:1.0-82",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "eureka-discovery-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-82"
      }
    },
    "memoryReservation": 480,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "eureka-discovery-service",
    "portMappings": [
      {
        "containerPort": 8761,
        "hostPort": 8761,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "eureka-discovery-service"
  placement_constraints {
    expression = "attribute:scaling == exactlyOnePerAZ"
    type       = "memberOf"
  }
  tags = {
    Version = "1.0-82"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/infrastructure-eureka-discovery-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "event_tracking_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/event-tracking-service:1.0-7",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "event-tracking-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-7"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "event-tracking-service",
    "portMappings": [
      {
        "containerPort": 8296,
        "hostPort": 8296,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "event-tracking-service"
  tags = {
    Version = "1.0-7"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-event-tracking-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "external_app_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/external-app-service:1.0-55",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "external-app-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-55"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "external-app-service",
    "portMappings": [
      {
        "containerPort": 8288,
        "hostPort": 8288,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "external-app-service"
  tags = {
    Version = "1.0-55"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-external-app-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "image_reference_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/image-reference-service:1.0-22",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "image-reference-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-22"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "image-reference-service",
    "portMappings": [
      {
        "containerPort": 8245,
        "hostPort": 8245,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "image-reference-service"
  tags = {
    Version = "1.0-22"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-image-reference-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "image_scaling_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/image-scaling-service:1.0-13",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "image-scaling-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-13"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "image-scaling-service",
    "portMappings": [
      {
        "containerPort": 8244,
        "hostPort": 8244,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "image-scaling-service"
  tags = {
    Version = "1.0-13"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-image-scaling-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "instructor_graphql_api" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/instructor-graphql-api:1.0-119",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "instructor-graphql-api",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-119"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "instructor-graphql-api",
    "portMappings": [
      {
        "containerPort": 8268,
        "hostPort": 8268,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "instructor-graphql-api"
  tags = {
    Version = "1.0-119"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-instructor-graphql-api"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "ip_geo_location_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/ip-geo-location-service:1.0-15",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "ip-geo-location-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-15"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "ip-geo-location-service",
    "portMappings": [
      {
        "containerPort": 8269,
        "hostPort": 8269,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "ip-geo-location-service"
  tags = {
    Version = "1.0-15"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-ip-geo-location-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "learner_graphql_api" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/learner-graphql-api:1.0-116",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "learner-graphql-api",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-116"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "learner-graphql-api",
    "portMappings": [
      {
        "containerPort": 8208,
        "hostPort": 8208,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "learner-graphql-api"
  tags = {
    Version = "1.0-116"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-learner-graphql-api"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "learning_activity_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/learning-activity-service:1.0-49",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "learning-activity-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-49"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "learning-activity-service",
    "portMappings": [
      {
        "containerPort": 8276,
        "hostPort": 8276,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "learning-activity-service"
  tags = {
    Version = "1.0-49"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-learning-activity-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "learning_media_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/learning-media-service:1.0-324",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "learning-media-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-324"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "learning-media-service",
    "portMappings": [
      {
        "containerPort": 8230,
        "hostPort": 8230,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "learning-media-service"
  tags = {
    Version = "1.0-324"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-learning-media-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "market_search_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/market-search-service:1.0-146",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "market-search-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-146"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "market-search-service",
    "portMappings": [
      {
        "containerPort": 8238,
        "hostPort": 8238,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "market-search-service"
  tags = {
    Version = "1.0-146"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-market-search-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "market_subscription_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/market-subscription-service:1.0-366",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "market-subscription-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-366"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "market-subscription-service",
    "portMappings": [
      {
        "containerPort": 8236,
        "hostPort": 8236,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "market-subscription-service"
  tags = {
    Version = "1.0-366"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-market-subscription-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "media_asset_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/media-asset-service:1.0-85",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "media-asset-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-85"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "media-asset-service",
    "portMappings": [
      {
        "containerPort": 8254,
        "hostPort": 8254,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "media-asset-service"
  tags = {
    Version = "1.0-85"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-media-asset-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "military_user_validator" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/military-user-validator:1.0-80",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "military-user-validator",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-80"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "military-user-validator",
    "portMappings": [
      {
        "containerPort": 8284,
        "hostPort": 8284,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "military-user-validator"
  tags = {
    Version = "1.0-80"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-military-user-validator"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "notification_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/notification-service:1.0-114",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "notification-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-114"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "notification-service",
    "portMappings": [
      {
        "containerPort": 8242,
        "hostPort": 8242,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "notification-service"
  tags = {
    Version = "1.0-114"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-notification-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "performance_assessment_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/performance-assessment-service:1.0-45",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "performance-assessment-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-45"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "performance-assessment-service",
    "portMappings": [
      {
        "containerPort": 8289,
        "hostPort": 8289,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "performance-assessment-service"
  tags = {
    Version = "1.0-45"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-performance-assessment-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "publication_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx640m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/publication-service:1.0-109",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "publication-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-109"
      }
    },
    "memoryReservation": 896,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "publication-service",
    "portMappings": [
      {
        "containerPort": 8251,
        "hostPort": 8251,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "publication-service"
  tags = {
    Version = "1.0-109"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-publication-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "registration_validation_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/registration-validation-service:1.0-21",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "registration-validation-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-21"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "registration-validation-service",
    "portMappings": [
      {
        "containerPort": 8292,
        "hostPort": 8292,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "registration-validation-service"
  tags = {
    Version = "1.0-21"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-registration-validation-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "simple_email_manager" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/simple-email-manager:1.0-39",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "simple-email-manager",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-39"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "simple-email-manager",
    "portMappings": [
      {
        "containerPort": 8240,
        "hostPort": 8240,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "simple-email-manager"
  tags = {
    Version = "1.0-39"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-simple-email-manager"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "single_step_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/single-step-service:1.0-34",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "single-step-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-34"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "single-step-service",
    "portMappings": [
      {
        "containerPort": 8246,
        "hostPort": 8246,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "single-step-service"
  tags = {
    Version = "1.0-34"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-single-step-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "spring_config_server" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/spring-config-server:1.0-57",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "spring-config-server",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-57"
      }
    },
    "memoryReservation": 480,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "spring-config-server",
    "portMappings": [
      {
        "containerPort": 8888,
        "hostPort": 8888,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "spring-config-server"
  tags = {
    Version = "1.0-57"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-spring-config-server"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "survey_form_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/survey-form-service:1.0-6",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "survey-form-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-6"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "survey-form-service",
    "portMappings": [
      {
        "containerPort": 8291,
        "hostPort": 8291,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "survey-form-service"
  tags = {
    Version = "1.0-6"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-survey-form-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "team_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/team-service:1.0-135",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "team-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-135"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "team-service",
    "portMappings": [
      {
        "containerPort": 8256,
        "hostPort": 8256,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "team-service"
  tags = {
    Version = "1.0-135"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-team-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "tenant_configuration_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/tenant-configuration-service:1.0-55",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "tenant-configuration-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-55"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "tenant-configuration-service",
    "portMappings": [
      {
        "containerPort": 8241,
        "hostPort": 8241,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "tenant-configuration-service"
  tags = {
    Version = "1.0-55"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-tenant-configuration-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "tenant_host_domain_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/tenant-host-domain-service:1.0-20",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "tenant-host-domain-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-20"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "tenant-host-domain-service",
    "portMappings": [
      {
        "containerPort": 8222,
        "hostPort": 8222,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "tenant-host-domain-service"
  tags = {
    Version = "1.0-20"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-tenant-host-domain-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "tenant_user_configuration_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx640m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/tenant-user-configuration-service:1.0-57",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "tenant-user-configuration-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-57"
      }
    },
    "memoryReservation": 896,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "tenant-user-configuration-service",
    "portMappings": [
      {
        "containerPort": 8261,
        "hostPort": 8261,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "tenant-user-configuration-service"
  tags = {
    Version = "1.0-57"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-tenant-user-configuration-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "user_data_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/user-data-service:2.0-127",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "user-data-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "2.0-127"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "user-data-service",
    "portMappings": [
      {
        "containerPort": 8264,
        "hostPort": 8264,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "user-data-service"
  tags = {
    Version = "2.0-127"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-user-data-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

resource "aws_ecs_task_definition" "xapi_service" {
  container_definitions = <<EOF
[
  {
    "cpu": 0,
    "environment": [
      {
        "name": "AWS_STS_REGIONAL_ENDPOINTS",
        "value": "regional"
      },
      {
        "name": "JAVA_TOOL_OPTIONS",
        "value": "-Xms256m -Xmx256m"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "production-gov"
      }
    ],
    "essential": true,
    "image": "050779347855.dkr.ecr.us-gov-west-1.amazonaws.com/xapi-service:1.0-1",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "xapi-service",
        "awslogs-multiline-pattern": "^[0-9]{4}[^\\s]",
        "awslogs-region": "us-gov-west-1",
        "awslogs-stream-prefix": "1.0-1"
      }
    },
    "memoryReservation": 416,
    "mountPoints": [
      {
        "containerPath": "/etc/xray",
        "readOnly": true,
        "sourceVolume": "xray-daemon"
      }
    ],
    "name": "xapi-service",
    "portMappings": [
      {
        "containerPort": 8295,
        "hostPort": 8295,
        "protocol": "tcp"
      }
    ],
    "volumesFrom": []
  }
]
EOF
  family                = "xapi-service"
  tags = {
    Version = "1.0-1"

  }
  task_role_arn = "arn:aws-us-gov:iam::050779347855:role/web-app-xapi-service"
  volume {
    host_path = "/ecs/xray/daemon"
    name      = "xray-daemon"
  }
}

