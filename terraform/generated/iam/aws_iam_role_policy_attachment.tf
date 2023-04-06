resource "aws_iam_role_policy_attachment" "AWSReservedSSO_administrators_0904d7a089e60584_policy_AdministratorAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = "AWSReservedSSO_administrators_0904d7a089e60584"
}

resource "aws_iam_role_policy_attachment" "AWSReservedSSO_developers_0847e649a00cc5e7_policy_PowerUserAccess" {
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  role       = "AWSReservedSSO_developers_0847e649a00cc5e7"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAmazonEKSForFargate_policy_aws_service_role_AmazonEKSForFargateServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonEKSForFargateServiceRolePolicy"
  role       = "AWSServiceRoleForAmazonEKSForFargate"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAmazonEKSNodegroup_policy_aws_service_role_AWSServiceRoleForAmazonEKSNodegroup" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSServiceRoleForAmazonEKSNodegroup"
  role       = "AWSServiceRoleForAmazonEKSNodegroup"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAmazonEKS_policy_aws_service_role_AmazonEKSServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonEKSServiceRolePolicy"
  role       = "AWSServiceRoleForAmazonEKS"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAmazonGuardDuty_policy_aws_service_role_AmazonGuardDutyServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonGuardDutyServiceRolePolicy"
  role       = "AWSServiceRoleForAmazonGuardDuty"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAmazonSSM_policy_aws_service_role_AmazonSSMServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonSSMServiceRolePolicy"
  role       = "AWSServiceRoleForAmazonSSM"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForAutoScaling_policy_aws_service_role_AutoScalingServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AutoScalingServiceRolePolicy"
  role       = "AWSServiceRoleForAutoScaling"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForBackup_policy_aws_service_role_AWSBackupServiceLinkedRolePolicyForBackup" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSBackupServiceLinkedRolePolicyForBackup"
  role       = "AWSServiceRoleForBackup"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForClientVPNConnections_policy_aws_service_role_ClientVPNServiceConnectionsRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/ClientVPNServiceConnectionsRolePolicy"
  role       = "AWSServiceRoleForClientVPNConnections"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForClientVPN_policy_aws_service_role_ClientVPNServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/ClientVPNServiceRolePolicy"
  role       = "AWSServiceRoleForClientVPN"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForCloudFormationStackSetsOrgMember_policy_aws_service_role_CloudFormationStackSetsOrgMemberServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/CloudFormationStackSetsOrgMemberServiceRolePolicy"
  role       = "AWSServiceRoleForCloudFormationStackSetsOrgMember"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForCloudFrontLogger_policy_aws_service_role_AWSCloudFrontLogger" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSCloudFrontLogger"
  role       = "AWSServiceRoleForCloudFrontLogger"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForCloudTrail_policy_aws_service_role_CloudTrailServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/CloudTrailServiceRolePolicy"
  role       = "AWSServiceRoleForCloudTrail"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForConfig_policy_aws_service_role_AWSConfigServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSConfigServiceRolePolicy"
  role       = "AWSServiceRoleForConfig"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForElastiCache_policy_aws_service_role_ElastiCacheServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/ElastiCacheServiceRolePolicy"
  role       = "AWSServiceRoleForElastiCache"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForElasticLoadBalancing_policy_aws_service_role_AWSElasticLoadBalancingServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSElasticLoadBalancingServiceRolePolicy"
  role       = "AWSServiceRoleForElasticLoadBalancing"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForGlobalAccelerator_policy_aws_service_role_AWSGlobalAcceleratorSLRPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSGlobalAcceleratorSLRPolicy"
  role       = "AWSServiceRoleForGlobalAccelerator"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForKafkaConnect_policy_aws_service_role_KafkaConnectServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/KafkaConnectServiceRolePolicy"
  role       = "AWSServiceRoleForKafkaConnect"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForKafka_policy_aws_service_role_KafkaServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/KafkaServiceRolePolicy"
  role       = "AWSServiceRoleForKafka"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForLambdaReplicator_policy_aws_service_role_AWSLambdaReplicator" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSLambdaReplicator"
  role       = "AWSServiceRoleForLambdaReplicator"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForOrganizations_policy_aws_service_role_AWSOrganizationsServiceTrustPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSOrganizationsServiceTrustPolicy"
  role       = "AWSServiceRoleForOrganizations"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForRDS_policy_aws_service_role_AmazonRDSServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonRDSServiceRolePolicy"
  role       = "AWSServiceRoleForRDS"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForSSO_policy_aws_service_role_AWSSSOServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSSSOServiceRolePolicy"
  role       = "AWSServiceRoleForSSO"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForSecurityHub_policy_aws_service_role_AWSSecurityHubServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSSecurityHubServiceRolePolicy"
  role       = "AWSServiceRoleForSecurityHub"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForServiceQuotas_policy_aws_service_role_ServiceQuotasServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/ServiceQuotasServiceRolePolicy"
  role       = "AWSServiceRoleForServiceQuotas"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForSupport_policy_aws_service_role_AWSSupportServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSSupportServiceRolePolicy"
  role       = "AWSServiceRoleForSupport"
}

resource "aws_iam_role_policy_attachment" "AWSServiceRoleForTrustedAdvisor_policy_aws_service_role_AWSTrustedAdvisorServiceRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSTrustedAdvisorServiceRolePolicy"
  role       = "AWSServiceRoleForTrustedAdvisor"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_EBS_CSI_DriverRole_policy_KMS_Key_For_Encryption_On_EBS_Policy" {
  policy_arn = "arn:aws:iam::169684386827:policy/KMS_Key_For_Encryption_On_EBS_Policy"
  role       = "AmazonEKS_EBS_CSI_DriverRole"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_EBS_CSI_DriverRole_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "AmazonEKS_EBS_CSI_DriverRole"
}

resource "aws_iam_role_policy_attachment" "DrataAutopilotRole_policy_SecurityAudit" {
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
  role       = "DrataAutopilotRole"
}

resource "aws_iam_role_policy_attachment" "OrganizationAccountAccessRole_policy_AdministratorAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = "OrganizationAccountAccessRole"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20220818161915282900000006_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-20220818161915282900000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20220818161915282900000006_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-20220818161915282900000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20220818161915282900000006_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-20220818161915282900000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20220823125548116500000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-20220823125548116500000007"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20220823125548116500000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-20220823125548116500000007"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20220823125548116500000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-20220823125548116500000007"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20220823125548116500000007_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az1-4xlarge-eks-node-group-20220823125548116500000007"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20220823125548116500000007_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az1-4xlarge-eks-node-group-20220823125548116500000007"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221020153002485400000006_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-20221020153002485400000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221020153002485400000006_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-20221020153002485400000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221020153002485400000006_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-20221020153002485400000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221102203257004000000009_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-20221102203257004000000009"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221102203257004000000009_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-20221102203257004000000009"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221102203257004000000009_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-20221102203257004000000009"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221110172120390200000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-20221110172120390200000007"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221110172120390200000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-20221110172120390200000007"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20221110172120390200000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-20221110172120390200000007"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20230124155745065400000006_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-20230124155745065400000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20230124155745065400000006_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-20230124155745065400000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20230124155745065400000006_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-20230124155745065400000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023031716524215360000000b_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-2023031716524215360000000b"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023031716524215360000000b_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-2023031716524215360000000b"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023031716524215360000000b_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-2023031716524215360000000b"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20230324104144291700000006_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-20230324104144291700000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20230324104144291700000006_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-20230324104144291700000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_20230324104144291700000006_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-20230324104144291700000006"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023032411460326330000000e_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-2023032411460326330000000e"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023032411460326330000000e_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-2023032411460326330000000e"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023032411460326330000000e_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-2023032411460326330000000e"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023032411460326330000000e_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az1-4xlarge-eks-node-group-2023032411460326330000000e"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023032411460326330000000e_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az1-4xlarge-eks-node-group-2023032411460326330000000e"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023040311534749630000000c_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-4xlarge-eks-node-group-2023040311534749630000000c"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023040311534749630000000c_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-4xlarge-eks-node-group-2023040311534749630000000c"
}

resource "aws_iam_role_policy_attachment" "az1_4xlarge_eks_node_group_2023040311534749630000000c_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-4xlarge-eks-node-group-2023040311534749630000000c"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230119111552802300000008_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-arm64-eks-node-group-20230119111552802300000008"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230119111552802300000008_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-arm64-eks-node-group-20230119111552802300000008"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230119111552802300000008_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-arm64-eks-node-group-20230119111552802300000008"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230119111552802300000008_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az1-arm64-eks-node-group-20230119111552802300000008"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230119111552802300000008_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az1-arm64-eks-node-group-20230119111552802300000008"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230124155745066900000009_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-arm64-eks-node-group-20230124155745066900000009"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230124155745066900000009_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-arm64-eks-node-group-20230124155745066900000009"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230124155745066900000009_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-arm64-eks-node-group-20230124155745066900000009"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230124155745066900000009_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az1-arm64-eks-node-group-20230124155745066900000009"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230124155745066900000009_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az1-arm64-eks-node-group-20230124155745066900000009"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023031716524216890000000c_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-arm64-eks-node-group-2023031716524216890000000c"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023031716524216890000000c_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-arm64-eks-node-group-2023031716524216890000000c"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023031716524216890000000c_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-arm64-eks-node-group-2023031716524216890000000c"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023031716524216890000000c_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az1-arm64-eks-node-group-2023031716524216890000000c"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023031716524216890000000c_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az1-arm64-eks-node-group-2023031716524216890000000c"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230324104144295600000008_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-arm64-eks-node-group-20230324104144295600000008"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230324104144295600000008_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-arm64-eks-node-group-20230324104144295600000008"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230324104144295600000008_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-arm64-eks-node-group-20230324104144295600000008"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023032411460262940000000b_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-arm64-eks-node-group-2023032411460262940000000b"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023032411460262940000000b_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-arm64-eks-node-group-2023032411460262940000000b"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023032411460262940000000b_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-arm64-eks-node-group-2023032411460262940000000b"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023032411460262940000000b_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az1-arm64-eks-node-group-2023032411460262940000000b"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_2023032411460262940000000b_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az1-arm64-eks-node-group-2023032411460262940000000b"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230403115346682300000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az1-arm64-eks-node-group-20230403115346682300000007"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230403115346682300000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az1-arm64-eks-node-group-20230403115346682300000007"
}

resource "aws_iam_role_policy_attachment" "az1_arm64_eks_node_group_20230403115346682300000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az1-arm64-eks-node-group-20230403115346682300000007"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20220818161915279400000004_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20220818161915279400000004"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20220818161915279400000004_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20220818161915279400000004"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20220818161915279400000004_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20220818161915279400000004"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20220823125548127600000009_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20220823125548127600000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20220823125548127600000009_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20220823125548127600000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20220823125548127600000009_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20220823125548127600000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20220823125548127600000009_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az2-4xlarge-eks-node-group-20220823125548127600000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20220823125548127600000009_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az2-4xlarge-eks-node-group-20220823125548127600000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221020153002486200000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20221020153002486200000007"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221020153002486200000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20221020153002486200000007"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221020153002486200000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20221020153002486200000007"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221102203256999900000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20221102203256999900000007"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221102203256999900000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20221102203256999900000007"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221102203256999900000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20221102203256999900000007"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221110172120391000000008_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20221110172120391000000008"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221110172120391000000008_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20221110172120391000000008"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20221110172120391000000008_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20221110172120391000000008"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_2023012415574590030000000f_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-2023012415574590030000000f"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_2023012415574590030000000f_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-2023012415574590030000000f"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_2023012415574590030000000f_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-2023012415574590030000000f"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230317165241279100000006_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20230317165241279100000006"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230317165241279100000006_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20230317165241279100000006"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230317165241279100000006_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20230317165241279100000006"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230324104144296000000009_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20230324104144296000000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230324104144296000000009_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20230324104144296000000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230324104144296000000009_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20230324104144296000000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230324104144296000000009_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az2-4xlarge-eks-node-group-20230324104144296000000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230324104144296000000009_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az2-4xlarge-eks-node-group-20230324104144296000000009"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230324114603621900000010_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20230324114603621900000010"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230324114603621900000010_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20230324114603621900000010"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230324114603621900000010_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20230324114603621900000010"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230403115348617400000011_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-4xlarge-eks-node-group-20230403115348617400000011"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230403115348617400000011_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-4xlarge-eks-node-group-20230403115348617400000011"
}

resource "aws_iam_role_policy_attachment" "az2_4xlarge_eks_node_group_20230403115348617400000011_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-4xlarge-eks-node-group-20230403115348617400000011"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320085759617700000002_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-br-eks-node-group-20230320085759617700000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320085759617700000002_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-br-eks-node-group-20230320085759617700000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320085759617700000002_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-br-eks-node-group-20230320085759617700000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320085759617700000002_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az2-arm64-br-eks-node-group-20230320085759617700000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320085759617700000002_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az2-arm64-br-eks-node-group-20230320085759617700000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320151316428000000002_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-br-eks-node-group-20230320151316428000000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320151316428000000002_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-br-eks-node-group-20230320151316428000000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320151316428000000002_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-br-eks-node-group-20230320151316428000000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320151316428000000002_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az2-arm64-br-eks-node-group-20230320151316428000000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230320151316428000000002_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az2-arm64-br-eks-node-group-20230320151316428000000002"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230324104144290800000005_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-br-eks-node-group-20230324104144290800000005"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230324104144290800000005_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-br-eks-node-group-20230324104144290800000005"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230324104144290800000005_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-br-eks-node-group-20230324104144290800000005"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230324104144290800000005_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az2-arm64-br-eks-node-group-20230324104144290800000005"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_20230324104144290800000005_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az2-arm64-br-eks-node-group-20230324104144290800000005"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023032411460319150000000d_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-br-eks-node-group-2023032411460319150000000d"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023032411460319150000000d_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-br-eks-node-group-2023032411460319150000000d"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023032411460319150000000d_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-br-eks-node-group-2023032411460319150000000d"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023032411460319150000000d_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az2-arm64-br-eks-node-group-2023032411460319150000000d"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023032411460319150000000d_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az2-arm64-br-eks-node-group-2023032411460319150000000d"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023040311534853840000000e_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-br-eks-node-group-2023040311534853840000000e"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023040311534853840000000e_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-br-eks-node-group-2023040311534853840000000e"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023040311534853840000000e_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-br-eks-node-group-2023040311534853840000000e"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_br_eks_node_group_2023040311534853840000000e_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az2-arm64-br-eks-node-group-2023040311534853840000000e"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230119111552577000000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-eks-node-group-20230119111552577000000007"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230119111552577000000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-eks-node-group-20230119111552577000000007"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230119111552577000000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-eks-node-group-20230119111552577000000007"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230119111552577000000007_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az2-arm64-eks-node-group-20230119111552577000000007"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230119111552577000000007_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az2-arm64-eks-node-group-20230119111552577000000007"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230124155745059900000005_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-eks-node-group-20230124155745059900000005"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230124155745059900000005_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-eks-node-group-20230124155745059900000005"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230124155745059900000005_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-eks-node-group-20230124155745059900000005"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_2023031716524286450000000d_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-eks-node-group-2023031716524286450000000d"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_2023031716524286450000000d_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-eks-node-group-2023031716524286450000000d"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_2023031716524286450000000d_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-eks-node-group-2023031716524286450000000d"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230324104144293600000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-eks-node-group-20230324104144293600000007"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230324104144293600000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-eks-node-group-20230324104144293600000007"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230324104144293600000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-eks-node-group-20230324104144293600000007"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_2023032411460269400000000c_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-eks-node-group-2023032411460269400000000c"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_2023032411460269400000000c_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-eks-node-group-2023032411460269400000000c"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_2023032411460269400000000c_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-eks-node-group-2023032411460269400000000c"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230403115348557700000010_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az2-arm64-eks-node-group-20230403115348557700000010"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230403115348557700000010_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az2-arm64-eks-node-group-20230403115348557700000010"
}

resource "aws_iam_role_policy_attachment" "az2_arm64_eks_node_group_20230403115348557700000010_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az2-arm64-eks-node-group-20230403115348557700000010"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20220818161915283400000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-20220818161915283400000007"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20220818161915283400000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-20220818161915283400000007"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20220818161915283400000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-20220818161915283400000007"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20220823125548120400000008_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-20220823125548120400000008"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20220823125548120400000008_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-20220823125548120400000008"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20220823125548120400000008_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-20220823125548120400000008"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20220823125548120400000008_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az3-4xlarge-eks-node-group-20220823125548120400000008"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20220823125548120400000008_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az3-4xlarge-eks-node-group-20220823125548120400000008"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221020153002486900000008_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-20221020153002486900000008"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221020153002486900000008_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-20221020153002486900000008"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221020153002486900000008_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-20221020153002486900000008"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221102203256987300000004_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-20221102203256987300000004"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221102203256987300000004_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-20221102203256987300000004"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221102203256987300000004_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-20221102203256987300000004"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221110172120392000000009_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-20221110172120392000000009"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221110172120392000000009_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-20221110172120392000000009"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20221110172120392000000009_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-20221110172120392000000009"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20230124155745058300000004_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-20230124155745058300000004"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20230124155745058300000004_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-20230124155745058300000004"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20230124155745058300000004_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-20230124155745058300000004"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20230124155745058300000004_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az3-4xlarge-eks-node-group-20230124155745058300000004"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_20230124155745058300000004_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az3-4xlarge-eks-node-group-20230124155745058300000004"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023031716524301070000000f_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-2023031716524301070000000f"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023031716524301070000000f_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-2023031716524301070000000f"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023031716524301070000000f_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-2023031716524301070000000f"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023032410414490570000000b_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-2023032410414490570000000b"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023032410414490570000000b_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-2023032410414490570000000b"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023032410414490570000000b_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-2023032410414490570000000b"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023032411460362100000000f_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-2023032411460362100000000f"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023032411460362100000000f_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-2023032411460362100000000f"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023032411460362100000000f_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-2023032411460362100000000f"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023040311534820340000000d_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-4xlarge-eks-node-group-2023040311534820340000000d"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023040311534820340000000d_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-4xlarge-eks-node-group-2023040311534820340000000d"
}

resource "aws_iam_role_policy_attachment" "az3_4xlarge_eks_node_group_2023040311534820340000000d_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-4xlarge-eks-node-group-2023040311534820340000000d"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230119111552912300000009_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-arm64-eks-node-group-20230119111552912300000009"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230119111552912300000009_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-arm64-eks-node-group-20230119111552912300000009"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230119111552912300000009_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-arm64-eks-node-group-20230119111552912300000009"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230119111552912300000009_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az3-arm64-eks-node-group-20230119111552912300000009"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230119111552912300000009_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az3-arm64-eks-node-group-20230119111552912300000009"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230124155745066600000008_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-arm64-eks-node-group-20230124155745066600000008"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230124155745066600000008_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-arm64-eks-node-group-20230124155745066600000008"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230124155745066600000008_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-arm64-eks-node-group-20230124155745066600000008"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023031716524290590000000e_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-arm64-eks-node-group-2023031716524290590000000e"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023031716524290590000000e_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-arm64-eks-node-group-2023031716524290590000000e"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023031716524290590000000e_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-arm64-eks-node-group-2023031716524290590000000e"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023031716524290590000000e_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "az3-arm64-eks-node-group-2023031716524290590000000e"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023031716524290590000000e_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "az3-arm64-eks-node-group-2023031716524290590000000e"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023032410414449660000000a_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-arm64-eks-node-group-2023032410414449660000000a"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023032410414449660000000a_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-arm64-eks-node-group-2023032410414449660000000a"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023032410414449660000000a_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-arm64-eks-node-group-2023032410414449660000000a"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230324114602108600000006_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-arm64-eks-node-group-20230324114602108600000006"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230324114602108600000006_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-arm64-eks-node-group-20230324114602108600000006"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_20230324114602108600000006_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-arm64-eks-node-group-20230324114602108600000006"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023040311534854510000000f_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "az3-arm64-eks-node-group-2023040311534854510000000f"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023040311534854510000000f_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "az3-arm64-eks-node-group-2023040311534854510000000f"
}

resource "aws_iam_role_policy_attachment" "az3_arm64_eks_node_group_2023040311534854510000000f_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "az3-arm64-eks-node-group-2023040311534854510000000f"
}

resource "aws_iam_role_policy_attachment" "clickhouse_ec2_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "clickhouse_ec2_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "clickhouse_ec2_policy_ch_get_tls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/ch_get_tls_secrets"
  role       = "clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "cognito_auth_role_policy_cognito_auth_ssm_policy" {
  policy_arn = "arn:aws:iam::169684386827:policy/cognito_auth-ssm-policy"
  role       = "cognito_auth-role"
}

resource "aws_iam_role_policy_attachment" "default_20220523131651400000000002_policy_AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = "default-20220523131651400000000002"
}

resource "aws_iam_role_policy_attachment" "default_20220523131651400000000002_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "default-20220523131651400000000002"
}

resource "aws_iam_role_policy_attachment" "ec2_default_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "ec2_default"
}

resource "aws_iam_role_policy_attachment" "ec2_default_policy_AmazonSSMPatchAssociation" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = "ec2_default"
}

resource "aws_iam_role_policy_attachment" "ec2_default_policy_CloudWatchAgentServerPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = "ec2_default"
}

resource "aws_iam_role_policy_attachment" "ec2_default_policy_get_internal_ec2_keypair_from_secretsmanager" {
  policy_arn = "arn:aws:iam::169684386827:policy/get_internal_ec2_keypair_from_secretsmanager"
  role       = "ec2_default"
}

resource "aws_iam_role_policy_attachment" "ec2_default_policy_get_posthog_ca_from_secretsmanager" {
  policy_arn = "arn:aws:iam::169684386827:policy/get_posthog_ca_from_secretsmanager"
  role       = "ec2_default"
}

resource "aws_iam_role_policy_attachment" "github_terraform_infra_role_policy_terraform_role" {
  policy_arn = "arn:aws:iam::169684386827:policy/terraform-role"
  role       = "github-terraform-infra-role"
}

resource "aws_iam_role_policy_attachment" "kube_system_20220523131651399400000001_policy_AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = "kube-system-20220523131651399400000001"
}

resource "aws_iam_role_policy_attachment" "kube_system_20220523131651399400000001_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "kube-system-20220523131651399400000001"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220523131651404200000007_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "nodes-eks-node-group-20220523131651404200000007"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220523131651404200000007_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "nodes-eks-node-group-20220523131651404200000007"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220523131651404200000007_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "nodes-eks-node-group-20220523131651404200000007"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220602125147928200000004_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "nodes-eks-node-group-20220602125147928200000004"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220602125147928200000004_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "nodes-eks-node-group-20220602125147928200000004"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220602125147928200000004_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "nodes-eks-node-group-20220602125147928200000004"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220616115441134600000003_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "nodes-eks-node-group-20220616115441134600000003"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220616115441134600000003_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "nodes-eks-node-group-20220616115441134600000003"
}

resource "aws_iam_role_policy_attachment" "nodes_eks_node_group_20220616115441134600000003_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "nodes-eks-node-group-20220616115441134600000003"
}

resource "aws_iam_role_policy_attachment" "posthog_dev_aws_load_balancer_controller_policy_service_posthog_dev_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/posthog-dev/posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "posthog_dev_cluster_20220429143555706600000004_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "posthog-dev-cluster-20220429143555706600000004"
}

resource "aws_iam_role_policy_attachment" "posthog_dev_cluster_20220429143555706600000004_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "posthog-dev-cluster-20220429143555706600000004"
}

resource "aws_iam_role_policy_attachment" "posthog_dev_cluster_autoscaler_policy_posthog_dev_worker_autoscaling20220503143630354100000003" {
  policy_arn = "arn:aws:iam::169684386827:policy/posthog-dev-worker-autoscaling20220503143630354100000003"
  role       = "posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "posthog_dev_ebs_csi_driver_policy_posthog_dev_ebs_csi_driver20221014160624289300000001" {
  policy_arn = "arn:aws:iam::169684386827:policy/posthog-dev-ebs-csi-driver20221014160624289300000001"
  role       = "posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "posthog_dev_external_dns_policy_posthog_dev_external_dns20220506104822640100000001" {
  policy_arn = "arn:aws:iam::169684386827:policy/posthog-dev-external-dns20220506104822640100000001"
  role       = "posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "rds_backup_service_role_us_east_1_policy_service_role_AWSBackupServiceRolePolicyForBackup" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = "rds-backup-service-role-us-east-1"
}

resource "aws_iam_role_policy_attachment" "secrettest_role_4c20jvwx_policy_service_role_AWSLambdaBasicExecutionRole_1331fe92_9d01_4713_a7d8_bdcf48878ddc" {
  policy_arn = "arn:aws:iam::169684386827:policy/service-role/AWSLambdaBasicExecutionRole-1331fe92-9d01-4713-a7d8-bdcf48878ddc"
  role       = "secrettest-role-4c20jvwx"
}

resource "aws_iam_role_policy_attachment" "secrettest_role_4c20jvwx_policy_service_role_AWSLambdaVPCAccessExecutionRole_d6b7ff65_2a11_439b_a5b9_a9e156598ab9" {
  policy_arn = "arn:aws:iam::169684386827:policy/service-role/AWSLambdaVPCAccessExecutionRole-d6b7ff65-2a11-439b-a5b9-a9e156598ab9"
  role       = "secrettest-role-4c20jvwx"
}

resource "aws_iam_role_policy_attachment" "spacelift_policy_AdministratorAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = "spacelift"
}

resource "aws_iam_role_policy_attachment" "stacksets_exec_a2fbe04951ccdbbedf46c50187226295_policy_AdministratorAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = "stacksets-exec-a2fbe04951ccdbbedf46c50187226295"
}

resource "aws_iam_role_policy_attachment" "terraform_20221006010416860700000001_policy_service_role_AmazonRDSEnhancedMonitoringRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  role       = "terraform-20221006010416860700000001"
}

resource "aws_iam_role_policy_attachment" "terraform_20221006013829304700000001_policy_service_role_AmazonRDSEnhancedMonitoringRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  role       = "terraform-20221006013829304700000001"
}

resource "aws_iam_role_policy_attachment" "terraform_20221128125119272600000001_policy_service_role_AmazonRDSEnhancedMonitoringRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  role       = "terraform-20221128125119272600000001"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_1377_clickhouse_ec2_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "test_ch_pr_1377_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_1377_clickhouse_ec2_policy_test_ch_pr_1377_ch_get_tls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test_ch_pr_1377_ch_get_tls_secrets"
  role       = "test_ch_pr_1377_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_218_clickhouse_ec2_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "test_ch_pr_218_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_218_clickhouse_ec2_policy_test_ch_pr_218_ch_get_tls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test_ch_pr_218_ch_get_tls_secrets"
  role       = "test_ch_pr_218_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_218_clickhouse_ec2_policy_test_ch_pr_218_get_kafka_mtls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-ch-pr-218-get_kafka_mtls_secrets"
  role       = "test_ch_pr_218_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_229_clickhouse_ec2_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "test_ch_pr_229_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_229_clickhouse_ec2_policy_test_ch_pr_229_ch_get_tls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test_ch_pr_229_ch_get_tls_secrets"
  role       = "test_ch_pr_229_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_229_clickhouse_ec2_policy_test_ch_pr_229_get_kafka_mtls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-ch-pr-229-get_kafka_mtls_secrets"
  role       = "test_ch_pr_229_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_230_clickhouse_ec2_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "test_ch_pr_230_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_230_clickhouse_ec2_policy_test_ch_pr_230_ch_get_tls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test_ch_pr_230_ch_get_tls_secrets"
  role       = "test_ch_pr_230_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_230_clickhouse_ec2_policy_test_ch_pr_230_get_kafka_mtls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-ch-pr-230-get_kafka_mtls_secrets"
  role       = "test_ch_pr_230_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_485_clickhouse_ec2_policy_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = "test_ch_pr_485_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_485_clickhouse_ec2_policy_test_ch_pr_485_ch_get_tls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test_ch_pr_485_ch_get_tls_secrets"
  role       = "test_ch_pr_485_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_ch_pr_485_clickhouse_ec2_policy_test_ch_pr_485_get_kafka_mtls_secrets" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-ch-pr-485-get_kafka_mtls_secrets"
  role       = "test_ch_pr_485_clickhouse_ec2"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1337_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_1337_posthog_dev_test_eks_pr_1337_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-1337-posthog-dev/test-eks-pr-1337-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-1337-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1337_posthog_dev_cluster_20230317165241239800000002_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-1337-posthog-dev-cluster-20230317165241239800000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1337_posthog_dev_cluster_20230317165241239800000002_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-1337-posthog-dev-cluster-20230317165241239800000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1337_posthog_dev_cluster_autoscaler_policy_test_eks_pr_1337_posthog_dev_worker_autoscaling20230317170455001400000032" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1337-posthog-dev-worker-autoscaling20230317170455001400000032"
  role       = "test-eks-pr-1337-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1337_posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "test-eks-pr-1337-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1337_posthog_dev_ebs_csi_driver_policy_test_eks_pr_1337_posthog_dev_ebs_csi_driver20230317170454445900000024" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1337-posthog-dev-ebs-csi-driver20230317170454445900000024"
  role       = "test-eks-pr-1337-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1337_posthog_dev_external_dns_policy_test_eks_pr_1337_posthog_dev_external_dns20230317170454980500000031" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1337-posthog-dev-external-dns20230317170454980500000031"
  role       = "test-eks-pr-1337-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1376_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_1376_posthog_dev_test_eks_pr_1376_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-1376-posthog-dev/test-eks-pr-1376-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-1376-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1376_posthog_dev_cluster_20230324104144267900000002_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-1376-posthog-dev-cluster-20230324104144267900000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1376_posthog_dev_cluster_20230324104144267900000002_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-1376-posthog-dev-cluster-20230324104144267900000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1376_posthog_dev_cluster_autoscaler_policy_test_eks_pr_1376_posthog_dev_worker_autoscaling2023032410531417930000003a" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1376-posthog-dev-worker-autoscaling2023032410531417930000003a"
  role       = "test-eks-pr-1376-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1376_posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "test-eks-pr-1376-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1376_posthog_dev_ebs_csi_driver_policy_test_eks_pr_1376_posthog_dev_ebs_csi_driver2023032410531351490000002a" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1376-posthog-dev-ebs-csi-driver2023032410531351490000002a"
  role       = "test-eks-pr-1376-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1376_posthog_dev_external_dns_policy_test_eks_pr_1376_posthog_dev_external_dns20230324105313831500000039" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1376-posthog-dev-external-dns20230324105313831500000039"
  role       = "test-eks-pr-1376-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1377_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_1377_posthog_dev_test_eks_pr_1377_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-1377-posthog-dev/test-eks-pr-1377-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-1377-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1377_posthog_dev_cluster_20230403115346600800000002_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-1377-posthog-dev-cluster-20230403115346600800000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1377_posthog_dev_cluster_20230403115346600800000002_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-1377-posthog-dev-cluster-20230403115346600800000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1377_posthog_dev_cluster_autoscaler_policy_test_eks_pr_1377_posthog_dev_worker_autoscaling2023040312045036110000003a" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1377-posthog-dev-worker-autoscaling2023040312045036110000003a"
  role       = "test-eks-pr-1377-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1377_posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "test-eks-pr-1377-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1377_posthog_dev_ebs_csi_driver_policy_test_eks_pr_1377_posthog_dev_ebs_csi_driver2023040312044958890000002a" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1377-posthog-dev-ebs-csi-driver2023040312044958890000002a"
  role       = "test-eks-pr-1377-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1377_posthog_dev_external_dns_policy_test_eks_pr_1377_posthog_dev_external_dns20230403120450150300000039" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1377-posthog-dev-external-dns20230403120450150300000039"
  role       = "test-eks-pr-1377-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1379_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_1379_posthog_dev_test_eks_pr_1379_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-1379-posthog-dev/test-eks-pr-1379-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-1379-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1379_posthog_dev_cluster_20230324114602000300000003_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-1379-posthog-dev-cluster-20230324114602000300000003"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1379_posthog_dev_cluster_20230324114602000300000003_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-1379-posthog-dev-cluster-20230324114602000300000003"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1379_posthog_dev_cluster_autoscaler_policy_test_eks_pr_1379_posthog_dev_worker_autoscaling2023032411565177690000003a" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1379-posthog-dev-worker-autoscaling2023032411565177690000003a"
  role       = "test-eks-pr-1379-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1379_posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "test-eks-pr-1379-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1379_posthog_dev_ebs_csi_driver_policy_test_eks_pr_1379_posthog_dev_ebs_csi_driver2023032411565116420000002a" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1379-posthog-dev-ebs-csi-driver2023032411565116420000002a"
  role       = "test-eks-pr-1379-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_1379_posthog_dev_external_dns_policy_test_eks_pr_1379_posthog_dev_external_dns20230324115651463500000039" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-1379-posthog-dev-external-dns20230324115651463500000039"
  role       = "test-eks-pr-1379-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_193_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_193_posthog_dev_test_eks_pr_193_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-193-posthog-dev/test-eks-pr-193-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-193-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_193_posthog_dev_cluster_20220523131651400500000003_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-193-posthog-dev-cluster-20220523131651400500000003"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_193_posthog_dev_cluster_20220523131651400500000003_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-193-posthog-dev-cluster-20220523131651400500000003"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_193_posthog_dev_cluster_autoscaler_policy_test_eks_pr_193_posthog_dev_worker_autoscaling20220523132654503700000016" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-193-posthog-dev-worker-autoscaling20220523132654503700000016"
  role       = "test-eks-pr-193-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_193_posthog_dev_external_dns_policy_test_eks_pr_193_posthog_dev_external_dns20220523132654483100000015" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-193-posthog-dev-external-dns20220523132654483100000015"
  role       = "test-eks-pr-193-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_245_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_245_posthog_dev_test_eks_pr_245_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-245-posthog-dev/test-eks-pr-245-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-245-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_245_posthog_dev_cluster_20220602125147921600000001_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-245-posthog-dev-cluster-20220602125147921600000001"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_245_posthog_dev_cluster_20220602125147921600000001_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-245-posthog-dev-cluster-20220602125147921600000001"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_245_posthog_dev_cluster_autoscaler_policy_test_eks_pr_245_posthog_dev_worker_autoscaling2022060213020007600000000e" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-245-posthog-dev-worker-autoscaling2022060213020007600000000e"
  role       = "test-eks-pr-245-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_245_posthog_dev_external_dns_policy_test_eks_pr_245_posthog_dev_external_dns2022060213020005220000000d" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-245-posthog-dev-external-dns2022060213020005220000000d"
  role       = "test-eks-pr-245-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_279_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_279_posthog_dev_test_eks_pr_279_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-279-posthog-dev/test-eks-pr-279-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-279-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_279_posthog_dev_cluster_20220616115441135200000004_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-279-posthog-dev-cluster-20220616115441135200000004"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_279_posthog_dev_cluster_20220616115441135200000004_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-279-posthog-dev-cluster-20220616115441135200000004"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_279_posthog_dev_cluster_autoscaler_policy_test_eks_pr_279_posthog_dev_worker_autoscaling2022061612072596630000000e" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-279-posthog-dev-worker-autoscaling2022061612072596630000000e"
  role       = "test-eks-pr-279-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_279_posthog_dev_external_dns_policy_test_eks_pr_279_posthog_dev_external_dns2022061612072594680000000d" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-279-posthog-dev-external-dns2022061612072594680000000d"
  role       = "test-eks-pr-279-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_458_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_458_posthog_dev_test_eks_pr_458_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-458-posthog-dev/test-eks-pr-458-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-458-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_458_posthog_dev_cluster_20220818161915270700000002_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-458-posthog-dev-cluster-20220818161915270700000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_458_posthog_dev_cluster_20220818161915270700000002_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-458-posthog-dev-cluster-20220818161915270700000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_458_posthog_dev_cluster_autoscaler_policy_test_eks_pr_458_posthog_dev_worker_autoscaling2022081816305010710000001c" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-458-posthog-dev-worker-autoscaling2022081816305010710000001c"
  role       = "test-eks-pr-458-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_458_posthog_dev_external_dns_policy_test_eks_pr_458_posthog_dev_external_dns2022081816305008240000001b" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-458-posthog-dev-external-dns2022081816305008240000001b"
  role       = "test-eks-pr-458-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_687_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_687_posthog_dev_test_eks_pr_687_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-687-posthog-dev/test-eks-pr-687-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-687-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_687_posthog_dev_cluster_20221020153002461400000002_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-687-posthog-dev-cluster-20221020153002461400000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_687_posthog_dev_cluster_20221020153002461400000002_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-687-posthog-dev-cluster-20221020153002461400000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_687_posthog_dev_cluster_autoscaler_policy_test_eks_pr_687_posthog_dev_worker_autoscaling2022102015424954200000001d" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-687-posthog-dev-worker-autoscaling2022102015424954200000001d"
  role       = "test-eks-pr-687-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_687_posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "test-eks-pr-687-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_687_posthog_dev_ebs_csi_driver_policy_test_eks_pr_687_posthog_dev_ebs_csi_driver20221020154249089600000015" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-687-posthog-dev-ebs-csi-driver20221020154249089600000015"
  role       = "test-eks-pr-687-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_687_posthog_dev_external_dns_policy_test_eks_pr_687_posthog_dev_external_dns2022102015424936800000001c" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-687-posthog-dev-external-dns2022102015424936800000001c"
  role       = "test-eks-pr-687-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_750_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_750_posthog_dev_test_eks_pr_750_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-750-posthog-dev/test-eks-pr-750-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-750-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_750_posthog_dev_cluster_20221102203256974100000003_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-750-posthog-dev-cluster-20221102203256974100000003"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_750_posthog_dev_cluster_20221102203256974100000003_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-750-posthog-dev-cluster-20221102203256974100000003"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_750_posthog_dev_cluster_autoscaler_policy_test_eks_pr_750_posthog_dev_worker_autoscaling2022110220454586770000001d" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-750-posthog-dev-worker-autoscaling2022110220454586770000001d"
  role       = "test-eks-pr-750-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_750_posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "test-eks-pr-750-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_750_posthog_dev_ebs_csi_driver_policy_test_eks_pr_750_posthog_dev_ebs_csi_driver20221102204545409600000015" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-750-posthog-dev-ebs-csi-driver20221102204545409600000015"
  role       = "test-eks-pr-750-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_750_posthog_dev_external_dns_policy_test_eks_pr_750_posthog_dev_external_dns2022110220454583930000001c" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-750-posthog-dev-external-dns2022110220454583930000001c"
  role       = "test-eks-pr-750-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_777_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_777_posthog_dev_test_eks_pr_777_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-777-posthog-dev/test-eks-pr-777-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-777-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_777_posthog_dev_cluster_20221110172120366000000001_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-777-posthog-dev-cluster-20221110172120366000000001"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_777_posthog_dev_cluster_20221110172120366000000001_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-777-posthog-dev-cluster-20221110172120366000000001"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_777_posthog_dev_cluster_autoscaler_policy_test_eks_pr_777_posthog_dev_worker_autoscaling2022111017353672430000001d" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-777-posthog-dev-worker-autoscaling2022111017353672430000001d"
  role       = "test-eks-pr-777-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_777_posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "test-eks-pr-777-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_777_posthog_dev_ebs_csi_driver_policy_test_eks_pr_777_posthog_dev_ebs_csi_driver20221110173536375100000015" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-777-posthog-dev-ebs-csi-driver20221110173536375100000015"
  role       = "test-eks-pr-777-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_777_posthog_dev_external_dns_policy_test_eks_pr_777_posthog_dev_external_dns2022111017353662040000001c" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-777-posthog-dev-external-dns2022111017353662040000001c"
  role       = "test-eks-pr-777-posthog-dev-external-dns"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_788_posthog_dev_cluster_20221115143713688800000002_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-788-posthog-dev-cluster-20221115143713688800000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_788_posthog_dev_cluster_20221115143713688800000002_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-788-posthog-dev-cluster-20221115143713688800000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_993_posthog_dev_aws_load_balancer_controller_policy_service_test_eks_pr_993_posthog_dev_test_eks_pr_993_posthog_dev_AWSLoadBalancerControllerGlobalIAMPolicy" {
  policy_arn = "arn:aws:iam::169684386827:policy/service/test-eks-pr-993-posthog-dev/test-eks-pr-993-posthog-dev-AWSLoadBalancerControllerGlobalIAMPolicy"
  role       = "test-eks-pr-993-posthog-dev-aws-load-balancer-controller"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_993_posthog_dev_cluster_20230124155745013700000002_policy_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "test-eks-pr-993-posthog-dev-cluster-20230124155745013700000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_993_posthog_dev_cluster_20230124155745013700000002_policy_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = "test-eks-pr-993-posthog-dev-cluster-20230124155745013700000002"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_993_posthog_dev_cluster_autoscaler_policy_test_eks_pr_993_posthog_dev_worker_autoscaling20230124160938416600000032" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-993-posthog-dev-worker-autoscaling20230124160938416600000032"
  role       = "test-eks-pr-993-posthog-dev-cluster-autoscaler"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_993_posthog_dev_ebs_csi_driver_policy_service_role_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "test-eks-pr-993-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_993_posthog_dev_ebs_csi_driver_policy_test_eks_pr_993_posthog_dev_ebs_csi_driver20230124160937644100000024" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-993-posthog-dev-ebs-csi-driver20230124160937644100000024"
  role       = "test-eks-pr-993-posthog-dev-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "test_eks_pr_993_posthog_dev_external_dns_policy_test_eks_pr_993_posthog_dev_external_dns20230124160938054400000031" {
  policy_arn = "arn:aws:iam::169684386827:policy/test-eks-pr-993-posthog-dev-external-dns20230124160938054400000031"
  role       = "test-eks-pr-993-posthog-dev-external-dns"
}

