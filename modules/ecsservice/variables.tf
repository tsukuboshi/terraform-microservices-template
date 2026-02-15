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

variable "subnet_ids" {
  type = list(string)
}

variable "associate_public_ip_address" {
  type = bool
}

variable "security_group_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "ecs_cluster_arn" {
  type = string
}

variable "ecs_desired_count" {
  type = number
}

variable "ecs_container_name" {
  type = string
}

variable "ecs_container_port" {
  type = number
}

variable "ecs_task_definition_arn" {
  type = string
}

variable "deployment_strategy" {
  type = string
}

variable "alternate_target_group_arn" {
  type = string
}

variable "production_listener_rule_arn" {
  type = string
}

variable "test_listener_rule_arn" {
  type = string
}

variable "ecs_infra_role_arn" {
  type = string
}
