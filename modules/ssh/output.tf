output "key_name" {
  value = aws_key_pair.ec2_key_pair.key_name
}

output "key_value" {
  value = tls_private_key.ssh_key.private_key_pem
  
}

output "key_pair" {
  value = aws_key_pair.ec2_key_pair.public_key
  
}
