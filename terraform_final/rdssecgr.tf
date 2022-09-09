resource "aws_security_group" "rdssec" {
  name        = "rds_security_group"
  description = " RDS postgre server"
  vpc_id      =  aws_vpc.ops_vpc.id
  # Keep the instance private by only allowing traffic from the web server.
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
#   tags {
#      Name = "terraform-example-rds-security-group"
#   }
}