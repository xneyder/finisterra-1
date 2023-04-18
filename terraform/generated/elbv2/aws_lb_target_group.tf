resource "aws_lb_target_group" "awseb_AWSEB_15MUDOYVBCD0V" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "dbt-clinician-web-green"

    "elasticbeanstalk:environment-id" = "e-jgrjparfpf"

    "elasticbeanstalk:environment-name" = "dbt-clinician-web-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_1CE4EQTZCXGMN" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "form-service-blue"

    "elasticbeanstalk:environment-id" = "e-bmqqxwyjst"

    "elasticbeanstalk:environment-name" = "form-service-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_1KL1HTYXVLBO3" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "internal-services-gateway-green"

    "elasticbeanstalk:environment-id" = "e-yd9s5vvfgp"

    "elasticbeanstalk:environment-name" = "internal-services-gateway-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_1RIBY3C1UJL6Z" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "mobile-client-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-pcw37ypdme"

    "elasticbeanstalk:environment-name" = "mobile-client-gateway-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_2K3XZ04E4CGX" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "capillary-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-bner7vhrif"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_32EBDCVNET6O" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "collaboration-person-blue"

    "elasticbeanstalk:environment-id" = "e-3evreti3za"

    "elasticbeanstalk:environment-name" = "collaboration-person-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_5I5BPHGEKZZU" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "learner-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-rwv222b3qp"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_85FZMWFW80KB" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "identity-service-blue"

    "elasticbeanstalk:environment-id" = "e-udanqbam3f"

    "elasticbeanstalk:environment-name" = "identity-service-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_AAEU0KCESEZW" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "market-service-green"

    "elasticbeanstalk:environment-id" = "e-jhagz8maay"

    "elasticbeanstalk:environment-name" = "market-service-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_DRJX2I75DDGD" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "learner-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-59p3bpnwec"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_G1E58SI6K9GH" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "services-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-32xzmdus8p"

    "elasticbeanstalk:environment-name" = "services-gateway-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_SEX4C054MM4S" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "book-service-green"

    "elasticbeanstalk:environment-id" = "e-xmec4epg3c"

    "elasticbeanstalk:environment-name" = "book-service-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_TL79QFVI7V3" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "capillary-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-ipfavj64xz"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_AWSEB_YQXP658RVKNN" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTP"
    unhealthy_threshold = 5
  }
  port       = 80
  protocol   = "HTTP"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "book-service-blue"

    "elasticbeanstalk:environment-id" = "e-fmzgrfkcqp"

    "elasticbeanstalk:environment-name" = "book-service-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_13BRWX43RBRKL" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "internal-services-gateway-green"

    "elasticbeanstalk:environment-id" = "e-yd9s5vvfgp"

    "elasticbeanstalk:environment-name" = "internal-services-gateway-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_1ITBSVWM72LY7" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "book-service-blue"

    "elasticbeanstalk:environment-id" = "e-fmzgrfkcqp"

    "elasticbeanstalk:environment-name" = "book-service-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_1NPG7X2RFJRCW" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "capillary-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-bner7vhrif"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_1T75SCD09HAAM" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "services-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-32xzmdus8p"

    "elasticbeanstalk:environment-name" = "services-gateway-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_95M35U10HKO6" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "learner-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-rwv222b3qp"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_ABQH2Z86TMP8" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "identity-service-blue"

    "elasticbeanstalk:environment-id" = "e-udanqbam3f"

    "elasticbeanstalk:environment-name" = "identity-service-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_AUSQVE5FNNDF" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "dbt-clinician-web-green"

    "elasticbeanstalk:environment-id" = "e-jgrjparfpf"

    "elasticbeanstalk:environment-name" = "dbt-clinician-web-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_BA13PDTGN3G" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "mobile-client-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-pcw37ypdme"

    "elasticbeanstalk:environment-name" = "mobile-client-gateway-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_FWBN6663VT5N" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "capillary-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-ipfavj64xz"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_JJG3XZEW6RBE" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "book-service-green"

    "elasticbeanstalk:environment-id" = "e-xmec4epg3c"

    "elasticbeanstalk:environment-name" = "book-service-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_JRUKW21HVQNJ" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "learner-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-59p3bpnwec"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_KDPXFWOISYA9" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "form-service-blue"

    "elasticbeanstalk:environment-id" = "e-bmqqxwyjst"

    "elasticbeanstalk:environment-name" = "form-service-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_WOEYX76SD8A1" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "collaboration-person-blue"

    "elasticbeanstalk:environment-id" = "e-3evreti3za"

    "elasticbeanstalk:environment-name" = "collaboration-person-blue"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "awseb_https_Y2DPEDQN6QH6" {
  deregistration_delay = "20"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 15
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 5
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = true
    type            = "lb_cookie"
  }
  tags = {
    Name = "market-service-green"

    "elasticbeanstalk:environment-id" = "e-jhagz8maay"

    "elasticbeanstalk:environment-name" = "market-service-green"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "ecs_default_eureka_discovery" {
  deregistration_delay = "300"
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 2
  }
  port       = 443
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }
  tags = {
    Description = "Provides HTTPS access to the eureka-discovery-service running in an ECS cluster"

    Name = "ecs-default-eureka-discovery-service"

  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

resource "aws_lb_target_group" "ecs_default_spring_config_server" {
  deregistration_delay = "300"
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    port                = "traffic-port"
    protocol            = "HTTPS"
    unhealthy_threshold = 2
  }
  port       = 8888
  protocol   = "HTTPS"
  slow_start = 0
  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }
  target_type = "instance"
  vpc_id      = "vpc-0bd9acb7990b4154d"
}

