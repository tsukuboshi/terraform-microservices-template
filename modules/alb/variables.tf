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

variable "deletion_protection" {
  type = bool
}

variable "subnet_1a_id" {
  type = string
}

variable "subnet_1c_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "has_access_logs" {
  type    = bool
  default = false
}

variable "access_log_bucket_name" {
  type    = string
  default = null
}

variable "access_log_prefix" {
  type    = string
  default = null
}
