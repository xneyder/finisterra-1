resource "aws_autoscaling_group" "awseb_e_32xzmdus8p_stack_AWSEBAutoScalingGroup_DG4CSGRX6MCC" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-32xzmdus8p-stack-AWSEBAutoScalingLaunchConfiguration-AIUVRKAPP9Z2"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "services-gateway-blue"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-32xzmdus8p"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "services-gateway-blue"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-G1E58SI6K9GH/57dd0460a8d71d56", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-1T75SCD09HAAM/7147a3a89ea4829a"
  ]
}

resource "aws_autoscaling_group" "awseb_e_3evreti3za_stack_AWSEBAutoScalingGroup_1B0EJVZQ6UQV9" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-3evreti3za-stack-AWSEBAutoScalingLaunchConfiguration-1IZMOD8GEXDFX"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "collaboration-person-blue"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-3evreti3za"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "collaboration-person-blue"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-32EBDCVNET6O/3e86dcafe546447e", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-WOEYX76SD8A1/b65166bdc08fafbd"
  ]
}

resource "aws_autoscaling_group" "awseb_e_59p3bpnwec_stack_AWSEBAutoScalingGroup_1ON4K0NW5K7WO" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-59p3bpnwec-stack-AWSEBAutoScalingLaunchConfiguration-6EI6C0VEZV2D"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "learner-web-ui-gateway-blue"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-59p3bpnwec"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "learner-web-ui-gateway-blue"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-DRJX2I75DDGD/ba2456c6dc68b7d0", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-JRUKW21HVQNJ/6d4c136043ff5bab"
  ]
}

resource "aws_autoscaling_group" "awseb_e_bmqqxwyjst_stack_AWSEBAutoScalingGroup_LJXY7KQWBLXK" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-bmqqxwyjst-stack-AWSEBAutoScalingLaunchConfiguration-1LHMXIJ3683Z9"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "form-service-blue"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-bmqqxwyjst"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "form-service-blue"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-1CE4EQTZCXGMN/ed92788dada306f3", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-KDPXFWOISYA9/d1ed4548e1b5af37"
  ]
}

resource "aws_autoscaling_group" "awseb_e_bner7vhrif_stack_AWSEBAutoScalingGroup_1ROG3ORZMMX48" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-bner7vhrif-stack-AWSEBAutoScalingLaunchConfiguration-VKFYC1C3V9J0"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "capillary-web-ui-gateway-blue"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-bner7vhrif"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "capillary-web-ui-gateway-blue"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-2K3XZ04E4CGX/ea85e2af213f03dc", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-1NPG7X2RFJRCW/5947b105fe89ccde"
  ]
}

resource "aws_autoscaling_group" "awseb_e_fmzgrfkcqp_stack_AWSEBAutoScalingGroup_VMGLQ3UKK1KY" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-fmzgrfkcqp-stack-AWSEBAutoScalingLaunchConfiguration-1LOGBY1QQR689"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "book-service-blue"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-fmzgrfkcqp"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "book-service-blue"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-YQXP658RVKNN/71cd584aa7eea690", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-1ITBSVWM72LY7/4d250918fe6c03ff"
  ]
}

resource "aws_autoscaling_group" "awseb_e_ipfavj64xz_stack_AWSEBAutoScalingGroup_10EZHY36C0W3Z" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-ipfavj64xz-stack-AWSEBAutoScalingLaunchConfiguration-1GO4LR28F9S60"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "capillary-web-ui-gateway-green"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-ipfavj64xz"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "capillary-web-ui-gateway-green"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-TL79QFVI7V3/043977142a0dbf1d", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-FWBN6663VT5N/060e7dbf6250d62e"
  ]
}

resource "aws_autoscaling_group" "awseb_e_jgrjparfpf_stack_AWSEBAutoScalingGroup_NCF5DZ76ITDN" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-jgrjparfpf-stack-AWSEBAutoScalingLaunchConfiguration-10ABAES14Y4Q8"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "dbt-clinician-web-green"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-jgrjparfpf"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "dbt-clinician-web-green"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-15MUDOYVBCD0V/931d2e2232b0f747", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-AUSQVE5FNNDF/c017fe1764b96b03"
  ]
}

resource "aws_autoscaling_group" "awseb_e_jhagz8maay_stack_AWSEBAutoScalingGroup_1M93QZILI7GQN" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-jhagz8maay-stack-AWSEBAutoScalingLaunchConfiguration-1OQZV51LE4R45"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "market-service-green"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-jhagz8maay"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "market-service-green"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-AAEU0KCESEZW/17534a71c8a56fe4", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-Y2DPEDQN6QH6/07bea956e74e1c38"
  ]
}

resource "aws_autoscaling_group" "awseb_e_pcw37ypdme_stack_AWSEBAutoScalingGroup_165D32JDYUA6O" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-pcw37ypdme-stack-AWSEBAutoScalingLaunchConfiguration-AWZ4IZZYEOO5"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "mobile-client-gateway-blue"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-pcw37ypdme"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "mobile-client-gateway-blue"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-1RIBY3C1UJL6Z/777481f0becec444", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-BA13PDTGN3G/1edd65d8ab56e5dc"
  ]
}

resource "aws_autoscaling_group" "awseb_e_rwv222b3qp_stack_AWSEBAutoScalingGroup_1MLNCOGIT8AIV" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-rwv222b3qp-stack-AWSEBAutoScalingLaunchConfiguration-13YMWW55SCEEW"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "learner-web-ui-gateway-green"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-rwv222b3qp"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "learner-web-ui-gateway-green"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-5I5BPHGEKZZU/ceb1b1d73d05204a", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-95M35U10HKO6/986ad47b9aaa35a5"
  ]
}

resource "aws_autoscaling_group" "awseb_e_udanqbam3f_stack_AWSEBAutoScalingGroup_1PJGCX54MJZVZ" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-udanqbam3f-stack-AWSEBAutoScalingLaunchConfiguration-13URLATTKMNZ3"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "identity-service-blue"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-udanqbam3f"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "identity-service-blue"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-85FZMWFW80KB/e81c3f994726fc24", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-ABQH2Z86TMP8/483f042e79cc7972"
  ]
}

resource "aws_autoscaling_group" "awseb_e_xmec4epg3c_stack_AWSEBAutoScalingGroup_UQ4ARCTDJ5PP" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-xmec4epg3c-stack-AWSEBAutoScalingLaunchConfiguration-12887VXT6TVNY"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "book-service-green"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-xmec4epg3c"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "book-service-green"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-SEX4C054MM4S/acbec2c618e473f1", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-JJG3XZEW6RBE/338ad25d27256cd4"
  ]
}

resource "aws_autoscaling_group" "awseb_e_yd9s5vvfgp_stack_AWSEBAutoScalingGroup_NT4M6B5ZTDEQ" {
  capacity_rebalance        = false
  default_instance_warmup   = 0
  health_check_grace_period = 300
  launch_configuration      = "awseb-e-yd9s5vvfgp-stack-AWSEBAutoScalingLaunchConfiguration-1F9EQPL9CPU5J"
  max_instance_lifetime     = 0
  max_size                  = 4
  metrics_granularity       = "1Minute"
  min_size                  = 1
  protect_from_scale_in     = false
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "internal-services-gateway-green"
  }
  tag {
    key                 = "elasticbeanstalk:environment-id"
    propagate_at_launch = true
    value               = "e-yd9s5vvfgp"
  }
  tag {
    key                 = "elasticbeanstalk:environment-name"
    propagate_at_launch = true
    value               = "internal-services-gateway-green"
  }
  target_group_arns = [
    "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-AWSEB-1KL1HTYXVLBO3/7cff1cc5e885e081", "arn:aws-us-gov:elasticloadbalancing:us-gov-west-1:050779347855:targetgroup/awseb-https-13BRWX43RBRKL/9afaf32c8e7dde20"
  ]
}

resource "aws_autoscaling_group" "ecs_production_gov_v02_instance_asg_capacity" {
  capacity_rebalance      = false
  default_instance_warmup = 0
  enabled_metrics = [
    "GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"
  ]
  health_check_grace_period = 282
  launch_configuration      = "ecs-production-gov-v02-LaunchConfigurationCapacity-IEGO64TA1MZ"
  max_instance_lifetime     = 0
  max_size                  = 5
  metrics_granularity       = "1Minute"
  min_size                  = 2
  protect_from_scale_in     = false
  tag {
    key                 = "LaunchConfiguration"
    propagate_at_launch = true
    value               = "ecs-production-gov-v02-LaunchConfigurationCapacity-IEGO64TA1MZ"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "ecs-production-gov-v02-container-instance"
  }
}

resource "aws_autoscaling_group" "ecs_production_gov_v02_instance_asg_one_per_az" {
  capacity_rebalance      = false
  default_instance_warmup = 0
  enabled_metrics = [
    "GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"
  ]
  health_check_grace_period = 282
  launch_configuration      = "ecs-production-gov-v02-LaunchConfigurationExactlyOnePerAZ-1XQRH2DSGN1SH"
  max_instance_lifetime     = 0
  max_size                  = 3
  metrics_granularity       = "1Minute"
  min_size                  = 3
  protect_from_scale_in     = false
  tag {
    key                 = "LaunchConfiguration"
    propagate_at_launch = true
    value               = "ecs-production-gov-v02-LaunchConfigurationExactlyOnePerAZ-1XQRH2DSGN1SH"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "ecs-production-gov-v02-container-instance"
  }
}

