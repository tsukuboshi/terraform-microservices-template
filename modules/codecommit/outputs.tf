# ====================
#
# Outputs
#
# ====================

output "codecommit_repository_name" {
  value = aws_codecommit_repository.tf_codecommit.repository_name
}

output "codecommit_repository_arn" {
  value = aws_codecommit_repository.tf_codecommit.arn
}

output "codecommit_repository_url" {
  value = aws_codecommit_repository.tf_codecommit.clone_url_http
}
