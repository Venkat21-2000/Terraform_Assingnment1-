output "public_instance_ip" {
  value = module.ec2.public_instance_id
}

output "private_instance_ip" {
  value = module.ec2.private_instance_id
}
