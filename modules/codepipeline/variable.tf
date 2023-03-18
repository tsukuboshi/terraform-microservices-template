# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "codepipeline_role_arn" {}

variable "artifact_bucket" {}

variable "codecommit_repository_name" {}

variable "codebuild_app_project_id" {}

variable "codebuild_firelens_project_id" {}

variable "has_blue_green_deployment" {}
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

variable "appspec_file" {
  default = null
}

variable "taskdef_file" {
  default = null
}
