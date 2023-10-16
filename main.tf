provider aws {
    region = var.region
}
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr1
  availability_zone = var.az1
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Main1"
  }
}
resource "aws_subnet" "main2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr2
  availability_zone = var.az2
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Main2"
  }
}
resource "aws_subnet" "main3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr3
  availability_zone = var.az3
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Main3"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.main1.id
  route_table_id = aws_route_table.example.id
}
resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.main2.id
  route_table_id = aws_route_table.example.id
}
resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.main3.id
  route_table_id = aws_route_table.example.id
}
