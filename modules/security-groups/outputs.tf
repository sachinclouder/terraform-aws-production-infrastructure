output "alb_security_group_id" {

  description = "ALB Security Group ID"

  value = aws_security_group.alb.id
}

output "management_security_group_id" {
  description = "Management security group ID"
  value       = aws_security_group.management.id
}

output "application_security_group_id" {
  description = "Application EC2 security group ID"
  value       = aws_security_group.application.id
}