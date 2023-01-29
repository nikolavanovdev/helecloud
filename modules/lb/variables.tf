variable "vpc_id" {
  type        = string
  description = "The VPC ID."
  default     = ""
}

variable "subnets" {
  type        = list
  description = "A list of public subnet IDs to attach to the LB."
  default     = []
}