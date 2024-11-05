variable "aws_region" {
  description = "AWS região"
  default     = "us-east-1"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "cidr00" {
  description = "CIDR Geral 0.0.0.0/0"
  default     = "0.0.0.0/0"
  type        = string
}

variable "availability_zone_a" {
  description = "Zona de disponibilidade a"
  default     = "us-east-1a"
  type        = string
}

variable "availability_zone_b" {
  description = "Zona de disponibilidade b"
  default     = "us-east-1b"
  type        = string
}

variable "availability_zone_c" {
  description = "Zona de disponibilidade c"
  default     = "us-east-1c"
  type        = string
}

variable "ec2" {
  description = "Padão EC2"
  default     = "t2.micro"
  type        = string
}

variable "soimage" {
  description = "Imagem do SO"
  default     = "ami-06b21ccaeff8cd686"
  type        = string
}

variable "key_name" {
  description = "Nome da chave"
  default     = "terraform"
  type        = string
}