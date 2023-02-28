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

locals {
        instance_name = {"RadhaGovind":"ami-0dfcb1ef8550277af","RadhaMadhav":"ami-0c2b0d3fb02824d92"}
}

resource "aws_instance" "my_ec2_instance" {
        for_each = local.instance_name
        ami = each.value
        instance_type = "t2.micro"
        tags = {
                Name = each.key
}
}