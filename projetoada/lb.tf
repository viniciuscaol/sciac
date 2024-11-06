# Security Group
resource "aws_security_group" "scada_sglb" {
  vpc_id = aws_vpc.sc_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ADA SC SGLB"
  }
}

# Load Balancer
resource "aws_lb" "scada_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.scada_sglb.id]
  subnets = [
    aws_subnet.publica_1.id,
    aws_subnet.publica_2.id,
    aws_subnet.publica_3.id,
  ]

  tags = {
    Name = "SC ADA LB"
  }
}

# Target Group para as instâncias EC2
resource "aws_lb_target_group" "scada_tg" {
  name        = "app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.sc_vpc.id
  target_type = "instance"
}

# Listener do Load Balancer
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.scada_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.scada_tg.arn
  }
}
