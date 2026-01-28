terraform {
  backend "s3" {
    bucket = "terr-statefile-bucket2"
    key    = "state/file.tfstate"
    region = "eu-north-1"
    dynamodb_table = "lock_table" 
    encrypt = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}