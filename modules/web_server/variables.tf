variable "number_of_servers" {
    type    = string
    default = "2"
}

variable "ami" {
    type    = string
    default = ""
}

variable "instance_type" {
    type    = string
    default = "t2.micro"
}

variable "vpc_id" {
    type        = string
    description = "The VPC ID."
    default     = ""
}

variable "lb_security_group_id" {
    type    = string
    default = ""
}

variable "target_group_arn" {
    type    = string
    default = ""
}

variable "keyname" {
    type    = string
    default = ""  
}

variable "efs_url" {
    type    = string
    default = "" 
}

variable "mount_target_ip" {
    type    = string
    default = ""
}