# ====================
#
# IAM Custom Policy
#
# ====================

resource "aws_iam_policy" "tf_eventbridge_iam_policy" {
  name   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-policy"
  policy = data.aws_iam_policy_document.tf_eventbridge_iam_policy_document.json
}


data "aws_iam_policy_document" "tf_eventbridge_iam_policy_document" {
  version = "2012-10-17"

  statement {
    sid = "EventBridgeForCodePipelinePolicy"

    effect = "Allow"
    actions = [
      "codepipeline:StartPipelineExecution"
    ]
    resources = [
      "*"
    ]
  }
}
