terraform {
  backend "s3" {
    bucket = "terr-statefile-bucket"
    key    = "state/file.tfstate"
    region = "eu-north-1"
    dynamodb_table = "lock_table" 
    encrypt = true
  }
}

provider "aws" {
  region = "eu-north-1"
}