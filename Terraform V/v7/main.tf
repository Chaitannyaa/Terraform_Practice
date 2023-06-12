provider "aws" {
   region     = "us-east-1"
   access_key = "AKIA27CR22N3OCTIFG3D"
   secret_key = "2hLr2FAZ9xUwf2h9Ay+kxHESK689pRcUApAfTwAm"
   
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0557a15b87f6559cf"  
    instance_type = "t2.micro" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]
    tags = { Name = "Ubuntu test" }

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/krishiva/terraform/aws_key")
      timeout     = "4m"
   }
}

locals {
   ingress_rules = [{
      port        = 443
      description = "Ingress rules for port 443"
   },
   {
      port        = 22
      description = "Ingree rules for port 22"
   }]
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
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
  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
         description = ingress.value.description
         from_port   = ingress.value.port
         to_port     = ingress.value.port
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
      }
   }
  tags = { Name = "Terraform_Generated" }
}


resource "aws_key_pair" "tester" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4VoZdA/PF1y5dz5G5vbbIMClRf2ZxqC0HuDtenRWes9d7thX2F6eakX3tTRD/7KLhfnu/oPir+/gQs2Eto/MGOlITkzEFVWsqrwq84ZPvM6ejRQRcB9gGzTQzIGKYTabTlmXvykAfhAdkN4aIThpgGhtzHOQ0PK54v4y20rb3K1zlxz1ICqqJiwB+A4mxlgzNBJKVhAXmeqjDn/AEfwJY20J0lEHmNkOUFeacTr24csG/CVv/K2AvUMs7HCTRw8X+oHgWZ9wFN/Sh0DkUREbq2tHqFhfEiumtT6z+CKxF3EkW0O4cO7ugOiD5xyZZdDe3Lj37FgNxdOGV0iFA7KBH krishiva@DESKTOP-FAHNVP6"
}
