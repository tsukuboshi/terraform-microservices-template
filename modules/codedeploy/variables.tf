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

variable "codedeploy_role_arn" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "blue_listener_arn" {
  type = string
}

variable "green_listener_arn" {
  type = string
}

variable "blue_tg_name" {
  type = string
}

variable "green_tg_name" {
  type = string
}

variable "deployment_config_name" {
  type = string
}
