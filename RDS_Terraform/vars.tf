variable "rds_db_name" {
  description = "RDS database name"
  default     = "myacadb"
}


variable "rds_username" {
  description = "RDS database username"
  default     = "djangoproject"
}


variable "rds_password" {
  description = "RDS database password"
  default     = "secret"
}


variable "rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t2.micro"
}
