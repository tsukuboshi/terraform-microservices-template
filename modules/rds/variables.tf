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

variable "deletion_protection" {
  type = bool
}

variable "multi_az" {
  type = bool
}

variable "rds_port" {
  type = number
}

variable "rds_engine" {
  type = string
}

variable "rds_engine_major_version" {
  type = string
}

variable "rds_engine_minor_version" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_name" {
  type    = string
  default = null
}

variable "db_root_name" {
  type = string
}

variable "db_storage_type" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "db_max_allocated_storage" {
  type = number
}

variable "db_storage_encrypted" {
  type = bool
}

variable "db_enabled_cloudwatch_logs_exports" {
  type    = list(string)
  default = null
}

variable "db_backup_retention_period" {
  type = number
}

variable "db_backup_window" {
  type = string
}

variable "db_maintenance_window" {
  type = string
}

variable "db_performance_insights_enabled" {
  type = bool
}

variable "db_performance_insights_retention_period" {
  type = number
}

variable "db_monitoring_role_arn" {
  type = string
}

variable "db_monitoring_interval" {
  type = number
}

variable "db_auto_minor_version_upgrade" {
  type = bool
}

variable "isolated_1a_subnet_id" {
  type = string
}

variable "isolated_1c_subnet_id" {
  type = string
}

variable "backup_tag_key" {
  type = string
}

variable "backup_tag_value" {
  type = string
}

variable "db_secret_rotate" {
  type = bool
}
