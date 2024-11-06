//VPC

resource "aws_vpc" "sc_vpc" {
  cidr_block = var.vpc_cidr
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

resource "aws_subnet" "publica_1" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "Sub Publica 1"
  }

  depends_on = [aws_vpc.sc_vpc]
}

resource "aws_subnet" "publica_2" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone_b

  tags = {
    Name = "Sub Publica 2"
  }

  depends_on = [aws_vpc.sc_vpc]
}

resource "aws_subnet" "publica_3" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone_c

  tags = {
    Name = "Sub Publica 3"
  }

  depends_on = [aws_vpc.sc_vpc]
}

//EIP

resource "aws_eip" "sceip_1" {
  tags = {
    Name = "IP Elastic 1"
  }
}

resource "aws_eip" "sceip_2" {
  tags = {
    Name = "IP Elastic 1"
  }
}

resource "aws_eip" "sceip_3" {
  tags = {
    Name = "IP Elastic 1"
  }
}

//Nat Gateway

resource "aws_nat_gateway" "scnatgw_1" {
  allocation_id = aws_eip.sceip_1.id
  subnet_id     = aws_subnet.publica_1.id

  tags = {
    Name = "NAT-1"
  }

  depends_on = [aws_subnet.publica_1]
}

resource "aws_nat_gateway" "scnatgw_2" {
  allocation_id = aws_eip.sceip_2.id
  subnet_id     = aws_subnet.publica_2.id

  tags = {
    Name = "NAT-2"
  }

  depends_on = [aws_subnet.publica_2]
}

resource "aws_nat_gateway" "scnatgw_3" {
  allocation_id = aws_eip.sceip_3.id
  subnet_id     = aws_subnet.publica_3.id

  tags = {
    Name = "NAT-3"
  }

  depends_on = [aws_subnet.publica_3]
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

resource "aws_route_table_association" "rotapublica_1" {
  subnet_id      = aws_subnet.publica_1.id
  route_table_id = aws_route_table.sc_rotapublica.id
  depends_on     = [aws_route_table.sc_rotapublica]
}

resource "aws_route_table_association" "rotapublica_2" {
  subnet_id      = aws_subnet.publica_2.id
  route_table_id = aws_route_table.sc_rotapublica.id
  depends_on     = [aws_route_table.sc_rotapublica]
}

resource "aws_route_table_association" "rotapublica_3" {
  subnet_id      = aws_subnet.publica_3.id
  route_table_id = aws_route_table.sc_rotapublica.id
  depends_on     = [aws_route_table.sc_rotapublica]
}

//Subrede privada

resource "aws_subnet" "privada_1" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "Sub Privada 1"
  }
}

resource "aws_subnet" "privada_2" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = var.availability_zone_b

  tags = {
    Name = "Sub Privada 2"
  }
}

resource "aws_subnet" "privada_3" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = var.availability_zone_c

  tags = {
    Name = "Sub Privada 3"
  }
}

resource "aws_subnet" "rds_1" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "Banco RDS 1"
  }
}

resource "aws_subnet" "rds_2" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = var.availability_zone_b

  tags = {
    Name = "Banco RDS 2"
  }
}

resource "aws_subnet" "rds_3" {
  vpc_id            = aws_vpc.sc_vpc.id
  cidr_block        = "10.0.9.0/24"
  availability_zone = var.availability_zone_c

  tags = {
    Name = "Banco RDS 3"
  }
}

//Route Table Privada

resource "aws_route_table" "scrotaprivada_1" {
  vpc_id = aws_vpc.sc_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.scnatgw_1.id
  }

  tags = {
    Name = "Route Table Privada 1"
  }
}

resource "aws_route_table" "scrotaprivada_2" {
  vpc_id = aws_vpc.sc_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.scnatgw_2.id
  }

  tags = {
    Name = "Route Table Privada 2"
  }
}

resource "aws_route_table" "scrotaprivada_3" {
  vpc_id = aws_vpc.sc_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.scnatgw_3.id
  }

  tags = {
    Name = "Route Table Privada 3"
  }
}


resource "aws_route_table_association" "rotaprivada_1" {
  subnet_id      = aws_subnet.privada_1.id
  route_table_id = aws_route_table.scrotaprivada_1.id
  depends_on     = [aws_route_table.scrotaprivada_1]
}

resource "aws_route_table_association" "rotaprivada_2" {
  subnet_id      = aws_subnet.privada_2.id
  route_table_id = aws_route_table.scrotaprivada_2.id
  depends_on     = [aws_route_table.scrotaprivada_2]
}

resource "aws_route_table_association" "rotaprivada_3" {
  subnet_id      = aws_subnet.privada_3.id
  route_table_id = aws_route_table.scrotaprivada_3.id
  depends_on     = [aws_route_table.scrotaprivada_3]
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

resource "aws_route_table_association" "rotards_1" {
  subnet_id      = aws_subnet.rds_1.id
  route_table_id = aws_route_table.rotards.id
  depends_on     = [aws_route_table.rotards]
}

resource "aws_route_table_association" "rotards_2" {
  subnet_id      = aws_subnet.rds_2.id
  route_table_id = aws_route_table.rotards.id
  depends_on     = [aws_route_table.rotards]
}

resource "aws_route_table_association" "rotards_3" {
  subnet_id      = aws_subnet.rds_3.id
  route_table_id = aws_route_table.rotards.id
  depends_on     = [aws_route_table.rotards]
}