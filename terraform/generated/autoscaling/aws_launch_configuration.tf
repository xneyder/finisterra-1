resource "aws_launch_configuration" "awseb_e_32xzmdus8p_stack_AWSEBAutoScalingLaunchConfiguration_AIUVRKAPP9Z2" {
  enable_monitoring    = false
  iam_instance_profile = "services-gateway"
  image_id             = "ami-0b733a9711d3a42c5"
  instance_type        = "t3.small"
  security_groups = [
    "sg-0961642367dac1a13"
  ]
  user_data = "88a918ee5293f61fbfd7765143aba28b5ef5d755"
}

resource "aws_launch_configuration" "awseb_e_3evreti3za_stack_AWSEBAutoScalingLaunchConfiguration_1IZMOD8GEXDFX" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-collaboration-person-service"
  image_id             = "ami-09d86c60c28509810"
  instance_type        = "t2.micro"
  security_groups = [
    "sg-0c57e293d12c4ba08"
  ]
  user_data = "311ab1837567386ecbb1d51546ccac62b5e36445"
}

resource "aws_launch_configuration" "awseb_e_59p3bpnwec_stack_AWSEBAutoScalingLaunchConfiguration_6EI6C0VEZV2D" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-gateway"
  image_id             = "ami-09d86c60c28509810"
  instance_type        = "t2.small"
  security_groups = [
    "sg-0f5539d3e349bae63"
  ]
  user_data = "84f070ebb405c7472a47758d594cecefb95b0851"
}

resource "aws_launch_configuration" "awseb_e_bmqqxwyjst_stack_AWSEBAutoScalingLaunchConfiguration_1LHMXIJ3683Z9" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-form-service"
  image_id             = "ami-09d86c60c28509810"
  instance_type        = "t2.micro"
  security_groups = [
    "sg-091b35fd5feaac3d0"
  ]
  user_data = "25a5b860c95a87d7f4aae37767cf386c26a5d6fa"
}

resource "aws_launch_configuration" "awseb_e_bner7vhrif_stack_AWSEBAutoScalingLaunchConfiguration_VKFYC1C3V9J0" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-gateway"
  image_id             = "ami-0a4f692219167e96a"
  instance_type        = "t2.small"
  security_groups = [
    "sg-0a3723815add710c0"
  ]
  user_data = "6a120d438bca04a7138ecba60aff512867afb73f"
}

resource "aws_launch_configuration" "awseb_e_fbj96npvkw_stack_AWSEBAutoScalingLaunchConfiguration_NTZB83ZL82PC" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-identity-service"
  image_id             = "ami-052e897b5512ff945"
  instance_type        = "t2.small"
  security_groups = [
    "sg-034a6ff43d0aa2770"
  ]
  user_data = "444538a5324cafef2e72e74a1510569cb305ed4b"
}

resource "aws_launch_configuration" "awseb_e_fmzgrfkcqp_stack_AWSEBAutoScalingLaunchConfiguration_1LOGBY1QQR689" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-book-service"
  image_id             = "ami-0a4f692219167e96a"
  instance_type        = "t2.small"
  security_groups = [
    "sg-0d799b653c4043218"
  ]
  user_data = "6d36cd5748689fd6f5ef22287939a5cc48e567d6"
}

resource "aws_launch_configuration" "awseb_e_jgrjparfpf_stack_AWSEBAutoScalingLaunchConfiguration_10ABAES14Y4Q8" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-dbt-clinician-web"
  image_id             = "ami-0c2b4a8cef8b7b238"
  instance_type        = "t2.micro"
  security_groups = [
    "sg-0296b2368533e84a8"
  ]
  user_data = "99a9cd2289d072f57f6093c080ef459d4410722d"
}

resource "aws_launch_configuration" "awseb_e_jhagz8maay_stack_AWSEBAutoScalingLaunchConfiguration_1OQZV51LE4R45" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-market-service"
  image_id             = "ami-0524526c08d7abd4d"
  instance_type        = "t3.medium"
  security_groups = [
    "sg-026b3cb094746c939"
  ]
  user_data = "f2829d95d23d3bd0956bcd88b34b0737ec384ac8"
}

resource "aws_launch_configuration" "awseb_e_p6bifdmp7h_stack_AWSEBAutoScalingLaunchConfiguration_5ZGXBP8856K5" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-gateway"
  image_id             = "ami-0a4f692219167e96a"
  instance_type        = "t2.small"
  security_groups = [
    "sg-08a68e02fea2591df"
  ]
  user_data = "5b5170924413b93785bd172e139f331f2221d3c4"
}

resource "aws_launch_configuration" "awseb_e_pcw37ypdme_stack_AWSEBAutoScalingLaunchConfiguration_AWZ4IZZYEOO5" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-mobile-client-gateway"
  image_id             = "ami-052e897b5512ff945"
  instance_type        = "t3.small"
  security_groups = [
    "sg-00a3f418f039eac2a"
  ]
  user_data = "6431ee8cb5ed87c8e1d78ea4e92b3239926e8fe9"
}

resource "aws_launch_configuration" "awseb_e_rwv222b3qp_stack_AWSEBAutoScalingLaunchConfiguration_13YMWW55SCEEW" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-gateway"
  image_id             = "ami-019e0b5a23a843984"
  instance_type        = "t2.small"
  security_groups = [
    "sg-0615d31b0d6d092d3"
  ]
  user_data = "2a8f3116cb4bf1176ed38a7c9b5dce1d9976cc4a"
}

resource "aws_launch_configuration" "awseb_e_tx62adwg2k_stack_AWSEBAutoScalingLaunchConfiguration_KWTPTGQG6K0F" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-identity-service"
  image_id             = "ami-052e897b5512ff945"
  instance_type        = "t2.small"
  security_groups = [
    "sg-0abf393744a38edb1"
  ]
  user_data = "9febd94e763a2f3f248e93c92f73fbeed495b6cc"
}

resource "aws_launch_configuration" "awseb_e_xmec4epg3c_stack_AWSEBAutoScalingLaunchConfiguration_12887VXT6TVNY" {
  enable_monitoring    = false
  iam_instance_profile = "web-app-book-service"
  image_id             = "ami-09d86c60c28509810"
  instance_type        = "t2.small"
  security_groups = [
    "sg-00980b7da446e1fe7"
  ]
  user_data = "5e748142e25852c0d4983c9ea0b185c0829747b0"
}

resource "aws_launch_configuration" "awseb_e_yd9s5vvfgp_stack_AWSEBAutoScalingLaunchConfiguration_1F9EQPL9CPU5J" {
  enable_monitoring    = false
  iam_instance_profile = "internal-services-gateway"
  image_id             = "ami-0b733a9711d3a42c5"
  instance_type        = "t3.small"
  security_groups = [
    "sg-0c1125388a56a7f34"
  ]
  user_data = "0c8b15d3d4f86cf21e3e1257bd0edc0e4ef183c5"
}

resource "aws_launch_configuration" "ecs_production_gov_v02_LaunchConfigurationCapacity_IEGO64TA1MZ" {
  enable_monitoring    = true
  iam_instance_profile = "ecsInstanceRole"
  image_id             = "ami-05f55cc2c21fe5898"
  instance_type        = "t3a.xlarge"
  security_groups = [
    "sg-096a6ba8268eef3f6"
  ]
  user_data = "b8fec361465771675d2576153ef2e973c42dd302"
}

resource "aws_launch_configuration" "ecs_production_gov_v02_LaunchConfigurationExactlyOnePerAZ_1XQRH2DSGN1SH" {
  enable_monitoring    = true
  iam_instance_profile = "ecsInstanceRole"
  image_id             = "ami-05f55cc2c21fe5898"
  instance_type        = "m5.xlarge"
  security_groups = [
    "sg-096a6ba8268eef3f6"
  ]
  user_data = "89668daab6c784a13332e66a33800e787ae8a395"
}

