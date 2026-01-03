output "ec2_public_ip" {
  value = aws_instance.tf_instance.public_ip
}

output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}
