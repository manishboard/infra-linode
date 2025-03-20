resource "aws_vpc" "global_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name     = "${var.environment}-${var.project}-vpc"
    resource = var.resource
    iac      = var.iac
  }
}

resource "aws_internet_gateway" "global_igw" {
  vpc_id = aws_vpc.global_vpc.id
  tags = {
    Name     = "${var.environment}-${var.project}-igw"
    resource = var.resource
    iac      = var.iac
  }
}

resource "aws_route_table" "global_rt" {
  vpc_id = aws_vpc.global_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.global_igw.id
  }

  tags = {
    Name     = "${var.environment}-${var.project}-rt"
    resource = var.resource
    iac      = var.iac
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.global_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name     = "${var.environment}-${var.project}-public-subnet-a"
    resource = var.resource
    iac      = var.iac
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.global_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-${var.project}-public-subnet-b"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = aws_vpc.global_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-${var.project}-public-subnet-c"
  }
}

resource "aws_route_table_association" "public_subnetA_rt_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.global_rt.id
}

resource "aws_route_table_association" "public_subnetB_rt_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.global_rt.id
}

resource "aws_route_table_association" "public_subnetC_rt_association" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.global_rt.id
}

resource "aws_security_group" "public_sg" {
  name        = "${var.environment}-aurora-sg"
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.global_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow IPv4 (remove if you only want IPv6)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-public-sg"
  }
}


