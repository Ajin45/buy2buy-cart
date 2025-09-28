variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "ami_name" {
  type    = string
  default = "packer-ami-{{timestamp}}"
}
