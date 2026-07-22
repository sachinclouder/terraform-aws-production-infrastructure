output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.this.arn
}

output "domain_validation_options" {
  description = "DNS records required for ACM validation"

  value = [
    for option in aws_acm_certificate.this.domain_validation_options : {
      domain_name           = option.domain_name
      resource_record_name  = option.resource_record_name
      resource_record_type  = option.resource_record_type
      resource_record_value = option.resource_record_value
    }
  ]
}