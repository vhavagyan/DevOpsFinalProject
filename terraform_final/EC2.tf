#create ec2 instance
 resource "aws_instance" "FinalProject" {
  ami           = var.AMI
  instance_type = var.instance_type
  key_name = var.key_name
  iam_instance_profile = aws_iam_instance_profile.EC2_profile.name
  subnet_id = aws_subnet.ops_subnet.id
  vpc_security_group_ids   = [aws_security_group.ops_security_group.id]
  associate_public_ip_address = true
    provisioner "local-exec" {
    command = "echo ${self.public_ip} >> /home/levon/main/ansible/hosts"
  }

  tags = {
    Name = var.instance_name
  }
 }

#create gateway
resource "aws_internet_gateway" "ops_gw" {
  vpc_id = aws_vpc.ops_vpc.id

  tags = {
    Name = var.gateway_name
  }
}

#create route table
resource "aws_route_table" "ops_route_table" {
 vpc_id = aws_vpc.ops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ops_gw.id
  }

  tags = {
   Name = var.route_table_name
  }
}

#route table association with public subnet
#ops instance path
resource "aws_route_table_association" "ops-rtb-association" {
  subnet_id      = aws_subnet.ops_subnet.id
  route_table_id = aws_route_table.ops_route_table.id
}


#create security group
resource "aws_security_group" "ops_security_group" {
  name        = var.security_group_name
  description = "Openning_ports"
  vpc_id      = aws_vpc.ops_vpc.id

  dynamic "ingress" {
    for_each = ["80","443","22","3000","9090","8080"]
    content {
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
}
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
}
}

output "instance_id" {
  value = aws_instance.FinalProject.id
}
output "instance_ips" {
  description = "Public IP address "
  value       = aws_instance.FinalProject.public_ip 

}

output "vpc_id" {
  value = aws_vpc.ops_vpc
}
output "vpc_cidr" {
  value = aws_vpc.ops_vpc.cidr_block
}
output "aws_subnet" {
  value = aws_subnet.ops_subnet
}
output "aws_internet_gateway"  {
  value = aws_internet_gateway.ops_gw
}
output "aws_route_table" {
  value = aws_route_table.ops_route_table
}
output "aws_security_group" {
  value = aws_security_group.ops_security_group
}

