# ====================
#
# Variables
#
# ====================

variable "route_table_id" {
  type = string
}

variable "gateway_id" {
  type    = string
  default = null
}

variable "nat_gateway_id" {
  type    = string
  default = null
}

variable "destination_cidr_block" {
  type = string
}
