resource "aws_network_interface" "eni_00156b746e6de45d5" {
  description       = "AWS Lambda VPC ENI-learning-image-publisher-ebdab770-e7c1-4820-832f-5c18841704d0"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0027777d65e38ced2" {
  description       = "ELB app/awseb-AWSEB-1GLHUBRW9EX1B/c961c5120a050a5a"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_005b59357025715b2" {
  description       = "ELB app/awseb-AWSEB-XZ6JUMA8IEE/24c9cf558cf46ee7"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_0088f5ef3b59fb271" {
  description       = "ELB app/awseb-AWSEB-9EQA00IFFDNV/51f5f97fcb37b814"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_00a8f7f7073e71154" {
  description       = "ES shared-01"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_00b71ce2bd08c3a19" {
  description       = "ES shared-01"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_00d0c9ded7b1fadf4" {
  description       = "ELB app/awseb-AWSEB-WCBXFBCA34C9/28d3e2c26d09e522"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_01103380198f6cd17" {
  description       = "ELB app/awseb-AWSEB-1T7NB5B3Y3A7K/10a543629c206331"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_01555261326f3e7a1" {
  description       = "ElastiCache gateway-redis-001"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0158c7c2b8c825363" {
  description       = "ES shared-01"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0178a28865cd096d7" {
  description       = "ElastiCache core-redis3-002"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0186d4c77a969fa83" {
  description       = "ELB app/awseb-AWSEB-XZ6JUMA8IEE/24c9cf558cf46ee7"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_01adea6004154003c" {
  attachment {
    device_index = 0
    instance     = "i-09e1671d59f89f16a"
  }
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_01b2001f9641d8294" {
  description       = "ELB app/awseb-AWSEB-15FYW3NG9H6DT/cbfd3b5d8a0420ba"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_01c6e5eedd01a0d77" {
  description       = "ELB app/awseb-AWSEB-NDZP2R5I5BRY/7faab2bb314013fe"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_01ef0c5e21b5c60d0" {
  description       = "ELB app/awseb-AWSEB-15X3QV41KCHP8/1084d67b6e605d54"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_01ffb564eac20c693" {
  description       = "ELB app/awseb-AWSEB-15FYW3NG9H6DT/cbfd3b5d8a0420ba"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_025296928315a5587" {
  attachment {
    device_index = 0
    instance     = "i-0f0a66787af12d780"
  }
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0296eee65209948e3" {
  description       = "AWS Lambda VPC ENI-identity-saveSignInEvent-cc303349-6129-43f4-9d7c-cd0fd0d3e1ee"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_02a6e66345799e244" {
  description       = "ELB app/awseb-AWSEB-NDZP2R5I5BRY/7faab2bb314013fe"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_02cafd12a28c4aba7" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_02d82443ae6327f9f" {
  attachment {
    device_index = 0
    instance     = "i-03eb275e893951265"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_02e41ea436adbd7f1" {
  description       = "ELB app/awseb-AWSEB-1MDXACYOB2IRQ/56ec1770c583c5c0"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_031edba57a140755f" {
  description       = "AWS Lambda VPC ENI-identity-saveSignInEvent-d72829dc-bae5-4176-97d6-faec32e6f084"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_032278d878fc0bde4" {
  description       = "ELB app/awseb-AWSEB-1MDXACYOB2IRQ/56ec1770c583c5c0"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_033f25fccfecabebd" {
  attachment {
    device_index = 0
    instance     = "i-04f9941552f1cc5d5"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_037eeb6be648082b6" {
  attachment {
    device_index = 0
    instance     = "i-0218964c46045b5ed"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_03933d0313b4a35f9" {
  description       = "ELB app/awseb-AWSEB-XSOHODKYO0N7/76e4011fa2a24353"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_03969871f6b5dd0e2" {
  attachment {
    device_index = 0
    instance     = "i-0262933b142ba0db1"
  }
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_03e33fa183b7d0b10" {
  description       = "ELB app/awseb-AWSEB-1T7NB5B3Y3A7K/10a543629c206331"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_03f17f56fc8591659" {
  attachment {
    device_index = 0
    instance     = "i-054e9f5b39c2bb58e"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_04461607c3bb6893c" {
  description       = "ELB app/awseb-AWSEB-19VCM7V6OTYWF/116e9152168e13d3"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_0455b94ce551f4920" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_04bec1eb62c1cd8f0" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_04ce5312d26b0a52e" {
  description       = "ELB app/awseb-AWSEB-DJD83A7DQHVI/b5d8f12b4fe75607"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_04dad6a8d52a17978" {
  description       = "RDSNetworkInterface"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_054c057d192e04180" {
  description       = "ELB app/awseb-AWSEB-1T7NB5B3Y3A7K/10a543629c206331"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_05e3781a0abff96ae" {
  description       = "ELB app/awseb-AWSEB-DJD83A7DQHVI/b5d8f12b4fe75607"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_05fb3904d6f17418d" {
  description       = "ELB app/awseb-AWSEB-8H0U1SE19616/b167e44c5a2ca844"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_05fe8827ce68f5671" {
  description       = "ELB app/awseb-AWSEB-19VCM7V6OTYWF/116e9152168e13d3"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_060eaa337e306eb93" {
  description       = "ElastiCache core-redis3-001"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_06dcbe9004aad0faf" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_06fac7d3b987d35a6" {
  description       = "ElastiCache general-redis-02-002"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_074cc9d284998b1ef" {
  attachment {
    device_index = 0
    instance     = "i-07bcdbd56b575f73d"
  }
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_076545a7bc3c2b8ec" {
  attachment {
    device_index = 0
    instance     = "i-0af6641d34c6eeb19"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0768e9d51e965bcbe" {
  description       = "ES shared-01"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_078df9fd447a37bf4" {
  description       = "ELB app/awseb-AWSEB-DJD83A7DQHVI/b5d8f12b4fe75607"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_07f1b51443cee2d4c" {
  attachment {
    device_index = 0
    instance     = "i-01c9e4f8de66c969d"
  }
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_07f991884832c6796" {
  attachment {
    device_index = 0
    instance     = "i-06875baad0bc7be5e"
  }
  description       = "Primary network interface"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
  tags = {
    Name = "core-rds-proxy"

  }
}

resource "aws_network_interface" "eni_08102f9664fc2257a" {
  description       = "DMSNetworkInterface"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_081b57d6dd2d34e72" {
  attachment {
    device_index = 0
    instance     = "i-0dc94083aa5bcb1f3"
  }
  description       = "Primary network interface"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_087f1f659a60cfed6" {
  description       = "RDSNetworkInterface"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_08a98548f0efb7d3d" {
  description       = "ELB app/service-infrastructure-internal/fd55d6a9485ddbea"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_09173259b872b37e3" {
  description       = "AWS Lambda VPC ENI-learning-image-publisher-2a580b10-690a-4505-b00a-597542e34e2d"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_091dc3829e3ae1c2c" {
  description       = "ELB app/awseb-AWSEB-XSOHODKYO0N7/76e4011fa2a24353"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_09485f02fe16a3fed" {
  description       = "ELB app/awseb-AWSEB-1W0ZV84FILDNY/0522b81018f9ce52"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_09685d9f264b9b1d1" {
  description       = "Interface for NAT Gateway nat-0a9c5c1c49f952d26"
  source_dest_check = false
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_096dd125cf911b1a5" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_09867869f85097e34" {
  description       = "ELB app/awseb-AWSEB-15FYW3NG9H6DT/cbfd3b5d8a0420ba"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_098ca6eef46cc49f3" {
  description       = "ElastiCache core-redis3-003"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_09eeb36f80d5bd5c9" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_09f85ea46aa06435d" {
  description       = "RDSNetworkInterface"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0a30d4f92c21d2b73" {
  attachment {
    device_index = 0
    instance     = "i-0db65856b9b32287a"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0a66b8e7aba2ca1c4" {
  description       = "AWS Lambda VPC ENI-learning-image-publisher-fa754c90-fda9-4a9b-8b6c-bf82bbdf05d0"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0aa0af140f5d3d18c" {
  attachment {
    device_index = 0
    instance     = "i-0db9986f41eead4f0"
  }
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0ac15067e417d8bbb" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0ae08bef558f0d4fa" {
  description       = "ELB app/awseb-AWSEB-8H0U1SE19616/b167e44c5a2ca844"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_0ae5fcf00de427fb9" {
  attachment {
    device_index = 0
    instance     = "i-0638462115f9b5791"
  }
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0af7c7e2b01a3a5a9" {
  attachment {
    device_index = 0
    instance     = "i-0a5a91dc513886571"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0b4b9c3c82eefb241" {
  description       = "ELB app/service-infrastructure-internal/fd55d6a9485ddbea"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0b58557038bc18675" {
  attachment {
    device_index = 0
    instance     = "i-0df32a46ac1dc8996"
  }
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0bcf9b49d94d47b17" {
  attachment {
    device_index = 0
    instance     = "i-05128580794a1eff8"
  }
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0bf45040652299717" {
  attachment {
    device_index = 0
    instance     = "i-0e58a853ddfa77b65"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0c24bcf5b06d1e365" {
  description       = "ELB app/awseb-AWSEB-NDZP2R5I5BRY/7faab2bb314013fe"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_0c2ae7d56245e0829" {
  description       = "ELB app/awseb-AWSEB-1W0ZV84FILDNY/0522b81018f9ce52"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_0c2cb6f8cf90d2de1" {
  description       = "Interface for NAT Gateway nat-0d8b2f0ad23aa7527"
  source_dest_check = false
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_0c9f8f364bbd31821" {
  description       = "RDSNetworkInterface"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0cb1b80f80f51f3eb" {
  description       = "ELB app/service-infrastructure-internal/fd55d6a9485ddbea"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0cb61d2126d879be6" {
  attachment {
    device_index = 0
    instance     = "i-0147fdcfe8e69e796"
  }
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0cceae62b1e17e68e" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0cf683f03b3944029" {
  description       = "ES shared-01"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0cfbbdf5183ff23dd" {
  description       = "RDSNetworkInterface"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0d010361c41b49589" {
  attachment {
    device_index = 0
    instance     = "i-0eb75240d79b0e380"
  }
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0d476a3eb81043a32" {
  description       = "ELB app/awseb-AWSEB-9EQA00IFFDNV/51f5f97fcb37b814"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_0d61e7a3db793579a" {
  description       = "ElastiCache general-redis-02-001"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0dd2623ca026870ac" {
  description       = "ELB app/awseb-AWSEB-WCBXFBCA34C9/28d3e2c26d09e522"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_0dfd8f3096c9ffa54" {
  description       = "Interface for NAT Gateway nat-0955f97e2eb10272c"
  source_dest_check = false
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_0e5a7f5cf29ac11ff" {
  description       = "ELB app/awseb-AWSEB-1GLHUBRW9EX1B/c961c5120a050a5a"
  source_dest_check = true
  subnet_id         = "subnet-076f8b852c6b60060"
}

resource "aws_network_interface" "eni_0e8b8991d1cfd8a3e" {
  description       = "AWS Lambda VPC ENI-identity-saveSignInEvent-b76c8aef-53f7-43e8-a339-fcc55cb5ee65"
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0e9209079fe927383" {
  attachment {
    device_index = 0
    instance     = "i-0d34f8cb5602f5857"
  }
  description       = "Primary network interface"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
  tags = {
    Name = "production-BastionServer"

  }
}

resource "aws_network_interface" "eni_0f091112b422bb8fe" {
  description       = "ELB app/awseb-AWSEB-1MDXACYOB2IRQ/56ec1770c583c5c0"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_0f1fdd69fb2e22481" {
  attachment {
    device_index = 0
    instance     = "i-0c8a4de7d5781fa5f"
  }
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0f307256e239115b1" {
  description       = "RDSNetworkInterface"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0f8e08f1103e2679a" {
  description       = "ES shared-01"
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0f98f79922a2de4a7" {
  attachment {
    device_index = 0
    instance     = "i-05c05cc8dbf8cfd76"
  }
  source_dest_check = true
  subnet_id         = "subnet-05203dc92b0823553"
}

resource "aws_network_interface" "eni_0fa4283cba1bcafca" {
  description       = "ELB app/awseb-AWSEB-9EQA00IFFDNV/51f5f97fcb37b814"
  source_dest_check = true
  subnet_id         = "subnet-07402e5b661b23bec"
}

resource "aws_network_interface" "eni_0febd2b5f9448b600" {
  description       = "ES shared-02"
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

resource "aws_network_interface" "eni_0fec232fcbe004053" {
  description       = "ELB app/awseb-AWSEB-15X3QV41KCHP8/1084d67b6e605d54"
  source_dest_check = true
  subnet_id         = "subnet-0680aa96bc65f072d"
}

resource "aws_network_interface" "eni_0ff7ca09d6c7aff1d" {
  attachment {
    device_index = 0
    instance     = "i-0f3baa6f6ea2b4c66"
  }
  source_dest_check = true
  subnet_id         = "subnet-04e27b7af0a76d7ee"
}

resource "aws_network_interface" "eni_0ffe9f4f83c8ed6af" {
  attachment {
    device_index = 0
    instance     = "i-0326b5561dd4c3da0"
  }
  source_dest_check = true
  subnet_id         = "subnet-096303542f2113a20"
}

