resource "aws_vpc_security_group_ingress_rule" "sgr_0002e712fce150b15" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "Allogy testing services; for convenience"
  from_port         = 8001
  ip_protocol       = "tcp"
  security_group_id = "sg-096a6ba8268eef3f6"
  to_port           = 8003
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0037845ce5e473bbc" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0ab678abfaabcacf3"
  security_group_id            = "sg-0a3723815add710c0"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_005a6ddea4804d5f4" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-03769d92c81a37e14"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_006a1f2b994c9dce2" {
  cidr_ipv4         = "0.0.0.0/0"
  description       = "HTTP"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0cc77f2002d2d75ac"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_006f0132fbb2f1e78" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-026b3cb094746c939"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_008c1c7baff2013e4" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0b827258e3f0559d8"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_009589628bddcc30b" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-01c091d8d9e740817"
  security_group_id            = "sg-026b3cb094746c939"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_00bc6da26b43901fa" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-05b689cdd90002026"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_00efd707cac92b16e" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0e07dcad269bc9148"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0131d739ac32a2645" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0d799b653c4043218"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_015c6ffa5abb8c573" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0a3723815add710c0"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_015e1218f265d92d2" {
  cidr_ipv4         = "0.0.0.0/0"
  description       = "HTTPS"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-03365a1e4d5ef869d"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_016679d3043dd7bfe" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-00a3f418f039eac2a"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_016d4fedafa40ea63" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-00e4e569f9e6920de"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_016dc94f2253e5d22" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0ab678abfaabcacf3"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_01a8e6e2645e6d972" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0b827258e3f0559d8"
  security_group_id            = "sg-0c57e293d12c4ba08"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_01ddc7bcb9fe76589" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-02b8e9f6f4fa195b6"
  security_group_id            = "sg-0f5539d3e349bae63"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_01e7fc42271499339" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-057a681c0afce6d70"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_01f01e604998787f1" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-05b689cdd90002026"
  security_group_id            = "sg-08a68e02fea2591df"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_01f64265e4318842d" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-057a681c0afce6d70"
  security_group_id            = "sg-00980b7da446e1fe7"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_020840fb3600f057b" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-02b8e9f6f4fa195b6"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_022a9abc211b5d541" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0e3da0334f6f1024d"
  security_group_id            = "sg-034a6ff43d0aa2770"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_024aeb900294c0147" {
  cidr_ipv4         = "192.64.190.31/32"
  description       = "macOS Jenkins JNLP"
  from_port         = 53659
  ip_protocol       = "tcp"
  security_group_id = "sg-06d03510b3f32b683"
  to_port           = 53659
}

resource "aws_vpc_security_group_ingress_rule" "sgr_026125b53475e212c" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-006b0c4ba4ce0eed7"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_026cb1a07969438df" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-01c091d8d9e740817"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_026d8cb090ee9750c" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0e3e058433a4793a7"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0297fb4e7512f9245" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-00e4e569f9e6920de"
  security_group_id            = "sg-0c1125388a56a7f34"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_02ad6ab3077f40513" {
  description                  = "Jenkins Master SSH"
  from_port                    = 22
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-06d03510b3f32b683"
  security_group_id            = "sg-00d2e39f749c9f80c"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_02bdaec6ff28bf9c9" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-08a68e02fea2591df"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_02c00935108d8c9d4" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-00e4e569f9e6920de"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_034c5f31d5cd437df" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-03769d92c81a37e14"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_039c03b98eb938d58" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-00e4e569f9e6920de"
  security_group_id            = "sg-0c1125388a56a7f34"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_03a1b0855a6927ffa" {
  cidr_ipv4         = "99.106.205.90/32"
  description       = "Luke Read"
  from_port         = 22
  ip_protocol       = "tcp"
  security_group_id = "sg-085eb8e3a0fba2f92"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_03eeab99e4c515d60" {
  cidr_ipv4         = "172.16.0.0/24"
  description       = "Redis"
  from_port         = 6379
  ip_protocol       = "tcp"
  security_group_id = "sg-05ec1afb8e4b24a12"
  to_port           = 6379
}

resource "aws_vpc_security_group_ingress_rule" "sgr_03fd02f242efa77f0" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "Spring Cloud Config Server"
  from_port         = 8888
  ip_protocol       = "tcp"
  security_group_id = "sg-03769d92c81a37e14"
  to_port           = 8888
}

resource "aws_vpc_security_group_ingress_rule" "sgr_041987aa0a47833a9" {
  cidr_ipv4         = "0.0.0.0/0"
  description       = "HTTP"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-06d03510b3f32b683"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0485e462a704fa597" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0f5539d3e349bae63"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_04aae80945231a0ba" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-05da8fce7414d294c"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_04c62a7ebfb86dd80" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0296b2368533e84a8"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_04e014940611b486d" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0a8d1d3a2d1effe5d"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_04f261eaa1886fcfa" {
  cidr_ipv4         = "172.222.112.145/32"
  from_port         = 22
  ip_protocol       = "tcp"
  security_group_id = "sg-0b0eed2b18edcbfaa"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_05425b43ccbdd9a92" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "HTTPS"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-09655a5d35c96b651"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_059764dd4f10bb643" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0ce67711c9eb8e894"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_05db1e7e3c17c0aa4" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-01c091d8d9e740817"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_05fc7e716081ef38c" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "Eureka Discovery Service"
  from_port         = 8761
  ip_protocol       = "tcp"
  security_group_id = "sg-096a6ba8268eef3f6"
  to_port           = 8761
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0626ce9c4bee91cff" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0ce67711c9eb8e894"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_06882f2d827c6814d" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0e3da0334f6f1024d"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_06a06899b5c2533f8" {
  cidr_ipv4         = "99.106.205.90/32"
  description       = "Luke Read - Home"
  from_port         = 22
  ip_protocol       = "tcp"
  security_group_id = "sg-0313ffdf68606e618"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_07acf4bcb1326304d" {
  cidr_ipv4         = "172.16.0.0/24"
  description       = "HTTPS"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-07fbaf379b52f13b0"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0802660b9bb146f92" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 53
  ip_protocol       = "udp"
  security_group_id = "sg-0b0eed2b18edcbfaa"
  to_port           = 53
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0844ab259b79aac7c" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-05b689cdd90002026"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_086e787242fc41406" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-02b8e9f6f4fa195b6"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_08701f1095cda5365" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "Redis access from within the VPC"
  from_port         = 6379
  ip_protocol       = "tcp"
  security_group_id = "sg-0d25cb1fc58d097e9"
  to_port           = 6379
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0873101b837cb99f2" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-006b0c4ba4ce0eed7"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_087dc81c9705931b6" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0ab678abfaabcacf3"
  security_group_id            = "sg-0a3723815add710c0"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_088019ec0c3f39335" {
  cidr_ipv4         = "0.0.0.0/0"
  description       = "DNS added to access endpoint"
  from_port         = 53
  ip_protocol       = "tcp"
  security_group_id = "sg-0b0eed2b18edcbfaa"
  to_port           = 53
}

resource "aws_vpc_security_group_ingress_rule" "sgr_088a7a5a38969c749" {
  cidr_ipv6         = "::/0"
  description       = "HTTPS"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-03365a1e4d5ef869d"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_08a9063ae7a2676d4" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0848e0e98be81d011"
  security_group_id            = "sg-0d799b653c4043218"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_08f2ab034f931c661" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0615d31b0d6d092d3"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_090e05346b4a70ff1" {
  cidr_ipv4         = "172.16.0.0/24"
  description       = "Jenkins JNLP"
  from_port         = 53659
  ip_protocol       = "tcp"
  security_group_id = "sg-06d03510b3f32b683"
  to_port           = 53659
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0930baddfca6a7bc8" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0c57e293d12c4ba08"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_096c6fd248b76ae23" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0e3e058433a4793a7"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0977796c844836a44" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0b827258e3f0559d8"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_098b4b76339b51ba6" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0a8d1d3a2d1effe5d"
  security_group_id            = "sg-0961642367dac1a13"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_09b300fce34f231c8" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-05da8fce7414d294c"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_09b5604c640084fe6" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0ab678abfaabcacf3"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_09b596e736dd75697" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-057a681c0afce6d70"
  security_group_id            = "sg-00980b7da446e1fe7"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0a14e7e0b086368f6" {
  cidr_ipv4         = "0.0.0.0/0"
  description       = "HTTP"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-03365a1e4d5ef869d"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0a2e77168b4e20681" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-057a681c0afce6d70"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0a4e4c6567f3b23f6" {
  cidr_ipv4         = "45.30.52.95/32"
  description       = "ssh added to access endpoint and instance"
  from_port         = 22
  ip_protocol       = "tcp"
  security_group_id = "sg-0b0eed2b18edcbfaa"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0a6b271b1c19f090f" {
  cidr_ipv4         = "172.30.0.0/16"
  description       = "Postgresql access from Original Production VPC"
  from_port         = 5432
  ip_protocol       = "tcp"
  security_group_id = "sg-0b0eed2b18edcbfaa"
  to_port           = 5432
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0a7504d3194184f9a" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0848e0e98be81d011"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0a994ca203165d7a6" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0ce67711c9eb8e894"
  security_group_id            = "sg-00a3f418f039eac2a"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0aab48ab12f6ed7d4" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "HTTPS"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-081ba48ae3370758b"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0acabee0cf49baf9f" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "MongoDB/DocumentDB access from within the VPC"
  from_port         = 27017
  ip_protocol       = "tcp"
  security_group_id = "sg-0cb65ab88426db217"
  to_port           = 27017
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0aeb83faa8fce7626" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-07f009cc182a06a04"
  security_group_id            = "sg-0296b2368533e84a8"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0af33e48f32b114f2" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-00980b7da446e1fe7"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0af4611772d67dcaf" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0e07dcad269bc9148"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0b309380240ff264b" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0848e0e98be81d011"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0b4c947e2acd3ad28" {
  cidr_ipv4         = "76.247.70.53/32"
  description       = "Payal Pandey"
  from_port         = 22
  ip_protocol       = "tcp"
  security_group_id = "sg-085eb8e3a0fba2f92"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0b5238abef77d2678" {
  cidr_ipv6         = "::/0"
  description       = "HTTP"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-03365a1e4d5ef869d"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0b6b83aea0ede04e0" {
  cidr_ipv4         = "172.30.0.0/16"
  description       = "Redis access from Original Production VPC"
  from_port         = 6379
  ip_protocol       = "tcp"
  security_group_id = "sg-0d25cb1fc58d097e9"
  to_port           = 6379
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0b76a292b45ee47f6" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "Service port range"
  from_port         = 8200
  ip_protocol       = "tcp"
  security_group_id = "sg-096a6ba8268eef3f6"
  to_port           = 8300
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0b880c30f0a49f5e6" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-01c091d8d9e740817"
  security_group_id            = "sg-026b3cb094746c939"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0bbd53ad9baa076a9" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-006b0c4ba4ce0eed7"
  security_group_id            = "sg-091b35fd5feaac3d0"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0bc31708d7cf871f0" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0e3e058433a4793a7"
  security_group_id            = "sg-0615d31b0d6d092d3"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0be6243aa03ebe8db" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-07f009cc182a06a04"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0c4d0872eec98dce1" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0a8d1d3a2d1effe5d"
  security_group_id            = "sg-0961642367dac1a13"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0c831d549c877154e" {
  cidr_ipv4         = "172.30.0.0/16"
  description       = "HTTPS from Original Production VPC"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-081ba48ae3370758b"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0c8aab7cd39712670" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "Spring Cloud Config Server"
  from_port         = 8888
  ip_protocol       = "tcp"
  security_group_id = "sg-096a6ba8268eef3f6"
  to_port           = 8888
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0ca445027f1d28cf6" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "Postgresql access from within the VPC"
  from_port         = 5432
  ip_protocol       = "tcp"
  security_group_id = "sg-0b0eed2b18edcbfaa"
  to_port           = 5432
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0ccfe55cc2f589704" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0e3e058433a4793a7"
  security_group_id            = "sg-0615d31b0d6d092d3"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0ce4c0a236bf35a32" {
  cidr_ipv4         = "76.247.70.53/32"
  description       = "Payal Pandey - Home"
  from_port         = 22
  ip_protocol       = "tcp"
  security_group_id = "sg-0313ffdf68606e618"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0d17b3959d78b0b8b" {
  cidr_ipv4         = "10.21.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-091b35fd5feaac3d0"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0d63e0082d4fd75a6" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-07f009cc182a06a04"
  security_group_id            = "sg-0296b2368533e84a8"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0d7e3bb612a104501" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-006b0c4ba4ce0eed7"
  security_group_id            = "sg-091b35fd5feaac3d0"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0dcf6a7f0de5425f9" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0848e0e98be81d011"
  security_group_id            = "sg-0d799b653c4043218"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0dd87dba00b7b0076" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-07f009cc182a06a04"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0de6986e53e7a2698" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "Internal SSH"
  from_port         = 22
  ip_protocol       = "tcp"
  security_group_id = "sg-0664cb51cf00919ed"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0dec3a8bbbee730d3" {
  cidr_ipv4         = "0.0.0.0/0"
  description       = "HTTPS"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-06d03510b3f32b683"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0e0057ee901c8b10c" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0e3da0334f6f1024d"
  security_group_id            = "sg-034a6ff43d0aa2770"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0e3333eb14ae29f92" {
  from_port                    = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0e07dcad269bc9148"
  security_group_id            = "sg-0abf393744a38edb1"
  to_port                      = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0e6450c431a2fb3a9" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-02b8e9f6f4fa195b6"
  security_group_id            = "sg-0f5539d3e349bae63"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0e7f46f44e9e14244" {
  cidr_ipv4         = "10.21.0.0/16"
  description       = "X-Ray daemon"
  from_port         = 2000
  ip_protocol       = "udp"
  security_group_id = "sg-096a6ba8268eef3f6"
  to_port           = 2000
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0e957669ee730a1d4" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0e3da0334f6f1024d"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0eaaec56395d6a8f2" {
  cidr_ipv4         = "0.0.0.0/0"
  description       = "HTTPS"
  from_port         = 443
  ip_protocol       = "tcp"
  security_group_id = "sg-0cc77f2002d2d75ac"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0eb3de712ec423624" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0ce67711c9eb8e894"
  security_group_id            = "sg-00a3f418f039eac2a"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0ec0789d00a59b9aa" {
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  security_group_id = "sg-0a8d1d3a2d1effe5d"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0efe5792b5bdd16a1" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0e07dcad269bc9148"
  security_group_id            = "sg-0abf393744a38edb1"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0f159c89ba3d30e70" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-05b689cdd90002026"
  security_group_id            = "sg-08a68e02fea2591df"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0f42c90e79fa0adaa" {
  cidr_ipv4         = "136.49.26.165/32"
  description       = "David Venable - Home"
  from_port         = 22
  ip_protocol       = "tcp"
  security_group_id = "sg-0313ffdf68606e618"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "sgr_0fdeb715527a85b04" {
  from_port                    = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-0b827258e3f0559d8"
  security_group_id            = "sg-0c57e293d12c4ba08"
  to_port                      = 80
}

