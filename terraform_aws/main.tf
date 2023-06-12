terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = "~> 1.3.9"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webapache2" {
    ami = "ami-0557a15b87f6559cf"  
    instance_type = "t2.micro" 
    key_name= "my_aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]
    tags = { Name = "Ubuntu test" }

  # provisioner "remote-exec" {
  #   inline = [
  #       "sudo apt update",
  #       "sudo apt -y install nginx",
  #       "sudo systemctl start nginx",
  #       "sudo systemctl enable nginx"
  #   ]
  # }

  provisioner "remote-exec" {
    inline = [
        "sudo apt update",
        "sudo apt -y install apache2",
        "sudo systemctl start apache2",
        "sudo systemctl enable apache2" ]
  }
  connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("C:/Users/Chait/Desktop/Terrform/terraform_aws/aws_key")
      timeout     = "10m"
      host        = self.public_ip
    }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags]
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0" ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]

  tags = { Name = "Terraform_Generated" }
}

resource "aws_key_pair" "tester" {
  key_name   = "my_aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNz07d4dOhA8zsUSDXWjrSqWqzOpGFbd/RXdiDG5f0BtUyiA5j47yHWbsCm0bdi7uwHuwbwqS/RrQRSSeksK+V6yIKWaACIEtc6MT1+Fnq0IA/tteIGH/muzvJNJs3LHhF1ZdI1MDfqLd3Eec+ftPcLAyf8AAu3kSe0KsIgGF1g6Avqvo4VBylpYPOzGNSnyEe6mdbzD0ZmodMqY5x8PABJy2ljjzlaHqlhuz/J3zcWRoQ5SCBAHkpGuF7x/++j2wLxF4q1ctEaCFDA8WyF8wYiJypPtfRftTJxplzff+O1xGxML0aCSSUSsM181lXaEZb3HTSM8vHDKKEncCiMEvp chait@DESKTOP-7M81V2A"
}

output "my_public_ips" {
  value = aws_instance.webapache2[*].public_ip
}