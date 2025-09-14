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

variable "has_rolling_update" {}

variable "has_blue_green_deployment" {}

variable "codebuild_vpc_id" {}

variable "codebuild_subnet_ids" {}

variable "codebuild_sg_ids" {}

variable "buildspec_bgdeploy_file" {}

variable "docker_file_path" {}

variable "buildspec_rollingupdate_file" {}

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
