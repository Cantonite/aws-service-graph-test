resource "aws_iam_role" "cloudwatch_feedback" {
  name = "${local.name_prefix}-sns-feedback"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_feedback_logs_full_access" {
  role       = aws_iam_role.cloudwatch_feedback.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
