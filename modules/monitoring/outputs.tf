output "sns_topic_arn" {
  description = "ARN of the infrastructure alert SNS topic"
  value       = aws_sns_topic.infrastructure_alerts.arn
}

output "unhealthy_targets_alarm_name" {
  description = "Name of the unhealthy ALB targets alarm"
  value       = aws_cloudwatch_metric_alarm.unhealthy_targets.alarm_name
}