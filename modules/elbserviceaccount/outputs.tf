# ====================
#
# Outputs
#
# ====================

output "elb_service_account_id" {
  value = data.aws_elb_service_account.tf_log_service_account.id
}
