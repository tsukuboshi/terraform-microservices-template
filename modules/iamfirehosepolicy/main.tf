# ====================
#
# IAM Custom Policy
#
# ====================

# Firehose to S3 Policy Reference
# https://docs.aws.amazon.com/ja_jp/firehose/latest/dev/controlling-access.html#using-iam-s3

resource "aws_iam_policy" "tf_firehose_iam_policy" {
  name   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-policy"
  policy = data.aws_iam_policy_document.tf_firehose_iam_policy_document.json
}


data "aws_iam_policy_document" "tf_firehose_iam_policy_document" {
  version = "2012-10-17"

  statement {
    sid = "FirehoseToS3Policy"

    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
      # "s3:PutObjectAcl"
    ]
    resources = [
      "${var.log_bucket_arn}",
      "${var.log_bucket_arn}/*"
    ]
  }

  statement {
    sid = "FirehoseToCloudWatchLogsPolicy"

    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "${var.error_log_group_arn}:log-stream:*"
    ]
  }
}
