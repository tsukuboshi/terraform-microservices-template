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

variable "vpc_cidr_block" {
  type = string
}

variable "has_flow_log" {
  type    = bool
  default = false
}

variable "flow_log_bucket_arn" {
  type    = string
  default = null
}

variable "flow_log_file_format" {
  type    = string
  default = null
}

variable "flow_log_hive_compatible_partitions" {
  type    = bool
  default = null
}

variable "flow_log_per_hour_partition" {
  type    = bool
  default = null
}
