# ====================
#
# Outputs
#
# ====================

output "internet_route_ids" {
  value = { for route_name, route in aws_route.tf_route_ngw : route_name => route.id }
}
