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

variable "http_port" {
  type = number
}

variable "redirect_port" {
  type = number
}
