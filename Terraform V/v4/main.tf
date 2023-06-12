provider "aws" {
   region     = "us-east-1"
   access_key = "@@@@@@@@@@@@@@@@@@@@"
   secret_key = "#################################"
}

locals {
  env = "demo"
}

resource "aws_vpc" "test-vpc" {
  cidr_block = "172.10.0.0/16"

  tags = {
    Name = "${local.env}-vpc-tag"
  }
}

resource "aws_subnet" "test-subnet" {
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = "172.10.0.0/16"

  tags = {
    Name = "${local.env}-subnet-tag"
  }
}

resource "aws_instance" "demo_ec2" {
   
   ami           = "ami-0557a15b87f6559cf"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.test-subnet.id
   associate_public_ip_address = true
   
   tags = {
           Name = "${local.env} - Terraform EC2"
   }
}
