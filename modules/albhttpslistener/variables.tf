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

variable "load_balancer_arn" {
  type = string
}

variable "https_port" {
  type = number
}

variable "acm_alb_cert_arn" {
  type = string
}

variable "acm_alb_cert_valid_id" {
  type = string
}
