resource "aws_security_group" "sg_006b0c4ba4ce0eed7" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "form-service-blue"

    "elasticbeanstalk:environment-id" = "e-bmqqxwyjst"

    "elasticbeanstalk:environment-name" = "form-service-blue"

  }
}

resource "aws_security_group" "sg_00980b7da446e1fe7" {
  description = "VPC Security Group"
  tags = {
    Name = "book-service-green"

    "elasticbeanstalk:environment-id" = "e-xmec4epg3c"

    "elasticbeanstalk:environment-name" = "book-service-green"

  }
}

resource "aws_security_group" "sg_00a3f418f039eac2a" {
  description = "VPC Security Group"
  tags = {
    Name = "mobile-client-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-pcw37ypdme"

    "elasticbeanstalk:environment-name" = "mobile-client-gateway-blue"

  }
}

resource "aws_security_group" "sg_00d2e39f749c9f80c" {
  description = "Security group for running Jenkins slaves"
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Name = "JenkinsSlave"

  }
}

resource "aws_security_group" "sg_00e4e569f9e6920de" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "internal-services-gateway-green"

    "elasticbeanstalk:environment-id" = "e-yd9s5vvfgp"

    "elasticbeanstalk:environment-name" = "internal-services-gateway-green"

  }
}

resource "aws_security_group" "sg_01c091d8d9e740817" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "market-service-green"

    "elasticbeanstalk:environment-id" = "e-jhagz8maay"

    "elasticbeanstalk:environment-name" = "market-service-green"

  }
}

resource "aws_security_group" "sg_01d6cae62e5454846" {
  description = "A security group allowing SSH access from Allogy users locations. Use the AWS console or CLI to update your IP address. Also include your name in the Rule description."
  tags = {
    Access = "Developer"

    DeploymentEnvironment = "DeveloperTools"

    Name = "ssh-allogy-developer"

  }
}

resource "aws_security_group" "sg_0225c1bf65436ba5e" {
  description = "default VPC security group"
}

resource "aws_security_group" "sg_026b3cb094746c939" {
  description = "VPC Security Group"
  tags = {
    Name = "market-service-green"

    "elasticbeanstalk:environment-id" = "e-jhagz8maay"

    "elasticbeanstalk:environment-name" = "market-service-green"

  }
}

resource "aws_security_group" "sg_0296b2368533e84a8" {
  description = "VPC Security Group"
  tags = {
    Name = "dbt-clinician-web-green"

    "elasticbeanstalk:environment-id" = "e-jgrjparfpf"

    "elasticbeanstalk:environment-name" = "dbt-clinician-web-green"

  }
}

resource "aws_security_group" "sg_02b8e9f6f4fa195b6" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "learner-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-59p3bpnwec"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-blue"

  }
}

resource "aws_security_group" "sg_0313ffdf68606e618" {
  description = "A security group allowing SSH access from Allogy users locations. Use the AWS console or CLI to update your IP address. Also include your name in the Rule description."
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-AllogyDeveloperSSH"

  }
}

resource "aws_security_group" "sg_03365a1e4d5ef869d" {
  description = "Security group for a standard public-facing, web load balancer"
  tags = {
    DeploymentEnvironment = "ThirdParty"

    Name = "ThirdParty-PublicWeb"

  }
}

resource "aws_security_group" "sg_034a6ff43d0aa2770" {
  description = "VPC Security Group"
  tags = {
    Name = "identity-service-blue"

    "elasticbeanstalk:environment-id" = "e-fbj96npvkw"

    "elasticbeanstalk:environment-name" = "identity-service-blue"

  }
}

resource "aws_security_group" "sg_03769d92c81a37e14" {
  description = "service-infrastructure-internal"
}

resource "aws_security_group" "sg_0453e5789d4470402" {
  description = "default VPC security group"
}

resource "aws_security_group" "sg_057a681c0afce6d70" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "book-service-green"

    "elasticbeanstalk:environment-id" = "e-xmec4epg3c"

    "elasticbeanstalk:environment-name" = "book-service-green"

  }
}

resource "aws_security_group" "sg_05b689cdd90002026" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "capillary-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-p6bifdmp7h"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-green"

  }
}

resource "aws_security_group" "sg_05da8fce7414d294c" {
  description = "The security group for an Allogy Core service"
}

resource "aws_security_group" "sg_05ec1afb8e4b24a12" {
  description = "Security group for accessing Redis databases in DeveloperTools."
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Name = "DeveloperToolsRedis"

  }
}

resource "aws_security_group" "sg_0615d31b0d6d092d3" {
  description = "VPC Security Group"
  tags = {
    Name = "learner-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-rwv222b3qp"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-green"

  }
}

resource "aws_security_group" "sg_0664cb51cf00919ed" {
  description = "Permits SSH access from inside the VPC."
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-InternalSSH"

  }
}

resource "aws_security_group" "sg_06d03510b3f32b683" {
  description = "Security group for running Jenkins master"
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Name = "JenkinsMaster"

  }
}

resource "aws_security_group" "sg_07f009cc182a06a04" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "dbt-clinician-web-green"

    "elasticbeanstalk:environment-id" = "e-jgrjparfpf"

    "elasticbeanstalk:environment-name" = "dbt-clinician-web-green"

  }
}

resource "aws_security_group" "sg_07fbaf379b52f13b0" {
  description = "Security group for accessing ElasticSearch in DeveloperTools."
  tags = {
    DeploymentEnvironment = "DeveloperTools"

    Name = "DeveloperToolsElasticSearch"

  }
}

resource "aws_security_group" "sg_081ba48ae3370758b" {
  description = "ElasticSearch access for the shared-01 domain."
  tags = {
    DeploymentEnvironment = "production"

    Name = "ElasticSearchShared01"

  }
}

resource "aws_security_group" "sg_0848e0e98be81d011" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "book-service-blue"

    "elasticbeanstalk:environment-id" = "e-fmzgrfkcqp"

    "elasticbeanstalk:environment-name" = "book-service-blue"

  }
}

resource "aws_security_group" "sg_085eb8e3a0fba2f92" {
  description = "core-rds-proxy"
}

resource "aws_security_group" "sg_08a68e02fea2591df" {
  description = "VPC Security Group"
  tags = {
    Name = "capillary-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-p6bifdmp7h"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-green"

  }
}

resource "aws_security_group" "sg_091b35fd5feaac3d0" {
  description = "VPC Security Group"
  tags = {
    Name = "form-service-blue"

    "elasticbeanstalk:environment-id" = "e-bmqqxwyjst"

    "elasticbeanstalk:environment-name" = "form-service-blue"

  }
}

resource "aws_security_group" "sg_0961642367dac1a13" {
  description = "VPC Security Group"
  tags = {
    Name = "services-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-32xzmdus8p"

    "elasticbeanstalk:environment-name" = "services-gateway-blue"

  }
}

resource "aws_security_group" "sg_09655a5d35c96b651" {
  description = "ElasticSearch access for the shared-02 domain."
  tags = {
    DeploymentEnvironment = "production"

    Name = "ElasticSearchShared02"

  }
}

resource "aws_security_group" "sg_096a6ba8268eef3f6" {
  description = "Security group for ECS container instances in production"
  tags = {
    DeploymentEnvironment = "production"

    Name = "ECSContainerInstance"

  }
}

resource "aws_security_group" "sg_09ec086d4a18f2267" {
  description = "Allows lambda functions access to the internal services gateway"
}

resource "aws_security_group" "sg_0a3723815add710c0" {
  description = "VPC Security Group"
  tags = {
    Name = "capillary-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-bner7vhrif"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-blue"

  }
}

resource "aws_security_group" "sg_0a8d1d3a2d1effe5d" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "services-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-32xzmdus8p"

    "elasticbeanstalk:environment-name" = "services-gateway-blue"

  }
}

resource "aws_security_group" "sg_0ab678abfaabcacf3" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "capillary-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-bner7vhrif"

    "elasticbeanstalk:environment-name" = "capillary-web-ui-gateway-blue"

  }
}

resource "aws_security_group" "sg_0abf393744a38edb1" {
  description = "VPC Security Group"
  tags = {
    Name = "identity-service-green"

    "elasticbeanstalk:environment-id" = "e-tx62adwg2k"

    "elasticbeanstalk:environment-name" = "identity-service-green"

  }
}

resource "aws_security_group" "sg_0b0eed2b18edcbfaa" {
  description = "Standard security group for Postgresql instances. Permits internal access only."
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-Postgresql"

  }
}

resource "aws_security_group" "sg_0b4b0aecfd7841178" {
  description = "default VPC security group"
}

resource "aws_security_group" "sg_0b827258e3f0559d8" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "collaboration-person-blue"

    "elasticbeanstalk:environment-id" = "e-3evreti3za"

    "elasticbeanstalk:environment-name" = "collaboration-person-blue"

  }
}

resource "aws_security_group" "sg_0c1125388a56a7f34" {
  description = "VPC Security Group"
  tags = {
    Name = "internal-services-gateway-green"

    "elasticbeanstalk:environment-id" = "e-yd9s5vvfgp"

    "elasticbeanstalk:environment-name" = "internal-services-gateway-green"

  }
}

resource "aws_security_group" "sg_0c57e293d12c4ba08" {
  description = "VPC Security Group"
  tags = {
    Name = "collaboration-person-blue"

    "elasticbeanstalk:environment-id" = "e-3evreti3za"

    "elasticbeanstalk:environment-name" = "collaboration-person-blue"

  }
}

resource "aws_security_group" "sg_0cb65ab88426db217" {
  description = "Standard security group for MongoDB instances. Permits internal access only."
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-MongoDB"

  }
}

resource "aws_security_group" "sg_0cc77f2002d2d75ac" {
  description = "Security group for a standard public-facing, web load balancer"
  tags = {
    DeploymentEnvironment = "production"

    Name = "WebLoadBalancer"

  }
}

resource "aws_security_group" "sg_0ce67711c9eb8e894" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "mobile-client-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-pcw37ypdme"

    "elasticbeanstalk:environment-name" = "mobile-client-gateway-blue"

  }
}

resource "aws_security_group" "sg_0cea0f3c33135fbaa" {
  description = "A security group allowing SSH access from Allogy users locations. Use the AWS console or CLI to update your IP address. Also include your name in the Rule description."
  tags = {
    DeploymentEnvironment = "ThirdParty"

    Name = "ThirdParty-AllogyDeveloperSSH"

  }
}

resource "aws_security_group" "sg_0d25cb1fc58d097e9" {
  description = "Standard security group for Redis instances. Permits internal access only."
  tags = {
    DeploymentEnvironment = "production"

    Name = "production-Redis"

  }
}

resource "aws_security_group" "sg_0d799b653c4043218" {
  description = "VPC Security Group"
  tags = {
    Name = "book-service-blue"

    "elasticbeanstalk:environment-id" = "e-fmzgrfkcqp"

    "elasticbeanstalk:environment-name" = "book-service-blue"

  }
}

resource "aws_security_group" "sg_0e07dcad269bc9148" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "identity-service-green"

    "elasticbeanstalk:environment-id" = "e-tx62adwg2k"

    "elasticbeanstalk:environment-name" = "identity-service-green"

  }
}

resource "aws_security_group" "sg_0e3da0334f6f1024d" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "identity-service-blue"

    "elasticbeanstalk:environment-id" = "e-fbj96npvkw"

    "elasticbeanstalk:environment-name" = "identity-service-blue"

  }
}

resource "aws_security_group" "sg_0e3e058433a4793a7" {
  description = "Load Balancer Security Group"
  tags = {
    Name = "learner-web-ui-gateway-green"

    "elasticbeanstalk:environment-id" = "e-rwv222b3qp"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-green"

  }
}

resource "aws_security_group" "sg_0f5539d3e349bae63" {
  description = "VPC Security Group"
  tags = {
    Name = "learner-web-ui-gateway-blue"

    "elasticbeanstalk:environment-id" = "e-59p3bpnwec"

    "elasticbeanstalk:environment-name" = "learner-web-ui-gateway-blue"

  }
}

