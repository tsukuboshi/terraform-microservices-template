# ====================
#
# Outputs
#
# ====================

output "codebuild_project_id" {
  value = aws_codebuild_project.tf_codebuild.id
}

output "codebuild_project_arn" {
  value = aws_codebuild_project.tf_codebuild.arn
}
