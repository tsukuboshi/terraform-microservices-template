# ====================
#
# Outputs
#
# ====================

output "ecs_task_arn" {
  value = aws_ecs_task_definition.tf_ecs_task.arn
}

output "ecs_task_family" {
  value = aws_ecs_task_definition.tf_ecs_task.family
}
