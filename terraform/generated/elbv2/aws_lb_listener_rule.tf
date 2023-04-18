resource "aws_lb_listener_rule" "_3e77d7253daf11b3" {
  action {
    target_group_arn = "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/ecs-default-eureka-discovery/1f071fb877be1796"
    type             = "forward"
  }
  condition {
    host_header {
      values = [
        "discovery-internal.allogy.com"
      ]
    }
  }
  listener_arn = "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:listener/app/service-infrastructure-internal/fd55d6a9485ddbea/661c504d0bef088b"
}

resource "aws_lb_listener_rule" "a0b22e94512a6235" {
  action {
    target_group_arn = "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/ecs-default-eureka-discovery/1f071fb877be1796"
    type             = "forward"
  }
  condition {
    host_header {
      values = [
        "discovery-govcloud.allogy.com"
      ]
    }
  }
  listener_arn = "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:listener/app/service-infrastructure-internal/fd55d6a9485ddbea/1afd2d1ebf60176c"
}

