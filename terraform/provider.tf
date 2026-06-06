terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.95" }
  }
  #   backend "s3" {
  #     bucket  = "diabetes-mlops-tfstate-prod"
  #     key     = "prod/terraform.tfstate"
  #     region  = "us-east-1"
  #     profile = "prod"
  #   }
}

provider "aws" {
  region  = "us-east-1"
  profile = "dev"
}
