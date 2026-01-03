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

variable "code_connection_arn" {
  type = string
}

variable "github_repository_owner" {
  type = string
}

variable "github_repository_name" {
  type = string
}

variable "github_branch_name" {
  type = string
}

variable "codepipeline_role_arn" {
  type = string
}

variable "artifact_bucket" {
  type = string
}

variable "codebuild_app_project_id" {
  type = string
}

variable "deployment_strategy" {
  type = string
}

variable "enable_approval_stage" {
  type = bool
}

variable "ecs_cluster_id" {
  type    = string
  default = null
}

variable "ecs_service_name" {
  type    = string
  default = null
}

variable "codedeploy_app_name" {
  type    = string
  default = null
}

variable "codedeploy_group_name" {
  type    = string
  default = null
}

variable "appspec_file_path" {
  type    = string
  default = null
}

variable "taskdef_file_path" {
  type    = string
  default = null
}
