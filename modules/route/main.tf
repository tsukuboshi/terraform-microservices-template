# ====================
#
# Route
#
# ====================

resource "aws_route" "tf_route" {
  route_table_id         = var.route_table_id
  gateway_id             = var.gateway_id
  nat_gateway_id         = var.nat_gateway_id
  destination_cidr_block = var.destination_cidr_block
}
