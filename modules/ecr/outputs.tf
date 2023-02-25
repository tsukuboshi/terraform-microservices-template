# ====================
#
# Outputs
#
# ====================

output "ecr_repository_arn" {
  value = aws_ecr_repository.tf_ecr_repository.arn
}

output "ecr_repository_url" {
  value = aws_ecr_repository.tf_ecr_repository.repository_url
}
