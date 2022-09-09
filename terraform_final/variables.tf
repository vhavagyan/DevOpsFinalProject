variable "region" {
  default     = "us-eest-1"
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Enter Instance Type"
  type        = string
}

variable "AMI" {
  default = "ami-052efd3df9dad4825"
  type    = string
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR BLOCK"
  type        = string
}

variable "osp_public_subnet_cidr" {
  default     = "10.0.1.0/24"
  description = "public-subnet"
  type        = string
}

# variable "osp_public_subnet_cidr" {
#   default     = "10.0.1.0/24"
#   description = "public-subnet"
#   type        = string
# }

# variable "osp_public_subnet_cidr" {
#   default     = "10.0.1.0/24"
#   description = "public-subnet"
#   type        = string
# }



 variable "key_name" {
   default = "TF_key"
   type    = string
 }

variable "user_name" {
  default = "DEVOPS_ADMIN"
  type        = string
  description = "The name of the user"
}

variable "instance_name" {
  default = "OPS"
  type        = string
  description = "The name of the instance"
}

variable "vpc_name" {
  default = "ops_vpc"
  type        = string
  description = "The name of vpc"
}

variable "pbsubnet_name" {
  default = "ops_pb_subnet-us-east1-a"
  type        = string
  description = "The name of ops-vpc-public subnet"
}

variable "gateway_name" {
  default = "ops_gtw"
  type        = string
  description = "The name of gateway"
}

variable "route_table_name" {
  default = "ops_default_route"
  type        = string
  description = "The name of route table"
}

variable "security_group_name" {
  default = "ops_sec.group"
  type        = string
  description = "The name of security group"
}

variable "resource_bucket_name" {
 description = "index.html resource bucket name"
  type = string
  default = "webhostingterraform112290"
}

variable "domain_name" {
  default = "levon-arushanyan.acadevopscourse.xyz"
  type        = string
  description = "Domain name"
}


variable "route53ZoneID" {
    type = string
    default = "Z06533423NTHZUZN8R9T6"
    description = "Route53 Hosted zone ID for cloudfront website"
}