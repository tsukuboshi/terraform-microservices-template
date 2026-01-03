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

variable "alb_target_type" {
  type = string
}

variable "alb_lsnr_https_arn" {
  type = string
}

variable "alb_lsnr_rule_priority" {
  type = number
}

variable "has_host_header" {
  type    = bool
  default = false
}

variable "has_path_pattern" {
  type    = bool
  default = false
}

variable "alb_lsnr_rule_host_header_values" {
  type    = list(string)
  default = null
}

variable "alb_lsnr_rule_path_pattern_values" {
  type    = list(string)
  default = null
}
