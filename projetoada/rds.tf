# Security Group para o RDS permitir apenas tráfego das instâncias EC2

resource "aws_security_group" "scada_sgrds" {
  vpc_id = aws_vpc.sc_vpc.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.scada_ec2sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SC ADA SGRDS"
  }
}

# Subnet Group para o RDS

resource "aws_db_subnet_group" "scada_subgrouprds" {
  name = "scada_subgrouprds"
  subnet_ids = [aws_subnet.rds_1.id,
    aws_subnet.rds_2.id,
    aws_subnet.rds_3.id
  ]

  tags = {
    Name = "SC ADA Sub Group RDS"
  }
}

# Instâncias RDS

resource "aws_db_instance" "scada_rds" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = var.rds_dbname
  username               = var.rds_username
  password               = var.rds_password
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.scada_subgrouprds.name
  vpc_security_group_ids = [aws_security_group.scada_sgrds.id]
  skip_final_snapshot    = true

  tags = {
    Name = "SC ADA RDS"
  }
}