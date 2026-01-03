variable "environment" {
  type        = string
  description = "Environment name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "tf_state_bucket_name" {
  type        = string
  description = "S3 bucket name for Terraform state"
}

variable "vpc_cidr" {
  type        = string
}

variable "public_subnet_cidr" {
  type        = string
}

variable "availability_zone" {
  type        = string
}

variable "ami_id" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "key_name" {
  type        = string
}

variable "ssh_allowed_cidrs" {
  type        = list(string)
}
