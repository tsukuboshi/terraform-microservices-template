# ====================
#
# CloudWatch Logs Group
#
# ====================

resource "aws_cloudwatch_log_group" "tf_cloudwatch_log_group" {
  name = var.log_group_name
}
