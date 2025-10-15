# ====================
#
# CodePipeline
#
# ====================

resource "aws_codepipeline" "tf_codepipeline" {
  name           = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-pipeline"
  role_arn       = var.codepipeline_role_arn
  pipeline_type  = "V2"
  execution_mode = "QUEUED"

  trigger {
    provider_type = "CodeStarSourceConnection"
    git_configuration {
      source_action_name = "Source"
      pull_request {
        events = ["CLOSED"]
        branches {
          includes = ["${var.github_branch_name}"]
        }
      }
    }
  }

  artifact_store {
    location = var.artifact_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = 1
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = var.code_connection_arn
        FullRepositoryId = "${var.github_repository_owner}/${var.github_repository_name}"
        BranchName       = var.github_branch_name
      }
    }
  }

  stage {
    name = "BuildApp"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = 1
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifactApp"]

      configuration = {
        ProjectName = var.codebuild_app_project_id
      }
    }
  }
  dynamic "stage" {
    for_each = var.enable_approval_stage == true ? [1] : []
    content {
      name = "Approval"

      action {
        name     = "Approval"
        category = "Approval"
        owner    = "AWS"
        provider = "Manual"
        version  = 1
      }
    }
  }

  stage {
    name = "Deploy"

    dynamic "action" {
      for_each = var.has_rolling_update ? [1] : []
      content {
        name            = "Deploy"
        category        = "Deploy"
        owner           = "AWS"
        provider        = "ECS"
        version         = 1
        input_artifacts = ["BuildArtifactApp"]

        configuration = {
          ClusterName = var.ecs_cluster_id
          ServiceName = var.ecs_service_name
        }
      }
    }

    dynamic "action" {
      for_each = var.has_blue_green_deployment ? [1] : []
      content {
        name            = "Deploy"
        category        = "Deploy"
        owner           = "AWS"
        provider        = "CodeDeployToECS"
        version         = 1
        input_artifacts = ["BuildArtifactApp"]

        configuration = {
          ApplicationName                = var.codedeploy_app_name
          DeploymentGroupName            = var.codedeploy_group_name
          TaskDefinitionTemplateArtifact = "BuildArtifactApp"
          AppSpecTemplateArtifact        = "BuildArtifactApp"
          AppSpecTemplatePath            = var.appspec_file_path
          TaskDefinitionTemplatePath     = var.taskdef_file_path
          Image1ArtifactName             = "BuildArtifactApp"
          Image1ContainerName            = "IMAGE1_NAME"
        }
      }
    }
  }
}
