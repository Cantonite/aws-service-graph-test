data "aws_iam_policy_document" "allow_sns_send" {
  statement {
    effect    = "Allow"
    resources = [aws_sqs_queue.test_updates.arn]
    actions   = ["sqs:SendMessage"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.test_updates.arn]
    }

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
  }

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "lambda:CreateEventSourceMapping",
      "lambda:ListEventSourceMappings",
      "lambda:ListFunctions"
    ]
  }
}
