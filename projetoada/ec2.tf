resource "aws_instance" "EC2_1" {
  ami               = var.soimage
  instance_type     = var.ec2
  subnet_id         = aws_subnet.privada_1.id
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
  availability_zone = var.availability_zone_c

  key_name = var.key_name

  tags = {
    Name = "EC2-3"
  }
}
