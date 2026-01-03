# ------------------------
# S3 Bucket for Terraform State (bootstrap)
# ------------------------
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = var.tf_state_bucket_name

  tags = {
    Name        = var.tf_state_bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ------------------------
# VPC
# ------------------------
resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tf-vpc"
  }
}

# ------------------------
# Internet Gateway
# ------------------------
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf-igw"
  }
}

# ------------------------
# Public Subnet
# ------------------------
resource "aws_subnet" "tf_public_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-public-subnet"
  }
}

# ------------------------
# Route Table
# ------------------------
resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "tf-public-rt"
  }
}

resource "aws_route_table_association" "tf_public_assoc" {
  subnet_id      = aws_subnet.tf_public_subnet.id
  route_table_id = aws_route_table.tf_public_rt.id
}

# ------------------------
# EC2 Instance
# ------------------------
resource "aws_instance" "tf_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.tf_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.tf_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "tf-instance"
  }
}
