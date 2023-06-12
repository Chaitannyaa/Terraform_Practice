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

resource "local_file" "DevOps" {
        filename = "C:/Users/Chait/Desktop/Terrform/remote_state_management/terra_generated.txt"
        content = "I am a DevOps engineer, who knows terraform very well"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "chaitannyaa-terraform-state-bucket"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}

terraform {
  backend "s3" {
    bucket = "chaitannyaa-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
