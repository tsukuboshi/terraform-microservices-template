
# ====================
#
# Kinesis Firehose
#
# ====================

resource "aws_kinesis_firehose_delivery_stream" "firelens_delivery_stream" {
  name        = var.firehose_delivery_stream_name
  destination = "s3"

  s3_configuration {
    role_arn   = var.firehose_iam_role_arn
    bucket_arn = var.log_bucket_arn

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = var.firehose_error_log_group_name
      log_stream_name = var.firehose_error_log_stream_name
    }
  }
}
