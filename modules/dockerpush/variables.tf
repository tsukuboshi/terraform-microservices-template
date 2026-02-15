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

variable "image_name" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "container_name" {
  type = string
}

variable "dockerfile_path" {
  type = string
}

variable "ecr_login_id" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}
