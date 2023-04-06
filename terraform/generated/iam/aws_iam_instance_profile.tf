resource "aws_iam_instance_profile" "ch_node_profile" {
  path = "/"
  role = "clickhouse_ec2"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_instance_profile" "ec2_default" {
  path = "/"
  role = "ec2_default"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

    Region = "us-east-1"

  }
}

resource "aws_iam_instance_profile" "eks_02c2f245_65a0_9312_546e_2aba1d6e6a34" {
  path = "/"
  role = "az1-4xlarge-eks-node-group-20230124155745065400000006"
}

resource "aws_iam_instance_profile" "eks_14c389a0_2891_7bc4_dc58_41d19310214f" {
  path = "/"
  role = "az3-arm64-eks-node-group-2023032410414449660000000a"
}

resource "aws_iam_instance_profile" "eks_16c37808_9c47_65fe_d976_5d0610534931" {
  path = "/"
  role = "az2-arm64-eks-node-group-20230119111552577000000007"
}

resource "aws_iam_instance_profile" "eks_1cc3a380_baae_0767_982a_fce0ae8b23f1" {
  path = "/"
  role = "az2-arm64-br-eks-node-group-2023040311534853840000000e"
}

resource "aws_iam_instance_profile" "eks_20c3a380_ba5a_cee4_50d5_884a5e38e5bd" {
  path = "/"
  role = "az1-arm64-eks-node-group-20230403115346682300000007"
}

resource "aws_iam_instance_profile" "eks_22c37f1e_b4e7_6d8b_41a1_65797d513a80" {
  path = "/"
  role = "az3-4xlarge-eks-node-group-2023031716524301070000000f"
}

resource "aws_iam_instance_profile" "eks_26c37f1e_b4e4_2e8c_8c57_626a4ec78f94" {
  path = "/"
  role = "az1-4xlarge-eks-node-group-2023031716524215360000000b"
}

resource "aws_iam_instance_profile" "eks_28c389bd_500d_9877_4d9c_34933b382366" {
  path = "/"
  role = "az2-4xlarge-eks-node-group-20230324114603621900000010"
}

resource "aws_iam_instance_profile" "eks_2cc389a0_2869_11e1_beed_369f39c2e341" {
  path = "/"
  role = "az2-arm64-br-eks-node-group-20230324104144290800000005"
}

resource "aws_iam_instance_profile" "eks_2ec2f245_6472_41f0_5f95_959e21b48e01" {
  path = "/"
  role = "az3-4xlarge-eks-node-group-20230124155745058300000004"
}

resource "aws_iam_instance_profile" "eks_30c37838_3777_a1df_3644_04040182940d" {
  path = "/"
  role = "az3-4xlarge-eks-node-group-20220823125548120400000008"
}

resource "aws_iam_instance_profile" "eks_32c37838_378b_1f94_92ff_b3e7f3e0b76f" {
  path = "/"
  role = "az2-arm64-eks-node-group-20230119111552577000000007"
}

resource "aws_iam_instance_profile" "eks_38c389bd_4a71_7bee_c335_f55fc73b65e7" {
  path = "/"
  role = "az3-4xlarge-eks-node-group-2023032411460362100000000f"
}

resource "aws_iam_instance_profile" "eks_3ec37810_0e9a_ebd7_baec_92ca92dfc6bd" {
  path = "/"
  role = "az2-arm64-eks-node-group-20230119111552577000000007"
}

resource "aws_iam_instance_profile" "eks_3ec389a0_28d3_96c2_362d_c9ec9f8eb95a" {
  path = "/"
  role = "az2-arm64-eks-node-group-20230324104144293600000007"
}

resource "aws_iam_instance_profile" "eks_40c37808_9c46_c30a_df75_e61c7cbbb62a" {
  path = "/"
  role = "az1-4xlarge-eks-node-group-20220823125548116500000007"
}

resource "aws_iam_instance_profile" "eks_4cc37838_3786_1f0f_3bbc_2553b6c97f66" {
  path = "/"
  role = "az1-arm64-eks-node-group-20230119111552802300000008"
}

resource "aws_iam_instance_profile" "eks_4cc37f1e_b4e9_720e_f3ed_4a4297ecd8cf" {
  path = "/"
  role = "az2-4xlarge-eks-node-group-20230317165241279100000006"
}

resource "aws_iam_instance_profile" "eks_4cc389bd_4a48_5e93_7dee_dbc32ead9029" {
  path = "/"
  role = "az3-arm64-eks-node-group-20230324114602108600000006"
}

resource "aws_iam_instance_profile" "eks_4ec37f1e_b4e2_9512_2e84_6df3164c1b9d" {
  path = "/"
  role = "az1-arm64-eks-node-group-2023031716524216890000000c"
}

resource "aws_iam_instance_profile" "eks_4ec389bd_4e5a_0141_f15d_d22a98035fae" {
  path = "/"
  role = "az2-arm64-eks-node-group-2023032411460269400000000c"
}

resource "aws_iam_instance_profile" "eks_54c37f1e_b4f5_b419_90d5_61f19d340492" {
  path = "/"
  role = "az3-arm64-eks-node-group-2023031716524290590000000e"
}

resource "aws_iam_instance_profile" "eks_56c37fca_8237_d85b_6edb_b9197a3ff13a" {
  path = "/"
  role = "az2-arm64-br-eks-node-group-20230320151316428000000002"
}

resource "aws_iam_instance_profile" "eks_5ec389bd_48b1_7286_f4d4_7e3c6b790236" {
  path = "/"
  role = "az1-arm64-eks-node-group-2023032411460262940000000b"
}

resource "aws_iam_instance_profile" "eks_60c2f245_6555_5f5d_a3d3_df7e82c9464b" {
  path = "/"
  role = "az1-arm64-eks-node-group-20230124155745066900000009"
}

resource "aws_iam_instance_profile" "eks_7cc389a0_29ca_fe23_355a_867ae3780ba3" {
  path = "/"
  role = "az1-4xlarge-eks-node-group-20230324104144291700000006"
}

resource "aws_iam_instance_profile" "eks_80c2f245_6540_472d_644f_75ec29ce455a" {
  path = "/"
  role = "az2-arm64-eks-node-group-20230124155745059900000005"
}

resource "aws_iam_instance_profile" "eks_80c389a0_285a_8c61_2739_39ee55610ed3" {
  path = "/"
  role = "az1-arm64-eks-node-group-20230324104144295600000008"
}

resource "aws_iam_instance_profile" "eks_8ac37838_37a1_cf00_bd30_f11c3a4b2a88" {
  path = "/"
  role = "az1-4xlarge-eks-node-group-20220823125548116500000007"
}

resource "aws_iam_instance_profile" "eks_90c2f245_6565_9a87_d0f0_ada8deb3f638" {
  path = "/"
  role = "az3-arm64-eks-node-group-20230124155745066600000008"
}

resource "aws_iam_instance_profile" "eks_92c3a380_bbde_6e29_1289_acfde42766e7" {
  path = "/"
  role = "az1-4xlarge-eks-node-group-2023040311534749630000000c"
}

resource "aws_iam_instance_profile" "eks_9cc3a380_ba51_5bc4_9831_10de83cfae98" {
  path = "/"
  role = "az2-arm64-eks-node-group-20230403115348557700000010"
}

resource "aws_iam_instance_profile" "eks_9ec37810_0e9e_6f1d_8376_4d0923372aa3" {
  path = "/"
  role = "az2-4xlarge-eks-node-group-20220823125548127600000009"
}

resource "aws_iam_instance_profile" "eks_a8c37810_0e9a_e891_b108_b67e2e65896d" {
  path = "/"
  role = "az1-4xlarge-eks-node-group-20220823125548116500000007"
}

resource "aws_iam_instance_profile" "eks_a8c3a380_baed_02f0_b38d_2ff1abefcf9c" {
  path = "/"
  role = "az3-arm64-eks-node-group-2023040311534854510000000f"
}

resource "aws_iam_instance_profile" "eks_b2c389bd_48c0_1e48_23f4_f9ab464b2bb4" {
  path = "/"
  role = "az2-arm64-br-eks-node-group-2023032411460319150000000d"
}

resource "aws_iam_instance_profile" "eks_c6c37810_0eb0_7126_93fb_8174a0af44c3" {
  path = "/"
  role = "az1-arm64-eks-node-group-20230119111552802300000008"
}

resource "aws_iam_instance_profile" "eks_c8c37838_3776_bb61_fb4c_961749c6a26c" {
  path = "/"
  role = "az3-arm64-eks-node-group-20230119111552912300000009"
}

resource "aws_iam_instance_profile" "eks_cac37838_3779_890f_b451_53437736a10e" {
  path = "/"
  role = "az2-4xlarge-eks-node-group-20220823125548127600000009"
}

resource "aws_iam_instance_profile" "eks_d2c37808_9c4f_0c69_0699_39b0d0162e8c" {
  path = "/"
  role = "az3-4xlarge-eks-node-group-20220823125548120400000008"
}

resource "aws_iam_instance_profile" "eks_d2c389a0_2881_aa27_c061_41b0d832783d" {
  path = "/"
  role = "az2-4xlarge-eks-node-group-20230324104144296000000009"
}

resource "aws_iam_instance_profile" "eks_d4c2f245_6555_4c4f_f2b0_1a680bdd7986" {
  path = "/"
  role = "az2-4xlarge-eks-node-group-2023012415574590030000000f"
}

resource "aws_iam_instance_profile" "eks_d6c37810_0e9b_75fe_953e_2766d928a34f" {
  path = "/"
  role = "az3-4xlarge-eks-node-group-20220823125548120400000008"
}

resource "aws_iam_instance_profile" "eks_dac3a380_ba66_ca3e_c5a4_ec7fa26d77ee" {
  path = "/"
  role = "az3-4xlarge-eks-node-group-2023040311534820340000000d"
}

resource "aws_iam_instance_profile" "eks_dcc389bd_48b6_757a_69f5_6cd70e0d86b3" {
  path = "/"
  role = "az1-4xlarge-eks-node-group-2023032411460326330000000e"
}

resource "aws_iam_instance_profile" "eks_dec37810_0ea0_324c_33e9_da838c099c13" {
  path = "/"
  role = "az3-arm64-eks-node-group-20230119111552912300000009"
}

resource "aws_iam_instance_profile" "eks_e0c3a380_bab0_83eb_8e26_78a47932265a" {
  path = "/"
  role = "az2-4xlarge-eks-node-group-20230403115348617400000011"
}

resource "aws_iam_instance_profile" "eks_e6c37f1e_b4f8_254f_6862_1bd8e5c5d8bd" {
  path = "/"
  role = "az2-arm64-br-eks-node-group-20230320085759617700000002"
}

resource "aws_iam_instance_profile" "eks_ecc37808_9c4a_7b02_188e_7df33610a735" {
  path = "/"
  role = "az2-4xlarge-eks-node-group-20220823125548127600000009"
}

resource "aws_iam_instance_profile" "eks_f4c37f1e_b4e0_be54_cb01_aa4197aeadef" {
  path = "/"
  role = "az2-arm64-eks-node-group-2023031716524286450000000d"
}

resource "aws_iam_instance_profile" "eks_fac389a0_275d_e8a8_0db7_9aab2a7d43bc" {
  path = "/"
  role = "az3-4xlarge-eks-node-group-2023032410414490570000000b"
}

resource "aws_iam_instance_profile" "eks_fcc37808_9c4b_20e0_bbe5_3c2492d2c313" {
  path = "/"
  role = "az1-arm64-eks-node-group-20230119111552802300000008"
}

resource "aws_iam_instance_profile" "eks_fcc37808_9c4b_d87b_fabf_ea8a620078bd" {
  path = "/"
  role = "az3-arm64-eks-node-group-20230119111552912300000009"
}

resource "aws_iam_instance_profile" "test_ch_pr_1377_ch_node_profile" {
  path = "/"
  role = "test_ch_pr_1377_clickhouse_ec2"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_instance_profile" "test_ch_pr_218__node_profile" {
  path = "/"
  role = "test_ch_pr_218_clickhouse_ec2"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_instance_profile" "test_ch_pr_229__node_profile" {
  path = "/"
  role = "test_ch_pr_229_clickhouse_ec2"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_instance_profile" "test_ch_pr_230__node_profile" {
  path = "/"
  role = "test_ch_pr_230_clickhouse_ec2"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

resource "aws_iam_instance_profile" "test_ch_pr_485__node_profile" {
  path = "/"
  role = "test_ch_pr_485_clickhouse_ec2"
  tags = {
    Environment = "dev"

    ManagedByTerraform = "true"

  }
}

