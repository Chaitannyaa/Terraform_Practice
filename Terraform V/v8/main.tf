provider "aws" {
   region     = "us-east-1"
}

module "webserver-1" {
  source = ".//module_1"
}

module "webserver-2" {
  source = ".//module_2"
}
