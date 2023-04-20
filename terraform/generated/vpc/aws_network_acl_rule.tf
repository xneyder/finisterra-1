resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_100" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 80
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 100
  to_port        = 80
}

resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_110" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 443
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 110
  to_port        = 443
}

resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_120" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 22
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 120
  to_port        = 22
}

resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_122" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 25
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 122
  to_port        = 25
}

resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_140" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 1024
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 140
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_180" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 8080
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "6"
  rule_action    = "deny"
  rule_number    = 180
  to_port        = 8080
}

resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_190" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 5432
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "6"
  rule_action    = "deny"
  rule_number    = 190
  to_port        = 5432
}

resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_32767" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "-1"
  rule_action    = "deny"
  rule_number    = 32767
}

resource "aws_network_acl_rule" "acl_02870bd3064cb0e80_500" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 1024
  network_acl_id = "acl-02870bd3064cb0e80"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 500
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_066a348fb81dcaef3_100" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 80
  network_acl_id = "acl-066a348fb81dcaef3"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 100
  to_port        = 80
}

resource "aws_network_acl_rule" "acl_066a348fb81dcaef3_110" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 443
  network_acl_id = "acl-066a348fb81dcaef3"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 110
  to_port        = 443
}

resource "aws_network_acl_rule" "acl_066a348fb81dcaef3_120" {
  cidr_block     = "10.21.0.0/16"
  egress         = true
  from_port      = 1024
  network_acl_id = "acl-066a348fb81dcaef3"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 120
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_066a348fb81dcaef3_130" {
  cidr_block     = "10.21.0.0/16"
  egress         = false
  from_port      = 1024
  network_acl_id = "acl-066a348fb81dcaef3"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 130
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_066a348fb81dcaef3_32767" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  network_acl_id = "acl-066a348fb81dcaef3"
  protocol       = "-1"
  rule_action    = "deny"
  rule_number    = 32767
}

resource "aws_network_acl_rule" "acl_066a348fb81dcaef3_540" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 1024
  network_acl_id = "acl-066a348fb81dcaef3"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 540
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_0a8f17f3dfe0678ad_100" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 80
  network_acl_id = "acl-0a8f17f3dfe0678ad"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 100
  to_port        = 80
}

resource "aws_network_acl_rule" "acl_0a8f17f3dfe0678ad_110" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 443
  network_acl_id = "acl-0a8f17f3dfe0678ad"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 110
  to_port        = 443
}

resource "aws_network_acl_rule" "acl_0a8f17f3dfe0678ad_120" {
  cidr_block     = "10.21.0.0/16"
  egress         = true
  from_port      = 1024
  network_acl_id = "acl-0a8f17f3dfe0678ad"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 120
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_0a8f17f3dfe0678ad_140" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 1024
  network_acl_id = "acl-0a8f17f3dfe0678ad"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 140
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_0a8f17f3dfe0678ad_150" {
  cidr_block     = "10.21.0.0/16"
  egress         = true
  from_port      = 22
  network_acl_id = "acl-0a8f17f3dfe0678ad"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 150
  to_port        = 22
}

resource "aws_network_acl_rule" "acl_0a8f17f3dfe0678ad_220" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 22
  network_acl_id = "acl-0a8f17f3dfe0678ad"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 220
  to_port        = 22
}

resource "aws_network_acl_rule" "acl_0a8f17f3dfe0678ad_32767" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  network_acl_id = "acl-0a8f17f3dfe0678ad"
  protocol       = "-1"
  rule_action    = "deny"
  rule_number    = 32767
}

resource "aws_network_acl_rule" "acl_0a8f17f3dfe0678ad_540" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 1024
  network_acl_id = "acl-0a8f17f3dfe0678ad"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 540
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_0c0b56b0d5d4ea4ac_100" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 80
  network_acl_id = "acl-0c0b56b0d5d4ea4ac"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 100
  to_port        = 80
}

resource "aws_network_acl_rule" "acl_0c0b56b0d5d4ea4ac_110" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 443
  network_acl_id = "acl-0c0b56b0d5d4ea4ac"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 110
  to_port        = 443
}

resource "aws_network_acl_rule" "acl_0c0b56b0d5d4ea4ac_120" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 22
  network_acl_id = "acl-0c0b56b0d5d4ea4ac"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 120
  to_port        = 22
}

resource "aws_network_acl_rule" "acl_0c0b56b0d5d4ea4ac_140" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  from_port      = 1024
  network_acl_id = "acl-0c0b56b0d5d4ea4ac"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 140
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_0c0b56b0d5d4ea4ac_180" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 8080
  network_acl_id = "acl-0c0b56b0d5d4ea4ac"
  protocol       = "6"
  rule_action    = "deny"
  rule_number    = 180
  to_port        = 8080
}

resource "aws_network_acl_rule" "acl_0c0b56b0d5d4ea4ac_190" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 5432
  network_acl_id = "acl-0c0b56b0d5d4ea4ac"
  protocol       = "6"
  rule_action    = "deny"
  rule_number    = 190
  to_port        = 5432
}

resource "aws_network_acl_rule" "acl_0c0b56b0d5d4ea4ac_32767" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  network_acl_id = "acl-0c0b56b0d5d4ea4ac"
  protocol       = "-1"
  rule_action    = "deny"
  rule_number    = 32767
}

resource "aws_network_acl_rule" "acl_0c0b56b0d5d4ea4ac_500" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  from_port      = 1024
  network_acl_id = "acl-0c0b56b0d5d4ea4ac"
  protocol       = "6"
  rule_action    = "allow"
  rule_number    = 500
  to_port        = 65535
}

