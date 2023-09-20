output "security_group_ids_nginx" {
  value = module.sg["nginx"].security_group_id
}

output "security_group_ids_alb" {
  value = module.sg["alb"].security_group_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets_ids" {
  value = module.vpc.public_subnets
}
