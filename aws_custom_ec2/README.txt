Custom script for an Amazon Elastic Compute Cloud (EC2) using Terraform.

user_data attribute of the aws_instance resource allows you to specify data 
(such as a script) to configure the instance details.


provider "aws" {
   region     = "us-east-1"
   access_key = "AKIA27CR22N3OCTIFG3D"
   secret_key = "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"
}

resource "aws_instance" "custom_config" {

    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.micro"

  user_data = <<-EOF
      #!/bin/sh
      sudo apt-get update
      sudo apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this custom page built with Terraform User Data</h1></body></html>" > /var/www/html/index.html
      EOF
} 
