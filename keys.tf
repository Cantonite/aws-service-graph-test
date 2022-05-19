# resource "aws_kms_key" "signing_verify" {
#   description             = "KMS key for signing"
#   deletion_window_in_days = 7
#   key_usage               = "SIGN_VERIFY"
# }

resource "aws_kms_key" "encrypt_decrypt" {
  description             = "KMS key encryption"
  deletion_window_in_days = 7
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = data.aws_iam_policy_document.allow_key_usage.json
}
