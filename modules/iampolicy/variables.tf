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

variable "api_actions" {
  type = list(string)
}

variable "resource_arns" {
  type = list(string)
}

variable "condition_test" {
  type    = string
  default = null
}

variable "condition_variable" {
  type    = string
  default = null
}

variable "condition_values" {
  type    = list(string)
  default = null
}
