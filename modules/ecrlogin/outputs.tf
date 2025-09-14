# ====================
#
# Outputs
#
# ====================

output "ecr_login_id" {
  value = terraform_data.ecr_login.id
}
