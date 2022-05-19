import os
import json
import boto3

client = boto3.client(
    service_name="sns",
    region_name="eu-west-2"
)

def handler(event, context):
   message = {"foo": "bar"}
   response = client.publish (
      TargetArn = os.environ.get("SNS_TARGET_ARN"),
      Message = json.dumps({'default': json.dumps(message)}),
      Subject = "Test",
      MessageStructure = "json"
   )

   return {
      "statusCode": 200,
      "body": json.dumps(response)
   }
