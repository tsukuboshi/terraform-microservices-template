# ====================
#
# Outputs
#
# ====================

output "bucket_name" {
  value = aws_s3_bucket.tf_bucket_artifact.bucket
}
