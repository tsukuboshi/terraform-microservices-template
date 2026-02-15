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

variable "security_group_id" {
  type = string
}

variable "sg_rule_type" {
  type = string
}

variable "sg_rule_protocol" {
  type = string
}

variable "sg_rule_from_port" {
  type = number
}

variable "sg_rule_to_port" {
  type = number
}

variable "sg_rule_cidr_blocks" {
  type    = list(string)
  default = null
}

variable "sg_rule_source_security_group_id" {
  type    = string
  default = null
}
