output "acm_alb_cert_arn" {
  value = aws_acm_certificate.main.arn
}

output "acm_alb_cert_valid_id" {
  value = true
}
