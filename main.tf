resource "aws_sns_topic" "test_updates" {
  name = "${local.name_prefix}-test-updates"

  kms_master_key_id = aws_kms_key.encrypt_decrypt.key_id

  sqs_failure_feedback_role_arn    = aws_iam_role.cloudwatch_feedback.arn
  sqs_success_feedback_role_arn    = aws_iam_role.cloudwatch_feedback.arn
  sqs_success_feedback_sample_rate = 100
}

resource "aws_sqs_queue" "test_updates" {
  name = "${local.name_prefix}-test-updates"

  kms_master_key_id = aws_kms_key.encrypt_decrypt.key_id
}

resource "aws_sqs_queue_policy" "test_updates" {
  queue_url = aws_sqs_queue.test_updates.id

  policy = data.aws_iam_policy_document.allow_sns_send.json
}

resource "aws_sns_topic_subscription" "test_updates" {
  protocol = "sqs"

  topic_arn = aws_sns_topic.test_updates.arn
  endpoint  = aws_sqs_queue.test_updates.arn
}

resource "aws_lambda_event_source_mapping" "test_updates" {
  event_source_arn = aws_sqs_queue.test_updates.arn
  function_name    = aws_lambda_function.dequeue.arn
}

resource "aws_s3_bucket" "test_updates" {
  bucket_prefix = "${local.name_prefix}-test-updates"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "test_updates" {
  bucket = aws_s3_bucket.test_updates.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.encrypt_decrypt.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
