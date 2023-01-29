resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = "helecloud"
  password               = "softwareone"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.securityGroup_rds.id]
}

resource "aws_security_group" "securityGroup_rds" {
  name        = "sg_rds"
  description = "rds security group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress_rds" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.web_security_group_id
  security_group_id        = aws_security_group.securityGroup_rds.id
}

resource "aws_security_group_rule" "egress_rds" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.securityGroup_rds.id
}