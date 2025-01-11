output "public_instance_id" {
  value = module.public_ec2.instance_id
}

output "public_instance_public_ip" {
  value = module.public_ec2.instance_public_ip
}

output "private_instance_id" {
  value = module.private_ec2.instance_id
}

output "private_instance_private_ip" {
  value = module.private_ec2.instance_private_ip
}
