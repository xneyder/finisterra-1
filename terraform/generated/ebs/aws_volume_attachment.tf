resource "aws_volume_attachment" "vol_015eaaf5da1816e8d_i_0dc94083aa5bcb1f3" {
  device_name = "/dev/sdb"
  instance_id = "i-0dc94083aa5bcb1f3"
  volume_id   = "vol-015eaaf5da1816e8d"
}

resource "aws_volume_attachment" "vol_05861db3d05015f9a_i_0d34f8cb5602f5857" {
  device_name = "/dev/xvda"
  instance_id = "i-0d34f8cb5602f5857"
  volume_id   = "vol-05861db3d05015f9a"
}

resource "aws_volume_attachment" "vol_06fbca7af4b46f3f1_i_0dc94083aa5bcb1f3" {
  device_name = "/dev/xvda"
  instance_id = "i-0dc94083aa5bcb1f3"
  volume_id   = "vol-06fbca7af4b46f3f1"
}

resource "aws_volume_attachment" "vol_08f519eb04828ec12_i_06875baad0bc7be5e" {
  device_name = "/dev/xvda"
  instance_id = "i-06875baad0bc7be5e"
  volume_id   = "vol-08f519eb04828ec12"
}

