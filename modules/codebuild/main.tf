
# ====================
#
# CodeBuild
#
# ====================

resource "aws_codebuild_project" "tf_codebuild" {
  name         = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-project"
  service_role = var.codebuild_role_arn

  artifacts {
    type                = "CODEPIPELINE"
    encryption_disabled = false
    name                = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-artifacts"
    packaging           = "NONE"
  }

  vpc_config {
    vpc_id = var.codebuild_vpc_id

    subnets = var.codebuild_subnet_ids

    security_group_ids = var.codebuild_sg_ids
  }

  dynamic "source" {
    for_each = var.deployment_strategy != "codedeploy_blue_green_deployment" ? [1] : []
    content {
      type                = "CODEPIPELINE"
      git_clone_depth     = 0
      insecure_ssl        = false
      report_build_status = false
      buildspec           = file(var.buildspec_ecs_file)
    }
  }

  dynamic "source" {
    for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
    content {
      type                = "CODEPIPELINE"
      git_clone_depth     = 0
      insecure_ssl        = false
      report_build_status = false
      buildspec           = file(var.buildspec_codedeploy_file)
    }
  }
  logs_config {
    cloudwatch_logs {
      group_name = var.codebuild_log_group_name
    }
  }
  environment {
    compute_type    = var.codebuild_compute_type
    image           = var.codebuild_image
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
    }

    environment_variable {
      name  = "REPOSITORY_URI"
      value = var.ecr_repository_url
    }

    environment_variable {
      name  = "DOCKER_FILE"
      value = var.docker_file_path
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "TASK_FAMILY"
        value = var.ecs_task_definition_family
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "CPU"
        value = var.ecs_task_cpu
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "MEMORY"
        value = var.ecs_task_memory
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "TASK_ROLE_ARN"
        value = var.ecs_task_role_arn
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "EXECUTION_ROLE_ARN"
        value = var.ecs_exec_role_arn
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "FRONTEND_CONTAINER_NAME"
        value = var.app_container_name
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "FRONTEND_HOST_PORT"
        value = var.app_http_port
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "FRONTEND_CONTAINER_PORT"
        value = var.app_http_port
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "DB_SECRET_ARN"
        value = var.db_secret_arn
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "TASK_DEFINITION_FILE"
        value = var.taskdef_file_path
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "APPSPEC_FILE"
        value = var.appspec_file_path
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "CW_LOG_GROUP"
        value = var.error_log_group_name
      }
    }

    dynamic "environment_variable" {
      for_each = var.deployment_strategy == "codedeploy_blue_green_deployment" ? [1] : []
      content {
        name  = "CW_LOG_STREAM_PREFIX"
        value = var.error_log_stream_prefix
      }
    }
  }
}
