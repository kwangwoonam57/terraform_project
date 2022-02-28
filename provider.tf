terraform {
  cloud {
    organization = "LGUplus-Internship-NGW"

    workspaces {
      name = "intern228572-workspace"
    }
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}