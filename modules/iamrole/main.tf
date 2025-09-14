
# ====================
#
# IAM Role
#
# ====================

data "aws_iam_policy_document" "tf_policy_document" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = [var.iam_role_principal_identifiers]
    }
    actions = ["sts:AssumeRole"]

    dynamic "condition" {
      for_each = var.condition_test != null && var.condition_variable != null && var.condition_values != null ? [1] : []
      content {
        test     = var.condition_test
        variable = var.condition_variable
        values   = var.condition_values
      }
    }
  }
}

resource "aws_iam_role" "tf_iam_role" {
  name               = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-role"
  assume_role_policy = data.aws_iam_policy_document.tf_policy_document.json

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-role"
  }
}
