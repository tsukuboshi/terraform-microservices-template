# ====================
#
# Variables
#
# ====================

variable "system" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "resourcetype" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "service_name" {
  type = string
}

variable "vpc_endpoint_type" {
  type = string
}

variable "subnet_ids" {
  type    = list(string)
  default = null
}

variable "security_group_ids" {
  type    = list(string)
  default = null
}

variable "private_dns_enabled" {
  type    = bool
  default = null
}

variable "is_gateway_endpoint" {
  type = bool
}

variable "route_table_1a_id" {
  type    = string
  default = null
}

variable "route_table_1c_id" {
  type    = string
  default = null
}
