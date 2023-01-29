variable "vpc_id" {
  type        = string
  description = "The VPC ID."
  default     = ""
}

variable "web_security_group_id" {
    type    = string
    default = ""
}