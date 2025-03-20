terraform {
  required_providers {
        aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

    tags = {
    Name = "my_vpc"
  }
}


resource "aws_subnet" "my_subnet" {
  vpc_id            = local.vpc_id
  availability_zone = var.subnet_zones[0]
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "my_subnet"
  }
}

#Conditionally allow ssh inbound traffic based on ssh_access variable
resource "aws_security_group" "my_security_group" {
  name        = var.ssh_access ? "allow_ssh" : "deny_ssh"
  description = "allows or denies ssh access"
  vpc_id      = local.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = [
        var.ssh_access ? "0.0.0.0/0" : "32.32.32.32/32"
    ]
  }
}




resource "aws_instance" "my_instance" {
  subnet_id                    = aws_subnet.my_subnet.id
  ami                          = local.al_ami
  instance_type                = "t2.micro"
  key_name                     = "main-key"
  associate_public_ip_address  = true
  vpc_security_group_ids       = [aws_security_group.my_security_group.id]
  tags = {
    Name = "my_instance"
  }
}

locals {
  vpc_id = aws_vpc.my_vpc.id
  #Amazon Linux 2023 64-bit ami
  al_ami = "ami-08b5b3a93ed654d19"
}

#Internet gateway, route table, and route table association
#Just practice to test if conditional ssh is actually working
resource "aws_internet_gateway" "my_gateway" {
  vpc_id = local.vpc_id
   tags = {
    Name = "my_gateway"
  }
  
}


resource "aws_route_table" "my_route_table" {
  vpc_id = local.vpc_id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gateway.id
  }
     tags = {
    Name = "my_route_table"
  }
}

resource "aws_main_route_table_association" "rta" {
  vpc_id         = local.vpc_id
  route_table_id = aws_route_table.my_route_table.id
}
