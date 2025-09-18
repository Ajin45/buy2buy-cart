module "vpc" {
  source       = "../Modules/vpc_module"
  project_name = var.project_name
  cidr-block   = var.cidr-block
  VpcNameTag   = var.VpcNameTag
}
