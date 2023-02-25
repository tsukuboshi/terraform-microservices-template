# ====================
#
# IAM Custom Policy
#
# ====================

# CodeBuild Policy Reference
# https://docs.aws.amazon.com/ja_jp/codebuild/latest/userguide/setting-up.html#setting-up-service-role

resource "aws_iam_policy" "tf_codebuild_iam_policy" {
  name   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-policy"
  policy = data.aws_iam_policy_document.tf_codebuild_iam_policy_document.json
}

data "aws_iam_policy_document" "tf_codebuild_iam_policy_document" {
  version = "2012-10-17"

  statement {
    sid = "CloudWatchLogsPolicy"

    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid = "S3Policy"

    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid = "CodeCommitPolicy"

    effect = "Allow"
    actions = [
      "codecommit:GitPull"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid = "CodeBuildPolicy"

    effect = "Allow"
    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid = "ECRPolicy"

    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    resources = [
      "*"
    ]
  }
}
