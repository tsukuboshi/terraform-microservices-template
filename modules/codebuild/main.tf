
# ====================
#
# CodeBuild
#
# ====================

data "aws_caller_identity" "tf_caller_identity" {}

resource "aws_codebuild_project" "tf_codebuild" {
  name         = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-project"
  service_role = var.codebuild_role_arn

  artifacts {
    type                = "CODEPIPELINE"
    encryption_disabled = false
    name                = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-artifacts"
    packaging           = "NONE"
  }

  source {
    type                = "CODEPIPELINE"
    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    buildspec           = var.has_blue_green_deployment ? file(var.buildspec_bgdeploy_file) : file(var.buildspec_rollingupdate_file)
  }
  logs_config {
    cloudwatch_logs {
      group_name = var.codebuild_log_group_name
    }
  }
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.tf_caller_identity.account_id
    }

    environment_variable {
      name  = "REPOSITORY_URI"
      value = var.ecr_repository_url
    }

    environment_variable {
      name  = "TASK_FAMILY"
      value = var.ecs_task_definition_family
    }

    environment_variable {
      name  = "TASK_ROLE_ARN"
      value = var.ecs_task_role_arn
    }

    environment_variable {
      name  = "EXECUTION_ROLE_ARN"
      value = var.ecs_exec_role_arn
    }


    environment_variable {
      name  = "FRONTEND_CONTAINER_NAME"
      value = var.app_container_name
    }

    environment_variable {
      name  = "FIRELENS_CONTAINER_NAME"
      value = var.firelens_container_name
    }

    environment_variable {
      name  = "CW_LOG_GROUP"
      value = var.error_log_group_name
    }

    environment_variable {
      name  = "CW_LOG_STREAM_PREFIX"
      value = var.error_log_stream_prefix
    }
  }
}
