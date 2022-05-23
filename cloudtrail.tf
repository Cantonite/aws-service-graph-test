# resource "aws_cloudtrail" "test_updates_s3" {
#   name                          = aws_s3_bucket.test_updates.bucket
#   s3_bucket_name                = aws_s3_bucket.test_updates.id
#   s3_key_prefix                 = "prefix"
#   include_global_service_events = false

#   event_selector {
#     read_write_type           = "All"
#     include_management_events = false

#     data_resource {
#       type   = "AWS::S3::Object"
#       values = ["arn:aws:s3"]
#     }
#   }
# }

# resource "aws_s3_bucket_policy" "test_updates_s3" {
#   bucket = aws_s3_bucket.test_updates.id
#   policy = data.aws_iam_policy_document.allow_s3_cloudtrail.json
# }
