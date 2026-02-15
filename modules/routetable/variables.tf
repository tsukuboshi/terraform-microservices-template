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

variable "has_subnet_1a" {
  type    = bool
  default = false
}

variable "has_subnet_1c" {
  type    = bool
  default = false
}

variable "subnet_1a_id" {
  type    = string
  default = null
}

variable "subnet_1c_id" {
  type    = string
  default = null
}
