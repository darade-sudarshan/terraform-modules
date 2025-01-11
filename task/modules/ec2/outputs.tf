output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.windows.id
}

# output "instance_private_ip" {
#   description = "Private IP of the EC2 instance"
#   value       = aws_instance.windows.private_ip
# }

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.windows.public_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.instance_sg.id
}
