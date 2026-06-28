terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.52.0"
    }
  }
  backend "local" {
    
  }
  #backend "s3" {
  #  bucket = "cybr-backet-lab-name-90989"
  #  key = "terraform.tfstate"
  #  region = "ap-south-1"
  #}
}

provider "aws" {
  region = var.aws_region
  # Configuration options
}
