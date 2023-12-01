provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_instance" "public_instance" {
  ami                    = "ami-0c0fef718caa09499"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = "Public Instance"
  }

  # user_data = file("user.sh")
  provisioner "remote-exec" {
    inline = [

      "sudo yum install -y nginx",
      "sudo service nginx start",
      "sudo chkconfig nginx on",
      "echo '${tls_private_key.ssh_key.private_key_pem}' > /home/ec2-user/private_key.pem",
      "chmod 400 /home/ec2-user/private_key.pem"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "private_instance" {
  ami                    = "ami-0c0fef718caa09499"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = "Private Instance"
  }

  user_data = file("user-data.sh")
}
