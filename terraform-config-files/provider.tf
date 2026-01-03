terraform {
  backend "s3" {
    bucket = "tf-state-bucket"
    key    = "ec2-instance/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.74.0"
    }
  }
    
}
