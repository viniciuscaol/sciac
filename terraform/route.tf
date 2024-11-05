
resource "aws_route_table" "terraform_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_gw.id
  }

}

resource "aws_route_table_association" "publica_a" {
  subnet_id      = aws_nat_gateway.publica_a.id
  route_table_id = aws_route_table.terraform_route_table.id
  depends_on     = [aws_route_table.terraform_route_table]
}

resource "aws_route_table_association" "publica_b" {
  subnet_id      = aws_nat_gateway.publica_b.id
  route_table_id = aws_route_table.terraform_route_table.id
  depends_on     = [aws_route_table.terraform_route_table]
}

resource "aws_route_table_association" "publica_c" {
  subnet_id      = aws_nat_gateway.publica_c.id
  route_table_id = aws_route_table.terraform_route_table.id
  depends_on     = [aws_route_table.terraform_route_table]
}