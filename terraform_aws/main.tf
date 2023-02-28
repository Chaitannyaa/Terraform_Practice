terraform {
        required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
}
}
        required_version = "~> 1.3.9"
}

provider "aws" {
        region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
        count = 1
        ami = "ami-0557a15b87f6559cf"
        instance_type = "t2.micro"
        tags = {
                Name = "Ubuntu"
}
}

resource "aws_s3_bucket" "my_s3_bucket" {
        bucket = "chaitannyaa"
        tags = {
                Name = "chaitannyaa"
                Environment = "Ram"
}
}

output "my_public_ips" {
        value = aws_instance.my_ec2_instance[*].public_ip
}
