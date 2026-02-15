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

variable "route53_zone_name" {
  type = string
}

variable "acm_domain_name" {
  type = string
}

variable "acm_sans" {
  type = list(string)
}
