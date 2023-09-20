module "networking" {
  source                  = "./networking"
  enable_dns_hostnames    = var.enable_dns_hostnames
  naming_prefix           = local.naming_prefix
  vpc_cidr_block          = var.vpc_cidr_block
  vpc_public_subnet_count = var.vpc_public_subnet_count
  common_tags             = local.common_tags
  map_public_ip_on_launch = var.map_public_ip_on_launch
}

module "s3" {
  source          = "./s3"
  bucket_name     = "${local.naming_prefix}-s3-bucket"
  common_tags     = local.common_tags
  website_content = fileset(path.root, "website/*")
}

module "nginx" {
  source                  = "./nginx"
  bucket_name             = module.s3.bucket_name
  common_tags             = local.common_tags
  instance_count          = var.instance_count
  instance_type           = var.instance_type
  naming_prefix           = local.naming_prefix
  vpc_security_group_ids  = [module.networking.security_group_ids_nginx]
  bucket_id               = module.s3.bucket_id
  startup_script_location = "${path.root}/templates/startup_script.tpl"
  vpc_id                  = module.networking.vpc_id
  vpc_public_subnet_count = var.vpc_public_subnet_count
  public_subnets_ids      = module.networking.public_subnets_ids
}

data "aws_elb_service_account" "root" {}

module "alb" {
  depends_on              = [module.networking, module.nginx, module.s3]
  source                  = "./alb"
  bucket_id               = module.s3.bucket_id
  bucket_name             = module.s3.bucket_name
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  naming_prefix           = local.naming_prefix
  vpc_id                  = module.networking.vpc_id
  instance_ids            = module.nginx.instance_ids
  common_tags             = local.common_tags
  public_subnets_ids      = module.networking.public_subnets_ids
  security_groups_alb     = [module.networking.security_group_ids_alb]
}
