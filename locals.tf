locals {
  name_prefix = "${data.aws_region.current.name}-${data.aws_caller_identity.current.id}"

  aws_services = [
    "s3",
    "sns",
    "sqs",
    "kms"
  ]
}
