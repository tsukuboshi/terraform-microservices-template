# ====================
#
# Outputs
#
# ====================

output "eventbridge_iam_policy_arn" {
  value = aws_iam_policy.tf_eventbridge_iam_policy.arn
}
