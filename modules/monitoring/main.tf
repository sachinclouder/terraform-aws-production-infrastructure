resource "aws_sns_topic" "infrastructure_alerts" {
  name = "${var.project_name}-${var.environment}-infrastructure-alerts"

  tags = {
    Name        = "${var.project_name}-${var.environment}-infrastructure-alerts"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.infrastructure_alerts.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_cloudwatch_metric_alarm" "unhealthy_targets" {
  alarm_name        = "${var.project_name}-${var.environment}-unhealthy-alb-targets"
  alarm_description = "Triggers when one or more ALB targets are unhealthy"

  namespace   = "AWS/ApplicationELB"
  metric_name = "UnHealthyHostCount"

  statistic           = "Maximum"
  period              = 60
  evaluation_periods  = 2
  datapoints_to_alarm = 2

  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }

  alarm_actions = [
    aws_sns_topic.infrastructure_alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.infrastructure_alerts.arn
  ]

  treat_missing_data = "notBreaching"

  tags = {
    Name        = "${var.project_name}-${var.environment}-unhealthy-alb-targets"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}