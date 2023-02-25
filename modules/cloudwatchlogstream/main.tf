# ====================
#
# CloudWatch Log Stream
#
# ====================

resource "aws_cloudwatch_log_stream" "tf_cloudwatch_log_stream" {
  name           = var.log_stream_name
  log_group_name = var.log_group_name
}
