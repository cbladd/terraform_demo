variable "private_subnet_ids" {
  description = "A list of VPC private subnets"
  type        = list(string)
}

variable "suffix" {
  type = string
  default = ""
}

variable "private_ip" {
  type = string
  default = ""
}

variable "vpc_security_group_id" {}

variable "ssh_security_group_id" {}

variable "mysql_user" {
  type = string
}

variable "mysql_pass" {
  type = string
}
