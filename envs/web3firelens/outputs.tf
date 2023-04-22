# ====================
#
# Outputs
#
# ====================

output "url_for_enduser" {
  value = "https://${var.sub_domain}.${var.naked_domain}"
}

output "url_for_sourcerepo" {
  value = "codecommit::${var.aws_region}://${module.codecommit.codecommit_repository_name}"
}

output "aurora_endpoint" {
  value = module.rdsaurora.aurora_endpoint
}

output "elasticache_endpoint" {
  value = module.elasticache.elasticache_endpoint
}
