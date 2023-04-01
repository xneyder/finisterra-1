def aws_cloudtrail(self):
    print("Processing AWS CloudTrail...")

    paginator = self.cloudtrail_client.get_paginator("describe_trails")
    for page in paginator.paginate():
        for trail in page["trailList"]:
            trail_arn = trail["TrailARN"]
            trail_name = trail["Name"]
            print(f"  Processing AWS CloudTrail: {trail_name}")

            attributes = {
                "id": trail_name,
                "arn": trail_arn,
                "name": trail_name,
                "s3_bucket_name": trail["S3BucketName"],
                "s3_key_prefix": trail.get("S3KeyPrefix", ""),
                "cloud_watch_logs_role_arn": trail.get("CloudWatchLogsRoleArn", ""),
                "cloud_watch_logs_group_arn": trail.get("CloudWatchLogsLogGroupArn", ""),
                "sns_topic_name": trail.get("SnsTopicName", ""),
            }

            self.hcl.process_resource(
                "aws_cloudtrail", trail_name.replace("-", "_"), attributes)


def aws_cloudtrail_event_data_store(self):
    print("Processing AWS CloudTrail Event Data Store...")

    response = self.cloudtrail_client.list_event_selectors(
        TrailName=self.trail_name)
    event_selectors = response["EventSelectors"]

    for event_selector in event_selectors:
        for data_resource in event_selector["DataResources"]:
            if data_resource["Type"] == "AWS::S3::Object":
                print(
                    f"  Processing AWS CloudTrail Event Data Store: {data_resource['Values'][0]}")

                attributes = {
                    "id": data_resource["Values"][0],
                    "trail_arn": self.trail_arn,
                    "type": data_resource["Type"],
                    "values": data_resource["Values"],
                }

                self.hcl.process_resource(
                    "aws_cloudtrail_event_data_store", data_resource["Values"][0].replace("/", "_"), attributes)
