def aws_cloudwatch_composite_alarm(self):
    print("Processing CloudWatch Composite Alarms...")

    paginator = self.cloudwatch_client.get_paginator("describe_alarms")
    for page in paginator.paginate(AlarmTypes=["CompositeAlarm"]):
        for composite_alarm in page["CompositeAlarms"]:
            alarm_name = composite_alarm["AlarmName"]
            print(f"  Processing CloudWatch Composite Alarm: {alarm_name}")

            attributes = {
                "id": alarm_name,
                "alarm_name": alarm_name,
                "alarm_description": composite_alarm.get("AlarmDescription", ""),
                "alarm_rule": composite_alarm["AlarmRule"],
                "actions_enabled": composite_alarm["ActionsEnabled"],
                "alarm_actions": composite_alarm.get("AlarmActions", []),
                "insufficient_data_actions": composite_alarm.get("InsufficientDataActions", []),
                "ok_actions": composite_alarm.get("OKActions", []),
            }

            self.hcl.process_resource(
                "aws_cloudwatch_composite_alarm", alarm_name.replace("-", "_"), attributes)


def aws_cloudwatch_dashboard(self):
    print("Processing CloudWatch Dashboards...")

    paginator = self.cloudwatch_client.get_paginator("list_dashboards")
    for page in paginator.paginate():
        for dashboard in page["DashboardEntries"]:
            dashboard_name = dashboard["DashboardName"]
            print(f"  Processing CloudWatch Dashboard: {dashboard_name}")

            dashboard_body = self.cloudwatch_client.get_dashboard(
                DashboardName=dashboard_name)["DashboardBody"]

            attributes = {
                "id": dashboard_name,
                "dashboard_name": dashboard_name,
                "dashboard_body": json.dumps(json.loads(dashboard_body), indent=2),
            }

            self.hcl.process_resource(
                "aws_cloudwatch_dashboard", dashboard_name.replace("-", "_"), attributes)


def aws_cloudwatch_metric_alarm(self):
    print("Processing CloudWatch Metric Alarms...")

    paginator = self.cloudwatch_client.get_paginator("describe_alarms")
    for page in paginator.paginate(AlarmTypes=["MetricAlarm"]):
        for metric_alarm in page["MetricAlarms"]:
            alarm_name = metric_alarm["AlarmName"]
            print(f"  Processing CloudWatch Metric Alarm: {alarm_name}")

            attributes = {
                "id": alarm_name,
                "alarm_name": alarm_name,
                "alarm_description": metric_alarm.get("AlarmDescription", ""),
                "comparison_operator": metric_alarm["ComparisonOperator"],
                "evaluation_periods": metric_alarm["EvaluationPeriods"],
                "metric_name": metric_alarm["MetricName"],
                "namespace": metric_alarm["Namespace"],
                "period": metric_alarm["Period"],
                "statistic": metric_alarm["Statistic"],
                "threshold": metric_alarm["Threshold"],
                "actions_enabled": metric_alarm["ActionsEnabled"],
                "alarm_actions": metric_alarm.get("AlarmActions", []),
                "insufficient_data_actions": metric_alarm.get("InsufficientDataActions", []),
                "ok_actions": metric_alarm.get("OKActions", []),
            }

            if "Dimensions" in metric_alarm:
                attributes["dimensions"] = {
                    dimension["Name"]: dimension["Value"] for dimension in metric_alarm["Dimensions"]}

            self.hcl.process_resource(
                "aws_cloudwatch_metric_alarm", alarm_name.replace("-", "_"), attributes)


def aws_cloudwatch_metric_stream(self):
    print("Processing CloudWatch Metric Streams...")

    paginator = self.cloudwatch_client.get_paginator("describe_metric_streams")
    for page in paginator.paginate():
        for metric_stream in page["Entries"]:
            stream_name = metric_stream["Name"]
            print(f"  Processing CloudWatch Metric Stream: {stream_name}")

            attributes = {
                "id": stream_name,
                "name": stream_name,
                "arn": metric_stream["Arn"],
                "firehose_arn": metric_stream["FirehoseArn"],
                "role_arn": metric_stream["RoleArn"],
                "output_format": metric_stream["OutputFormat"],
            }

            if "IncludeFilters" in metric_stream:
                attributes["include_filters"] = metric_stream["IncludeFilters"]

            if "ExcludeFilters" in metric_stream:
                attributes["exclude_filters"] = metric_stream["ExcludeFilters"]

            self.hcl.process_resource(
                "aws_cloudwatch_metric_stream", stream_name.replace("-", "_"), attributes)
