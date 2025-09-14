# ====================
#
# VPC EndPoint
#
# ====================

resource "aws_vpc_endpoint" "tf_endpoint" {
  vpc_id              = var.vpc_id
  service_name        = var.service_name
  vpc_endpoint_type   = var.vpc_endpoint_type
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = var.private_dns_enabled

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "tf_endpoint_rt_1a" {
  count           = var.is_gateway_endpoint ? 1 : 0
  vpc_endpoint_id = aws_vpc_endpoint.tf_endpoint.id
  route_table_id  = var.route_table_1a_id
}

resource "aws_vpc_endpoint_route_table_association" "tf_endpoint_rt_1c" {
  count           = var.is_gateway_endpoint ? 1 : 0
  vpc_endpoint_id = aws_vpc_endpoint.tf_endpoint.id
  route_table_id  = var.route_table_1c_id
}
