output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.main.*.id, [""])[0]
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = [aws_subnet.main_subnet_private_1[0].id, 
                  aws_subnet.main_subnet_private_2[0].id, 
                  aws_subnet.main_subnet_private_3[0].id
                ]
}

output "public_subnet_ids" {
  description = "List of IDs of pubic subnets"
  value       = [aws_subnet.main_subnet_public_1[0].id,
                  aws_subnet.main_subnet_public_2[0].id
                ]
}

output "ssh_security_group_id" {
  description = "VPC security group ids"
  value       = aws_security_group.ssh_sg.*.id
}

output "vpc_security_group_id" {
  description = "Allow all traffic from inside the VPC"
  value       = aws_security_group.vpc_sg.*.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.main.*.cidr_block, [""])[0]
}
