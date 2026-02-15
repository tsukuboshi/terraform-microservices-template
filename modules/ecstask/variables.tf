# ====================
#
# Variables
#
# ====================

variable "aws_region" {
  type = string
}

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

variable "cpu_for_ecs_task" {
  type = string
}

variable "memory_for_ecs_task" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "ecs_task_exec_role_arn" {
  type = string
}

variable "ecs_task_cpu" {
  type = string
}

variable "ecs_task_memory" {
  type = string
}

variable "container_definitions_file" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "app_image_tag" {
  type = string
}

variable "app_container_name" {
  type = string
}

variable "http_port" {
  type = number
}

variable "db_secret_arn" {
  type = string
}

variable "error_log_group_name" {
  type = string
}

variable "error_log_stream_prefix" {
  type = string
}

variable "ecr_app_push_id" {
  type = string
}

variable "outbound_route_ids" {
  type    = list(string)
  default = null
}
