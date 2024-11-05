//Subnets privadas

resource "aws_subnet" "privada_a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "privada-a"
  }
  depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "privada_b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "privada-b"
  }
  depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "privada_c" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "privada-c"
  }
  depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "rds_a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.8.0/24"


  tags = {
    Name = "rds-a"
  }
  depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "rds_b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.9.0/24"

  tags = {
    Name = "rds-b"
  }
  depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "rds_c" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.10.0/24"

  tags = {
    Name = "rds-c"
  }
  depends_on = [aws_vpc.terraform_vpc]
}