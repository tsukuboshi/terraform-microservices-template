# ====================
#
# S3 Bucket Policy
#
# ====================


resource "aws_s3_bucket_policy" "tf_bucket_policy" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.tf_iam_policy_document.json
}


data "aws_iam_policy_document" "tf_iam_policy_document" {
  statement {
    effect = var.effect
    principals {
      type        = var.principals_type
      identifiers = var.principals_identifiers_list
    }
    actions   = var.action_list
    resources = var.resource_arn_list
  }
}
