resource "aws_instance" "ec2" {
  ami                         = "ami-085f9c64a9b75eed5"
  instance_type               = "t2.medium"
  key_name                    = var.keyPair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet_a.id
  vpc_security_group_ids      = [aws_security_group.global_sg.id]
  security_groups             = [aws_security_group.global_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install curl -y
              curl -fsSL https://get.docker.com | sh -
              sleep 5
              usermod -aG docker ubuntu
              newgrp docker
              systemctl enable docker
              systemctl start docker
              EOF

  tags = {
    Name = "${var.environment}-${var.project}-ec2-k8-master"
  }
}