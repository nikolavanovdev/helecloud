output "lb_security_group_id" {
  value = aws_security_group.main.id
}

output "target_group_arn" {
  value = aws_lb_target_group.lb_target_group.arn
}

output "target_group_arn_suffix" {
  value = aws_lb_target_group.lb_target_group.arn_suffix
}

output "load_balancer_arn_suffix" {
  value = aws_lb.main.arn_suffix
}