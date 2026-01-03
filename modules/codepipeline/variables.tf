# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "code_connection_arn" {}

variable "github_repository_owner" {}

variable "github_repository_name" {}

variable "github_branch_name" {}

variable "codepipeline_role_arn" {}

variable "artifact_bucket" {}

variable "codebuild_app_project_id" {}

variable "deployment_strategy" {}

variable "enable_approval_stage" {}

variable "ecs_cluster_id" {
  default = null
}

variable "ecs_service_name" {
  default = null
}

variable "codedeploy_app_name" {
  default = null
}

variable "codedeploy_group_name" {
  default = null
}

variable "appspec_file_path" {
  default = null
}

variable "taskdef_file_path" {
  default = null
}
