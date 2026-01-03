provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "multi" {
  name        = "multi-sg-jenkins"
  description = "SG for Jenkins + Docker app"
  vpc_id      = "vpc-00819f3da277cf3e3"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "multi-tier-sg"
  }
}

resource "aws_instance" "launch_multiserver" {
  ami                    = "ami-0b46816ffa1234887"
  instance_type          = "t3.micro"
  key_name               = "terraform"
  vpc_security_group_ids = [aws_security_group.multi.id]

  tags = {
    Name = "multi-service-project"
  }
}

output "public_ip" {
  value = aws_instance.launch_multiserver.public_ip
}
