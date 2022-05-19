resource "aws_lambda_function" "dequeue" {
  function_name    = "${local.name_prefix}-dequeue-test"
  role             = aws_iam_role.dequeue.arn
  runtime          = "python3.7"
  handler          = "function-dequeue.handler"
  filename         = "${path.module}/function-dequeue.zip"
  source_code_hash = data.archive_file.dequeue.output_base64sha256
  vpc_config {
    subnet_ids         = [aws_subnet.main.id]
    security_group_ids = [aws_vpc.main.default_security_group_id]
  }
  environment {
    variables = {
      S3_BUCKET_NAME = aws_s3_bucket.test_updates.bucket
    }
  }
}

resource "aws_iam_role" "dequeue" {
  name = "${local.name_prefix}-dequeue-test"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dequeue_basic_execution" {
  role       = aws_iam_role.dequeue.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "dequeue_allow_network_interface" {
  role       = aws_iam_role.dequeue.name
  policy_arn = aws_iam_policy.allow_network_interface.arn
}

resource "aws_iam_role_policy_attachment" "dequeue_allow_receive_message" {
  role       = aws_iam_role.dequeue.name
  policy_arn = aws_iam_policy.allow_receive_message.arn
}

resource "aws_iam_role_policy_attachment" "dequeue_allow_s3_write" {
  role       = aws_iam_role.dequeue.name
  policy_arn = aws_iam_policy.allow_s3_write.arn
}

resource "aws_iam_role_policy_attachment" "dequeue_allow_encrypt_decrypt" {
  role       = aws_iam_role.dequeue.name
  policy_arn = aws_iam_policy.allow_encrypt_decrypt.arn
}

data "archive_file" "dequeue" {
  type             = "zip"
  source_file      = "${path.module}/function-dequeue.py"
  output_path      = "${path.module}/function-dequeue.zip"
  output_file_mode = "0644"
}
