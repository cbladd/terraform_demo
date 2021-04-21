variable "vpc_count" {
  type        = number
  default     = 2
}

variable "subnet_ids" {
  description = "A list of VPC private subnets"
  type        = list(string)
  default     = null
}
