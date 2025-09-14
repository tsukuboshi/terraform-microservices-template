# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "action_list" {}

variable "resource_arn_list" {}

variable "condition_test" {
  default = null
}

variable "condition_variable" {
  default = null
}

variable "condition_values" {
  default = null
}
