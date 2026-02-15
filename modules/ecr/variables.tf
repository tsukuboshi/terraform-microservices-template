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

variable "force_destroy" {
  type = bool
}

variable "allow_latest_tag" {
  type = bool
}

variable "image_count_lifecycle_policy" {
  type = number
}
