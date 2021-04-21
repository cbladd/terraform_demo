
provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "instance" {
  source            = "./modules/instance"
  depends_on        = [module.vpc]
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.vpc.ssh_security_group_id
}

module "rds" {
  source = "./modules/rds"
  depends_on = [module.vpc]
  private_subnet_ids = module.vpc.private_subnet_ids
  ssh_security_group_id = module.vpc.ssh_security_group_id
  vpc_security_group_id = module.vpc.vpc_security_group_id
}

