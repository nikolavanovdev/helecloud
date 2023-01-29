resource "aws_efs_file_system" "efs" {
  creation_token = "heleworld"

  lifecycle_policy {
    transition_to_ia = "AFTER_14_DAYS"
  }
}

resource "aws_security_group" "sg_efs" {
  name        = "sg_efs"
  description = "efs security group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress_efs" {
    type                     = "ingress"
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    source_security_group_id = var.webservers_sg
    security_group_id        = aws_security_group.sg_efs.id
}

resource "aws_security_group_rule" "egress_efs" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.sg_efs.id
}

resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_id
  security_groups = [var.webservers_sg]
}