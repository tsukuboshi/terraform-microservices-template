# ====================
#
# Outputs
#
# ====================

output "code_connection_arn" {
  value = data.aws_codestarconnections_connection.github.arn
}
