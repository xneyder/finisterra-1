import os
import json
import boto3
from kafka import KafkaConsumer
from dotenv import load_dotenv
from typing import Dict
import sys
from providers.aws.Aws import Aws

# Load environment variables from .env file
load_dotenv()

KAFKA_BROKER = os.environ.get("KAFKA_BROKER")
KAFKA_TOPIC = os.environ.get("KAFKA_TOPIC")


def process_task(task_data: Dict):
    # Add your task processing logic here
    print("Processing task:", task_data)


def main():
    consumer = KafkaConsumer(
        KAFKA_TOPIC,
        bootstrap_servers=[KAFKA_BROKER],
        value_deserializer=lambda v: json.loads(v.decode('utf-8')),
        auto_offset_reset='earliest',
        group_id="gen_code_group",
        enable_auto_commit=False
    )

    script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))

    for message in consumer:
        task = message.value
        id_token = task['idToken']
        role_arn = task['roleArn']
        session_duration = task['sessionDuration']
        task_data = task['taskData']
        aws_region = task['awsRegion']
        provider = Aws(script_dir)

        try:
            provider.set_boto3_session(
                id_token, role_arn, session_duration, aws_region)

            process_task(task_data)
            provider.vpc()
            consumer.commit()
            print("Task processed and committed")
        except Exception as e:
            print("Error processing task:", e)


if __name__ == "__main__":
    main()
