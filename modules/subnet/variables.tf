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

variable "subnet_cidr_block" {
  type = string
}

variable "subnet_map_public_ip_on_launch" {
  type    = bool
  default = false
}

variable "subnet_availability_zone" {
  type = string
}
