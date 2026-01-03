# ====================
#
# Outputs
#
# ====================

output "internet_route_ids" {
  value = { for k, v in aws_route.tf_route_ngw : k => v.id }
}
