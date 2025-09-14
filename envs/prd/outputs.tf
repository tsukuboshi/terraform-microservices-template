# ====================
#
# Outputs
#
# ====================

output "access_domain" {
  description = "アクセスドメイン（ネイキッドドメインが設定されていない場合はALBのDNS名、設定されている場合はカスタムドメインを表示）"
  value       = var.naked_domain == null ? module.alb.alb_dns_name : "${var.sub_domain}.${var.naked_domain}"
}
