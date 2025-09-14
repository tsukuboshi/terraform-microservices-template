# ====================
#
# Outputs
#
# ====================

output "codedeploy_app_name" {
  value = one(aws_codedeploy_app.tf_codedeploy_app[*].name)
}

output "codedeploy_app_arn" {
  value = one(aws_codedeploy_app.tf_codedeploy_app[*].arn)
}

output "codedeploy_group_name" {
  value = one(aws_codedeploy_deployment_group.tf_codedeploy_group[*].deployment_group_name)
}

output "codedeploy_group_arn" {
  value = one(aws_codedeploy_deployment_group.tf_codedeploy_group[*].arn)
}
