# ====================
#
# Outputs
#
# ====================

output "ecs_iam_policy_arn" {
  value = aws_iam_policy.tf_ecs_iam_policy.arn
}
