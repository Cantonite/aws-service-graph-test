import os
import json
import boto3

def handler(event, context):

   message = {"foo": "bar"}
   client = boto3.client("sns")
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
