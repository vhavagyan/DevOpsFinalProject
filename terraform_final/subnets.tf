#create subnet
#instance path
resource "aws_subnet" "ops_subnet" {
  vpc_id     = aws_vpc.ops_vpc.id
  cidr_block = var.osp_public_subnet_cidr

  tags = {
    Name = var.pbsubnet_name
  }
}

##################################################
#cluster path
resource "aws_subnet" "cluster-public-us-east-1b" {
  vpc_id                  = aws_vpc.ops_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                             = "cluster-public-us-east-1b"
    "kubernetes.io/cluster/im-cluster" = "owned" 
    "kubernetes.io/role/elb"           = 1
  }
}

resource "aws_subnet" "cluster-public-us-east-1c" {
  vpc_id                  = aws_vpc.ops_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    "Name"                             = "cluster-public-us-east-1c"
    "kubernetes.io/cluster/im-cluster" = "owned" 
    "kubernetes.io/role/elb"           = 1
  }
}

resource "aws_subnet" "cluster-public-us-east-1d" {
  vpc_id                  = aws_vpc.ops_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = true

  tags = {
    "Name"                             = "cluster-public-us-east-1d"
    "kubernetes.io/cluster/im-cluster" = "owned" 
    "kubernetes.io/role/elb"           = 1
  }
}

resource "aws_subnet" "DB-public-us-east-1e" {
  vpc_id                  = aws_vpc.ops_vpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1e"
  map_public_ip_on_launch = true
  tags = {
    "Name"                             = "DB-public-us-east-1e"
    "kubernetes.io/cluster/im-cluster" = "owned" 
    "kubernetes.io/role/elb"           = 1
  }
}

resource "aws_subnet" "DB-public-us-east-1c" {
  vpc_id                  = aws_vpc.ops_vpc.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    "Name"                             = "DB-public-us-east-1c"
    "kubernetes.io/cluster/im-cluster" = "owned" 
    "kubernetes.io/role/elb"           = 1
  }
}