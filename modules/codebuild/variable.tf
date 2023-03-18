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

variable "has_blue_green_deployment" {}

variable "buildspec_bgdeploy_file" {}

variable "container_build_path" {}

variable "buildspec_rollingupdate_file" {}

variable "codebuild_log_group_name" {}

variable "ecr_repository_url" {}

variable "ecs_task_definition_family" {}

variable "ecs_task_role_arn" {}

variable "ecs_exec_role_arn" {}

variable "frontend_container_name" {}

variable "firelens_container_name" {}

variable "error_log_group_name" {}

variable "error_log_stream_prefix" {}
