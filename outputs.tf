output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_id
}

output "alb_security_group_id" {
  value = module.security_groups.alb_security_group_id
}

output "management_security_group_id" {
  value = module.security_groups.management_security_group_id
}

output "application_security_group_id" {
  value = module.security_groups.application_security_group_id
}

output "ec2_iam_role_name" {
  value = module.iam.ec2_role_name
}

output "ec2_instance_profile_name" {
  value = module.iam.ec2_instance_profile_name
}