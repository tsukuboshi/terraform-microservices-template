# ====================
#
# Variables
#
# ====================

variable "bucket_name" {
  type = string
}

variable "bucket_id" {
  type = string
}

variable "account_id" {
  type = string
}

variable "effect" {
  type = string
}

variable "principals_type" {
  type = string
}

variable "principal_identifiers" {
  type = list(string)
}

variable "api_actions" {
  type = list(string)
}

variable "resource_arns" {
  type = list(string)
}
