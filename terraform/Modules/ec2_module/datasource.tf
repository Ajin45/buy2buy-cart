


data "aws_ami" "ami_from_packer" {

  most_recent = true

  filter {
    name  = "name"
    values = ["packer-ami-*"]
  }

  owners = ["self"]
}


data "aws_key_pair" "study_key" {
  filter {
    name  = "key-name"
    values = ["study-key"]
  }

}

