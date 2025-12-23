# Create SSH key pair
resource "tls_private_key" "web_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair
resource "aws_key_pair" "web_key" {
  key_name   = "web-server-key"
  public_key = tls_private_key.web_key.public_key_openssh
}

# Save private key to .pem file
resource "local_file" "private_key" {
  content  = tls_private_key.web_key.private_key_pem
  filename = "web-server-key.pem"
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnet
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "web-sg"
  }
}

# EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-0ecb62995f68bb549"  # Ubuntu
  instance_type = "t3.small"
  
  subnet_id     = data.aws_subnets.default.ids[0]
  key_name      = aws_key_pair.web_key.key_name
  
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  # Use templatefile() to process the .tpl file
  user_data = templatefile("${path.module}/user-data.tpl", {
    your_name = var.your_name
    timestamp = formatdate("YYYY-MM-DD HH:mm:ss", timestamp())
  })

  tags = {
    Name      = "web-server"
    CreatedBy = var.your_name
  }
}