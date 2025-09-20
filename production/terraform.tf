terraform {
  backend "s3" {
    bucket  = "ajin.terraform.backend"
    key     = "env/production/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

