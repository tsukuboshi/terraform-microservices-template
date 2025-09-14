# ====================
#
# Outputs
#
# ====================

output "ecs_service_name" {
  value = aws_ecs_service.tf_ecs_service.name
}
