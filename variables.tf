variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID."
  default     = "vpc-01459ce66fcdf957c"
}

variable "public_subnets_ids" {
  type        = list
  description = "A list of public subnet IDs"
  default     = ["subnet-0ec79a925a220315b","subnet-006bb5c71ecc3df3c","subnet-0213e9a5563686eb8","subnet-085b0ebd5337caff6"]
}

variable "ec2_intance_ami" {
  type        = string
  description = "EC2 instance AMI to be used"
  default     = "ami-06e85d4c3149db26a"
}

variable "keyname" {
  type        = string
  description = "Generate key pair for troubleshooting purposes"
  default     = "heleworld-keypair"
}