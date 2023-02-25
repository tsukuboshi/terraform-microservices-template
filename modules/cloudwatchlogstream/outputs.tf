# ====================
#
# Outputs
#
# ====================

output "log_stream_name" {
  value = aws_cloudwatch_log_stream.tf_cloudwatch_log_stream.name
}
