# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "subnet_1a_id" {}

variable "subnet_1c_id" {}

variable "associate_public_ip_address" {}

variable "security_group_id" {}

variable "target_group_arn" {}

variable "ecs_cluster_arn" {}

variable "ecs_service_desired_count" {}

variable "ecs_container_name" {}

variable "ecs_container_port" {}

variable "ecs_task_definition_arn" {}

variable "deployment_strategy" {}

variable "alternate_target_group_arn" {}

variable "production_listener_rule_arn" {}

variable "test_listener_rule_arn" {}

variable "ecs_infra_role_arn" {}
