# ====================
#
# CodeCommit
#
# ====================

resource "aws_codecommit_repository" "tf_codecommit" {
  repository_name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-repo"
}
