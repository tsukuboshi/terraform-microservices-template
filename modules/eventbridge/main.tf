# ====================
#
# EventBridge
#
# ====================

resource "aws_cloudwatch_event_rule" "tf_codepipeline_event_rule" {
  name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-cpp-rule"

  event_pattern = templatefile(var.event_pattern_file,
    {
      CODECOMMIT_ARN : "${var.codecommit_repository_arn}"
    }
  )
}

resource "aws_cloudwatch_event_target" "tf_codepipeline_event_target" {
  rule     = aws_cloudwatch_event_rule.tf_codepipeline_event_rule.name
  arn      = var.codepipeline_arn
  role_arn = var.eventbridge_role_arn
}
