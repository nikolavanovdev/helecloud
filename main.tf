terraform {
  required_version = ">= 1.0.4"
}

provider "aws" {
  region = var.aws_region
}


module "elb" {
    source             = "./modules/lb"
    vpc_id             = var.vpc_id 
    subnets            = var.public_subnets_ids
}

module "efs" {
    source        = "./modules/efs"
    vpc_id        = var.vpc_id
    subnet_id     = var.public_subnets_ids[0]
    webservers_sg = module.web_server.webserver_sg
}

module "web_server" {
    source               = "./modules/web_server"
    vpc_id               = var.vpc_id
    ami                  = var.ec2_intance_ami
    keyname              = var.keyname
    lb_security_group_id = module.elb.lb_security_group_id
    target_group_arn     = module.elb.target_group_arn
    efs_url              = module.efs.efs_url
    mount_target_ip      = module.efs.mount_target_ip
    depends_on           = [module.elb]
}

module "rds" {
    source                = "./modules/rds"
    vpc_id                = var.vpc_id
    web_security_group_id = module.web_server.webserver_sg
}

module "cloudwatch" {
    source                        = "./modules/cloudwatch"
    load_balancer_arn_suffix      = module.elb.load_balancer_arn_suffix   
    target_group_arn_suffix       = module.elb.target_group_arn_suffix
}