resource "aws_ecs_capacity_provider" "FARGATE" {
  name = "FARGATE"
}

resource "aws_ecs_capacity_provider" "FARGATE_SPOT" {
  name = "FARGATE_SPOT"
}

