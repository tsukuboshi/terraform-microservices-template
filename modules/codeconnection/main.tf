# ====================
#
# CodeConnection
#
# ====================

data "aws_codestarconnections_connection" "github" {
  name = var.code_connection_name
}
