# ====================
#
# CodeDeploy
#
# ====================

resource "aws_codedeploy_app" "tf_codedeploy_app" {
  name             = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-app"
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "tf_codedeploy_group" {
  deployment_group_name  = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-group"
  app_name               = one(aws_codedeploy_app.tf_codedeploy_app[*].name)
  deployment_config_name = var.deployment_config_name
  service_role_arn       = var.codedeploy_role_arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "STOP_DEPLOYMENT"
      wait_time_in_minutes = 60
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.blue_listener_arn]
      }

      test_traffic_route {
        listener_arns = [var.green_listener_arn]
      }

      target_group {
        name = var.blue_tg_name
      }

      target_group {
        name = var.green_tg_name
      }
    }
  }
}
