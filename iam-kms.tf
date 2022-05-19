data "aws_iam_policy_document" "allow_key_usage" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.id}:root"
      ]
    }
  }

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "s3.amazonaws.com",
        "sns.amazonaws.com",
        "sqs.amazonaws.com"
      ]
    }
  }
}
