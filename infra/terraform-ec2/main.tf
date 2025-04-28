provider "aws" {
  region = "us-east-1"  # Change this to your preferred AWS region
}

resource "aws_instance" "my_ec2" {
  ami                    = "ami-05b10e08d247fb927"  # Amazon Linux 2 AMI (Change if needed)
  instance_type          = "t2.micro"  # Free-tier eligible instance
  key_name               = "my-ec2-key"  # Replace with your actual key pair name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "MyTerraformEC2"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["100.14.227.15/32"]  # Allows SSH from anywhere (Not recommended for production)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTP traffic from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTPS traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allows all outbound traffic
  }
}
