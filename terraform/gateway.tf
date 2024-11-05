//Internet Gateway

resource "aws_internet_gateway" "terraform_gw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
  depends_on = [aws_vpc.terraform_vpc]
}

//Nat Gateway

resource "aws_eip" "nateip_a" {

}

resource "aws_nat_gateway" "publica_a" {
  subnet_id     = aws_subnet.publica_a.id
  allocation_id = aws_eip.nateip_a.id
  tags = {
    Name = "NAT-A"
  }
  depends_on = [aws_internet_gateway.terraform_gw]
}

resource "aws_eip" "nateip_b" {

}

resource "aws_nat_gateway" "publica_b" {
  subnet_id     = aws_subnet.publica_b.id
  allocation_id = aws_eip.nateip_b.id
  tags = {
    Name = "NAT-B"
  }
  depends_on = [aws_internet_gateway.terraform_gw]
}

resource "aws_eip" "nateip_c" {

}

resource "aws_nat_gateway" "publica_c" {
  subnet_id     = aws_subnet.publica_c.id
  allocation_id = aws_eip.nateip_c.id
  tags = {
    Name = "NAT-C"
  }
  depends_on = [aws_internet_gateway.terraform_gw]
}
