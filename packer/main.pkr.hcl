

packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "prod_ami" {

  region        = var.region
  instance_type = "t3.micro"
  ssh_username  = "ec2-user"
  ami_name      = var.ami_name
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["137112412989"]
    most_recent = true
  }
}

build {
  name    = "ami build"
  sources = ["source.amazon-ebs.prod_ami"]


  provisioner "file" {
    source      = "../website"
    destination = "/tmp/website/"
  }

  provisioner "shell" {
    script = "./setup.sh"
  }

}
