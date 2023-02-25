# ====================
#
# Kinesis Firehose
#
# ====================

output "firehose_arn" {
  value = aws_kinesis_firehose_delivery_stream.firelens_delivery_stream.arn
}
