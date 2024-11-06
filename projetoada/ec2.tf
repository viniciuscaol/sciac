# Security Group para as instâncias EC2 permitir tráfego do Load Balancer
resource "aws_security_group" "scada_ec2sg" {
  vpc_id = aws_vpc.sc_vpc.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.scada_sglb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SC ADA EC2SG"
  }
}

# Instâncias EC2
resource "aws_instance" "EC2_1" {
  ami               = var.soimage
  instance_type     = var.ec2
  subnet_id         = aws_subnet.privada_1.id
  security_groups   = [aws_security_group.scada_ec2sg.name]
  availability_zone = var.availability_zone_a

  key_name = var.key_name

  tags = {
    Name = "EC2-1"
  }
}

resource "aws_instance" "EC2_2" {
  ami               = var.soimage
  instance_type     = var.ec2
  subnet_id         = aws_subnet.privada_2.id
  security_groups   = [aws_security_group.scada_ec2sg.name]
  availability_zone = var.availability_zone_b

  key_name = var.key_name

  tags = {
    Name = "EC2-2"
  }
}

resource "aws_instance" "EC2_3" {
  ami               = var.soimage
  instance_type     = var.ec2
  subnet_id         = aws_subnet.privada_3.id
  security_groups   = [aws_security_group.scada_ec2sg.name]
  availability_zone = var.availability_zone_c

  key_name = var.key_name

  tags = {
    Name = "EC2-3"
  }
}

# Registro das instâncias EC2 no Target Group

resource "aws_lb_target_group_attachment" "ec21_attachment" {
  target_group_arn = aws_lb_target_group.scada_tg.arn
  target_id        = aws_instance.EC2_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec22_attachment" {
  target_group_arn = aws_lb_target_group.scada_tg.arn
  target_id        = aws_instance.EC2_2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec23_attachment" {
  target_group_arn = aws_lb_target_group.scada_tg.arn
  target_id        = aws_instance.EC2_3.id
  port             = 80
}