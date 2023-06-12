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

  provisioner "remote-exec" {
    inline = [
      "touch hello1.txt",
      "echo 'helloworld remote provisioner' >> hello1.txt",
    ]
  }

  provisioner "file" {
    source      = "/home/krishiva/terraform/copy.txt"
    destination = "/home/ubuntu/test-file.txt"
  }

  provisioner "local-exec" {
    working_dir = "/home/krishiva/terraform/"
    interpreter = ["/bin/bash", "-c"]	
    command = "echo $VAR1 $VAR2 $VAR3 >> my_vars.txt"
    environment = {
      VAR1 = "my-value-1"
      VAR2 = "my-value-2"
      VAR3 = "my-value-3"
    }
    
  } 

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/krishiva/terraform/aws_key")
      timeout     = "4m"
   }
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
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
  tags = { Name = "Terraform_Generated" }
}


resource "aws_key_pair" "tester" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMjjdrBLXhF08OABkmdp21Ba6O2k96yunuTmKWS3Er/05+nE3fAFfytXvWxbX/0N3isdvA0oO4P8KrS551hVFyGLGPfKzAjceMzMYD0QWU/TJyd7syVv7n/QGlmdr9M7y+FBlxbEGJdB0R44YMrvA7qI7/QKWR6J6Y/8yIlJy/+f/kAqCfJPljs8dX9GGOfELlgCOAmWcmxGrjKVbwveeYUXCz4lleFazfJw6zFLh1r0SWkrsZuTTJ++z66HK83j6rcJnsqxHZEDIbwARpg0o0tiCIFqiK3eEEPedXrUqIovtlYVj+FJhwjcz3BBQALO9Jyhf9SAVVWY17VJ9/1ikL krishiva@DESKTOP-FAHNVP6"
}