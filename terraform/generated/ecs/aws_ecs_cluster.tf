resource "aws_ecs_cluster" "production" {
  name = "production"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

