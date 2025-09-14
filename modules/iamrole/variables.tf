# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "iam_role_principal_identifiers" {}

variable "condition_test" {
  default = null
}

variable "condition_variable" {
  default = null
}

variable "condition_values" {
  default = null
}
