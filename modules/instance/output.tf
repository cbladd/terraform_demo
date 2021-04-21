output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.jump.public_ip
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.jump.*.private_ip
}
