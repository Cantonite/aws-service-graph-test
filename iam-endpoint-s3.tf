data "aws_iam_policy_document" "allow_s3_put" {
  statement {
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.test_updates.arn}/*"
    ]
    actions = [
      "s3:*",
      "s3:PutObject"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
