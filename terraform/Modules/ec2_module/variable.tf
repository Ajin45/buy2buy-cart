variable "vpc_id" {
  type        = string
  description = "vpc_id from vpc module"
}

variable "sgports" {
  type        = list(string)
  description = "ports"

}

variable "project_name" {
  type        = string
  description = "project_name"

}

variable "public_subnets" {
    type = list(string)
    description = "public subnets from vpc module"
}
