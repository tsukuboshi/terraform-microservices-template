# ====================
#
# ECS Task Definition
#
# ====================

resource "aws_ecs_task_definition" "tf_ecs_task" {
  family                   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-task-definition"
  cpu                      = var.cpu_for_ecs_task
  memory                   = var.memory_for_ecs_task
  task_role_arn            = var.ecs_task_role_arn
  execution_role_arn       = var.ecs_exec_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions = templatefile(var.container_definitions_file,
    {
      FRONTEND_CONTAINER_NAME = "${var.frontend_container_name}",
      FRONTEND_IMAGE_URL      = "${var.ecr_repository_url}:${var.frontend_image_name}",
      FIRELENS_CONTAINER_NAME = "${var.firelens_container_name}",
      FIRELENS_IMAGE_URL      = "${var.ecr_repository_url}:${var.firelens_image_name}",
      CW_LOG_GROUP            = "${var.error_log_group_name}",
      CW_REGION               = "${var.aws_region}",
      CW_LOG_STREAM_PREFIX    = "${var.error_log_stream_prefix}"
    }
  )

  depends_on = [var.ecr_frontend_push_id, var.ecr_firelens_push_id]
}
