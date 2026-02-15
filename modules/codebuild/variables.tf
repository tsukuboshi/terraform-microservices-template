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

variable "codebuild_role_arn" {
  type = string
}

variable "deployment_strategy" {
  type = string
}

variable "codebuild_vpc_id" {
  type = string
}

variable "codebuild_subnet_ids" {
  type = list(string)
}

variable "codebuild_sg_ids" {
  type = list(string)
}

variable "buildspec_codedeploy_file" {
  type = string
}

variable "docker_file_path" {
  type = string
}

variable "buildspec_ecs_file" {
  type = string
}

variable "codebuild_log_group_name" {
  type = string
}

variable "codebuild_compute_type" {
  type = string
}

variable "codebuild_image" {
  type = string
}

variable "account_id" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "ecs_task_definition_family" {
  type = string
}

variable "ecs_task_cpu" {
  type = string
}

variable "ecs_task_memory" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "ecs_exec_role_arn" {
  type = string
}

variable "app_container_name" {
  type = string
}

variable "app_http_port" {
  type = number
}

variable "db_secret_arn" {
  type = string
}

variable "taskdef_file_path" {
  type    = string
  default = null
}

variable "appspec_file_path" {
  type    = string
  default = null
}

variable "error_log_group_name" {
  type = string
}

variable "error_log_stream_prefix" {
  type = string
}
