# ====================
#
# CodePipeline
#
# ====================

resource "aws_codepipeline" "tf_codepipeline" {
  name     = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-pipeline"
  role_arn = var.codepipeline_role_arn

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
      provider         = "CodeCommit"
      version          = 1
      output_artifacts = ["SourceArtifact"]
      configuration = {
        RepositoryName       = var.codecommit_repository_name
        BranchName           = "main"
        OutputArtifactFormat = "CODE_ZIP"
        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "BuildFrontend"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = 1
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifactFrontend"]

      configuration = {
        ProjectName = var.codebuild_frontend_project_id
      }
    }
  }

  stage {
    name = "BuildFirelens"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = 1
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifactFirelens"]

      configuration = {
        ProjectName = var.codebuild_firelens_project_id
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = var.has_blue_green_deployment ? "CodeDeployToECS" : "ECS"
      version         = 1
      input_artifacts = ["BuildArtifactFrontend", "BuildArtifactFirelens"]

      configuration = var.has_blue_green_deployment ? {
        ApplicationName                = var.codedeploy_app_name
        DeploymentGroupName            = var.codedeploy_group_name
        TaskDefinitionTemplateArtifact = "BuildArtifactFrontend"
        AppSpecTemplateArtifact        = "BuildArtifactFirelens"
        # AppSpecTemplatePath            = file(var.appspec_file)
        # TaskDefinitionTemplatePath     = file(var.taskdef_file)
        Image1ArtifactName  = "BuildArtifact"
        Image1ContainerName = "IMAGE1_NAME"
        Image2ContainerName = "IMAGE2_NAME"
        } : {
        ClusterName = var.ecs_cluster_id
        ServiceName = var.ecs_service_name
      }
    }
  }
}
