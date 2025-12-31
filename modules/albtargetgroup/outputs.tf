# ====================
#
# Outputs
#
# ====================

output "alb_tg_arn" {
  value = aws_lb_target_group.tf_alb_tg.arn
}

output "alb_tg_name" {
  value = aws_lb_target_group.tf_alb_tg.name
}

output "alb_lsnr_rule_arn" {
  value = aws_lb_listener_rule.tf_alb_lsnr_rule.arn
}
