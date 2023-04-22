resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_documentation_Form_AlarmHigh_1c30460a_f320_4101_abe9_c827257948cd" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a2bd9004-04b9-4a0c-b8aa-0d513d6651cc:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/07b0ccd4-1503-43e2-971c-80c4201e253f"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a2bd9004-04b9-4a0c-b8aa-0d513d6651cc:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/07b0ccd4-1503-43e2-971c-80c4201e253f."
  alarm_name          = "TargetTracking-table/documentation.Form-AlarmHigh-1c30460a-f320-4101-abe9-c827257948cd"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "documentation.Form"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_documentation_Form_AlarmHigh_1efa836c_02fe_4954_910c_2aa696294be5" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9b4bb8dd-856f-42f0-841c-1524aa14241c:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/e2bf9a5d-4557-4d3e-a090-0722a1d630cb"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9b4bb8dd-856f-42f0-841c-1524aa14241c:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/e2bf9a5d-4557-4d3e-a090-0722a1d630cb."
  alarm_name          = "TargetTracking-table/documentation.Form-AlarmHigh-1efa836c-02fe-4954-910c-2aa696294be5"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "documentation.Form"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_documentation_Form_AlarmLow_7795a2e2_39d0_4c5f_88bc_52cc33d75dd3" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a2bd9004-04b9-4a0c-b8aa-0d513d6651cc:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/07b0ccd4-1503-43e2-971c-80c4201e253f"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a2bd9004-04b9-4a0c-b8aa-0d513d6651cc:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/07b0ccd4-1503-43e2-971c-80c4201e253f."
  alarm_name          = "TargetTracking-table/documentation.Form-AlarmLow-7795a2e2-39d0-4c5f-88bc-52cc33d75dd3"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "documentation.Form"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_documentation_Form_AlarmLow_b1fe46ea_6436_4f61_8d43_95dfb9bb3a64" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9b4bb8dd-856f-42f0-841c-1524aa14241c:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/e2bf9a5d-4557-4d3e-a090-0722a1d630cb"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9b4bb8dd-856f-42f0-841c-1524aa14241c:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/e2bf9a5d-4557-4d3e-a090-0722a1d630cb."
  alarm_name          = "TargetTracking-table/documentation.Form-AlarmLow-b1fe46ea-6436-4f61-8d43-95dfb9bb3a64"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "documentation.Form"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_documentation_Form_ProvisionedCapacityHigh_040f3f65_3038_4ee6_a558_3675ef2be9fe" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9b4bb8dd-856f-42f0-841c-1524aa14241c:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/e2bf9a5d-4557-4d3e-a090-0722a1d630cb"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9b4bb8dd-856f-42f0-841c-1524aa14241c:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/e2bf9a5d-4557-4d3e-a090-0722a1d630cb."
  alarm_name          = "TargetTracking-table/documentation.Form-ProvisionedCapacityHigh-040f3f65-3038-4ee6-a558-3675ef2be9fe"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "documentation.Form"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_documentation_Form_ProvisionedCapacityHigh_d767f826_7e71_434e_a4b0_f684778e5840" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a2bd9004-04b9-4a0c-b8aa-0d513d6651cc:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/07b0ccd4-1503-43e2-971c-80c4201e253f"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a2bd9004-04b9-4a0c-b8aa-0d513d6651cc:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/07b0ccd4-1503-43e2-971c-80c4201e253f."
  alarm_name          = "TargetTracking-table/documentation.Form-ProvisionedCapacityHigh-d767f826-7e71-434e-a4b0-f684778e5840"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "documentation.Form"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_documentation_Form_ProvisionedCapacityLow_221afe35_9d9c_4a81_a50f_b33e54a14043" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9b4bb8dd-856f-42f0-841c-1524aa14241c:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/e2bf9a5d-4557-4d3e-a090-0722a1d630cb"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9b4bb8dd-856f-42f0-841c-1524aa14241c:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/e2bf9a5d-4557-4d3e-a090-0722a1d630cb."
  alarm_name          = "TargetTracking-table/documentation.Form-ProvisionedCapacityLow-221afe35-9d9c-4a81-a50f-b33e54a14043"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "documentation.Form"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_documentation_Form_ProvisionedCapacityLow_3fac1d38_e4a6_4b48_aa08_a3008f7ea533" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a2bd9004-04b9-4a0c-b8aa-0d513d6651cc:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/07b0ccd4-1503-43e2-971c-80c4201e253f"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a2bd9004-04b9-4a0c-b8aa-0d513d6651cc:resource/dynamodb/table/documentation.Form:policyName/$documentation.Form-scaling-policy:createdBy/07b0ccd4-1503-43e2-971c-80c4201e253f."
  alarm_name          = "TargetTracking-table/documentation.Form-ProvisionedCapacityLow-3fac1d38-e4a6-4b48-aa08-a3008f7ea533"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "documentation.Form"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Form_AlarmHigh_26a14048_d81c_4ef3_a47e_5834872a39ae" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ff27f855-c894-4c6b-9561-ea6de1a931df:resource/dynamodb/table/forms.Form:policyName/FormReadAutoScalingPolicy:createdBy/7352cf95-7516-41df-99b6-bed9737629da"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ff27f855-c894-4c6b-9561-ea6de1a931df:resource/dynamodb/table/forms.Form:policyName/FormReadAutoScalingPolicy:createdBy/7352cf95-7516-41df-99b6-bed9737629da."
  alarm_name          = "TargetTracking-table/forms.Form-AlarmHigh-26a14048-d81c-4ef3-a47e-5834872a39ae"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "forms.Form"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Form_AlarmHigh_f3173e38_9530_4c78_9532_fe620e904e71" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b857ad03-2cdf-4997-92a2-f6be2ee0f25b:resource/dynamodb/table/forms.Form:policyName/FormWriteScalingPolicy:createdBy/a6c3ba92-01e5-4e21-93ef-4272beadac61"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b857ad03-2cdf-4997-92a2-f6be2ee0f25b:resource/dynamodb/table/forms.Form:policyName/FormWriteScalingPolicy:createdBy/a6c3ba92-01e5-4e21-93ef-4272beadac61."
  alarm_name          = "TargetTracking-table/forms.Form-AlarmHigh-f3173e38-9530-4c78-9532-fe620e904e71"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "forms.Form"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Form_AlarmLow_0d381559_5b45_4797_bdb4_9d721db3a460" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ff27f855-c894-4c6b-9561-ea6de1a931df:resource/dynamodb/table/forms.Form:policyName/FormReadAutoScalingPolicy:createdBy/7352cf95-7516-41df-99b6-bed9737629da"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ff27f855-c894-4c6b-9561-ea6de1a931df:resource/dynamodb/table/forms.Form:policyName/FormReadAutoScalingPolicy:createdBy/7352cf95-7516-41df-99b6-bed9737629da."
  alarm_name          = "TargetTracking-table/forms.Form-AlarmLow-0d381559-5b45-4797-bdb4-9d721db3a460"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "forms.Form"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Form_AlarmLow_27f5748f_f186_466a_a3f6_cc40e9c49800" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b857ad03-2cdf-4997-92a2-f6be2ee0f25b:resource/dynamodb/table/forms.Form:policyName/FormWriteScalingPolicy:createdBy/a6c3ba92-01e5-4e21-93ef-4272beadac61"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b857ad03-2cdf-4997-92a2-f6be2ee0f25b:resource/dynamodb/table/forms.Form:policyName/FormWriteScalingPolicy:createdBy/a6c3ba92-01e5-4e21-93ef-4272beadac61."
  alarm_name          = "TargetTracking-table/forms.Form-AlarmLow-27f5748f-f186-466a-a3f6-cc40e9c49800"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "forms.Form"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Form_ProvisionedCapacityHigh_0ddd4a60_e593_4522_b75d_908d4b662a4b" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ff27f855-c894-4c6b-9561-ea6de1a931df:resource/dynamodb/table/forms.Form:policyName/FormReadAutoScalingPolicy:createdBy/7352cf95-7516-41df-99b6-bed9737629da"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ff27f855-c894-4c6b-9561-ea6de1a931df:resource/dynamodb/table/forms.Form:policyName/FormReadAutoScalingPolicy:createdBy/7352cf95-7516-41df-99b6-bed9737629da."
  alarm_name          = "TargetTracking-table/forms.Form-ProvisionedCapacityHigh-0ddd4a60-e593-4522-b75d-908d4b662a4b"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "forms.Form"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Form_ProvisionedCapacityHigh_8d349fad_8d5c_46f5_a113_76a731af3e11" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b857ad03-2cdf-4997-92a2-f6be2ee0f25b:resource/dynamodb/table/forms.Form:policyName/FormWriteScalingPolicy:createdBy/a6c3ba92-01e5-4e21-93ef-4272beadac61"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b857ad03-2cdf-4997-92a2-f6be2ee0f25b:resource/dynamodb/table/forms.Form:policyName/FormWriteScalingPolicy:createdBy/a6c3ba92-01e5-4e21-93ef-4272beadac61."
  alarm_name          = "TargetTracking-table/forms.Form-ProvisionedCapacityHigh-8d349fad-8d5c-46f5-a113-76a731af3e11"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "forms.Form"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Form_ProvisionedCapacityLow_88d050ff_5679_44da_8904_3484a53e7e94" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ff27f855-c894-4c6b-9561-ea6de1a931df:resource/dynamodb/table/forms.Form:policyName/FormReadAutoScalingPolicy:createdBy/7352cf95-7516-41df-99b6-bed9737629da"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ff27f855-c894-4c6b-9561-ea6de1a931df:resource/dynamodb/table/forms.Form:policyName/FormReadAutoScalingPolicy:createdBy/7352cf95-7516-41df-99b6-bed9737629da."
  alarm_name          = "TargetTracking-table/forms.Form-ProvisionedCapacityLow-88d050ff-5679-44da-8904-3484a53e7e94"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "forms.Form"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Form_ProvisionedCapacityLow_b6aa740a_43fe_4add_9b1a_d36b91e81b3a" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b857ad03-2cdf-4997-92a2-f6be2ee0f25b:resource/dynamodb/table/forms.Form:policyName/FormWriteScalingPolicy:createdBy/a6c3ba92-01e5-4e21-93ef-4272beadac61"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b857ad03-2cdf-4997-92a2-f6be2ee0f25b:resource/dynamodb/table/forms.Form:policyName/FormWriteScalingPolicy:createdBy/a6c3ba92-01e5-4e21-93ef-4272beadac61."
  alarm_name          = "TargetTracking-table/forms.Form-ProvisionedCapacityLow-b6aa740a-43fe-4add-9b1a-d36b91e81b3a"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "forms.Form"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Instance_AlarmHigh_eb1d22ca_331a_493a_bde6_8d63435d9610" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:602e552d-110a-4651-95d7-10b0a95b8d5d:resource/dynamodb/table/forms.Instance:policyName/InstanceReadScalingPolicy:createdBy/6b5e5ce3-707e-482b-b5c3-018ff6a72857"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:602e552d-110a-4651-95d7-10b0a95b8d5d:resource/dynamodb/table/forms.Instance:policyName/InstanceReadScalingPolicy:createdBy/6b5e5ce3-707e-482b-b5c3-018ff6a72857."
  alarm_name          = "TargetTracking-table/forms.Instance-AlarmHigh-eb1d22ca-331a-493a-bde6-8d63435d9610"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "forms.Instance"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Instance_AlarmHigh_fb7d0e0d_8725_4e1f_a5dc_5d607b6cb5b1" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:720b3f14-f4e1-4a5e-9121-26ba3bfd5bb4:resource/dynamodb/table/forms.Instance:policyName/InstanceWriteScalingPolicy:createdBy/0ab78521-c4cd-4b40-916b-b7a53d10fe0e"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:720b3f14-f4e1-4a5e-9121-26ba3bfd5bb4:resource/dynamodb/table/forms.Instance:policyName/InstanceWriteScalingPolicy:createdBy/0ab78521-c4cd-4b40-916b-b7a53d10fe0e."
  alarm_name          = "TargetTracking-table/forms.Instance-AlarmHigh-fb7d0e0d-8725-4e1f-a5dc-5d607b6cb5b1"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "forms.Instance"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Instance_AlarmLow_24ce51e4_f369_423f_b0cd_96a80deeaede" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:602e552d-110a-4651-95d7-10b0a95b8d5d:resource/dynamodb/table/forms.Instance:policyName/InstanceReadScalingPolicy:createdBy/6b5e5ce3-707e-482b-b5c3-018ff6a72857"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:602e552d-110a-4651-95d7-10b0a95b8d5d:resource/dynamodb/table/forms.Instance:policyName/InstanceReadScalingPolicy:createdBy/6b5e5ce3-707e-482b-b5c3-018ff6a72857."
  alarm_name          = "TargetTracking-table/forms.Instance-AlarmLow-24ce51e4-f369-423f-b0cd-96a80deeaede"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "forms.Instance"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Instance_AlarmLow_2c777a2a_05f6_4247_81a1_65b57eddd384" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:720b3f14-f4e1-4a5e-9121-26ba3bfd5bb4:resource/dynamodb/table/forms.Instance:policyName/InstanceWriteScalingPolicy:createdBy/0ab78521-c4cd-4b40-916b-b7a53d10fe0e"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:720b3f14-f4e1-4a5e-9121-26ba3bfd5bb4:resource/dynamodb/table/forms.Instance:policyName/InstanceWriteScalingPolicy:createdBy/0ab78521-c4cd-4b40-916b-b7a53d10fe0e."
  alarm_name          = "TargetTracking-table/forms.Instance-AlarmLow-2c777a2a-05f6-4247-81a1-65b57eddd384"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "forms.Instance"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Instance_ProvisionedCapacityHigh_990e0805_df66_4ea3_afd4_7114d1531c39" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:602e552d-110a-4651-95d7-10b0a95b8d5d:resource/dynamodb/table/forms.Instance:policyName/InstanceReadScalingPolicy:createdBy/6b5e5ce3-707e-482b-b5c3-018ff6a72857"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:602e552d-110a-4651-95d7-10b0a95b8d5d:resource/dynamodb/table/forms.Instance:policyName/InstanceReadScalingPolicy:createdBy/6b5e5ce3-707e-482b-b5c3-018ff6a72857."
  alarm_name          = "TargetTracking-table/forms.Instance-ProvisionedCapacityHigh-990e0805-df66-4ea3-afd4-7114d1531c39"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "forms.Instance"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Instance_ProvisionedCapacityHigh_efaa516c_9a5c_4ff0_8160_8926d50e567e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:720b3f14-f4e1-4a5e-9121-26ba3bfd5bb4:resource/dynamodb/table/forms.Instance:policyName/InstanceWriteScalingPolicy:createdBy/0ab78521-c4cd-4b40-916b-b7a53d10fe0e"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:720b3f14-f4e1-4a5e-9121-26ba3bfd5bb4:resource/dynamodb/table/forms.Instance:policyName/InstanceWriteScalingPolicy:createdBy/0ab78521-c4cd-4b40-916b-b7a53d10fe0e."
  alarm_name          = "TargetTracking-table/forms.Instance-ProvisionedCapacityHigh-efaa516c-9a5c-4ff0-8160-8926d50e567e"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "forms.Instance"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Instance_ProvisionedCapacityLow_6dd3bf7c_0f5b_42ff_aade_f6c8015c21a9" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:602e552d-110a-4651-95d7-10b0a95b8d5d:resource/dynamodb/table/forms.Instance:policyName/InstanceReadScalingPolicy:createdBy/6b5e5ce3-707e-482b-b5c3-018ff6a72857"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:602e552d-110a-4651-95d7-10b0a95b8d5d:resource/dynamodb/table/forms.Instance:policyName/InstanceReadScalingPolicy:createdBy/6b5e5ce3-707e-482b-b5c3-018ff6a72857."
  alarm_name          = "TargetTracking-table/forms.Instance-ProvisionedCapacityLow-6dd3bf7c-0f5b-42ff-aade-f6c8015c21a9"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "forms.Instance"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_forms_Instance_ProvisionedCapacityLow_bc73a2ad_3b8e_4a78_be35_763373d4adc0" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:720b3f14-f4e1-4a5e-9121-26ba3bfd5bb4:resource/dynamodb/table/forms.Instance:policyName/InstanceWriteScalingPolicy:createdBy/0ab78521-c4cd-4b40-916b-b7a53d10fe0e"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:720b3f14-f4e1-4a5e-9121-26ba3bfd5bb4:resource/dynamodb/table/forms.Instance:policyName/InstanceWriteScalingPolicy:createdBy/0ab78521-c4cd-4b40-916b-b7a53d10fe0e."
  alarm_name          = "TargetTracking-table/forms.Instance-ProvisionedCapacityLow-bc73a2ad-3b8e-4a78-be35-763373d4adc0"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "forms.Instance"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_AlarmHigh_0d5670e2_e11d_45af_839a_41ac1631ee41" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b730befa-cbc2-4bd9-acf7-574edca0a386:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d0a4d813-79f2-4da8-814a-520a1bf8d1e0"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b730befa-cbc2-4bd9-acf7-574edca0a386:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d0a4d813-79f2-4da8-814a-520a1bf8d1e0."
  alarm_name          = "TargetTracking-table/learning.Book-AlarmHigh-0d5670e2-e11d-45af-839a-41ac1631ee41"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_AlarmHigh_a83cf446_76f1_40d0_a950_95bd0b35bc89" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:84b6f583-6338-472d-92e6-bf7f80726018:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d7b7025a-b7a8-418a-9764-e0d5ddc856d5"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:84b6f583-6338-472d-92e6-bf7f80726018:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d7b7025a-b7a8-418a-9764-e0d5ddc856d5."
  alarm_name          = "TargetTracking-table/learning.Book-AlarmHigh-a83cf446-76f1-40d0-a950-95bd0b35bc89"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 84
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_AlarmLow_3b16a3bd_42fb_4cab_a20c_b98256e8eae6" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b730befa-cbc2-4bd9-acf7-574edca0a386:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d0a4d813-79f2-4da8-814a-520a1bf8d1e0"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b730befa-cbc2-4bd9-acf7-574edca0a386:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d0a4d813-79f2-4da8-814a-520a1bf8d1e0."
  alarm_name          = "TargetTracking-table/learning.Book-AlarmLow-3b16a3bd-42fb-4cab-a20c-b98256e8eae6"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_AlarmLow_70d7592f_79cd_4a99_bdcc_db2a5263467f" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:84b6f583-6338-472d-92e6-bf7f80726018:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d7b7025a-b7a8-418a-9764-e0d5ddc856d5"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:84b6f583-6338-472d-92e6-bf7f80726018:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d7b7025a-b7a8-418a-9764-e0d5ddc856d5."
  alarm_name          = "TargetTracking-table/learning.Book-AlarmLow-70d7592f-79cd-4a99-bdcc-db2a5263467f"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 60
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Development_AlarmHigh_3f813d17_ef9e_4d09_ae9c_e56b690415b6" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38df5366-50f8-4ab0-ac64-c74babfc91a5:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/11f4f2ae-576b-4590-a169-6c4cccbbf16a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38df5366-50f8-4ab0-ac64-c74babfc91a5:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/11f4f2ae-576b-4590-a169-6c4cccbbf16a."
  alarm_name          = "TargetTracking-table/learning.Book-Development-AlarmHigh-3f813d17-ef9e-4d09-ae9c-e56b690415b6"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book-Development"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Development_AlarmHigh_f1624f82_28a4_4754_90de_d338b81fd7a4" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:cd85c3a3-1fee-4700-8e4d-933adf91afe3:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/3e4b4988-3f43-4068-bc58-cb99df97d449"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:cd85c3a3-1fee-4700-8e4d-933adf91afe3:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/3e4b4988-3f43-4068-bc58-cb99df97d449."
  alarm_name          = "TargetTracking-table/learning.Book-Development-AlarmHigh-f1624f82-28a4-4754-90de-d338b81fd7a4"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book-Development"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Development_AlarmLow_a763a59e_79cf_400e_9f64_110d76c2494f" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:cd85c3a3-1fee-4700-8e4d-933adf91afe3:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/3e4b4988-3f43-4068-bc58-cb99df97d449"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:cd85c3a3-1fee-4700-8e4d-933adf91afe3:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/3e4b4988-3f43-4068-bc58-cb99df97d449."
  alarm_name          = "TargetTracking-table/learning.Book-Development-AlarmLow-a763a59e-79cf-400e-9f64-110d76c2494f"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book-Development"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Development_AlarmLow_b7d776db_d2e1_408a_9e93_25d463618aae" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38df5366-50f8-4ab0-ac64-c74babfc91a5:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/11f4f2ae-576b-4590-a169-6c4cccbbf16a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38df5366-50f8-4ab0-ac64-c74babfc91a5:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/11f4f2ae-576b-4590-a169-6c4cccbbf16a."
  alarm_name          = "TargetTracking-table/learning.Book-Development-AlarmLow-b7d776db-d2e1-408a-9e93-25d463618aae"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book-Development"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Development_ProvisionedCapacityHigh_b54af125_9e53_4c0d_b5d9_fbd55f4cdad7" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:cd85c3a3-1fee-4700-8e4d-933adf91afe3:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/3e4b4988-3f43-4068-bc58-cb99df97d449"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:cd85c3a3-1fee-4700-8e4d-933adf91afe3:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/3e4b4988-3f43-4068-bc58-cb99df97d449."
  alarm_name          = "TargetTracking-table/learning.Book-Development-ProvisionedCapacityHigh-b54af125-9e53-4c0d-b5d9-fbd55f4cdad7"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Development_ProvisionedCapacityHigh_b97738ef_7412_4f25_b127_85ffc1af4d6d" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38df5366-50f8-4ab0-ac64-c74babfc91a5:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/11f4f2ae-576b-4590-a169-6c4cccbbf16a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38df5366-50f8-4ab0-ac64-c74babfc91a5:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/11f4f2ae-576b-4590-a169-6c4cccbbf16a."
  alarm_name          = "TargetTracking-table/learning.Book-Development-ProvisionedCapacityHigh-b97738ef-7412-4f25-b127-85ffc1af4d6d"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Development_ProvisionedCapacityLow_7462cbb8_eb4d_4e6e_9ba0_11d8dbc66c11" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38df5366-50f8-4ab0-ac64-c74babfc91a5:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/11f4f2ae-576b-4590-a169-6c4cccbbf16a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38df5366-50f8-4ab0-ac64-c74babfc91a5:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/11f4f2ae-576b-4590-a169-6c4cccbbf16a."
  alarm_name          = "TargetTracking-table/learning.Book-Development-ProvisionedCapacityLow-7462cbb8-eb4d-4e6e-9ba0-11d8dbc66c11"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Development_ProvisionedCapacityLow_90efa7f3_1210_489a_b3b9_c748662396e7" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:cd85c3a3-1fee-4700-8e4d-933adf91afe3:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/3e4b4988-3f43-4068-bc58-cb99df97d449"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:cd85c3a3-1fee-4700-8e4d-933adf91afe3:resource/dynamodb/table/learning.Book-Development:policyName/$learning.Book-Development-scaling-policy:createdBy/3e4b4988-3f43-4068-bc58-cb99df97d449."
  alarm_name          = "TargetTracking-table/learning.Book-Development-ProvisionedCapacityLow-90efa7f3-1210-489a-b3b9-c748662396e7"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Integration_AlarmHigh_00d9cf2d_8cb0_4d33_b14c_0eb7e52ceadb" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:895cc1a2-28cd-43a8-ae80-a8a4d5fb9fd5:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/cb1cb837-b511-488a-9c22-42834f426db9"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:895cc1a2-28cd-43a8-ae80-a8a4d5fb9fd5:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/cb1cb837-b511-488a-9c22-42834f426db9."
  alarm_name          = "TargetTracking-table/learning.Book-Integration-AlarmHigh-00d9cf2d-8cb0-4d33-b14c-0eb7e52ceadb"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book-Integration"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Integration_AlarmHigh_a28374ad_5151_4c86_86a9_601736231bb9" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:81e19bbe-dbf6-42fc-bc01-ca194c40f195:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/749c905b-b631-457e-9f2a-06ddf740d2f0"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:81e19bbe-dbf6-42fc-bc01-ca194c40f195:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/749c905b-b631-457e-9f2a-06ddf740d2f0."
  alarm_name          = "TargetTracking-table/learning.Book-Integration-AlarmHigh-a28374ad-5151-4c86-86a9-601736231bb9"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book-Integration"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Integration_AlarmLow_38df01c1_24f9_4f8e_92dc_50ad0577d7fd" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:895cc1a2-28cd-43a8-ae80-a8a4d5fb9fd5:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/cb1cb837-b511-488a-9c22-42834f426db9"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:895cc1a2-28cd-43a8-ae80-a8a4d5fb9fd5:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/cb1cb837-b511-488a-9c22-42834f426db9."
  alarm_name          = "TargetTracking-table/learning.Book-Integration-AlarmLow-38df01c1-24f9-4f8e-92dc-50ad0577d7fd"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book-Integration"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Integration_AlarmLow_db1c8f31_3109_4406_aae1_9f73f4982ca2" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:81e19bbe-dbf6-42fc-bc01-ca194c40f195:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/749c905b-b631-457e-9f2a-06ddf740d2f0"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:81e19bbe-dbf6-42fc-bc01-ca194c40f195:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/749c905b-b631-457e-9f2a-06ddf740d2f0."
  alarm_name          = "TargetTracking-table/learning.Book-Integration-AlarmLow-db1c8f31-3109-4406-aae1-9f73f4982ca2"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book-Integration"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Integration_ProvisionedCapacityHigh_055b690f_859d_4011_9b14_228d4c36f9a7" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:895cc1a2-28cd-43a8-ae80-a8a4d5fb9fd5:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/cb1cb837-b511-488a-9c22-42834f426db9"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:895cc1a2-28cd-43a8-ae80-a8a4d5fb9fd5:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/cb1cb837-b511-488a-9c22-42834f426db9."
  alarm_name          = "TargetTracking-table/learning.Book-Integration-ProvisionedCapacityHigh-055b690f-859d-4011-9b14-228d4c36f9a7"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book-Integration"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Integration_ProvisionedCapacityHigh_3f5bdae4_cc5b_4bdb_8ec1_9dacb3fe33b5" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:81e19bbe-dbf6-42fc-bc01-ca194c40f195:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/749c905b-b631-457e-9f2a-06ddf740d2f0"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:81e19bbe-dbf6-42fc-bc01-ca194c40f195:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/749c905b-b631-457e-9f2a-06ddf740d2f0."
  alarm_name          = "TargetTracking-table/learning.Book-Integration-ProvisionedCapacityHigh-3f5bdae4-cc5b-4bdb-8ec1-9dacb3fe33b5"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book-Integration"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Integration_ProvisionedCapacityLow_425e0540_bd2e_43f1_98f7_63116fc208fb" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:895cc1a2-28cd-43a8-ae80-a8a4d5fb9fd5:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/cb1cb837-b511-488a-9c22-42834f426db9"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:895cc1a2-28cd-43a8-ae80-a8a4d5fb9fd5:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/cb1cb837-b511-488a-9c22-42834f426db9."
  alarm_name          = "TargetTracking-table/learning.Book-Integration-ProvisionedCapacityLow-425e0540-bd2e-43f1-98f7-63116fc208fb"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book-Integration"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_Integration_ProvisionedCapacityLow_611115e4_2862_4a06_892b_cdcabcda6e28" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:81e19bbe-dbf6-42fc-bc01-ca194c40f195:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/749c905b-b631-457e-9f2a-06ddf740d2f0"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:81e19bbe-dbf6-42fc-bc01-ca194c40f195:resource/dynamodb/table/learning.Book-Integration:policyName/$learning.Book-Integration-scaling-policy:createdBy/749c905b-b631-457e-9f2a-06ddf740d2f0."
  alarm_name          = "TargetTracking-table/learning.Book-Integration-ProvisionedCapacityLow-611115e4-2862-4a06-892b-cdcabcda6e28"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book-Integration"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_ProvisionedCapacityHigh_ca489f94_92f6_42f8_bae4_425afa91ce30" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b730befa-cbc2-4bd9-acf7-574edca0a386:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d0a4d813-79f2-4da8-814a-520a1bf8d1e0"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b730befa-cbc2-4bd9-acf7-574edca0a386:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d0a4d813-79f2-4da8-814a-520a1bf8d1e0."
  alarm_name          = "TargetTracking-table/learning.Book-ProvisionedCapacityHigh-ca489f94-92f6-42f8-bae4-425afa91ce30"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_ProvisionedCapacityHigh_ec0d182b_1671_48d4_bfb6_1cf9f4cf7329" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:84b6f583-6338-472d-92e6-bf7f80726018:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d7b7025a-b7a8-418a-9764-e0d5ddc856d5"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:84b6f583-6338-472d-92e6-bf7f80726018:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d7b7025a-b7a8-418a-9764-e0d5ddc856d5."
  alarm_name          = "TargetTracking-table/learning.Book-ProvisionedCapacityHigh-ec0d182b-1671-48d4-bfb6-1cf9f4cf7329"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Book"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 2
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_ProvisionedCapacityLow_df606d3a_65b7_41d5_938a_47e73d1dea9d" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:84b6f583-6338-472d-92e6-bf7f80726018:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d7b7025a-b7a8-418a-9764-e0d5ddc856d5"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:84b6f583-6338-472d-92e6-bf7f80726018:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d7b7025a-b7a8-418a-9764-e0d5ddc856d5."
  alarm_name          = "TargetTracking-table/learning.Book-ProvisionedCapacityLow-df606d3a-65b7-41d5-938a-47e73d1dea9d"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 2
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Book_ProvisionedCapacityLow_fb777281_ba85_4f34_b03f_8e449c459380" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b730befa-cbc2-4bd9-acf7-574edca0a386:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d0a4d813-79f2-4da8-814a-520a1bf8d1e0"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b730befa-cbc2-4bd9-acf7-574edca0a386:resource/dynamodb/table/learning.Book:policyName/$learning.Book-scaling-policy:createdBy/d0a4d813-79f2-4da8-814a-520a1bf8d1e0."
  alarm_name          = "TargetTracking-table/learning.Book-ProvisionedCapacityLow-fb777281-ba85-4f34-b03f-8e449c459380"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Book"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_DomainModel_AlarmHigh_54e005fd_9ffd_4428_8553_8a47d5271ad2" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:10759daf-a111-42be-bef8-a38882806183:resource/dynamodb/table/learning.DomainModel:policyName/WriteAutoScalingPolicy:createdBy/42115cb1-109c-42b1-bef5-98e03912a2ce"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:10759daf-a111-42be-bef8-a38882806183:resource/dynamodb/table/learning.DomainModel:policyName/WriteAutoScalingPolicy:createdBy/42115cb1-109c-42b1-bef5-98e03912a2ce."
  alarm_name          = "TargetTracking-table/learning.DomainModel-AlarmHigh-54e005fd-9ffd-4428-8553-8a47d5271ad2"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.DomainModel"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_DomainModel_AlarmHigh_6a50b0bc_004b_442f_af65_225ecd04db51" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9cefade2-9a00-4fd9-a0ba-064070a39369:resource/dynamodb/table/learning.DomainModel:policyName/ReadAutoScalingPolicy:createdBy/788c46c6-abeb-4056-8a55-9a2ac6149543"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9cefade2-9a00-4fd9-a0ba-064070a39369:resource/dynamodb/table/learning.DomainModel:policyName/ReadAutoScalingPolicy:createdBy/788c46c6-abeb-4056-8a55-9a2ac6149543."
  alarm_name          = "TargetTracking-table/learning.DomainModel-AlarmHigh-6a50b0bc-004b-442f-af65-225ecd04db51"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.DomainModel"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_DomainModel_AlarmLow_70cb6481_26bf_4763_b539_695f17a8d9cc" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:10759daf-a111-42be-bef8-a38882806183:resource/dynamodb/table/learning.DomainModel:policyName/WriteAutoScalingPolicy:createdBy/42115cb1-109c-42b1-bef5-98e03912a2ce"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:10759daf-a111-42be-bef8-a38882806183:resource/dynamodb/table/learning.DomainModel:policyName/WriteAutoScalingPolicy:createdBy/42115cb1-109c-42b1-bef5-98e03912a2ce."
  alarm_name          = "TargetTracking-table/learning.DomainModel-AlarmLow-70cb6481-26bf-4763-b539-695f17a8d9cc"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.DomainModel"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_DomainModel_AlarmLow_a24fe4ab_d1b2_48f3_81e4_3b5536e1d61d" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9cefade2-9a00-4fd9-a0ba-064070a39369:resource/dynamodb/table/learning.DomainModel:policyName/ReadAutoScalingPolicy:createdBy/788c46c6-abeb-4056-8a55-9a2ac6149543"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9cefade2-9a00-4fd9-a0ba-064070a39369:resource/dynamodb/table/learning.DomainModel:policyName/ReadAutoScalingPolicy:createdBy/788c46c6-abeb-4056-8a55-9a2ac6149543."
  alarm_name          = "TargetTracking-table/learning.DomainModel-AlarmLow-a24fe4ab-d1b2-48f3-81e4-3b5536e1d61d"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.DomainModel"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_DomainModel_ProvisionedCapacityHigh_918cf000_9253_411f_a472_51071228ad35" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9cefade2-9a00-4fd9-a0ba-064070a39369:resource/dynamodb/table/learning.DomainModel:policyName/ReadAutoScalingPolicy:createdBy/788c46c6-abeb-4056-8a55-9a2ac6149543"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9cefade2-9a00-4fd9-a0ba-064070a39369:resource/dynamodb/table/learning.DomainModel:policyName/ReadAutoScalingPolicy:createdBy/788c46c6-abeb-4056-8a55-9a2ac6149543."
  alarm_name          = "TargetTracking-table/learning.DomainModel-ProvisionedCapacityHigh-918cf000-9253-411f-a472-51071228ad35"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.DomainModel"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_DomainModel_ProvisionedCapacityHigh_e2cb6d1b_6bb9_4569_88c8_893de4ea735f" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:10759daf-a111-42be-bef8-a38882806183:resource/dynamodb/table/learning.DomainModel:policyName/WriteAutoScalingPolicy:createdBy/42115cb1-109c-42b1-bef5-98e03912a2ce"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:10759daf-a111-42be-bef8-a38882806183:resource/dynamodb/table/learning.DomainModel:policyName/WriteAutoScalingPolicy:createdBy/42115cb1-109c-42b1-bef5-98e03912a2ce."
  alarm_name          = "TargetTracking-table/learning.DomainModel-ProvisionedCapacityHigh-e2cb6d1b-6bb9-4569-88c8-893de4ea735f"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.DomainModel"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_DomainModel_ProvisionedCapacityLow_e172714e_1f16_4881_bfec_6b2de48abfa6" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9cefade2-9a00-4fd9-a0ba-064070a39369:resource/dynamodb/table/learning.DomainModel:policyName/ReadAutoScalingPolicy:createdBy/788c46c6-abeb-4056-8a55-9a2ac6149543"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9cefade2-9a00-4fd9-a0ba-064070a39369:resource/dynamodb/table/learning.DomainModel:policyName/ReadAutoScalingPolicy:createdBy/788c46c6-abeb-4056-8a55-9a2ac6149543."
  alarm_name          = "TargetTracking-table/learning.DomainModel-ProvisionedCapacityLow-e172714e-1f16-4881-bfec-6b2de48abfa6"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.DomainModel"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_DomainModel_ProvisionedCapacityLow_f06f5e09_e97a_4de1_8620_db0bc5456718" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:10759daf-a111-42be-bef8-a38882806183:resource/dynamodb/table/learning.DomainModel:policyName/WriteAutoScalingPolicy:createdBy/42115cb1-109c-42b1-bef5-98e03912a2ce"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:10759daf-a111-42be-bef8-a38882806183:resource/dynamodb/table/learning.DomainModel:policyName/WriteAutoScalingPolicy:createdBy/42115cb1-109c-42b1-bef5-98e03912a2ce."
  alarm_name          = "TargetTracking-table/learning.DomainModel-ProvisionedCapacityLow-f06f5e09-e97a-4de1-8620-db0bc5456718"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.DomainModel"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Image_Development_AlarmHigh_a7c6c342_57a8_431e_9194_6ecea1e59141" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:879dcc2c-7db3-40f5-9b2a-aa3f36628d59:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/9e9e3229-e19f-4e3d-92b1-a2e8179b8d07"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:879dcc2c-7db3-40f5-9b2a-aa3f36628d59:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/9e9e3229-e19f-4e3d-92b1-a2e8179b8d07."
  alarm_name          = "TargetTracking-table/learning.Image-Development-AlarmHigh-a7c6c342-57a8-431e-9194-6ecea1e59141"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Image-Development"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Image_Development_AlarmHigh_b3737391_9de3_4024_8e52_fb90930514bb" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c44b4e65-cb1c-4a60-8983-dfe34fb0d2b7:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/6c5bcf8a-e6d5-47db-8684-51b1596dd751"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c44b4e65-cb1c-4a60-8983-dfe34fb0d2b7:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/6c5bcf8a-e6d5-47db-8684-51b1596dd751."
  alarm_name          = "TargetTracking-table/learning.Image-Development-AlarmHigh-b3737391-9de3-4024-8e52-fb90930514bb"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Image-Development"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Image_Development_AlarmLow_5abacedb_ca2f_4f3c_8328_c97642e25161" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c44b4e65-cb1c-4a60-8983-dfe34fb0d2b7:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/6c5bcf8a-e6d5-47db-8684-51b1596dd751"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c44b4e65-cb1c-4a60-8983-dfe34fb0d2b7:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/6c5bcf8a-e6d5-47db-8684-51b1596dd751."
  alarm_name          = "TargetTracking-table/learning.Image-Development-AlarmLow-5abacedb-ca2f-4f3c-8328-c97642e25161"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Image-Development"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Image_Development_AlarmLow_71989efd_a741_47aa_ba8c_0824be05c25d" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:879dcc2c-7db3-40f5-9b2a-aa3f36628d59:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/9e9e3229-e19f-4e3d-92b1-a2e8179b8d07"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:879dcc2c-7db3-40f5-9b2a-aa3f36628d59:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/9e9e3229-e19f-4e3d-92b1-a2e8179b8d07."
  alarm_name          = "TargetTracking-table/learning.Image-Development-AlarmLow-71989efd-a741-47aa-ba8c-0824be05c25d"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Image-Development"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Image_Development_ProvisionedCapacityHigh_438fbc44_98b9_485b_9b61_1c00b1adf364" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:879dcc2c-7db3-40f5-9b2a-aa3f36628d59:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/9e9e3229-e19f-4e3d-92b1-a2e8179b8d07"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:879dcc2c-7db3-40f5-9b2a-aa3f36628d59:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/9e9e3229-e19f-4e3d-92b1-a2e8179b8d07."
  alarm_name          = "TargetTracking-table/learning.Image-Development-ProvisionedCapacityHigh-438fbc44-98b9-485b-9b61-1c00b1adf364"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Image-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Image_Development_ProvisionedCapacityHigh_4482c392_f981_43e2_bf1e_0e3f03cd1328" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c44b4e65-cb1c-4a60-8983-dfe34fb0d2b7:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/6c5bcf8a-e6d5-47db-8684-51b1596dd751"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c44b4e65-cb1c-4a60-8983-dfe34fb0d2b7:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/6c5bcf8a-e6d5-47db-8684-51b1596dd751."
  alarm_name          = "TargetTracking-table/learning.Image-Development-ProvisionedCapacityHigh-4482c392-f981-43e2-bf1e-0e3f03cd1328"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.Image-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Image_Development_ProvisionedCapacityLow_173a8897_6c6b_4f98_ae52_2f1628e49eb9" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:879dcc2c-7db3-40f5-9b2a-aa3f36628d59:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/9e9e3229-e19f-4e3d-92b1-a2e8179b8d07"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:879dcc2c-7db3-40f5-9b2a-aa3f36628d59:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/9e9e3229-e19f-4e3d-92b1-a2e8179b8d07."
  alarm_name          = "TargetTracking-table/learning.Image-Development-ProvisionedCapacityLow-173a8897-6c6b-4f98-ae52-2f1628e49eb9"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Image-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_Image_Development_ProvisionedCapacityLow_9643cd77_35f2_4675_8589_15381ea39900" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c44b4e65-cb1c-4a60-8983-dfe34fb0d2b7:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/6c5bcf8a-e6d5-47db-8684-51b1596dd751"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c44b4e65-cb1c-4a60-8983-dfe34fb0d2b7:resource/dynamodb/table/learning.Image-Development:policyName/$learning.Image-Development-scaling-policy:createdBy/6c5bcf8a-e6d5-47db-8684-51b1596dd751."
  alarm_name          = "TargetTracking-table/learning.Image-Development-ProvisionedCapacityLow-9643cd77-35f2-4675-8589-15381ea39900"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.Image-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_MediaSteps_AlarmHigh_39928a99_1997_4aea_970c_3aa45b1224d5" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e208bf74-2820-4997-9750-36d64163661d:resource/dynamodb/table/learning.MediaSteps:policyName/ReadAutoScalingPolicy:createdBy/0fac88eb-a0f9-4f15-afdb-779817f4f74a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e208bf74-2820-4997-9750-36d64163661d:resource/dynamodb/table/learning.MediaSteps:policyName/ReadAutoScalingPolicy:createdBy/0fac88eb-a0f9-4f15-afdb-779817f4f74a."
  alarm_name          = "TargetTracking-table/learning.MediaSteps-AlarmHigh-39928a99-1997-4aea-970c-3aa45b1224d5"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.MediaSteps"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_MediaSteps_AlarmHigh_68bd7127_60a3_4c0e_a8c0_a25922202ddd" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:6047ce94-bbd7-49c4-8606-e7a7350b3623:resource/dynamodb/table/learning.MediaSteps:policyName/WriteAutoScalingPolicy:createdBy/9f0835bd-759e-4312-8bbc-5501b2c3162a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:6047ce94-bbd7-49c4-8606-e7a7350b3623:resource/dynamodb/table/learning.MediaSteps:policyName/WriteAutoScalingPolicy:createdBy/9f0835bd-759e-4312-8bbc-5501b2c3162a."
  alarm_name          = "TargetTracking-table/learning.MediaSteps-AlarmHigh-68bd7127-60a3-4c0e-a8c0-a25922202ddd"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.MediaSteps"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_MediaSteps_AlarmLow_00db492e_0bf0_4c6a_880b_a717c3292fd2" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:6047ce94-bbd7-49c4-8606-e7a7350b3623:resource/dynamodb/table/learning.MediaSteps:policyName/WriteAutoScalingPolicy:createdBy/9f0835bd-759e-4312-8bbc-5501b2c3162a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:6047ce94-bbd7-49c4-8606-e7a7350b3623:resource/dynamodb/table/learning.MediaSteps:policyName/WriteAutoScalingPolicy:createdBy/9f0835bd-759e-4312-8bbc-5501b2c3162a."
  alarm_name          = "TargetTracking-table/learning.MediaSteps-AlarmLow-00db492e-0bf0-4c6a-880b-a717c3292fd2"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.MediaSteps"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_MediaSteps_AlarmLow_171a1cf6_ec87_430e_bbcd_0248b6680a7f" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e208bf74-2820-4997-9750-36d64163661d:resource/dynamodb/table/learning.MediaSteps:policyName/ReadAutoScalingPolicy:createdBy/0fac88eb-a0f9-4f15-afdb-779817f4f74a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e208bf74-2820-4997-9750-36d64163661d:resource/dynamodb/table/learning.MediaSteps:policyName/ReadAutoScalingPolicy:createdBy/0fac88eb-a0f9-4f15-afdb-779817f4f74a."
  alarm_name          = "TargetTracking-table/learning.MediaSteps-AlarmLow-171a1cf6-ec87-430e-bbcd-0248b6680a7f"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.MediaSteps"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_MediaSteps_ProvisionedCapacityHigh_46e75b83_928d_4a84_a016_56ad3aa89953" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:6047ce94-bbd7-49c4-8606-e7a7350b3623:resource/dynamodb/table/learning.MediaSteps:policyName/WriteAutoScalingPolicy:createdBy/9f0835bd-759e-4312-8bbc-5501b2c3162a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:6047ce94-bbd7-49c4-8606-e7a7350b3623:resource/dynamodb/table/learning.MediaSteps:policyName/WriteAutoScalingPolicy:createdBy/9f0835bd-759e-4312-8bbc-5501b2c3162a."
  alarm_name          = "TargetTracking-table/learning.MediaSteps-ProvisionedCapacityHigh-46e75b83-928d-4a84-a016-56ad3aa89953"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.MediaSteps"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_MediaSteps_ProvisionedCapacityHigh_8b5b7107_5412_4b7a_b852_423f2d9e5a6c" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e208bf74-2820-4997-9750-36d64163661d:resource/dynamodb/table/learning.MediaSteps:policyName/ReadAutoScalingPolicy:createdBy/0fac88eb-a0f9-4f15-afdb-779817f4f74a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e208bf74-2820-4997-9750-36d64163661d:resource/dynamodb/table/learning.MediaSteps:policyName/ReadAutoScalingPolicy:createdBy/0fac88eb-a0f9-4f15-afdb-779817f4f74a."
  alarm_name          = "TargetTracking-table/learning.MediaSteps-ProvisionedCapacityHigh-8b5b7107-5412-4b7a-b852-423f2d9e5a6c"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "learning.MediaSteps"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_MediaSteps_ProvisionedCapacityLow_8b0024f0_5d82_4c78_ae0f_0eec9bbb639d" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e208bf74-2820-4997-9750-36d64163661d:resource/dynamodb/table/learning.MediaSteps:policyName/ReadAutoScalingPolicy:createdBy/0fac88eb-a0f9-4f15-afdb-779817f4f74a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e208bf74-2820-4997-9750-36d64163661d:resource/dynamodb/table/learning.MediaSteps:policyName/ReadAutoScalingPolicy:createdBy/0fac88eb-a0f9-4f15-afdb-779817f4f74a."
  alarm_name          = "TargetTracking-table/learning.MediaSteps-ProvisionedCapacityLow-8b0024f0-5d82-4c78-ae0f-0eec9bbb639d"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.MediaSteps"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_learning_MediaSteps_ProvisionedCapacityLow_954653fb_d8fd_4e7d_b0f9_98fda98bbe37" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:6047ce94-bbd7-49c4-8606-e7a7350b3623:resource/dynamodb/table/learning.MediaSteps:policyName/WriteAutoScalingPolicy:createdBy/9f0835bd-759e-4312-8bbc-5501b2c3162a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:6047ce94-bbd7-49c4-8606-e7a7350b3623:resource/dynamodb/table/learning.MediaSteps:policyName/WriteAutoScalingPolicy:createdBy/9f0835bd-759e-4312-8bbc-5501b2c3162a."
  alarm_name          = "TargetTracking-table/learning.MediaSteps-ProvisionedCapacityLow-954653fb-d8fd-4e7d-b0f9-98fda98bbe37"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "learning.MediaSteps"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_AlarmHigh_0601b8e9_42fe_4c8e_b12c_072ea7da0f5c" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:07a9fd89-9f07-47b5-84a4-c0c61cbe09aa:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/2ba231ec-4871-46e3-9e61-38e2cc072fc6"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:07a9fd89-9f07-47b5-84a4-c0c61cbe09aa:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/2ba231ec-4871-46e3-9e61-38e2cc072fc6."
  alarm_name          = "TargetTracking-table/market.download.Content-AlarmHigh-0601b8e9-42fe-4c8e-b12c-072ea7da0f5c"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Content"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_AlarmHigh_c296194d_88ea_4963_89bb_dd1f8e922b3e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:439ed60b-0c20-4d7d-8aab-418702fffdb8:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/bcbf9907-739f-42fb-aec4-09941602321d"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:439ed60b-0c20-4d7d-8aab-418702fffdb8:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/bcbf9907-739f-42fb-aec4-09941602321d."
  alarm_name          = "TargetTracking-table/market.download.Content-AlarmHigh-c296194d-88ea-4963-89bb-dd1f8e922b3e"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Content"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_AlarmLow_d5d45a1a_fa46_41f1_9dce_fa1a26016669" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:439ed60b-0c20-4d7d-8aab-418702fffdb8:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/bcbf9907-739f-42fb-aec4-09941602321d"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:439ed60b-0c20-4d7d-8aab-418702fffdb8:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/bcbf9907-739f-42fb-aec4-09941602321d."
  alarm_name          = "TargetTracking-table/market.download.Content-AlarmLow-d5d45a1a-fa46-41f1-9dce-fa1a26016669"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Content"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_AlarmLow_da9461fe_0271_4a9c_b9fd_70e9a5795ccc" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:07a9fd89-9f07-47b5-84a4-c0c61cbe09aa:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/2ba231ec-4871-46e3-9e61-38e2cc072fc6"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:07a9fd89-9f07-47b5-84a4-c0c61cbe09aa:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/2ba231ec-4871-46e3-9e61-38e2cc072fc6."
  alarm_name          = "TargetTracking-table/market.download.Content-AlarmLow-da9461fe-0271-4a9c-b9fd-70e9a5795ccc"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Content"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_Development_AlarmHigh_694f1d85_b60d_4cca_b23c_0819b9d28d21" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f27c5584-727a-4fbd-a62b-d18524a8a0e7:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/88331696-6235-4af7-b288-0776d874c288"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f27c5584-727a-4fbd-a62b-d18524a8a0e7:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/88331696-6235-4af7-b288-0776d874c288."
  alarm_name          = "TargetTracking-table/market.download.Content-Development-AlarmHigh-694f1d85-b60d-4cca-b23c-0819b9d28d21"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Content-Development"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_Development_AlarmHigh_dc11cccc_77d3_4b32_b0f3_4adbb1a05dca" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0b504faa-aaa9-4061-a17d-1fa98f0c6cf0:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/711aa9a4-d8b5-42ae-8f6b-3969103b83aa"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0b504faa-aaa9-4061-a17d-1fa98f0c6cf0:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/711aa9a4-d8b5-42ae-8f6b-3969103b83aa."
  alarm_name          = "TargetTracking-table/market.download.Content-Development-AlarmHigh-dc11cccc-77d3-4b32-b0f3-4adbb1a05dca"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Content-Development"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_Development_AlarmLow_3c18df99_0e46_455d_bb3b_93fcc51ab31c" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f27c5584-727a-4fbd-a62b-d18524a8a0e7:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/88331696-6235-4af7-b288-0776d874c288"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f27c5584-727a-4fbd-a62b-d18524a8a0e7:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/88331696-6235-4af7-b288-0776d874c288."
  alarm_name          = "TargetTracking-table/market.download.Content-Development-AlarmLow-3c18df99-0e46-455d-bb3b-93fcc51ab31c"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Content-Development"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_Development_AlarmLow_5342b811_7a98_47df_a486_05192f01fa00" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0b504faa-aaa9-4061-a17d-1fa98f0c6cf0:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/711aa9a4-d8b5-42ae-8f6b-3969103b83aa"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0b504faa-aaa9-4061-a17d-1fa98f0c6cf0:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/711aa9a4-d8b5-42ae-8f6b-3969103b83aa."
  alarm_name          = "TargetTracking-table/market.download.Content-Development-AlarmLow-5342b811-7a98-47df-a486-05192f01fa00"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Content-Development"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_Development_ProvisionedCapacityHigh_27a7befc_3d61_4b77_b637_566a026d35fa" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f27c5584-727a-4fbd-a62b-d18524a8a0e7:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/88331696-6235-4af7-b288-0776d874c288"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f27c5584-727a-4fbd-a62b-d18524a8a0e7:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/88331696-6235-4af7-b288-0776d874c288."
  alarm_name          = "TargetTracking-table/market.download.Content-Development-ProvisionedCapacityHigh-27a7befc-3d61-4b77-b637-566a026d35fa"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Content-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_Development_ProvisionedCapacityHigh_3d2391b5_0735_48c8_9836_2b9e4dc94bc5" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0b504faa-aaa9-4061-a17d-1fa98f0c6cf0:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/711aa9a4-d8b5-42ae-8f6b-3969103b83aa"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0b504faa-aaa9-4061-a17d-1fa98f0c6cf0:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/711aa9a4-d8b5-42ae-8f6b-3969103b83aa."
  alarm_name          = "TargetTracking-table/market.download.Content-Development-ProvisionedCapacityHigh-3d2391b5-0735-48c8-9836-2b9e4dc94bc5"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Content-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_Development_ProvisionedCapacityLow_96bc65cb_fe1e_4bc2_9323_a39ca9c1468e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f27c5584-727a-4fbd-a62b-d18524a8a0e7:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/88331696-6235-4af7-b288-0776d874c288"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f27c5584-727a-4fbd-a62b-d18524a8a0e7:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/88331696-6235-4af7-b288-0776d874c288."
  alarm_name          = "TargetTracking-table/market.download.Content-Development-ProvisionedCapacityLow-96bc65cb-fe1e-4bc2-9323-a39ca9c1468e"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Content-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_Development_ProvisionedCapacityLow_f43f4877_792f_41b4_966e_c0b5982e352f" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0b504faa-aaa9-4061-a17d-1fa98f0c6cf0:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/711aa9a4-d8b5-42ae-8f6b-3969103b83aa"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0b504faa-aaa9-4061-a17d-1fa98f0c6cf0:resource/dynamodb/table/market.download.Content-Development:policyName/$market.download.Content-Development-scaling-policy:createdBy/711aa9a4-d8b5-42ae-8f6b-3969103b83aa."
  alarm_name          = "TargetTracking-table/market.download.Content-Development-ProvisionedCapacityLow-f43f4877-792f-41b4-966e-c0b5982e352f"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Content-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_ProvisionedCapacityHigh_25edbad8_9a17_4668_bf83_c19a7a3f4f6a" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:439ed60b-0c20-4d7d-8aab-418702fffdb8:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/bcbf9907-739f-42fb-aec4-09941602321d"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:439ed60b-0c20-4d7d-8aab-418702fffdb8:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/bcbf9907-739f-42fb-aec4-09941602321d."
  alarm_name          = "TargetTracking-table/market.download.Content-ProvisionedCapacityHigh-25edbad8-9a17-4668-bf83-c19a7a3f4f6a"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Content"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_ProvisionedCapacityHigh_f7403c8a_bd42_42e0_8111_dc609ad7a97d" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:07a9fd89-9f07-47b5-84a4-c0c61cbe09aa:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/2ba231ec-4871-46e3-9e61-38e2cc072fc6"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:07a9fd89-9f07-47b5-84a4-c0c61cbe09aa:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/2ba231ec-4871-46e3-9e61-38e2cc072fc6."
  alarm_name          = "TargetTracking-table/market.download.Content-ProvisionedCapacityHigh-f7403c8a-bd42-42e0-8111-dc609ad7a97d"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Content"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_ProvisionedCapacityLow_4d35bba2_50c4_4afb_8532_212a8f1a93f6" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:439ed60b-0c20-4d7d-8aab-418702fffdb8:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/bcbf9907-739f-42fb-aec4-09941602321d"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:439ed60b-0c20-4d7d-8aab-418702fffdb8:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/bcbf9907-739f-42fb-aec4-09941602321d."
  alarm_name          = "TargetTracking-table/market.download.Content-ProvisionedCapacityLow-4d35bba2-50c4-4afb-8532-212a8f1a93f6"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Content"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Content_ProvisionedCapacityLow_cd639a15_679c_43b1_9be1_75f915094b04" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:07a9fd89-9f07-47b5-84a4-c0c61cbe09aa:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/2ba231ec-4871-46e3-9e61-38e2cc072fc6"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:07a9fd89-9f07-47b5-84a4-c0c61cbe09aa:resource/dynamodb/table/market.download.Content:policyName/$market.download.Content-scaling-policy:createdBy/2ba231ec-4871-46e3-9e61-38e2cc072fc6."
  alarm_name          = "TargetTracking-table/market.download.Content-ProvisionedCapacityLow-cd639a15-679c-43b1-9be1-75f915094b04"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Content"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_AlarmHigh_1b336849_65bf_458d_b6e5_f18dc063fd37" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5e92d84f-a0f4-4f7e-9d89-3c833a083da3:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/b5c3b13f-b3eb-4a0e-bb54-8440ad00771c"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5e92d84f-a0f4-4f7e-9d89-3c833a083da3:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/b5c3b13f-b3eb-4a0e-bb54-8440ad00771c."
  alarm_name          = "TargetTracking-table/market.download.Download-AlarmHigh-1b336849-65bf-458d-b6e5-f18dc063fd37"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Download"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_AlarmHigh_2ef103af_a833_43cd_ae66_88e7ead0eb67" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b282243a-8264-4ca4-bf2e-725ca412d4c4:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/5bedeeb7-7cb1-438f-9113-a475dcbbf8bd"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b282243a-8264-4ca4-bf2e-725ca412d4c4:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/5bedeeb7-7cb1-438f-9113-a475dcbbf8bd."
  alarm_name          = "TargetTracking-table/market.download.Download-AlarmHigh-2ef103af-a833-43cd-ae66-88e7ead0eb67"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Download"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_AlarmLow_b633b099_ad4b_4c80_b718_2342cf8abdfb" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5e92d84f-a0f4-4f7e-9d89-3c833a083da3:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/b5c3b13f-b3eb-4a0e-bb54-8440ad00771c"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5e92d84f-a0f4-4f7e-9d89-3c833a083da3:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/b5c3b13f-b3eb-4a0e-bb54-8440ad00771c."
  alarm_name          = "TargetTracking-table/market.download.Download-AlarmLow-b633b099-ad4b-4c80-b718-2342cf8abdfb"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Download"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_AlarmLow_fcfcef64_d959_4150_89bf_4c36ff8527a5" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b282243a-8264-4ca4-bf2e-725ca412d4c4:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/5bedeeb7-7cb1-438f-9113-a475dcbbf8bd"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b282243a-8264-4ca4-bf2e-725ca412d4c4:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/5bedeeb7-7cb1-438f-9113-a475dcbbf8bd."
  alarm_name          = "TargetTracking-table/market.download.Download-AlarmLow-fcfcef64-d959-4150-89bf-4c36ff8527a5"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Download"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_Development_AlarmHigh_3c0522a1_9d9e_4351_9a77_68d263d67927" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0e26e355-517c-4384-9738-c59bb8c6653a:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/e07a3760-9e69-4072-a346-c58c096bab70"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0e26e355-517c-4384-9738-c59bb8c6653a:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/e07a3760-9e69-4072-a346-c58c096bab70."
  alarm_name          = "TargetTracking-table/market.download.Download-Development-AlarmHigh-3c0522a1-9d9e-4351-9a77-68d263d67927"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Download-Development"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_Development_AlarmHigh_6ff59fee_1d3f_42d2_b5d3_da515a018911" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:12d89c22-8bd3-475b-8a87-5953831a67a8:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/5eb23391-3185-4fae-b2ed-fc277d0e7596"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:12d89c22-8bd3-475b-8a87-5953831a67a8:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/5eb23391-3185-4fae-b2ed-fc277d0e7596."
  alarm_name          = "TargetTracking-table/market.download.Download-Development-AlarmHigh-6ff59fee-1d3f-42d2-b5d3-da515a018911"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Download-Development"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 42
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_Development_AlarmLow_12eb82ed_f62b_4ace_b61f_c8d1c9f75940" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:12d89c22-8bd3-475b-8a87-5953831a67a8:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/5eb23391-3185-4fae-b2ed-fc277d0e7596"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:12d89c22-8bd3-475b-8a87-5953831a67a8:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/5eb23391-3185-4fae-b2ed-fc277d0e7596."
  alarm_name          = "TargetTracking-table/market.download.Download-Development-AlarmLow-12eb82ed-f62b-4ace-b61f-c8d1c9f75940"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Download-Development"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_Development_AlarmLow_415841cf_593f_4e72_8ab2_28fff648a1f0" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0e26e355-517c-4384-9738-c59bb8c6653a:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/e07a3760-9e69-4072-a346-c58c096bab70"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0e26e355-517c-4384-9738-c59bb8c6653a:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/e07a3760-9e69-4072-a346-c58c096bab70."
  alarm_name          = "TargetTracking-table/market.download.Download-Development-AlarmLow-415841cf-593f-4e72-8ab2-28fff648a1f0"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Download-Development"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 30
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_Development_ProvisionedCapacityHigh_384c4d12_0ca2_418a_bd75_2325b899c0c4" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0e26e355-517c-4384-9738-c59bb8c6653a:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/e07a3760-9e69-4072-a346-c58c096bab70"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0e26e355-517c-4384-9738-c59bb8c6653a:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/e07a3760-9e69-4072-a346-c58c096bab70."
  alarm_name          = "TargetTracking-table/market.download.Download-Development-ProvisionedCapacityHigh-384c4d12-0ca2-418a-bd75-2325b899c0c4"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Download-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_Development_ProvisionedCapacityHigh_39318222_9ada_47a9_90f8_eb68daea7528" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:12d89c22-8bd3-475b-8a87-5953831a67a8:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/5eb23391-3185-4fae-b2ed-fc277d0e7596"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:12d89c22-8bd3-475b-8a87-5953831a67a8:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/5eb23391-3185-4fae-b2ed-fc277d0e7596."
  alarm_name          = "TargetTracking-table/market.download.Download-Development-ProvisionedCapacityHigh-39318222-9ada-47a9-90f8-eb68daea7528"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Download-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_Development_ProvisionedCapacityLow_a92eac51_8a4f_49d9_bf9a_8da524de0b7b" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0e26e355-517c-4384-9738-c59bb8c6653a:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/e07a3760-9e69-4072-a346-c58c096bab70"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0e26e355-517c-4384-9738-c59bb8c6653a:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/e07a3760-9e69-4072-a346-c58c096bab70."
  alarm_name          = "TargetTracking-table/market.download.Download-Development-ProvisionedCapacityLow-a92eac51-8a4f-49d9-bf9a-8da524de0b7b"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Download-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_Development_ProvisionedCapacityLow_e3eaff7f_07bc_44da_806f_b3d1f932bdaf" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:12d89c22-8bd3-475b-8a87-5953831a67a8:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/5eb23391-3185-4fae-b2ed-fc277d0e7596"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:12d89c22-8bd3-475b-8a87-5953831a67a8:resource/dynamodb/table/market.download.Download-Development:policyName/$market.download.Download-Development-scaling-policy:createdBy/5eb23391-3185-4fae-b2ed-fc277d0e7596."
  alarm_name          = "TargetTracking-table/market.download.Download-Development-ProvisionedCapacityLow-e3eaff7f-07bc-44da-806f-b3d1f932bdaf"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Download-Development"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_ProvisionedCapacityHigh_64763a6b_d8aa_4d52_8255_b7bc1f04f4d0" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b282243a-8264-4ca4-bf2e-725ca412d4c4:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/5bedeeb7-7cb1-438f-9113-a475dcbbf8bd"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b282243a-8264-4ca4-bf2e-725ca412d4c4:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/5bedeeb7-7cb1-438f-9113-a475dcbbf8bd."
  alarm_name          = "TargetTracking-table/market.download.Download-ProvisionedCapacityHigh-64763a6b-d8aa-4d52-8255-b7bc1f04f4d0"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Download"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_ProvisionedCapacityHigh_e0493186_d7ef_404b_b24a_3136b9ee63eb" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5e92d84f-a0f4-4f7e-9d89-3c833a083da3:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/b5c3b13f-b3eb-4a0e-bb54-8440ad00771c"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5e92d84f-a0f4-4f7e-9d89-3c833a083da3:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/b5c3b13f-b3eb-4a0e-bb54-8440ad00771c."
  alarm_name          = "TargetTracking-table/market.download.Download-ProvisionedCapacityHigh-e0493186-d7ef-404b-b24a-3136b9ee63eb"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "market.download.Download"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_ProvisionedCapacityLow_71bac349_ae19_4dc6_8980_32d08d011a24" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b282243a-8264-4ca4-bf2e-725ca412d4c4:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/5bedeeb7-7cb1-438f-9113-a475dcbbf8bd"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:b282243a-8264-4ca4-bf2e-725ca412d4c4:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/5bedeeb7-7cb1-438f-9113-a475dcbbf8bd."
  alarm_name          = "TargetTracking-table/market.download.Download-ProvisionedCapacityLow-71bac349-ae19-4dc6-8980-32d08d011a24"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Download"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_market_download_Download_ProvisionedCapacityLow_77caea27_06b9_4761_aa88_dd23b852463e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5e92d84f-a0f4-4f7e-9d89-3c833a083da3:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/b5c3b13f-b3eb-4a0e-bb54-8440ad00771c"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5e92d84f-a0f4-4f7e-9d89-3c833a083da3:resource/dynamodb/table/market.download.Download:policyName/$market.download.Download-scaling-policy:createdBy/b5c3b13f-b3eb-4a0e-bb54-8440ad00771c."
  alarm_name          = "TargetTracking-table/market.download.Download-ProvisionedCapacityLow-77caea27-06b9-4761-aa88-dd23b852463e"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "market.download.Download"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_media_ImageReference_AlarmHigh_056768f0_4a7a_4f4c_a85c_0ce806089810" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:77bf17b8-231c-44a5-9a06-739449b19a26:resource/dynamodb/table/media.ImageReference:policyName/WriteAutoScalingPolicy:createdBy/e6e411e0-4692-48f3-a92b-9f0be72a4f19"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:77bf17b8-231c-44a5-9a06-739449b19a26:resource/dynamodb/table/media.ImageReference:policyName/WriteAutoScalingPolicy:createdBy/e6e411e0-4692-48f3-a92b-9f0be72a4f19."
  alarm_name          = "TargetTracking-table/media.ImageReference-AlarmHigh-056768f0-4a7a-4f4c-a85c-0ce806089810"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "media.ImageReference"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_media_ImageReference_AlarmHigh_66b22d40_e65a_4de1_98ce_dba634d3024b" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4ddbe93c-1693-4f76-9563-003d77ca008a:resource/dynamodb/table/media.ImageReference:policyName/ReadAutoScalingPolicy:createdBy/7aade856-d353-43ac-8222-f9fda6b57639"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4ddbe93c-1693-4f76-9563-003d77ca008a:resource/dynamodb/table/media.ImageReference:policyName/ReadAutoScalingPolicy:createdBy/7aade856-d353-43ac-8222-f9fda6b57639."
  alarm_name          = "TargetTracking-table/media.ImageReference-AlarmHigh-66b22d40-e65a-4de1-98ce-dba634d3024b"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "media.ImageReference"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_media_ImageReference_AlarmLow_38ab69f4_efef_4944_8e43_e709478a0d5e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4ddbe93c-1693-4f76-9563-003d77ca008a:resource/dynamodb/table/media.ImageReference:policyName/ReadAutoScalingPolicy:createdBy/7aade856-d353-43ac-8222-f9fda6b57639"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4ddbe93c-1693-4f76-9563-003d77ca008a:resource/dynamodb/table/media.ImageReference:policyName/ReadAutoScalingPolicy:createdBy/7aade856-d353-43ac-8222-f9fda6b57639."
  alarm_name          = "TargetTracking-table/media.ImageReference-AlarmLow-38ab69f4-efef-4944-8e43-e709478a0d5e"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "media.ImageReference"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_media_ImageReference_AlarmLow_5005f074_5248_45a2_803f_89a9d77ef311" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:77bf17b8-231c-44a5-9a06-739449b19a26:resource/dynamodb/table/media.ImageReference:policyName/WriteAutoScalingPolicy:createdBy/e6e411e0-4692-48f3-a92b-9f0be72a4f19"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:77bf17b8-231c-44a5-9a06-739449b19a26:resource/dynamodb/table/media.ImageReference:policyName/WriteAutoScalingPolicy:createdBy/e6e411e0-4692-48f3-a92b-9f0be72a4f19."
  alarm_name          = "TargetTracking-table/media.ImageReference-AlarmLow-5005f074-5248-45a2-803f-89a9d77ef311"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "media.ImageReference"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_media_ImageReference_ProvisionedCapacityHigh_baf3dae1_5e77_48be_b3aa_cf8f7efad448" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:77bf17b8-231c-44a5-9a06-739449b19a26:resource/dynamodb/table/media.ImageReference:policyName/WriteAutoScalingPolicy:createdBy/e6e411e0-4692-48f3-a92b-9f0be72a4f19"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:77bf17b8-231c-44a5-9a06-739449b19a26:resource/dynamodb/table/media.ImageReference:policyName/WriteAutoScalingPolicy:createdBy/e6e411e0-4692-48f3-a92b-9f0be72a4f19."
  alarm_name          = "TargetTracking-table/media.ImageReference-ProvisionedCapacityHigh-baf3dae1-5e77-48be-b3aa-cf8f7efad448"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "media.ImageReference"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_media_ImageReference_ProvisionedCapacityHigh_bc2d771f_fb19_4177_a196_47d81c1c0b4e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4ddbe93c-1693-4f76-9563-003d77ca008a:resource/dynamodb/table/media.ImageReference:policyName/ReadAutoScalingPolicy:createdBy/7aade856-d353-43ac-8222-f9fda6b57639"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4ddbe93c-1693-4f76-9563-003d77ca008a:resource/dynamodb/table/media.ImageReference:policyName/ReadAutoScalingPolicy:createdBy/7aade856-d353-43ac-8222-f9fda6b57639."
  alarm_name          = "TargetTracking-table/media.ImageReference-ProvisionedCapacityHigh-bc2d771f-fb19-4177-a196-47d81c1c0b4e"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "media.ImageReference"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_media_ImageReference_ProvisionedCapacityLow_25425e28_57d6_4941_ba9e_65e1a722f8a3" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4ddbe93c-1693-4f76-9563-003d77ca008a:resource/dynamodb/table/media.ImageReference:policyName/ReadAutoScalingPolicy:createdBy/7aade856-d353-43ac-8222-f9fda6b57639"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4ddbe93c-1693-4f76-9563-003d77ca008a:resource/dynamodb/table/media.ImageReference:policyName/ReadAutoScalingPolicy:createdBy/7aade856-d353-43ac-8222-f9fda6b57639."
  alarm_name          = "TargetTracking-table/media.ImageReference-ProvisionedCapacityLow-25425e28-57d6-4941-ba9e-65e1a722f8a3"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "media.ImageReference"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_media_ImageReference_ProvisionedCapacityLow_a10f43f1_ded4_46eb_821a_53767521b73b" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:77bf17b8-231c-44a5-9a06-739449b19a26:resource/dynamodb/table/media.ImageReference:policyName/WriteAutoScalingPolicy:createdBy/e6e411e0-4692-48f3-a92b-9f0be72a4f19"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:77bf17b8-231c-44a5-9a06-739449b19a26:resource/dynamodb/table/media.ImageReference:policyName/WriteAutoScalingPolicy:createdBy/e6e411e0-4692-48f3-a92b-9f0be72a4f19."
  alarm_name          = "TargetTracking-table/media.ImageReference-ProvisionedCapacityLow-a10f43f1-ded4-46eb-821a-53767521b73b"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "media.ImageReference"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_ClientEndpoint_AlarmHigh_226bce9a_aeac_48f5_953e_fd0ccf0252de" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38199f27-6779-46fa-bee8-36d2f7dbd295:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/e0510f8e-7983-4cf6-979e-6b118d1ed96a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38199f27-6779-46fa-bee8-36d2f7dbd295:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/e0510f8e-7983-4cf6-979e-6b118d1ed96a."
  alarm_name          = "TargetTracking-table/notification.development.ClientEndpoint-AlarmHigh-226bce9a-aeac-48f5-953e-fd0ccf0252de"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.development.ClientEndpoint"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_ClientEndpoint_AlarmHigh_5087f86b_d8cc_4e1d_bbac_365db1adc077" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:317b76ea-ea83-49c2-beef-1d7ea92598c3:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/5a7e4701-03fc-40e7-a09d-2ef10830d7f9"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:317b76ea-ea83-49c2-beef-1d7ea92598c3:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/5a7e4701-03fc-40e7-a09d-2ef10830d7f9."
  alarm_name          = "TargetTracking-table/notification.development.ClientEndpoint-AlarmHigh-5087f86b-d8cc-4e1d-bbac-365db1adc077"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.development.ClientEndpoint"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_ClientEndpoint_AlarmLow_6170de97_5151_404c_abe9_fe3e5cae427a" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38199f27-6779-46fa-bee8-36d2f7dbd295:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/e0510f8e-7983-4cf6-979e-6b118d1ed96a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38199f27-6779-46fa-bee8-36d2f7dbd295:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/e0510f8e-7983-4cf6-979e-6b118d1ed96a."
  alarm_name          = "TargetTracking-table/notification.development.ClientEndpoint-AlarmLow-6170de97-5151-404c-abe9-fe3e5cae427a"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.development.ClientEndpoint"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_ClientEndpoint_AlarmLow_6a5835da_f087_478b_a8d2_1cae6ef06885" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:317b76ea-ea83-49c2-beef-1d7ea92598c3:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/5a7e4701-03fc-40e7-a09d-2ef10830d7f9"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:317b76ea-ea83-49c2-beef-1d7ea92598c3:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/5a7e4701-03fc-40e7-a09d-2ef10830d7f9."
  alarm_name          = "TargetTracking-table/notification.development.ClientEndpoint-AlarmLow-6a5835da-f087-478b-a8d2-1cae6ef06885"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.development.ClientEndpoint"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_ClientEndpoint_ProvisionedCapacityHigh_09ffb355_6ff3_457a_98ef_3f29052a8d09" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:317b76ea-ea83-49c2-beef-1d7ea92598c3:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/5a7e4701-03fc-40e7-a09d-2ef10830d7f9"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:317b76ea-ea83-49c2-beef-1d7ea92598c3:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/5a7e4701-03fc-40e7-a09d-2ef10830d7f9."
  alarm_name          = "TargetTracking-table/notification.development.ClientEndpoint-ProvisionedCapacityHigh-09ffb355-6ff3-457a-98ef-3f29052a8d09"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.development.ClientEndpoint"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_ClientEndpoint_ProvisionedCapacityHigh_f484ed26_c252_433d_aca7_5042d095bc9a" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38199f27-6779-46fa-bee8-36d2f7dbd295:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/e0510f8e-7983-4cf6-979e-6b118d1ed96a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38199f27-6779-46fa-bee8-36d2f7dbd295:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/e0510f8e-7983-4cf6-979e-6b118d1ed96a."
  alarm_name          = "TargetTracking-table/notification.development.ClientEndpoint-ProvisionedCapacityHigh-f484ed26-c252-433d-aca7-5042d095bc9a"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.development.ClientEndpoint"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_ClientEndpoint_ProvisionedCapacityLow_2aa9de64_183e_4eb6_8df9_4185014687c8" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38199f27-6779-46fa-bee8-36d2f7dbd295:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/e0510f8e-7983-4cf6-979e-6b118d1ed96a"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38199f27-6779-46fa-bee8-36d2f7dbd295:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/e0510f8e-7983-4cf6-979e-6b118d1ed96a."
  alarm_name          = "TargetTracking-table/notification.development.ClientEndpoint-ProvisionedCapacityLow-2aa9de64-183e-4eb6-8df9-4185014687c8"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.development.ClientEndpoint"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_ClientEndpoint_ProvisionedCapacityLow_d132840f_b4a1_434e_b01b_5a01df34831d" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:317b76ea-ea83-49c2-beef-1d7ea92598c3:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/5a7e4701-03fc-40e7-a09d-2ef10830d7f9"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:317b76ea-ea83-49c2-beef-1d7ea92598c3:resource/dynamodb/table/notification.development.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/5a7e4701-03fc-40e7-a09d-2ef10830d7f9."
  alarm_name          = "TargetTracking-table/notification.development.ClientEndpoint-ProvisionedCapacityLow-d132840f-b4a1-434e-b01b-5a01df34831d"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.development.ClientEndpoint"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_NotificationFeed_AlarmHigh_04737936_1a49_49c2_8ad9_8d673e777010" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:010ed4ff-f9d6-4493-9cd4-5480d1b3ca14:resource/dynamodb/table/notification.development.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/57c7ab2e-0a50-472d-95fa-7cdc30b9f9bd"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:010ed4ff-f9d6-4493-9cd4-5480d1b3ca14:resource/dynamodb/table/notification.development.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/57c7ab2e-0a50-472d-95fa-7cdc30b9f9bd."
  alarm_name          = "TargetTracking-table/notification.development.NotificationFeed-AlarmHigh-04737936-1a49-49c2-8ad9-8d673e777010"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.development.NotificationFeed"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_NotificationFeed_AlarmHigh_660301db_f02a_49f6_ad30_c733ce1454db" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5ca372c0-7655-46b6-b77a-01526832a31f:resource/dynamodb/table/notification.development.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/b14ce63d-5ba2-4b50-adda-e98771a1b6aa"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5ca372c0-7655-46b6-b77a-01526832a31f:resource/dynamodb/table/notification.development.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/b14ce63d-5ba2-4b50-adda-e98771a1b6aa."
  alarm_name          = "TargetTracking-table/notification.development.NotificationFeed-AlarmHigh-660301db-f02a-49f6-ad30-c733ce1454db"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.development.NotificationFeed"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_NotificationFeed_AlarmLow_3138a4da_02ab_4af9_b8e3_f24148903709" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:010ed4ff-f9d6-4493-9cd4-5480d1b3ca14:resource/dynamodb/table/notification.development.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/57c7ab2e-0a50-472d-95fa-7cdc30b9f9bd"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:010ed4ff-f9d6-4493-9cd4-5480d1b3ca14:resource/dynamodb/table/notification.development.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/57c7ab2e-0a50-472d-95fa-7cdc30b9f9bd."
  alarm_name          = "TargetTracking-table/notification.development.NotificationFeed-AlarmLow-3138a4da-02ab-4af9-b8e3-f24148903709"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.development.NotificationFeed"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_NotificationFeed_AlarmLow_9184abd6_70a4_4e40_b93d_b97758276c7b" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5ca372c0-7655-46b6-b77a-01526832a31f:resource/dynamodb/table/notification.development.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/b14ce63d-5ba2-4b50-adda-e98771a1b6aa"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5ca372c0-7655-46b6-b77a-01526832a31f:resource/dynamodb/table/notification.development.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/b14ce63d-5ba2-4b50-adda-e98771a1b6aa."
  alarm_name          = "TargetTracking-table/notification.development.NotificationFeed-AlarmLow-9184abd6-70a4-4e40-b93d-b97758276c7b"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.development.NotificationFeed"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_NotificationFeed_ProvisionedCapacityHigh_24ed5725_1ff3_4791_8f1b_09b567a7719c" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:010ed4ff-f9d6-4493-9cd4-5480d1b3ca14:resource/dynamodb/table/notification.development.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/57c7ab2e-0a50-472d-95fa-7cdc30b9f9bd"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:010ed4ff-f9d6-4493-9cd4-5480d1b3ca14:resource/dynamodb/table/notification.development.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/57c7ab2e-0a50-472d-95fa-7cdc30b9f9bd."
  alarm_name          = "TargetTracking-table/notification.development.NotificationFeed-ProvisionedCapacityHigh-24ed5725-1ff3-4791-8f1b-09b567a7719c"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.development.NotificationFeed"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_NotificationFeed_ProvisionedCapacityHigh_e1cc1df5_0dd3_40cb_91ff_9b761468332f" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5ca372c0-7655-46b6-b77a-01526832a31f:resource/dynamodb/table/notification.development.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/b14ce63d-5ba2-4b50-adda-e98771a1b6aa"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5ca372c0-7655-46b6-b77a-01526832a31f:resource/dynamodb/table/notification.development.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/b14ce63d-5ba2-4b50-adda-e98771a1b6aa."
  alarm_name          = "TargetTracking-table/notification.development.NotificationFeed-ProvisionedCapacityHigh-e1cc1df5-0dd3-40cb-91ff-9b761468332f"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.development.NotificationFeed"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_NotificationFeed_ProvisionedCapacityLow_ba433e5a_6146_4ea8_89b1_d2ce8ec14601" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:010ed4ff-f9d6-4493-9cd4-5480d1b3ca14:resource/dynamodb/table/notification.development.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/57c7ab2e-0a50-472d-95fa-7cdc30b9f9bd"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:010ed4ff-f9d6-4493-9cd4-5480d1b3ca14:resource/dynamodb/table/notification.development.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/57c7ab2e-0a50-472d-95fa-7cdc30b9f9bd."
  alarm_name          = "TargetTracking-table/notification.development.NotificationFeed-ProvisionedCapacityLow-ba433e5a-6146-4ea8-89b1-d2ce8ec14601"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.development.NotificationFeed"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_development_NotificationFeed_ProvisionedCapacityLow_cf5a71fa_696a_46ae_b2fc_470a79ea097e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5ca372c0-7655-46b6-b77a-01526832a31f:resource/dynamodb/table/notification.development.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/b14ce63d-5ba2-4b50-adda-e98771a1b6aa"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5ca372c0-7655-46b6-b77a-01526832a31f:resource/dynamodb/table/notification.development.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/b14ce63d-5ba2-4b50-adda-e98771a1b6aa."
  alarm_name          = "TargetTracking-table/notification.development.NotificationFeed-ProvisionedCapacityLow-cf5a71fa-696a-46ae-b2fc-470a79ea097e"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.development.NotificationFeed"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_ClientEndpoint_AlarmHigh_614ec91b_1114_4b7a_a9ab_0123575b57dd" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ec79fd7c-3bd1-459f-8773-aba5e0462616:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/06daf4d4-d625-45fa-9172-e49dde97e94d"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ec79fd7c-3bd1-459f-8773-aba5e0462616:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/06daf4d4-d625-45fa-9172-e49dde97e94d."
  alarm_name          = "TargetTracking-table/notification.production.ClientEndpoint-AlarmHigh-614ec91b-1114-4b7a-a9ab-0123575b57dd"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.production.ClientEndpoint"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_ClientEndpoint_AlarmHigh_f6dc9e07_00be_4281_8873_f3bd344d4657" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f173b973-3b62-4817-8f38-efdb9b3ece69:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/8b6b792c-bb8d-4b6f-8a46-871e6ee7b4f1"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f173b973-3b62-4817-8f38-efdb9b3ece69:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/8b6b792c-bb8d-4b6f-8a46-871e6ee7b4f1."
  alarm_name          = "TargetTracking-table/notification.production.ClientEndpoint-AlarmHigh-f6dc9e07-00be-4281-8873-f3bd344d4657"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.production.ClientEndpoint"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_ClientEndpoint_AlarmLow_afbb2075_9fc1_4b35_9206_7ec9d469f2f4" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f173b973-3b62-4817-8f38-efdb9b3ece69:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/8b6b792c-bb8d-4b6f-8a46-871e6ee7b4f1"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f173b973-3b62-4817-8f38-efdb9b3ece69:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/8b6b792c-bb8d-4b6f-8a46-871e6ee7b4f1."
  alarm_name          = "TargetTracking-table/notification.production.ClientEndpoint-AlarmLow-afbb2075-9fc1-4b35-9206-7ec9d469f2f4"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.production.ClientEndpoint"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_ClientEndpoint_AlarmLow_e851901e_1ad2_4ed6_803e_9a221ae783cc" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ec79fd7c-3bd1-459f-8773-aba5e0462616:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/06daf4d4-d625-45fa-9172-e49dde97e94d"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ec79fd7c-3bd1-459f-8773-aba5e0462616:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/06daf4d4-d625-45fa-9172-e49dde97e94d."
  alarm_name          = "TargetTracking-table/notification.production.ClientEndpoint-AlarmLow-e851901e-1ad2-4ed6-803e-9a221ae783cc"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.production.ClientEndpoint"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_ClientEndpoint_ProvisionedCapacityHigh_6b5a25b9_879d_42e8_8f78_48f3afa65cf5" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ec79fd7c-3bd1-459f-8773-aba5e0462616:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/06daf4d4-d625-45fa-9172-e49dde97e94d"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ec79fd7c-3bd1-459f-8773-aba5e0462616:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/06daf4d4-d625-45fa-9172-e49dde97e94d."
  alarm_name          = "TargetTracking-table/notification.production.ClientEndpoint-ProvisionedCapacityHigh-6b5a25b9-879d-42e8-8f78-48f3afa65cf5"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.production.ClientEndpoint"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_ClientEndpoint_ProvisionedCapacityHigh_afa545e1_3bca_41a6_8cff_284427410a9c" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f173b973-3b62-4817-8f38-efdb9b3ece69:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/8b6b792c-bb8d-4b6f-8a46-871e6ee7b4f1"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f173b973-3b62-4817-8f38-efdb9b3ece69:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/8b6b792c-bb8d-4b6f-8a46-871e6ee7b4f1."
  alarm_name          = "TargetTracking-table/notification.production.ClientEndpoint-ProvisionedCapacityHigh-afa545e1-3bca-41a6-8cff-284427410a9c"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.production.ClientEndpoint"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_ClientEndpoint_ProvisionedCapacityLow_24bce006_3bb4_4527_bbd3_b6d98673244e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ec79fd7c-3bd1-459f-8773-aba5e0462616:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/06daf4d4-d625-45fa-9172-e49dde97e94d"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:ec79fd7c-3bd1-459f-8773-aba5e0462616:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/WriteAutoScalingPolicy:createdBy/06daf4d4-d625-45fa-9172-e49dde97e94d."
  alarm_name          = "TargetTracking-table/notification.production.ClientEndpoint-ProvisionedCapacityLow-24bce006-3bb4-4527-bbd3-b6d98673244e"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.production.ClientEndpoint"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_ClientEndpoint_ProvisionedCapacityLow_50afc87f_7980_4370_8a61_c202fc0229d1" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f173b973-3b62-4817-8f38-efdb9b3ece69:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/8b6b792c-bb8d-4b6f-8a46-871e6ee7b4f1"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f173b973-3b62-4817-8f38-efdb9b3ece69:resource/dynamodb/table/notification.production.ClientEndpoint:policyName/ReadAutoScalingPolicy:createdBy/8b6b792c-bb8d-4b6f-8a46-871e6ee7b4f1."
  alarm_name          = "TargetTracking-table/notification.production.ClientEndpoint-ProvisionedCapacityLow-50afc87f-7980-4370-8a61-c202fc0229d1"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.production.ClientEndpoint"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_NotificationFeed_AlarmHigh_aafb78cd_01e3_4ad1_9f78_3a2182694eab" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c67a66d2-f02e-4d1d-95b6-a6fc5bdc718c:resource/dynamodb/table/notification.production.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/dca0709e-f34b-4467-af8e-ac49f562b4f3"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c67a66d2-f02e-4d1d-95b6-a6fc5bdc718c:resource/dynamodb/table/notification.production.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/dca0709e-f34b-4467-af8e-ac49f562b4f3."
  alarm_name          = "TargetTracking-table/notification.production.NotificationFeed-AlarmHigh-aafb78cd-01e3-4ad1-9f78-3a2182694eab"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.production.NotificationFeed"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_NotificationFeed_AlarmHigh_ded75409_6d31_4788_a045_9eb9a85d1a2b" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8c22f3e4-940f-44c7-8c86-fe42760a2e65:resource/dynamodb/table/notification.production.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/2d34a168-a4b0-443f-9be1-afdd71ed1217"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8c22f3e4-940f-44c7-8c86-fe42760a2e65:resource/dynamodb/table/notification.production.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/2d34a168-a4b0-443f-9be1-afdd71ed1217."
  alarm_name          = "TargetTracking-table/notification.production.NotificationFeed-AlarmHigh-ded75409-6d31-4788-a045-9eb9a85d1a2b"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.production.NotificationFeed"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_NotificationFeed_AlarmLow_07c80f68_56b5_4b7c_988d_09e82b65a52e" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c67a66d2-f02e-4d1d-95b6-a6fc5bdc718c:resource/dynamodb/table/notification.production.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/dca0709e-f34b-4467-af8e-ac49f562b4f3"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c67a66d2-f02e-4d1d-95b6-a6fc5bdc718c:resource/dynamodb/table/notification.production.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/dca0709e-f34b-4467-af8e-ac49f562b4f3."
  alarm_name          = "TargetTracking-table/notification.production.NotificationFeed-AlarmLow-07c80f68-56b5-4b7c-988d-09e82b65a52e"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.production.NotificationFeed"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_NotificationFeed_AlarmLow_d90da263_1658_4e19_a5f4_4f9e168914ba" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8c22f3e4-940f-44c7-8c86-fe42760a2e65:resource/dynamodb/table/notification.production.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/2d34a168-a4b0-443f-9be1-afdd71ed1217"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8c22f3e4-940f-44c7-8c86-fe42760a2e65:resource/dynamodb/table/notification.production.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/2d34a168-a4b0-443f-9be1-afdd71ed1217."
  alarm_name          = "TargetTracking-table/notification.production.NotificationFeed-AlarmLow-d90da263-1658-4e19-a5f4-4f9e168914ba"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.production.NotificationFeed"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_NotificationFeed_ProvisionedCapacityHigh_a76d8f37_0b00_4812_89b9_6aa8b58747a1" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c67a66d2-f02e-4d1d-95b6-a6fc5bdc718c:resource/dynamodb/table/notification.production.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/dca0709e-f34b-4467-af8e-ac49f562b4f3"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c67a66d2-f02e-4d1d-95b6-a6fc5bdc718c:resource/dynamodb/table/notification.production.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/dca0709e-f34b-4467-af8e-ac49f562b4f3."
  alarm_name          = "TargetTracking-table/notification.production.NotificationFeed-ProvisionedCapacityHigh-a76d8f37-0b00-4812-89b9-6aa8b58747a1"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.production.NotificationFeed"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_NotificationFeed_ProvisionedCapacityHigh_c2b9f819_1cb5_45d5_92a1_406a36e72e7c" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8c22f3e4-940f-44c7-8c86-fe42760a2e65:resource/dynamodb/table/notification.production.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/2d34a168-a4b0-443f-9be1-afdd71ed1217"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8c22f3e4-940f-44c7-8c86-fe42760a2e65:resource/dynamodb/table/notification.production.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/2d34a168-a4b0-443f-9be1-afdd71ed1217."
  alarm_name          = "TargetTracking-table/notification.production.NotificationFeed-ProvisionedCapacityHigh-c2b9f819-1cb5-45d5-92a1-406a36e72e7c"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "notification.production.NotificationFeed"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_NotificationFeed_ProvisionedCapacityLow_0f28515c_a79d_4249_ba55_8d8f1689cc0a" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8c22f3e4-940f-44c7-8c86-fe42760a2e65:resource/dynamodb/table/notification.production.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/2d34a168-a4b0-443f-9be1-afdd71ed1217"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8c22f3e4-940f-44c7-8c86-fe42760a2e65:resource/dynamodb/table/notification.production.NotificationFeed:policyName/WriteAutoScalingPolicy:createdBy/2d34a168-a4b0-443f-9be1-afdd71ed1217."
  alarm_name          = "TargetTracking-table/notification.production.NotificationFeed-ProvisionedCapacityLow-0f28515c-a79d-4249-ba55-8d8f1689cc0a"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.production.NotificationFeed"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_notification_production_NotificationFeed_ProvisionedCapacityLow_78cbf454_9545_403f_a6b6_671b9a5e5392" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c67a66d2-f02e-4d1d-95b6-a6fc5bdc718c:resource/dynamodb/table/notification.production.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/dca0709e-f34b-4467-af8e-ac49f562b4f3"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:c67a66d2-f02e-4d1d-95b6-a6fc5bdc718c:resource/dynamodb/table/notification.production.NotificationFeed:policyName/ReadAutoScalingPolicy:createdBy/dca0709e-f34b-4467-af8e-ac49f562b4f3."
  alarm_name          = "TargetTracking-table/notification.production.NotificationFeed-ProvisionedCapacityLow-78cbf454-9545-403f-a6b6-671b9a5e5392"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "notification.production.NotificationFeed"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_userCodes_Code_AlarmHigh_4e18f6a2_07a4_4163_a2a2_49e5834dca1b" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9944a818-6737-460b-bb07-d44b59a671a3:resource/dynamodb/table/userCodes.Code:policyName/WriteAutoScalingPolicy:createdBy/7c63bb76-4990-4da9-b412-4aafb3d421de"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9944a818-6737-460b-bb07-d44b59a671a3:resource/dynamodb/table/userCodes.Code:policyName/WriteAutoScalingPolicy:createdBy/7c63bb76-4990-4da9-b412-4aafb3d421de."
  alarm_name          = "TargetTracking-table/userCodes.Code-AlarmHigh-4e18f6a2-07a4-4163-a2a2-49e5834dca1b"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "userCodes.Code"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_userCodes_Code_AlarmHigh_bd28643c_9263_4c3f_83f1_b502905dc18a" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38382824-6305-4ddd-ae09-5e494afee3dd:resource/dynamodb/table/userCodes.Code:policyName/ReadAutoScalingPolicy:createdBy/edb06261-d919-435a-8641-063b7687b058"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38382824-6305-4ddd-ae09-5e494afee3dd:resource/dynamodb/table/userCodes.Code:policyName/ReadAutoScalingPolicy:createdBy/edb06261-d919-435a-8641-063b7687b058."
  alarm_name          = "TargetTracking-table/userCodes.Code-AlarmHigh-bd28643c-9263-4c3f-83f1-b502905dc18a"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "userCodes.Code"

  }
  evaluation_periods = 2
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 168
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_userCodes_Code_AlarmLow_5ed4799e_3f61_4eaf_9aa8_2cbb2e4e2360" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9944a818-6737-460b-bb07-d44b59a671a3:resource/dynamodb/table/userCodes.Code:policyName/WriteAutoScalingPolicy:createdBy/7c63bb76-4990-4da9-b412-4aafb3d421de"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9944a818-6737-460b-bb07-d44b59a671a3:resource/dynamodb/table/userCodes.Code:policyName/WriteAutoScalingPolicy:createdBy/7c63bb76-4990-4da9-b412-4aafb3d421de."
  alarm_name          = "TargetTracking-table/userCodes.Code-AlarmLow-5ed4799e-3f61-4eaf-9aa8-2cbb2e4e2360"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "userCodes.Code"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_userCodes_Code_AlarmLow_d1376487_31f5_4394_a99e_9d0b6da47a51" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38382824-6305-4ddd-ae09-5e494afee3dd:resource/dynamodb/table/userCodes.Code:policyName/ReadAutoScalingPolicy:createdBy/edb06261-d919-435a-8641-063b7687b058"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38382824-6305-4ddd-ae09-5e494afee3dd:resource/dynamodb/table/userCodes.Code:policyName/ReadAutoScalingPolicy:createdBy/edb06261-d919-435a-8641-063b7687b058."
  alarm_name          = "TargetTracking-table/userCodes.Code-AlarmLow-d1376487-31f5-4394-a99e-9d0b6da47a51"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "userCodes.Code"

  }
  evaluation_periods = 15
  metric_name        = "ConsumedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 60
  statistic          = "Sum"
  threshold          = 120
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_userCodes_Code_ProvisionedCapacityHigh_bad6ecc2_7098_424b_bff4_ebba2c5710fc" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9944a818-6737-460b-bb07-d44b59a671a3:resource/dynamodb/table/userCodes.Code:policyName/WriteAutoScalingPolicy:createdBy/7c63bb76-4990-4da9-b412-4aafb3d421de"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9944a818-6737-460b-bb07-d44b59a671a3:resource/dynamodb/table/userCodes.Code:policyName/WriteAutoScalingPolicy:createdBy/7c63bb76-4990-4da9-b412-4aafb3d421de."
  alarm_name          = "TargetTracking-table/userCodes.Code-ProvisionedCapacityHigh-bad6ecc2-7098-424b-bff4-ebba2c5710fc"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "userCodes.Code"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_userCodes_Code_ProvisionedCapacityHigh_e3a7323a_a9a3_4b2c_9c5d_b91598c5fd28" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38382824-6305-4ddd-ae09-5e494afee3dd:resource/dynamodb/table/userCodes.Code:policyName/ReadAutoScalingPolicy:createdBy/edb06261-d919-435a-8641-063b7687b058"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38382824-6305-4ddd-ae09-5e494afee3dd:resource/dynamodb/table/userCodes.Code:policyName/ReadAutoScalingPolicy:createdBy/edb06261-d919-435a-8641-063b7687b058."
  alarm_name          = "TargetTracking-table/userCodes.Code-ProvisionedCapacityHigh-e3a7323a-a9a3-4b2c-9c5d-b91598c5fd28"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    TableName = "userCodes.Code"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_userCodes_Code_ProvisionedCapacityLow_2221c955_4381_4aa9_ab73_523158a252e1" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9944a818-6737-460b-bb07-d44b59a671a3:resource/dynamodb/table/userCodes.Code:policyName/WriteAutoScalingPolicy:createdBy/7c63bb76-4990-4da9-b412-4aafb3d421de"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:9944a818-6737-460b-bb07-d44b59a671a3:resource/dynamodb/table/userCodes.Code:policyName/WriteAutoScalingPolicy:createdBy/7c63bb76-4990-4da9-b412-4aafb3d421de."
  alarm_name          = "TargetTracking-table/userCodes.Code-ProvisionedCapacityLow-2221c955-4381-4aa9-ab73-523158a252e1"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "userCodes.Code"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedWriteCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "TargetTracking_table_userCodes_Code_ProvisionedCapacityLow_df966a06_faf8_4ec8_a4d5_18fec6f7087d" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38382824-6305-4ddd-ae09-5e494afee3dd:resource/dynamodb/table/userCodes.Code:policyName/ReadAutoScalingPolicy:createdBy/edb06261-d919-435a-8641-063b7687b058"
  ]
  alarm_description   = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:38382824-6305-4ddd-ae09-5e494afee3dd:resource/dynamodb/table/userCodes.Code:policyName/ReadAutoScalingPolicy:createdBy/edb06261-d919-435a-8641-063b7687b058."
  alarm_name          = "TargetTracking-table/userCodes.Code-ProvisionedCapacityLow-df966a06-faf8-4ec8-a4d5-18fec6f7087d"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    TableName = "userCodes.Code"

  }
  evaluation_periods = 3
  metric_name        = "ProvisionedReadCapacityUnits"
  namespace          = "AWS/DynamoDB"
  period             = 300
  statistic          = "Average"
  threshold          = 4
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_32xzmdus8p_stack_AWSEBCWLHttp4xxPercentAlarm_YDXT4A8IZE2J" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-32xzmdus8p-stack-AWSEBCWLHttp4xxPercentAlarm-YDXT4A8IZE2J"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/services-gateway-blue"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_32xzmdus8p_stack_AWSEBCWLHttp5xxCountAlarm_1NH9VXZQ09AIF" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-32xzmdus8p-stack-AWSEBCWLHttp5xxCountAlarm-1NH9VXZQ09AIF"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/services-gateway-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_32xzmdus8p_stack_AWSEBCWLServiceErrorCountAlarm_LJ7NFNRWOKZ1" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-32xzmdus8p-stack-AWSEBCWLServiceErrorCountAlarm-LJ7NFNRWOKZ1"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/services-gateway-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_32xzmdus8p_stack_AWSEBCloudwatchAlarmHigh_A672AQQKLCQZ" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:108742bd-0c11-435d-bfb2-050f9353da86:autoScalingGroupName/awseb-e-32xzmdus8p-stack-AWSEBAutoScalingGroup-DG4CSGRX6MCC:policyName/awseb-e-32xzmdus8p-stack-AWSEBAutoScalingScaleUpPolicy-D7J831S7DEUE"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-32xzmdus8p-stack-AWSEBCloudwatchAlarmHigh-A672AQQKLCQZ"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-32xzmdus8p-stack-AWSEBAutoScalingGroup-DG4CSGRX6MCC"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 65
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_32xzmdus8p_stack_AWSEBCloudwatchAlarmLow_YY23GMVBPRO8" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8eec7c12-4b96-4920-a3c2-8da1cf9bd64d:autoScalingGroupName/awseb-e-32xzmdus8p-stack-AWSEBAutoScalingGroup-DG4CSGRX6MCC:policyName/awseb-e-32xzmdus8p-stack-AWSEBAutoScalingScaleDownPolicy-1LQ23IKYWK7K9"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-32xzmdus8p-stack-AWSEBCloudwatchAlarmLow-YY23GMVBPRO8"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-32xzmdus8p-stack-AWSEBAutoScalingGroup-DG4CSGRX6MCC"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 35
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_3evreti3za_stack_AWSEBCWLHttp4xxPercentAlarm_2B5YOFSC5HDF" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-3evreti3za-stack-AWSEBCWLHttp4xxPercentAlarm-2B5YOFSC5HDF"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/collaboration-person-blue"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_3evreti3za_stack_AWSEBCWLHttp5xxCountAlarm_1A3K1LKH6YB04" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-3evreti3za-stack-AWSEBCWLHttp5xxCountAlarm-1A3K1LKH6YB04"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/collaboration-person-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_3evreti3za_stack_AWSEBCWLServiceErrorCountAlarm_ZBG7V5LE8R9W" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-3evreti3za-stack-AWSEBCWLServiceErrorCountAlarm-ZBG7V5LE8R9W"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/collaboration-person-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_3evreti3za_stack_AWSEBCloudwatchAlarmHigh_OH98L9JAXB31" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:7d8dd0cf-1c9a-41a4-b902-ebff7ba48a7c:autoScalingGroupName/awseb-e-3evreti3za-stack-AWSEBAutoScalingGroup-1B0EJVZQ6UQV9:policyName/awseb-e-3evreti3za-stack-AWSEBAutoScalingScaleUpPolicy-PIRZN48RTQJA"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-3evreti3za-stack-AWSEBCloudwatchAlarmHigh-OH98L9JAXB31"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-3evreti3za-stack-AWSEBAutoScalingGroup-1B0EJVZQ6UQV9"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 12000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_3evreti3za_stack_AWSEBCloudwatchAlarmLow_1PG8M60BIGAHS" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e5258724-b895-42c9-b15e-6d3322a09eb1:autoScalingGroupName/awseb-e-3evreti3za-stack-AWSEBAutoScalingGroup-1B0EJVZQ6UQV9:policyName/awseb-e-3evreti3za-stack-AWSEBAutoScalingScaleDownPolicy-1QA01LKLM6OP4"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-3evreti3za-stack-AWSEBCloudwatchAlarmLow-1PG8M60BIGAHS"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-3evreti3za-stack-AWSEBAutoScalingGroup-1B0EJVZQ6UQV9"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 2000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_59p3bpnwec_stack_AWSEBCWLHttp4xxPercentAlarm_GAUIHBE0L185" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-59p3bpnwec-stack-AWSEBCWLHttp4xxPercentAlarm-GAUIHBE0L185"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/learner-web-ui-gateway-blue"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_59p3bpnwec_stack_AWSEBCWLHttp5xxCountAlarm_1TLG8JRBF1DKK" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-59p3bpnwec-stack-AWSEBCWLHttp5xxCountAlarm-1TLG8JRBF1DKK"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/learner-web-ui-gateway-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_59p3bpnwec_stack_AWSEBCWLServiceErrorCountAlarm_VTSJYO43S0VV" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-59p3bpnwec-stack-AWSEBCWLServiceErrorCountAlarm-VTSJYO43S0VV"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/learner-web-ui-gateway-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_59p3bpnwec_stack_AWSEBCloudwatchAlarmHigh_1MAE5O85XC6FK" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:00b97533-143b-4b17-89d4-70b3ee2318db:autoScalingGroupName/awseb-e-59p3bpnwec-stack-AWSEBAutoScalingGroup-1ON4K0NW5K7WO:policyName/awseb-e-59p3bpnwec-stack-AWSEBAutoScalingScaleUpPolicy-19YO6NK6QDGZZ"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-59p3bpnwec-stack-AWSEBCloudwatchAlarmHigh-1MAE5O85XC6FK"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-59p3bpnwec-stack-AWSEBAutoScalingGroup-1ON4K0NW5K7WO"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 65
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_59p3bpnwec_stack_AWSEBCloudwatchAlarmLow_EX1T4UM5XZ4E" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:5c601545-0493-4b4f-9133-6a00c4b5b34b:autoScalingGroupName/awseb-e-59p3bpnwec-stack-AWSEBAutoScalingGroup-1ON4K0NW5K7WO:policyName/awseb-e-59p3bpnwec-stack-AWSEBAutoScalingScaleDownPolicy-14U0CO42AAFAI"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-59p3bpnwec-stack-AWSEBCloudwatchAlarmLow-EX1T4UM5XZ4E"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-59p3bpnwec-stack-AWSEBAutoScalingGroup-1ON4K0NW5K7WO"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 35
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bmqqxwyjst_stack_AWSEBCWLHttp4xxPercentAlarm_1DQV6XL2CFEY" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-bmqqxwyjst-stack-AWSEBCWLHttp4xxPercentAlarm-1DQV6XL2CFEY"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/form-service-blue"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bmqqxwyjst_stack_AWSEBCWLHttp5xxCountAlarm_1F41313KQBBK" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-bmqqxwyjst-stack-AWSEBCWLHttp5xxCountAlarm-1F41313KQBBK"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/form-service-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bmqqxwyjst_stack_AWSEBCWLServiceErrorCountAlarm_U31G2C7BHOXI" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-bmqqxwyjst-stack-AWSEBCWLServiceErrorCountAlarm-U31G2C7BHOXI"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/form-service-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bmqqxwyjst_stack_AWSEBCloudwatchAlarmHigh_NZTGP2WZAUY6" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:af30632c-d2b9-4525-acc7-e579ef64edcc:autoScalingGroupName/awseb-e-bmqqxwyjst-stack-AWSEBAutoScalingGroup-LJXY7KQWBLXK:policyName/awseb-e-bmqqxwyjst-stack-AWSEBAutoScalingScaleUpPolicy-X4PGNF0ID3Y8"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-bmqqxwyjst-stack-AWSEBCloudwatchAlarmHigh-NZTGP2WZAUY6"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-bmqqxwyjst-stack-AWSEBAutoScalingGroup-LJXY7KQWBLXK"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 12000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bmqqxwyjst_stack_AWSEBCloudwatchAlarmLow_1UP9MI4SXJHS2" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:08b39865-2658-4522-9433-334844a0ce95:autoScalingGroupName/awseb-e-bmqqxwyjst-stack-AWSEBAutoScalingGroup-LJXY7KQWBLXK:policyName/awseb-e-bmqqxwyjst-stack-AWSEBAutoScalingScaleDownPolicy-1W1FB8PCAQDE0"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-bmqqxwyjst-stack-AWSEBCloudwatchAlarmLow-1UP9MI4SXJHS2"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-bmqqxwyjst-stack-AWSEBAutoScalingGroup-LJXY7KQWBLXK"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 2000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bner7vhrif_stack_AWSEBCWLHttp4xxPercentAlarm_DX6X68KTCWSY" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-bner7vhrif-stack-AWSEBCWLHttp4xxPercentAlarm-DX6X68KTCWSY"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bner7vhrif_stack_AWSEBCWLHttp5xxCountAlarm_14593IW1R3VKG" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-bner7vhrif-stack-AWSEBCWLHttp5xxCountAlarm-14593IW1R3VKG"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bner7vhrif_stack_AWSEBCWLServiceErrorCountAlarm_1XYIDO0T9B6MG" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-bner7vhrif-stack-AWSEBCWLServiceErrorCountAlarm-1XYIDO0T9B6MG"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/capillary-web-ui-gateway-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bner7vhrif_stack_AWSEBCloudwatchAlarmHigh_15PEP7ADYWVK3" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:1d9ca904-e2b0-45ef-af34-73da583be568:autoScalingGroupName/awseb-e-bner7vhrif-stack-AWSEBAutoScalingGroup-1ROG3ORZMMX48:policyName/awseb-e-bner7vhrif-stack-AWSEBAutoScalingScaleUpPolicy-LTG6WYDJC8K6"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-bner7vhrif-stack-AWSEBCloudwatchAlarmHigh-15PEP7ADYWVK3"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-bner7vhrif-stack-AWSEBAutoScalingGroup-1ROG3ORZMMX48"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 65
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_bner7vhrif_stack_AWSEBCloudwatchAlarmLow_GW0UGWWUL1U5" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:a4bcb435-11fd-41ae-8a21-d61490900f5f:autoScalingGroupName/awseb-e-bner7vhrif-stack-AWSEBAutoScalingGroup-1ROG3ORZMMX48:policyName/awseb-e-bner7vhrif-stack-AWSEBAutoScalingScaleDownPolicy-1VYZ7L04QGB70"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-bner7vhrif-stack-AWSEBCloudwatchAlarmLow-GW0UGWWUL1U5"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-bner7vhrif-stack-AWSEBAutoScalingGroup-1ROG3ORZMMX48"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 35
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fbj96npvkw_stack_AWSEBCWLHttp4xxPercentAlarm_I1WT9Z7HVNKL" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-fbj96npvkw-stack-AWSEBCWLHttp4xxPercentAlarm-I1WT9Z7HVNKL"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/identity-service-blue"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fbj96npvkw_stack_AWSEBCWLHttp5xxCountAlarm_14MVLVZT795DA" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-fbj96npvkw-stack-AWSEBCWLHttp5xxCountAlarm-14MVLVZT795DA"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/identity-service-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fbj96npvkw_stack_AWSEBCWLServiceErrorCountAlarm_JB25DIW048T8" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-fbj96npvkw-stack-AWSEBCWLServiceErrorCountAlarm-JB25DIW048T8"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/identity-service-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fbj96npvkw_stack_AWSEBCloudwatchAlarmHigh_1H7MKWUXH7Z20" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e7f0f65c-2773-4bd9-bc51-fcee1c63868d:autoScalingGroupName/awseb-e-fbj96npvkw-stack-AWSEBAutoScalingGroup-1MV2WEQG4C74B:policyName/awseb-e-fbj96npvkw-stack-AWSEBAutoScalingScaleUpPolicy-1RWNOVAVZ2TXH"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-fbj96npvkw-stack-AWSEBCloudwatchAlarmHigh-1H7MKWUXH7Z20"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-fbj96npvkw-stack-AWSEBAutoScalingGroup-1MV2WEQG4C74B"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 12000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fbj96npvkw_stack_AWSEBCloudwatchAlarmLow_1WWOGGUN195FB" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:761387e0-4c29-4662-b1f8-016cb51d8be8:autoScalingGroupName/awseb-e-fbj96npvkw-stack-AWSEBAutoScalingGroup-1MV2WEQG4C74B:policyName/awseb-e-fbj96npvkw-stack-AWSEBAutoScalingScaleDownPolicy-137S4KAZDJWXY"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-fbj96npvkw-stack-AWSEBCloudwatchAlarmLow-1WWOGGUN195FB"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-fbj96npvkw-stack-AWSEBAutoScalingGroup-1MV2WEQG4C74B"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 2000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fmzgrfkcqp_stack_AWSEBCWLHttp4xxPercentAlarm_2HFUL2KCJ5NU" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-fmzgrfkcqp-stack-AWSEBCWLHttp4xxPercentAlarm-2HFUL2KCJ5NU"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/book-service-blue"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fmzgrfkcqp_stack_AWSEBCWLHttp5xxCountAlarm_1H7I7UJDPVIV0" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-fmzgrfkcqp-stack-AWSEBCWLHttp5xxCountAlarm-1H7I7UJDPVIV0"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/book-service-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fmzgrfkcqp_stack_AWSEBCWLServiceErrorCountAlarm_22TVLIFUDF58" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-fmzgrfkcqp-stack-AWSEBCWLServiceErrorCountAlarm-22TVLIFUDF58"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/book-service-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fmzgrfkcqp_stack_AWSEBCloudwatchAlarmHigh_WD438XG9BKCF" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:de6f1db5-3f67-4bb8-8154-5d2a8a7b4621:autoScalingGroupName/awseb-e-fmzgrfkcqp-stack-AWSEBAutoScalingGroup-VMGLQ3UKK1KY:policyName/awseb-e-fmzgrfkcqp-stack-AWSEBAutoScalingScaleUpPolicy-183USW1NM3Y41"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-fmzgrfkcqp-stack-AWSEBCloudwatchAlarmHigh-WD438XG9BKCF"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-fmzgrfkcqp-stack-AWSEBAutoScalingGroup-VMGLQ3UKK1KY"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 12000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_fmzgrfkcqp_stack_AWSEBCloudwatchAlarmLow_14WFXK7YQYDN0" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0d255754-e734-4657-ba3a-def2e077e3fd:autoScalingGroupName/awseb-e-fmzgrfkcqp-stack-AWSEBAutoScalingGroup-VMGLQ3UKK1KY:policyName/awseb-e-fmzgrfkcqp-stack-AWSEBAutoScalingScaleDownPolicy-1T1KWOEZQZ9AU"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-fmzgrfkcqp-stack-AWSEBCloudwatchAlarmLow-14WFXK7YQYDN0"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-fmzgrfkcqp-stack-AWSEBAutoScalingGroup-VMGLQ3UKK1KY"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 2000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jgrjparfpf_stack_AWSEBCWLHttp4xxPercentAlarm_X18JI2K333RA" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-jgrjparfpf-stack-AWSEBCWLHttp4xxPercentAlarm-X18JI2K333RA"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/dbt-clinician-web-green"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jgrjparfpf_stack_AWSEBCWLHttp5xxCountAlarm_1R9WNI8FVQK41" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-jgrjparfpf-stack-AWSEBCWLHttp5xxCountAlarm-1R9WNI8FVQK41"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/dbt-clinician-web-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jgrjparfpf_stack_AWSEBCWLServiceErrorCountAlarm_8KQKF643OX4Y" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-jgrjparfpf-stack-AWSEBCWLServiceErrorCountAlarm-8KQKF643OX4Y"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/dbt-clinician-web-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jgrjparfpf_stack_AWSEBCloudwatchAlarmHigh_1EAKVJV3L491I" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8fce3c60-b542-4c29-86da-fa80ba44e661:autoScalingGroupName/awseb-e-jgrjparfpf-stack-AWSEBAutoScalingGroup-NCF5DZ76ITDN:policyName/awseb-e-jgrjparfpf-stack-AWSEBAutoScalingScaleUpPolicy-11PB2TBVHV9T1"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-jgrjparfpf-stack-AWSEBCloudwatchAlarmHigh-1EAKVJV3L491I"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-jgrjparfpf-stack-AWSEBAutoScalingGroup-NCF5DZ76ITDN"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 65
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jgrjparfpf_stack_AWSEBCloudwatchAlarmLow_NCUKPEIYM8PA" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:15e3825c-8531-42ae-a854-e663e77abb18:autoScalingGroupName/awseb-e-jgrjparfpf-stack-AWSEBAutoScalingGroup-NCF5DZ76ITDN:policyName/awseb-e-jgrjparfpf-stack-AWSEBAutoScalingScaleDownPolicy-9JQDULVEQPY7"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-jgrjparfpf-stack-AWSEBCloudwatchAlarmLow-NCUKPEIYM8PA"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-jgrjparfpf-stack-AWSEBAutoScalingGroup-NCF5DZ76ITDN"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 35
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jhagz8maay_stack_AWSEBCWLHttp4xxPercentAlarm_JQZ607MIYHR" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-jhagz8maay-stack-AWSEBCWLHttp4xxPercentAlarm-JQZ607MIYHR"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/market-service-green"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jhagz8maay_stack_AWSEBCWLHttp5xxCountAlarm_PKT6KGK6QWXY" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-jhagz8maay-stack-AWSEBCWLHttp5xxCountAlarm-PKT6KGK6QWXY"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/market-service-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jhagz8maay_stack_AWSEBCWLServiceErrorCountAlarm_RFN70E1SJDJP" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-jhagz8maay-stack-AWSEBCWLServiceErrorCountAlarm-RFN70E1SJDJP"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/market-service-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jhagz8maay_stack_AWSEBCloudwatchAlarmHigh_1XIV12Z949P1I" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:54530d52-cfe6-4344-8943-72119c3ad9c4:autoScalingGroupName/awseb-e-jhagz8maay-stack-AWSEBAutoScalingGroup-1M93QZILI7GQN:policyName/awseb-e-jhagz8maay-stack-AWSEBAutoScalingScaleUpPolicy-QAXPAV3838SO"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-jhagz8maay-stack-AWSEBCloudwatchAlarmHigh-1XIV12Z949P1I"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-jhagz8maay-stack-AWSEBAutoScalingGroup-1M93QZILI7GQN"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 12000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_jhagz8maay_stack_AWSEBCloudwatchAlarmLow_153GFQMHP3HIC" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:f49f3917-77cf-47bf-bdaf-4e39e14112ac:autoScalingGroupName/awseb-e-jhagz8maay-stack-AWSEBAutoScalingGroup-1M93QZILI7GQN:policyName/awseb-e-jhagz8maay-stack-AWSEBAutoScalingScaleDownPolicy-10I5CG1UC20TG"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-jhagz8maay-stack-AWSEBCloudwatchAlarmLow-153GFQMHP3HIC"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-jhagz8maay-stack-AWSEBAutoScalingGroup-1M93QZILI7GQN"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 2000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_p6bifdmp7h_stack_AWSEBCWLHttp4xxPercentAlarm_1XGO9YXKI667V" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-p6bifdmp7h-stack-AWSEBCWLHttp4xxPercentAlarm-1XGO9YXKI667V"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/capillary-web-ui-gateway-green"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_p6bifdmp7h_stack_AWSEBCWLHttp5xxCountAlarm_125R06ZQJX7N8" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-p6bifdmp7h-stack-AWSEBCWLHttp5xxCountAlarm-125R06ZQJX7N8"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/capillary-web-ui-gateway-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_p6bifdmp7h_stack_AWSEBCWLServiceErrorCountAlarm_1W2T5KM1S47HN" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-p6bifdmp7h-stack-AWSEBCWLServiceErrorCountAlarm-1W2T5KM1S47HN"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/capillary-web-ui-gateway-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_p6bifdmp7h_stack_AWSEBCloudwatchAlarmHigh_U8Z8K9S1PE37" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:569469f7-1944-46b9-a1bf-caac87464edd:autoScalingGroupName/awseb-e-p6bifdmp7h-stack-AWSEBAutoScalingGroup-1V4A0JOX0NVPA:policyName/awseb-e-p6bifdmp7h-stack-AWSEBAutoScalingScaleUpPolicy-2SU74CPESGKG"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-p6bifdmp7h-stack-AWSEBCloudwatchAlarmHigh-U8Z8K9S1PE37"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-p6bifdmp7h-stack-AWSEBAutoScalingGroup-1V4A0JOX0NVPA"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 65
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_p6bifdmp7h_stack_AWSEBCloudwatchAlarmLow_HE1D6SAXZ5B7" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:2e3e20b6-59fa-42a8-8432-f7cab7e7099c:autoScalingGroupName/awseb-e-p6bifdmp7h-stack-AWSEBAutoScalingGroup-1V4A0JOX0NVPA:policyName/awseb-e-p6bifdmp7h-stack-AWSEBAutoScalingScaleDownPolicy-V6SQJEGNRN3O"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-p6bifdmp7h-stack-AWSEBCloudwatchAlarmLow-HE1D6SAXZ5B7"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-p6bifdmp7h-stack-AWSEBAutoScalingGroup-1V4A0JOX0NVPA"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 35
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_pcw37ypdme_stack_AWSEBCWLHttp4xxPercentAlarm_ZB6GV1RWXMBW" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-pcw37ypdme-stack-AWSEBCWLHttp4xxPercentAlarm-ZB6GV1RWXMBW"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/mobile-client-gateway-blue"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_pcw37ypdme_stack_AWSEBCWLHttp5xxCountAlarm_17W5MLL4O3927" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-pcw37ypdme-stack-AWSEBCWLHttp5xxCountAlarm-17W5MLL4O3927"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/mobile-client-gateway-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_pcw37ypdme_stack_AWSEBCWLServiceErrorCountAlarm_JT6A2EQS0ECS" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-pcw37ypdme-stack-AWSEBCWLServiceErrorCountAlarm-JT6A2EQS0ECS"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/mobile-client-gateway-blue"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_pcw37ypdme_stack_AWSEBCloudwatchAlarmHigh_76CNQEJLDAMR" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:4379e626-64d8-4819-88bc-6cb6b15b5b1a:autoScalingGroupName/awseb-e-pcw37ypdme-stack-AWSEBAutoScalingGroup-165D32JDYUA6O:policyName/awseb-e-pcw37ypdme-stack-AWSEBAutoScalingScaleUpPolicy-1F3100WSAJD1J"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-pcw37ypdme-stack-AWSEBCloudwatchAlarmHigh-76CNQEJLDAMR"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-pcw37ypdme-stack-AWSEBAutoScalingGroup-165D32JDYUA6O"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 12000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_pcw37ypdme_stack_AWSEBCloudwatchAlarmLow_6RQURR8195DG" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:d0ee087c-8fb8-4213-90fa-d8d5f80af1bd:autoScalingGroupName/awseb-e-pcw37ypdme-stack-AWSEBAutoScalingGroup-165D32JDYUA6O:policyName/awseb-e-pcw37ypdme-stack-AWSEBAutoScalingScaleDownPolicy-HG4KJV0Q69ZT"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-pcw37ypdme-stack-AWSEBCloudwatchAlarmLow-6RQURR8195DG"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-pcw37ypdme-stack-AWSEBAutoScalingGroup-165D32JDYUA6O"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 2000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_rwv222b3qp_stack_AWSEBCWLHttp4xxPercentAlarm_1DP5PNHOJ2GNT" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-rwv222b3qp-stack-AWSEBCWLHttp4xxPercentAlarm-1DP5PNHOJ2GNT"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/learner-web-ui-gateway-green"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_rwv222b3qp_stack_AWSEBCWLHttp5xxCountAlarm_1JQDH1RSXTNLG" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-rwv222b3qp-stack-AWSEBCWLHttp5xxCountAlarm-1JQDH1RSXTNLG"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/learner-web-ui-gateway-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_rwv222b3qp_stack_AWSEBCWLServiceErrorCountAlarm_XT4YS5R1YUHM" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-rwv222b3qp-stack-AWSEBCWLServiceErrorCountAlarm-XT4YS5R1YUHM"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/learner-web-ui-gateway-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_rwv222b3qp_stack_AWSEBCloudwatchAlarmHigh_WKI4L1OQK674" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:e19d7015-1cb4-4c05-908e-c3587e78f740:autoScalingGroupName/awseb-e-rwv222b3qp-stack-AWSEBAutoScalingGroup-1MLNCOGIT8AIV:policyName/awseb-e-rwv222b3qp-stack-AWSEBAutoScalingScaleUpPolicy-RUQ4SK5DN42F"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-rwv222b3qp-stack-AWSEBCloudwatchAlarmHigh-WKI4L1OQK674"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-rwv222b3qp-stack-AWSEBAutoScalingGroup-1MLNCOGIT8AIV"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 65
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_rwv222b3qp_stack_AWSEBCloudwatchAlarmLow_18BK378P3CYCL" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:83bb4ebb-8243-4496-9edd-5d21a0401459:autoScalingGroupName/awseb-e-rwv222b3qp-stack-AWSEBAutoScalingGroup-1MLNCOGIT8AIV:policyName/awseb-e-rwv222b3qp-stack-AWSEBAutoScalingScaleDownPolicy-W7JR9Z2JAESZ"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-rwv222b3qp-stack-AWSEBCloudwatchAlarmLow-18BK378P3CYCL"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-rwv222b3qp-stack-AWSEBAutoScalingGroup-1MLNCOGIT8AIV"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 35
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_tx62adwg2k_stack_AWSEBCWLHttp4xxPercentAlarm_KR0UVJE492RT" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-tx62adwg2k-stack-AWSEBCWLHttp4xxPercentAlarm-KR0UVJE492RT"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/identity-service-green"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_tx62adwg2k_stack_AWSEBCWLHttp5xxCountAlarm_62UVO5J6GPET" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-tx62adwg2k-stack-AWSEBCWLHttp5xxCountAlarm-62UVO5J6GPET"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/identity-service-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_tx62adwg2k_stack_AWSEBCWLServiceErrorCountAlarm_D8V4XUHMU1LW" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-tx62adwg2k-stack-AWSEBCWLServiceErrorCountAlarm-D8V4XUHMU1LW"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/identity-service-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_tx62adwg2k_stack_AWSEBCloudwatchAlarmHigh_HUP3XB9WVVBY" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:0ec621f5-3a1b-4e5c-839b-111c7d602ad0:autoScalingGroupName/awseb-e-tx62adwg2k-stack-AWSEBAutoScalingGroup-WZUPJM6LCB0K:policyName/awseb-e-tx62adwg2k-stack-AWSEBAutoScalingScaleUpPolicy-UCSEVJA3RP2B"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-tx62adwg2k-stack-AWSEBCloudwatchAlarmHigh-HUP3XB9WVVBY"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-tx62adwg2k-stack-AWSEBAutoScalingGroup-WZUPJM6LCB0K"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 12000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_tx62adwg2k_stack_AWSEBCloudwatchAlarmLow_1FSU4O4GPW4KP" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:3a9cf105-8ac7-4fe1-b7d2-fef6cb24c186:autoScalingGroupName/awseb-e-tx62adwg2k-stack-AWSEBAutoScalingGroup-WZUPJM6LCB0K:policyName/awseb-e-tx62adwg2k-stack-AWSEBAutoScalingScaleDownPolicy-14XUDKZ14C737"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-tx62adwg2k-stack-AWSEBCloudwatchAlarmLow-1FSU4O4GPW4KP"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-tx62adwg2k-stack-AWSEBAutoScalingGroup-WZUPJM6LCB0K"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 2000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_xmec4epg3c_stack_AWSEBCWLHttp4xxPercentAlarm_1B8OE4DYCFS8P" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-xmec4epg3c-stack-AWSEBCWLHttp4xxPercentAlarm-1B8OE4DYCFS8P"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/book-service-green"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_xmec4epg3c_stack_AWSEBCWLHttp5xxCountAlarm_1GLLWZEG6X8G9" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-xmec4epg3c-stack-AWSEBCWLHttp5xxCountAlarm-1GLLWZEG6X8G9"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/book-service-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_xmec4epg3c_stack_AWSEBCWLServiceErrorCountAlarm_1UNYUXK9X0LOK" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-xmec4epg3c-stack-AWSEBCWLServiceErrorCountAlarm-1UNYUXK9X0LOK"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/book-service-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_xmec4epg3c_stack_AWSEBCloudwatchAlarmHigh_SS7P819SALL2" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:8f9dd026-8c5e-4109-985e-ceee7c3b8043:autoScalingGroupName/awseb-e-xmec4epg3c-stack-AWSEBAutoScalingGroup-UQ4ARCTDJ5PP:policyName/awseb-e-xmec4epg3c-stack-AWSEBAutoScalingScaleUpPolicy-WV6S313MW3OL"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-xmec4epg3c-stack-AWSEBCloudwatchAlarmHigh-SS7P819SALL2"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-xmec4epg3c-stack-AWSEBAutoScalingGroup-UQ4ARCTDJ5PP"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 12000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_xmec4epg3c_stack_AWSEBCloudwatchAlarmLow_UGSB43RJR8OR" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:394dd1c2-dca2-4441-82e3-352dc024eb4c:autoScalingGroupName/awseb-e-xmec4epg3c-stack-AWSEBAutoScalingGroup-UQ4ARCTDJ5PP:policyName/awseb-e-xmec4epg3c-stack-AWSEBAutoScalingScaleDownPolicy-1QH9F26QZJ6KF"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-xmec4epg3c-stack-AWSEBCloudwatchAlarmLow-UGSB43RJR8OR"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-xmec4epg3c-stack-AWSEBAutoScalingGroup-UQ4ARCTDJ5PP"

  }
  evaluation_periods = 2
  metric_name        = "NetworkOut"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 2000000
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLHttp4xxPercentAlarm_1U1SIXELEXDI3" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-4xx-client-errors"
  ]
  alarm_description   = "Application is returning too many 4xx responses (percentage too high)."
  alarm_name          = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLHttp4xxPercentAlarm-1U1SIXELEXDI3"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp4xx"
  namespace           = "ElasticBeanstalk/internal-services-gateway-green"
  period              = 60
  statistic           = "Average"
  threshold           = 0.1
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLHttp5xxCountAlarm_1QBCLRU9ELGEJ" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-5xx-server-errors"
  ]
  alarm_description   = "Application is returning too many 5xx responses (count too high)."
  alarm_name          = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLHttp5xxCountAlarm-1QBCLRU9ELGEJ"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLHttp5xx"
  namespace           = "ElasticBeanstalk/internal-services-gateway-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_yd9s5vvfgp_stack_AWSEBCWLServiceErrorCountAlarm_W8VUFW5SOUCX" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "awseb-e-yd9s5vvfgp-stack-AWSEBCWLServiceErrorCountAlarm-W8VUFW5SOUCX"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CWLServiceError"
  namespace           = "ElasticBeanstalk/internal-services-gateway-green"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_yd9s5vvfgp_stack_AWSEBCloudwatchAlarmHigh_LDCV6U4GHP4P" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:15304ba9-1195-4a44-ac9a-e11f2a4a66bc:autoScalingGroupName/awseb-e-yd9s5vvfgp-stack-AWSEBAutoScalingGroup-NT4M6B5ZTDEQ:policyName/awseb-e-yd9s5vvfgp-stack-AWSEBAutoScalingScaleUpPolicy-1HITXBUOH6F61"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Up alarm"
  alarm_name          = "awseb-e-yd9s5vvfgp-stack-AWSEBCloudwatchAlarmHigh-LDCV6U4GHP4P"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-yd9s5vvfgp-stack-AWSEBAutoScalingGroup-NT4M6B5ZTDEQ"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 65
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "awseb_e_yd9s5vvfgp_stack_AWSEBCloudwatchAlarmLow_132PE3UWXNHL1" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:autoscaling:us-gov-west-1:050779347855:scalingPolicy:64795aed-584e-4eb8-ab1e-cfe0c3666cf3:autoScalingGroupName/awseb-e-yd9s5vvfgp-stack-AWSEBAutoScalingGroup-NT4M6B5ZTDEQ:policyName/awseb-e-yd9s5vvfgp-stack-AWSEBAutoScalingScaleDownPolicy-1MIYTUR4DQXEO"
  ]
  alarm_description   = "ElasticBeanstalk Default Scale Down alarm"
  alarm_name          = "awseb-e-yd9s5vvfgp-stack-AWSEBCloudwatchAlarmLow-132PE3UWXNHL1"
  comparison_operator = "LessThanThreshold"
  dimensions = {
    AutoScalingGroupName = "awseb-e-yd9s5vvfgp-stack-AWSEBAutoScalingGroup-NT4M6B5ZTDEQ"

  }
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 35
  treat_missing_data = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_assessment_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-assessment-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/assessment-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_assessment_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-assessment-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/assessment-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_badge_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-badge-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/badge-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_badge_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-badge-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/badge-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_book_tree_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-book-tree-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/book-tree-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_book_tree_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-book-tree-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/book-tree-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_builder_publisher_task_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-builder-publisher-task-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/builder-publisher-task"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_builder_publisher_task_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-builder-publisher-task-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/builder-publisher-task"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_builder_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-builder-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/builder-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_builder_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-builder-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/builder-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_builder_sqs_task_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-builder-sqs-task-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/builder-sqs-task"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_builder_sqs_task_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-builder-sqs-task-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/builder-sqs-task"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_chat_allogy_server_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-chat-allogy-server-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/chat-allogy-server"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_chat_allogy_server_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-chat-allogy-server-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/chat-allogy-server"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_code_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-code-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/code-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_code_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-code-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/code-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_collections_space_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-collections-space-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/collections-space-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_collections_space_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-collections-space-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/collections-space-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_content_download_analytics_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-content-download-analytics-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/content-download-analytics-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_content_download_analytics_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-content-download-analytics-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/content-download-analytics-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_course_certificate_pdf_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-course-certificate-pdf-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/course-certificate-pdf-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_course_certificate_pdf_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-course-certificate-pdf-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/course-certificate-pdf-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_course_content_progress_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-course-content-progress-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/course-content-progress-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_course_content_progress_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-course-content-progress-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/course-content-progress-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_course_instance_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-course-instance-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/course-instance-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_course_instance_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-course-instance-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/course-instance-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_creator_graphql_api_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-creator-graphql-api-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/creator-graphql-api"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_creator_graphql_api_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-creator-graphql-api-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/creator-graphql-api"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_creator_settings_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-creator-settings-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/creator-settings-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_creator_settings_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-creator-settings-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/creator-settings-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_creator_user_settings_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-creator-user-settings-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/creator-user-settings-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_creator_user_settings_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-creator-user-settings-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/creator-user-settings-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_dbt_form_processor_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-dbt-form-processor-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/dbt-form-processor"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_dbt_form_processor_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-dbt-form-processor-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/dbt-form-processor"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_domain_model_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-domain-model-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/domain-model-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_domain_model_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-domain-model-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/domain-model-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_eureka_discovery_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-eureka-discovery-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/eureka-discovery-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_eureka_discovery_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-eureka-discovery-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/eureka-discovery-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_event_tracking_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-event-tracking-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/event-tracking-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_event_tracking_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-event-tracking-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/event-tracking-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_external_app_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-external-app-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/external-app-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_external_app_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-external-app-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/external-app-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_image_reference_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-image-reference-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/image-reference-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_image_reference_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-image-reference-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/image-reference-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_image_scaling_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-image-scaling-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/image-scaling-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_image_scaling_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-image-scaling-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/image-scaling-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_instructor_graphql_api_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-instructor-graphql-api-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/instructor-graphql-api"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_instructor_graphql_api_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-instructor-graphql-api-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/instructor-graphql-api"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_ip_geo_location_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-ip-geo-location-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/ip-geo-location-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_ip_geo_location_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-ip-geo-location-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/ip-geo-location-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_learner_graphql_api_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-learner-graphql-api-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/learner-graphql-api"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_learner_graphql_api_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-learner-graphql-api-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/learner-graphql-api"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_learning_activity_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-learning-activity-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/learning-activity-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_learning_activity_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-learning-activity-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/learning-activity-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_learning_media_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-learning-media-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/learning-media-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_learning_media_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-learning-media-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/learning-media-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_market_search_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-market-search-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/market-search-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_market_search_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-market-search-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/market-search-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_market_subscription_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-market-subscription-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/market-subscription-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_market_subscription_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-market-subscription-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/market-subscription-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_media_asset_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-media-asset-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/media-asset-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_media_asset_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-media-asset-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/media-asset-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_military_user_validator_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-military-user-validator-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/military-user-validator"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_military_user_validator_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-military-user-validator-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/military-user-validator"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_notification_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-notification-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/notification-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_notification_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-notification-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/notification-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_performance_assessment_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-performance-assessment-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/performance-assessment-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_performance_assessment_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-performance-assessment-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/performance-assessment-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_publication_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-publication-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/publication-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_publication_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-publication-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/publication-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_registration_validation_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-registration-validation-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/registration-validation-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_registration_validation_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-registration-validation-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/registration-validation-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_simple_email_manager_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-simple-email-manager-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/simple-email-manager"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_simple_email_manager_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-simple-email-manager-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/simple-email-manager"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_single_step_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-single-step-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/single-step-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_single_step_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-single-step-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/single-step-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_spring_config_server_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-spring-config-server-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/spring-config-server"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_spring_config_server_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-spring-config-server-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/spring-config-server"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_survey_form_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-survey-form-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/survey-form-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_survey_form_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-survey-form-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/survey-form-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_team_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-team-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/team-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_team_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-team-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/team-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_tenant_configuration_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-tenant-configuration-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/tenant-configuration-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_tenant_configuration_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-tenant-configuration-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/tenant-configuration-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_tenant_host_domain_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-tenant-host-domain-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/tenant-host-domain-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_tenant_host_domain_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-tenant-host-domain-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/tenant-host-domain-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_tenant_user_configuration_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-tenant-user-configuration-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/tenant-user-configuration-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_tenant_user_configuration_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-tenant-user-configuration-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/tenant-user-configuration-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_user_data_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-user-data-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/user-data-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_user_data_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-user-data-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/user-data-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_xapi_service_ServiceError" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many ERROR logs."
  alarm_name          = "microservice-xapi-service-ServiceError"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceError"
  namespace           = "ECSService/xapi-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "microservice_xapi_service_ServiceWarning" {
  actions_enabled = true
  alarm_actions = [
    "arn:aws-us-gov:sns:us-gov-west-1:050779347855:web-service-logging-errors"
  ]
  alarm_description   = "Application is logging too many WARNING logs."
  alarm_name          = "microservice-xapi-service-ServiceWarning"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ServiceWarning"
  namespace           = "ECSService/xapi-service"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  treat_missing_data  = "missing"
}

