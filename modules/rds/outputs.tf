# ====================
#
# Outputs
#
# ====================

output "rds_db_host" {
  value = aws_db_instance.tf_db_instance.address
}

output "rds_db_name" {
  value = aws_db_instance.tf_db_instance.db_name
}

output "rds_db_secret_arn" {
  value = aws_db_instance.tf_db_instance.master_user_secret[0].secret_arn
}
