# ====================
#
# ECS Service
#
# ====================

resource "aws_ecs_service" "tf_ecs_service" {
  name                              = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-service"
  cluster                           = var.ecs_cluster_arn
  task_definition                   = var.ecs_task_definition_arn
  desired_count                     = var.ecs_service_desired_count
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  enable_execute_command            = true
  health_check_grace_period_seconds = 60
  availability_zone_rebalancing     = "ENABLED"

  deployment_controller {
    type = var.deployment_strategy == "codedeploy_blue_green_deployment" ? "CODE_DEPLOY" : "ECS"
  }

  dynamic "deployment_configuration" {
    for_each = var.deployment_strategy == "ecs_rolling_update" ? [1] : []
    content {
      strategy = "ROLLING"
    }
  }

  dynamic "deployment_configuration" {
    for_each = var.deployment_strategy == "ecs_blue_green_deployment" ? [1] : []
    content {
      strategy             = "BLUE_GREEN"
      bake_time_in_minutes = 5
    }
  }

  network_configuration {
    assign_public_ip = var.associate_public_ip_address
    security_groups  = [var.security_group_id]
    subnets = [
      var.subnet_1a_id,
      var.subnet_1c_id
    ]
  }

  dynamic "load_balancer" {
    for_each = var.deployment_strategy != "ecs_blue_green_deployment" ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name   = var.ecs_container_name
      container_port   = var.ecs_container_port
    }
  }

  dynamic "load_balancer" {
    for_each = var.deployment_strategy == "ecs_blue_green_deployment" ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name   = var.ecs_container_name
      container_port   = var.ecs_container_port

      advanced_configuration {
        alternate_target_group_arn = var.alternate_target_group_arn
        production_listener_rule   = var.production_listener_rule_arn
        role_arn                   = var.ecs_infra_role_arn
        test_listener_rule         = var.test_listener_rule_arn
      }
    }
  }

  # 自動デプロイ及び自動スケールでECSが更新された後に、Terraformでリソースの設定が上書きされる事を回避するための設定
  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition,
      load_balancer
    ]
  }
}
