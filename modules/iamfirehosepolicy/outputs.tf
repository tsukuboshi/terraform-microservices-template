# ====================
#
# Outputs
#
# ====================

output "firehose_iam_policy_arn" {
  value = aws_iam_policy.tf_firehose_iam_policy.arn
}
