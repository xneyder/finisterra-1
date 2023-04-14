resource "aws_ebs_volume" "vol_015eaaf5da1816e8d" {
  availability_zone    = "us-gov-west-1b"
  multi_attach_enabled = false
}

resource "aws_ebs_volume" "vol_05861db3d05015f9a" {
  availability_zone    = "us-gov-west-1a"
  multi_attach_enabled = false
  tags = {
    Name = "production-BastionServer"

  }
}

resource "aws_ebs_volume" "vol_06fbca7af4b46f3f1" {
  availability_zone    = "us-gov-west-1b"
  multi_attach_enabled = false
}

resource "aws_ebs_volume" "vol_08f519eb04828ec12" {
  availability_zone    = "us-gov-west-1a"
  multi_attach_enabled = false
  tags = {
    Name = "core-rds-proxy"

  }
}

