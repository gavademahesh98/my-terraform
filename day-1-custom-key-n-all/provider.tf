terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.63.0"
    }
  }
}

provider "aws" {
   region = "ap-southeast-1"
   profile = "dev"

}