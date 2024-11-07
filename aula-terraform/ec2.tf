resource "aws_instance" "app_1" {
  ami               = var.soimage
  instance_type     = var.ec2
  key_name          = var.key_name
  subnet_id         = aws_subnet.publica_1.id
  availability_zone = var.availability_zone_a
  security_groups   = [aws_security_group.http_sg.id]

  tags = {
    Name = "EC2 App 1"
  }

  depends_on = [
    aws_subnet.publica_1
  ]
}


resource "aws_instance" "app_2" {
  ami               = var.soimage
  instance_type     = var.ec2
  key_name          = var.key_name
  subnet_id         = aws_subnet.publica_2.id
  availability_zone = var.availability_zone_b
  security_groups   = [aws_security_group.http_sg.id]

  tags = {
    Name = "EC2 App 2"
  }

  depends_on = [
    aws_subnet.publica_2
  ]
}

resource "aws_instance" "app_3" {
  ami               = var.soimage
  instance_type     = var.ec2
  key_name          = var.key_name
  subnet_id         = aws_subnet.publica_3.id
  availability_zone = var.availability_zone_c
  security_groups   = [aws_security_group.http_sg.id]

  tags = {
    Name = "EC2 App 3"
  }

  depends_on = [
    aws_subnet.publica_3
  ]
}
