# AWS Service Graph Test

Probably a bad name. Intention is to have a test suite which does a round-robin of AWS services. It's graph as in directed graph, not GraphQL or some other growth pain you are experiencing.

It can be seen as a reference point for IAM policies, or a way of proving that some tracing tooling is working as expected. Whatever it is, I found a lot of satisfaction in making it work.

Demonstrating:

1. Customer-Managed Keys (CMK)
2. Private Lambda functions (within VPC)
3. Lambda -> SNS
4. SNS -> SQS
5. SQS -> Lambda
6. Lambda -> S3

At time of authoring, the prerequisites are:

1. Terraform v1.1.5 (just realised I could be on v1.2.0, probably same difference)
2. An AWS account with credentials set up. Please refer to documentation or write me an email if you don't know this bit.

Creates one or more of the following resources:

- aws_lambda_function
- aws_iam_role
- aws_iam_role_policy_attachment
- aws_lambda_function
- aws_lambda_function_url
- aws_iam_role
- aws_iam_role_policy_attachment
- aws_iam_policy
- aws_iam_role
- aws_iam_role_policy_attachment
- aws_kms_key
- aws_sns_topic
- aws_sqs_queue
- aws_sqs_queue_policy
- aws_sns_topic_subscription
- aws_lambda_event_source_mapping
- aws_s3_bucket
- aws_s3_bucket_server_side_encryption_configuration
- aws_vpc
- aws_subnet
- aws_vpc_endpoint

To build:

```shell
make plan
make apply
```

To test:

```shell
make test
```

The test will:

1. Invoke a Lambda function via the Lambda URL
2. Lambda will publish to an SNS topic
3. SNS topic will put a message on an SQS queue
4. SQS will trigger another Lambda function
5. Lambda function will write to S3

The S3 object should contain details about your initial request! Wahoo!
