
# ====================
#
# IAM Custom Policy
#
# ====================

# ECS Exec Policy Reference
# https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/userguide/ecs-exec.html#ecs-exec-enabling-and-using

# CloudWatch Logs for Fluentbit Policy Reference
# https://github.com/aws/amazon-cloudwatch-logs-for-fluent-bit

# ECS Firelens Policy Reference
# https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/userguide/using_firelens.html#firelens-iam

resource "aws_iam_policy" "tf_ecs_iam_policy" {
  name   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-policy"
  policy = data.aws_iam_policy_document.tf_ecs_iam_policy_document.json
}


data "aws_iam_policy_document" "tf_ecs_iam_policy_document" {
  version = "2012-10-17"

  statement {
    sid = "ECSExecPolicy"

    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "CloudWatchLogsForFluentbitPolicy"

    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "FirelensPolicy"

    effect = "Allow"
    actions = [
      "firehose:PutRecordBatch",
    ]
    resources = [
      "*"
    ]
  }
}
