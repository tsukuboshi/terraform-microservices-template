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

variable "waf_ips" {
  type = list(string)
}

variable "waf_default_action_block_mode" {
  type = bool
}

variable "waf_ip_rule_allow_mode" {
  type = bool
}

variable "waf_managed_rule_block_mode" {
  type = bool
}

variable "waf_cloudwatch_metrics_enabled" {
  type = bool
}

variable "waf_sampled_requests_enabled" {
  type = bool
}

variable "alb_arn" {
  type = string
}

variable "has_web_acl_log" {
  type    = bool
  default = false
}

variable "waf_log_bucket_arn" {
  type    = string
  default = null
}
