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

variable "iam_role_principal_identifiers" {
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
