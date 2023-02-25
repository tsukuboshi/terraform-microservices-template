# ====================
#
# Outputs
#
# ====================

output "codepipeline_iam_policy_arn" {
  value = aws_iam_policy.tf_codepipeline_iam_policy.arn
}
