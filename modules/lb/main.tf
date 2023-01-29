resource "aws_lb_target_group" "lb_target_group" { 
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb" "main" {
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets
}

resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.id  
  }
}

resource "aws_security_group" "main" {
  name        = "lb_sg"
  description = "lb security group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "allow_port_80_ingress" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.main.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}