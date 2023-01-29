resource "aws_instance" "web_server" {
    count                  = var.number_of_servers
    ami                    = var.ami
    instance_type          = var.instance_type
    key_name               = var.keyname
    vpc_security_group_ids = [aws_security_group.securityGroup_webServers.id]
    user_data = data.template_file.user_data.rendered
}

data "template_file" "user_data" {
  template = file("./modules/web_server/user_data.tpl")
  vars = {
    efs_url = var.efs_url
    mount_target_ip  = var.mount_target_ip
  }
}

resource "aws_security_group" "securityGroup_webServers" {
  name        = "sg_web"
  description = "web servers security group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ing_webServers" {
    type                     = "ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    source_security_group_id = var.lb_security_group_id
    security_group_id        = aws_security_group.securityGroup_webServers.id
}

resource "aws_security_group_rule" "ssh_webServers" {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks              = ["0.0.0.0/0"]
    security_group_id        = aws_security_group.securityGroup_webServers.id
}

resource "aws_security_group_rule" "self_webServers" {
    type                     = "ingress"
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    self                     = true
    security_group_id        = aws_security_group.securityGroup_webServers.id
}

resource "aws_security_group_rule" "egress_webServers" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.securityGroup_webServers.id
}

resource "aws_alb_target_group_attachment" "lb_target_attach" {
    count            = var.number_of_servers
    target_group_arn = var.target_group_arn
    target_id        = aws_instance.web_server[count.index].id
    port             = 80
}