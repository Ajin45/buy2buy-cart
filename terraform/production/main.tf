module "vpc" {
  source       = "../Modules/vpc_module"
  project_name = var.project_name
  cidr-block   = var.cidr-block
  VpcNameTag   = var.VpcNameTag
  cidrnewbit   = var.cidrnewbit

}

module "ec2" {
  source  = "../Modules/ec2_module"
  vpc_id  = module.vpc.vpc_id
  sgports = var.sgports
  project_name = var.project_name
  public_subnets = module.vpc.public_subnets_ids
}
