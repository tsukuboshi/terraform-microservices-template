# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "vpc_id" {}

variable "service_name" {}

variable "vpc_endpoint_type" {}

variable "subnet_ids" {
  default = null
}

variable "security_group_ids" {
  default = null
}

variable "private_dns_enabled" {
  default = null
}

variable "is_gateway_endpoint" {}

variable "route_table_1a_id" {
  default = null
}

variable "route_table_1c_id" {
  default = null
}
