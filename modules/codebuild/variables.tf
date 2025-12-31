# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "codebuild_role_arn" {}

variable "deployment_strategy" {}

variable "codebuild_vpc_id" {}

variable "codebuild_subnet_ids" {}

variable "codebuild_sg_ids" {}

variable "buildspec_codedeploy_file" {}

variable "docker_file_path" {}

variable "buildspec_ecs_file" {}

variable "codebuild_log_group_name" {}

variable "codebuild_compute_type" {}

variable "codebuild_image" {}

variable "account_id" {}

variable "ecr_repository_url" {}

variable "ecs_task_definition_family" {}

variable "ecs_task_cpu" {}

variable "ecs_task_memory" {}

variable "ecs_task_role_arn" {}

variable "ecs_exec_role_arn" {}

variable "app_container_name" {}

variable "app_http_port" {}

variable "db_secret_arn" {}

variable "taskdef_file_path" {
  default = null
}

variable "appspec_file_path" {
  default = null
}

variable "error_log_group_name" {}

variable "error_log_stream_prefix" {}
