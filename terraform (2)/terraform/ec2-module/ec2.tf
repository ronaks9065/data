# Creating EC2 Instance
resource "aws_instance" "web" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = var.public_subnet_id
  associate_public_ip_address = true
  iam_instance_profile = var.iamprofilearn
  tags = {
    Name = var.instance_name
  }
  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
           EOF
}

# Creating Security Group
resource "aws_security_group" "sg" {
  name        = "sggroupbyTF"
  description = "Example security group created by Terraform"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # "-1" represents all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}