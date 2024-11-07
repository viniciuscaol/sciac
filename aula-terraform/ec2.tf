resource "aws_instance" "app_a" {
  ami               = var.soimage
  instance_type     = var.ec2
  key_name          = var.key_name
  subnet_id         = aws_subnet.publica_a.id
  availability_zone = var.availability_zone_a
  security_groups   = [aws_security_group.http_sg.id]

  tags = {
    Name = "EC2 App A"
  }

  depends_on = [
    aws_subnet.publica_a
  ]
}


resource "aws_instance" "app_b" {
  ami               = var.soimage
  instance_type     = var.ec2
  key_name          = var.key_name
  subnet_id         = aws_subnet.publica_b.id
  availability_zone = var.availability_zone_b
  security_groups   = [aws_security_group.http_sg.id]

  tags = {
    Name = "EC2 App B"
  }

  depends_on = [
    aws_subnet.publica_b
  ]
}

resource "aws_instance" "app_c" {
  ami               = var.soimage
  instance_type     = var.ec2
  key_name          = var.key_name
  subnet_id         = aws_subnet.publica_c.id
  availability_zone = var.availability_zone_c
  security_groups   = [aws_security_group.http_sg.id]

  tags = {
    Name = "EC2 App C"
  }

  depends_on = [
    aws_subnet.publica_c
  ]
}
