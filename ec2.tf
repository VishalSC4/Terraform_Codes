provider "aws" {
  region = "ap-south-1"
  
}



# Security Group Code
resource "aws_security_group" "Rajubhaicha-Sg" {
  description = "New-sg"
  name = "Raju-Sg"
  vpc_id = aws_vpc.Lalu-VPC.id

  ingress  {
description = "Allow all inbound rules"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }

  ingress  {
description = "Allow all inbound rules"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }

  ingress  {
description = "Allow all inbound rules"
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }

  egress  {
description = "Allow all outbound rules"
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
  }
  
}


#VPC Code


# 1 Create a VPC
resource "aws_vpc" "Lalu-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Lalucha-VPC"
  }
}

# 2 Create Internet Gateway

resource "aws_internet_gateway" "Lalu-IGW" {
  vpc_id = aws_vpc.Lalu-VPC.id

tags = {
  Name = "My-IGW"
}
}

# 3 Public Subnet

resource "aws_subnet" "public_subnet"{
  vpc_id = aws_vpc.Lalu-VPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
tags = {
  Name = "My-public-subnet"
}
}


# 4 Routetable

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.Lalu-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Lalu-IGW.id
  }

  tags = {
    Name = "My-RT"
  }
}

# 5 Associate Route Table with Subnets

resource "aws_route_table_association" "my-association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_route_table.id
  
}

# 6 EC2 Code

resource "aws_instance" "Rajubhai" {
  ami = "ami-00ca570c1b6d79f36"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.Rajubhaicha-Sg.id]
 user_data = <<-EOF
#!/bin/bash
dnf update -y
dnf install httpd -y
systemctl start httpd
systemctl enable httpd

echo "<h1>I'm doing the heredoc</h1>" > /var/www/html/index.html
EOF

  tags = {
    Name = "Lalubhai"

  }
  
}
output "public_ip" {
  value = aws_instance.Rajubhai.public_ip
}
