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

variable "account_id" {
  type = string
}

variable "force_destroy" {
  type = bool
}

variable "versioning_enabled" {
  type = bool
}

variable "object_expiration_days" {
  type = number
}
