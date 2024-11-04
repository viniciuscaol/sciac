//VPC

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    vpc = "terraform_vpc"
  }
}

//Subnets publicas

resource "aws_subnet" "publica_a" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "a"

  tags = {
    Name = "publica-a"
  }
  depends_on = [ aws_vpc.terraform_vpc ]
}

resource "aws_subnet" "publica_b" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "b"
  tags = {
    Name = "publica-b"
  }
  depends_on = [ aws_vpc.terraform_vpc ]
}

resource "aws_subnet" "publica_c" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "c"
  tags = {
    Name = "publica-c"
  }
  depends_on = [ aws_vpc.terraform_vpc ]
}

//Internet Gateway

resource "aws_internet_gateway" "terraform_gw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "main"
  }
}

//Subnets privadas

resource "aws_subnet" "privada_a" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "a"

  tags = {
    Name = "privada-a"
  }
  depends_on = [ aws_vpc.terraform_vpc ]
}

resource "aws_subnet" "privada_b" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "b"
  tags = {
    Name = "privada-b"
  }
  depends_on = [ aws_vpc.terraform_vpc ]
}

resource "aws_subnet" "privada_c" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "c"
  tags = {
    Name = "privada-c"
  }
  depends_on = [ aws_vpc.terraform_vpc ]
}

//Nat Gateway

resource "aws_nat_gateway" "publica_a" {
  subnet_id = aws_subnet.publica_a.id

  tags = {
    Name = "NAT-A"
  }
  depends_on = [ aws_internet_gateway.terraform_gw ]
}

resource "aws_nat_gateway" "publica_b" {
  subnet_id = aws_subnet.publica_b.id

  tags = {
    Name = "NAT-B"
  }
  depends_on = [ aws_internet_gateway.terraform_gw ]
}

resource "aws_nat_gateway" "publica_c" {
  subnet_id = aws_subnet.publica_c.id

  tags = {
    Name = "NAT-C"
  }
  depends_on = [ aws_internet_gateway.terraform_gw ]
}