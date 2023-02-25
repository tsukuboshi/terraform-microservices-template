# ====================
#
# S3 Artifact Bucket
#
# ====================

data "aws_caller_identity" "tf_caller_identity" {}

resource "aws_s3_bucket" "tf_bucket_artifact" {
  bucket        = "${var.system}-${var.project}-${var.environment}-artifact-${data.aws_caller_identity.tf_caller_identity.account_id}"
  force_destroy = var.internal
}

resource "aws_s3_bucket_public_access_block" "tf_public_access_block_artifact" {
  bucket                  = aws_s3_bucket.tf_bucket_artifact.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "tf_bucket_versioning_artifact" {
  bucket = aws_s3_bucket.tf_bucket_artifact.id
  versioning_configuration {
    status = var.internal == true ? "Disabled" : "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "tf_bucket_ownership_controls_artifact" {
  bucket = aws_s3_bucket.tf_bucket_artifact.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_bucket_encrypt_config_artifact" {
  bucket = aws_s3_bucket.tf_bucket_artifact.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
