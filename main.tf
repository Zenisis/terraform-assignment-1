
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.18.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
}







data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 instance
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = t2.micro
  key_name               = aws_key_pair.deployer.key_name
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # simple user-data: install nginx and start it
              yum update -y
              amazon-linux-extras install nginx1 -y || yum install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1> nginx webserver on ec2 terraform EC2</h1>" > /usr/share/nginx/html/index.html
              EOF

  
}































