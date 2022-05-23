output "invoke_url" {
  value = aws_lambda_function_url.invoke.function_url
}

output "bucket" {
  value = aws_s3_bucket.test_updates.bucket
}
