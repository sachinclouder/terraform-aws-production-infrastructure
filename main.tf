module "vpc" {
  source = "./modules/vpc"

  project_name = "terraform-project"
  environment  = "dev"

  vpc_cidr = "10.0.0.0/16"

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  enable_nat_gateway = false
}

module "security_groups" {

  source = "./modules/security-groups"

  project_name = local.project_name

  environment = local.environment

  vpc_id = module.vpc.vpc_id

  ssh_allowed_cidrs = []
}

module "iam" {
  source = "./modules/iam"

  project_name = local.project_name
  environment  = local.environment
}

module "alb" {
  source = "./modules/alb"

  project_name = local.project_name
  environment  = local.environment

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_groups.alb_security_group_id

  target_port                = 80
  health_check_path          = "/"
  enable_deletion_protection = false
}