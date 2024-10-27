terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "test-instance" {
  ami = "ami-0acc77abdfc7ed5a6"
  //key_name          = key_name
  instance_type = "t2.micro"
  security_groups   = [var.security_group]

  tags = {
    name = "test-instance"
  }
}
