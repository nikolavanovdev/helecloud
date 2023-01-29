variable "subnet_id" {
    type    = string
    default = ""  
}

variable "vpc_id" {
    type        = string
    description = "The VPC ID."
    default     = ""
}

variable "webservers_sg" {
    type        = string
    description = "The webservers SG"
    default     = ""
}