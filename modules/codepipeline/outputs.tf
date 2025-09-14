# ====================
#
# Outputs
#
# ====================

output "codepipeline_arn" {
  value = aws_codepipeline.tf_codepipeline.arn
}
