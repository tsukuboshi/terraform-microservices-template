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

variable "backup_vault_name" {
  type = string
}

variable "backup_role_arn" {
  type = string
}

variable "schedule_expression" {
  type = string
}

variable "delete_after_days" {
  type = number
}

variable "backup_tag_key" {
  type = string
}
