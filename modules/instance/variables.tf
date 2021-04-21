variable "public_subnet_ids" {
  description = "A list of VPC public subnets"
  type        = list(string)
}

variable "vpc_id" {
  type        = string
}

variable "security_group_id" {
  type        = list(string)
}

variable "public_key" {
  type        = string
}

