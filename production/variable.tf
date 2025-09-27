
variable "project_name" {
  type        = string
  description = "project_name"

}

variable "region" {

  type        = string
  description = "region"

}

variable "global_tags" {
  type        = map(string)
  description = "global-tags"

}


variable "cidr-block" {
  type        = string
  description = "vpc-cidr-block"

}

variable "VpcNameTag" {
  type        = string
  description = "vpc-tag"

}

variable "cidrnewbit" {
  type        = string
  description = "cidrnewbit"

}


variable "sgports" {
  type        = list(string)
  description = "ports"

}





