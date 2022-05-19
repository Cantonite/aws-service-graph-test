import os
import boto3

client = boto3.client('s3')

def handler(event, context):
    for record in event["Records"]:
        client.put_object(
            Body=record["body"],
            Bucket=os.environ.get("S3_BUCKET_NAME"),
            Key='test.txt')