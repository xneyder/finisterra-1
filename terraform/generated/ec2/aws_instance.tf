resource "aws_instance" "i_06875baad0bc7be5e" {
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
  }
  get_password_data = false
  hibernation       = false
  maintenance_options {
  }
  metadata_options {
  }
  private_dns_name_options {
  }
  root_block_device {
    delete_on_termination = true
    tags = {
      Name = "core-rds-proxy"

    }
  }
  source_dest_check = true
  tags = {
    Name = "core-rds-proxy"

  }
}

resource "aws_instance" "i_0d34f8cb5602f5857" {
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
  }
  get_password_data = false
  hibernation       = false
  maintenance_options {
  }
  metadata_options {
  }
  private_dns_name_options {
  }
  root_block_device {
    delete_on_termination = true
    tags = {
      Name = "production-BastionServer"

    }
  }
  source_dest_check = true
  tags = {
    Name = "production-BastionServer"

  }
}

resource "aws_instance" "i_0dc94083aa5bcb1f3" {
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  credit_specification {
    cpu_credits = "standard"
  }
  ebs_block_device {
    delete_on_termination = false
    device_name           = "/dev/sdb"
  }
  enclave_options {
  }
  get_password_data = false
  hibernation       = false
  maintenance_options {
  }
  metadata_options {
  }
  private_dns_name_options {
  }
  root_block_device {
    delete_on_termination = true
  }
  source_dest_check = true
  tags = {
    Name = "dbimport062822"

  }
}

