resource "aws_cloudwatch_metric_alarm" "lb_high_request_count" {
  alarm_name        = "request-count"
  namespace         = "AWS/ApplicationELB"
  metric_name       = "RequestCount"

  dimensions = {
    LoadBalancer = var.load_balancer_arn_suffix
  }
  
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  period                    = 60
  datapoints_to_alarm       = 1
  statistic                 = "Sum"
  threshold                 = 3
  unit                      = "Count"
  alarm_actions             = [aws_sns_topic.user_updates.arn]
  ok_actions                = [aws_sns_topic.user_updates.arn]
  insufficient_data_actions = [aws_sns_topic.user_updates.arn]
  treat_missing_data        = "missing"
}

resource "aws_cloudwatch_metric_alarm" "target_group_alarm" {
  alarm_name          = "target-group-healthy-targets"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  dimensions = {
    TargetGroup  = var.target_group_arn_suffix
    LoadBalancer = var.load_balancer_arn_suffix
  }
}

resource "aws_sns_topic" "user_updates" {
  name                        = "snstopic.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
}