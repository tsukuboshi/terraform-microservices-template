# ====================
#
# Variables
#
# ====================


variable "aws_region" {
  default = "ap-northeast-1"
  type    = string
}
variable "availability_zone_1a" {
  default = "ap-northeast-1a"
  type    = string
}

variable "availability_zone_1c" {
  default = "ap-northeast-1c"
  type    = string
}

variable "az_short_name_1a" {
  default = "1a"
  type    = string
}

variable "az_short_name_1c" {
  default = "1c"
  type    = string
}

variable "system" {
  default = "ex"
  type    = string
}

variable "project" {
  default = "microservices"
  type    = string
}

variable "environment" {
  default = "test"
  type    = string
}

variable "internal" {
  default = true
  type    = bool
}

variable "naked_domain" {
  # default = "example.com"
  type = string
}

variable "sub_domain" {
  default = "cm"
  type    = string
}

variable "service_rsrc_type_alb" {
  default = "alb"
  type    = string
}

variable "service_rsrc_type_ecs" {
  default = "ecs"
  type    = string
}

variable "service_rsrc_type_firehose" {
  default = "firehose"
  type    = string
}
variable "service_rsrc_type_backup" {
  default = "backup"
  type    = string
}

variable "service_rsrc_type_commit" {
  default = "commit"
  type    = string
}

variable "service_rsrc_type_build" {
  default = "build"
  type    = string
}

variable "service_rsrc_type_deploy" {
  default = "deploy"
  type    = string
}

variable "service_rsrc_type_pipeline" {
  default = "pipeline"
  type    = string
}

variable "service_rsrc_type_eventbridge" {
  default = "eventbridge"
  type    = string
}

# VPC #
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  type    = string
}

variable "flow_log_file_format_text" {
  default = "plain-text"
  type    = string
}

variable "flow_log_file_parquet" {
  default = "parquet"
  type    = string
}

# Subnet #
variable "public_subnet_1a_cidr_block" {
  default = "10.0.0.0/24"
  type    = string
}

variable "public_subnet_1c_cidr_block" {
  default = "10.0.1.0/24"
  type    = string
}

variable "private_subnet_1a_cidr_block" {
  default = "10.0.2.0/24"
  type    = string
}

variable "private_subnet_1c_cidr_block" {
  default = "10.0.3.0/24"
  type    = string
}

variable "isolated_subnet_1a_cidr_block" {
  default = "10.0.4.0/24"
  type    = string
}

variable "isolated_subnet_1c_cidr_block" {
  default = "10.0.5.0/24"
  type    = string
}

variable "network_rsrc_type_public" {
  default = "public"
  type    = string
}

variable "network_rsrc_type_private" {
  default = "private"
  type    = string
}

variable "network_rsrc_type_isolated" {
  default = "isolated"
  type    = string
}

variable "has_public_ip_to_computer" {
  default = true
  type    = bool
}


# S3 #
variable "s3_rsrc_type_vpc" {
  default = "vpc"
  type    = string
}

variable "s3_rsrc_type_alb" {
  default = "alb"
  type    = string
}

variable "s3_rsrc_type_waf" {
  default = "waf"
  type    = string
}

variable "enabled_s3_acl" {
  default = "ObjectWriter"
  type    = string
}

variable "disabled_s3_acl" {
  default = "BucketOwnerEnforced"
  type    = string
}

variable "object_expiration_days" {
  default = 366
  type    = number
}

# ALB #

variable "access_log_prefix" {
  default = "alb"
  type    = string
}

variable "alb_target_type_ecs" {
  default = "ip"
  type    = string
}

# WAF #
variable "waf_rsrc_type_alb" {
  default = "alb"
  type    = string
}

# ECR #
variable "app_image_name" {
  default = "httpd"
  type    = string
}

variable "app_container_name" {
  default = "web_server"
  type    = string
}

variable "firelens_image_name" {
  default = "fluentbit"
  type    = string
}

variable "firelens_container_name" {
  default = "log_router"
  type    = string
}

# ECS #
variable "ecs_service_desired_count" {
  default = 2
  type    = number
}

variable "has_blue_green_deployment" {
  default = true
  type    = bool
}
