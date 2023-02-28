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
        count = 2
        ami = "ami-0557a15b87f6559cf"
        instance_type = "t2.micro"
        tags = {
                Name = "Terraform - ${count.index}"
}
}