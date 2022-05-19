data "aws_iam_policy_document" "allow_sqs_invoke_lambda" {
  statement {
    effect = "Allow"
    resources = [
      "${aws_lambda_function.dequeue.arn}",
      "${aws_lambda_function.dequeue.arn}:*"
    ]
    actions = ["lambda:InvokeFunction"]
    principals {
      type        = "Service"
      identifiers = ["sqs.amazonaws.com"]
    }
  }
}
