resource "aws_lambda_function" "invoke" {
  function_name    = "${local.name_prefix}-invoke-test"
  role             = aws_iam_role.invoke.arn
  runtime          = "python3.7"
  handler          = "function-invoke.handler"
  filename         = "${path.module}/function-invoke.zip"
  source_code_hash = data.archive_file.invoke.output_base64sha256
  vpc_config {
    subnet_ids         = [aws_subnet.main.id]
    security_group_ids = [aws_vpc.main.default_security_group_id]
  }
  environment {
    variables = {
      SNS_TARGET_ARN = aws_sns_topic.test_updates.arn
    }
  }
}

resource "aws_lambda_function_url" "invoke" {
  function_name      = aws_lambda_function.invoke.function_name
  authorization_type = "NONE"
}

resource "aws_iam_role" "invoke" {
  name = "${local.name_prefix}-invoke-test"
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

resource "aws_iam_role_policy_attachment" "invoke_basic_execution" {
  role       = aws_iam_role.invoke.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "invoke_allow_network_interface" {
  role       = aws_iam_role.invoke.name
  policy_arn = aws_iam_policy.allow_network_interface.arn
}

resource "aws_iam_role_policy_attachment" "invoke_allow_topic_publish" {
  role       = aws_iam_role.invoke.name
  policy_arn = aws_iam_policy.allow_topic_publish.arn
}

resource "aws_iam_role_policy_attachment" "invoke_allow_encrypt_decrypt" {
  role       = aws_iam_role.invoke.name
  policy_arn = aws_iam_policy.allow_encrypt_decrypt.arn
}

data "archive_file" "invoke" {
  type             = "zip"
  source_file      = "${path.module}/function-invoke.py"
  output_path      = "${path.module}/function-invoke.zip"
  output_file_mode = "0644"
}
