data "aws_iam_policy_document" "allow_network_interface" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeInstances",
      "ec2:AttachNetworkInterface",
    ]
  }
}

resource "aws_iam_policy" "allow_network_interface" {
  policy = data.aws_iam_policy_document.allow_network_interface.json
}

data "aws_iam_policy_document" "allow_receive_message" {
  statement {
    effect    = "Allow"
    resources = [aws_sqs_queue.test_updates.arn]

    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:Get*"
    ]
  }
}

resource "aws_iam_policy" "allow_receive_message" {
  policy = data.aws_iam_policy_document.allow_receive_message.json
}

data "aws_iam_policy_document" "allow_topic_publish" {
  statement {
    effect    = "Allow"
    resources = [aws_sns_topic.test_updates.arn]

    actions = [
      "sns:Publish"
    ]
  }
}

resource "aws_iam_policy" "allow_topic_publish" {
  policy = data.aws_iam_policy_document.allow_topic_publish.json
}

data "aws_iam_policy_document" "allow_s3_write" {
  statement {
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.test_updates.arn}/*",
      "${aws_s3_bucket.test_updates.arn}"
    ]

    actions = [
      "s3:*",
      "s3:PutObject"
    ]
  }
}

resource "aws_iam_policy" "allow_s3_write" {
  policy = data.aws_iam_policy_document.allow_s3_write.json
}

data "aws_iam_policy_document" "allow_encrypt_decrypt" {
  statement {
    effect    = "Allow"
    resources = [aws_kms_key.encrypt_decrypt.arn]

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
  }
}

resource "aws_iam_policy" "allow_encrypt_decrypt" {
  policy = data.aws_iam_policy_document.allow_encrypt_decrypt.json
}
