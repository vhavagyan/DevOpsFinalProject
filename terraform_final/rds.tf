resource "aws_db_instance" "rds-instance"{
  allocated_storage    = 20
  identifier = "rds-terraform"
  engine               = "postgres"
  storage_type = "gp2"
  engine_version       = "12"
  instance_class       = "db.t3.micro"
  db_name                 = "jango_project"
  username             = "jango_user"
  password             = "Zaq11qaZXsw22wsX"
  db_subnet_group_name = aws_db_subnet_group.Jango-RDS.id
  vpc_security_group_ids = ["${aws_security_group.rdssec.id}"]
  publicly_accessible    = false
  skip_final_snapshot    = true

   tags = {
    Name = "jango-rds"
   }
}

 

resource "aws_db_subnet_group" "Jango-RDS" {
  name       = "jango-db-subnet"
  subnet_ids = [

    aws_subnet.DB-public-us-east-1e.id,
    aws_subnet.DB-public-us-east-1c.id
    
]

  tags = {
    Name = "jango-db-subnet"
  }
}


resource "aws_db_parameter_group" "param-group" {
  name        = "param-group"
  description = "RDS parameter group for postgres"
  family      = "postgres12"
  parameter {
    name  = "log_statement"
    value = "none"
  }
  
}