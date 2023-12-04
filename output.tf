output "public_instance_ip" {
  value = module.ec2.public_instance_ip
}

output "private_instance_ip" {
  value = module.ec2.private_instance_ip
}
