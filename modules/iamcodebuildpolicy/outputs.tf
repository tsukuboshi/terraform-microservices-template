# ====================
#
# Outputs
#
# ====================

output "codebuild_iam_policy_arn" {
  value = aws_iam_policy.tf_codebuild_iam_policy.arn
}
