provider "aws" {
    region = var.region
}




resource "aws_instance" "prometeus" {
  ami                         = var.os
  instance_type               = var.type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  monitoring                  = true
  key_name                    = "anster"
  user_data                   = file("user_data.sh")

  tags = {
    Name = "prometeus-graphana"
    Value = "Armen"
  }
}
