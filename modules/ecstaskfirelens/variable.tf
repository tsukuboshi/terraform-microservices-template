# ====================
#
# Variables
#
# ====================

variable "aws_region" {}

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "cpu_for_ecs_task" {}

variable "memory_for_ecs_task" {}

variable "ecs_task_role_arn" {}

variable "ecs_exec_role_arn" {}

variable "container_definitions_file" {}

variable "ecr_repository_url" {}

variable "app_image_name" {}

variable "app_container_name" {}

variable "firelens_image_name" {}

variable "firelens_container_name" {}

variable "error_log_group_name" {}

variable "error_log_stream_prefix" {}

variable "ecr_app_push_id" {}

variable "ecr_firelens_push_id" {}

variable "outbound_route_ids" {
  default = null
}
