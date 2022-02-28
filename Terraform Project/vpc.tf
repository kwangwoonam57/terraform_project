
resource "aws_vpc" "Terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Terraform_vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.Terraform_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "terraform_subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.Terraform_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "terraform_subnet2"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Terraform_vpc.id

  tags = {
    Name = "terraform_IGW"
  }
}

resource "aws_security_group" "Security_Group" {
  name = "terraform_security_group"
  description = "Allow inbound traffic"
  vpc_id = aws_vpc.Terraform_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 81
    to_port          = 81
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_security_group"
  }
}

resource "aws_route_table" "Route_Table" {
  vpc_id = aws_vpc.Terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "terraform_route_table"
  }
}

resource "aws_route_table_association" "Route_Table_AssociationA" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.Route_Table.id
}

resource "aws_route_table_association" "Route_Table_AssociationB" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.Route_Table.id
}