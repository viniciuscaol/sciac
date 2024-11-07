//VPC

resource "aws_vpc" "sc_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Projeto Ada"
  }
}

//Internet Gateway

resource "aws_internet_gateway" "sc_gw" {
  vpc_id = aws_vpc.sc_vpc.id

  tags = {
    Name = "SC-IGW"
  }

  depends_on = [aws_vpc.sc_vpc]
}

//Subrede privada

resource "aws_subnet" "publica_a" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "Sub Publica A"
  }

  depends_on = [aws_vpc.sc_vpc]
}

resource "aws_subnet" "publica_b" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone_b

  tags = {
    Name = "Sub Publica B"
  }

  depends_on = [aws_vpc.sc_vpc]
}

resource "aws_subnet" "publica_c" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone_c

  tags = {
    Name = "Sub Publica C"
  }

  depends_on = [aws_vpc.sc_vpc]
}

//EIP

resource "aws_eip" "sceip_a" {
  tags = {
    Name = "IP Elastic A"
  }
}

resource "aws_eip" "sceip_b" {
  tags = {
    Name = "IP Elastic B"
  }
}

resource "aws_eip" "sceip_c" {
  tags = {
    Name = "IP Elastic C"
  }
}

//Nat Gateway

resource "aws_nat_gateway" "scnatgw_a" {
  allocation_id = aws_eip.sceip_a.id
  subnet_id     = aws_subnet.publica_a.id

  tags = {
    Name = "NAT-A"
  }

  depends_on = [aws_subnet.publica_a]
}

resource "aws_nat_gateway" "scnatgw_b" {
  allocation_id = aws_eip.sceip_b.id
  subnet_id     = aws_subnet.publica_b.id

  tags = {
    Name = "NAT-B"
  }

  depends_on = [aws_subnet.publica_b]
}

resource "aws_nat_gateway" "scnatgw_c" {
  allocation_id = aws_eip.sceip_c.id
  subnet_id     = aws_subnet.publica_c.id

  tags = {
    Name = "NAT-C"
  }

  depends_on = [aws_subnet.publica_c]
}

//Route Table Publica

resource "aws_route_table" "sc_rotapublica" {
  vpc_id = aws_vpc.sc_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sc_gw.id
  }

  tags = {
    Name = "Route Table Publica"
  }
}

resource "aws_route_table_association" "rotapublica_a" {
  subnet_id      = aws_subnet.publica_a.id
  route_table_id = aws_route_table.sc_rotapublica.id
  depends_on     = [aws_route_table.sc_rotapublica]
}

resource "aws_route_table_association" "rotapublica_b" {
  subnet_id      = aws_subnet.publica_b.id
  route_table_id = aws_route_table.sc_rotapublica.id
  depends_on     = [aws_route_table.sc_rotapublica]
}

resource "aws_route_table_association" "rotapublica_c" {
  subnet_id      = aws_subnet.publica_c.id
  route_table_id = aws_route_table.sc_rotapublica.id
  depends_on     = [aws_route_table.sc_rotapublica]
}

//Subrede privada

resource "aws_subnet" "privada_a" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "Sub Privada A"
  }
}

resource "aws_subnet" "privada_b" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = var.availability_zone_b

  tags = {
    Name = "Sub Privada B"
  }
}

resource "aws_subnet" "privada_c" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = var.availability_zone_c

  tags = {
    Name = "Sub Privada C"
  }
}

resource "aws_subnet" "rds_a" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "Banco RDS A"
  }
}

resource "aws_subnet" "rds_b" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = var.availability_zone_b

  tags = {
    Name = "Banco RDS B"
  }
}

resource "aws_subnet" "rds_c" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.9.0/24"
  availability_zone = var.availability_zone_c

  tags = {
    Name = "Banco RDS C"
  }
}

//Route Table Privada

resource "aws_route_table" "scrotaprivada_a" {
  vpc_id = aws_vpc.sc_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.scnatgw_a.id
  }

  tags = {
    Name = "Route Table Privada A"
  }
}

resource "aws_route_table" "scrotaprivada_b" {
  vpc_id = aws_vpc.sc_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.scnatgw_b.id
  }

  tags = {
    Name = "Route Table Privada B"
  }
}

resource "aws_route_table" "scrotaprivada_c" {
  vpc_id = aws_vpc.sc_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.scnatgw_c.id
  }

  tags = {
    Name = "Route Table Privada C"
  }
}


resource "aws_route_table_association" "rotaprivada_a" {
  subnet_id      = aws_subnet.privada_a.id
  route_table_id = aws_route_table.scrotaprivada_a.id
  depends_on     = [aws_route_table.scrotaprivada_a]
}

resource "aws_route_table_association" "rotaprivada_b" {
  subnet_id      = aws_subnet.privada_b.id
  route_table_id = aws_route_table.scrotaprivada_b.id
  depends_on     = [aws_route_table.scrotaprivada_b]
}

resource "aws_route_table_association" "rotaprivada_c" {
  subnet_id      = aws_subnet.privada_c.id
  route_table_id = aws_route_table.scrotaprivada_c.id
  depends_on     = [aws_route_table.scrotaprivada_c]
}

resource "aws_route_table" "rotards" {
  vpc_id = aws_vpc.sc_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "Route Table Banco RDS"
  }
}

resource "aws_route_table_association" "rotards_a" {
  subnet_id      = aws_subnet.rds_a.id
  route_table_id = aws_route_table.rotards.id
  depends_on     = [aws_route_table.rotards]
}

resource "aws_route_table_association" "rotards_b" {
  subnet_id      = aws_subnet.rds_b.id
  route_table_id = aws_route_table.rotards.id
  depends_on     = [aws_route_table.rotards]
}

resource "aws_route_table_association" "rotards_c" {
  subnet_id      = aws_subnet.rds_c.id
  route_table_id = aws_route_table.rotards.id
  depends_on     = [aws_route_table.rotards]
}