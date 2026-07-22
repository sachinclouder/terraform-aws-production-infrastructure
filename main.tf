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

  certificate_arn            = module.acm.certificate_arn
  target_port                = 80
  health_check_path          = "/"
  enable_deletion_protection = false
}

module "autoscaling" {
  source = "./modules/autoscaling"

  project_name = local.project_name
  environment  = local.environment

  private_subnet_ids            = module.vpc.private_subnet_ids
  application_security_group_id = module.security_groups.application_security_group_id
  instance_profile_name         = module.iam.ec2_instance_profile_name
  target_group_arn              = module.alb.target_group_arn

  instance_type    = "t3.micro"
  min_size         = 1
  desired_capacity = 1
  max_size         = 2

  cpu_target_value = 50
}

module "monitoring" {
  source = "./modules/monitoring"

  project_name = local.project_name
  environment  = local.environment

  notification_email = "sachinclouder@gmail.com"

  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
}

module "acm" {
  source = "./modules/acm"

  domain_name = "aws.sachinkhokhar.cloud"

  project_name = local.project_name
  environment  = local.environment
}