provider "aws" {
  region = var.region

  default_tags {
    tags = {

      for key, value in var.global_tags : key => value

    }

  }
}
