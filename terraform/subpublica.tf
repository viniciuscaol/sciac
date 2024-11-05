//Subnets publicas

resource "aws_subnet" "publica_a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "a"

  tags = {
    Name = "publica-a"
  }
  depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "publica_b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "b"
  tags = {
    Name = "publica-b"
  }
  depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_subnet" "publica_c" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "c"
  tags = {
    Name = "publica-c"
  }
  depends_on = [aws_vpc.terraform_vpc]
}