data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  name    = "${var.naming_prefix}-vpc"
  cidr    = var.vpc_cidr_block
  azs     = slice(data.aws_availability_zones.available.names, 0, var.vpc_public_subnet_count)
  # Assumes 8 bits to be added to the CIDR range for the VPC
  public_subnets          = [for subnet in range(var.vpc_public_subnet_count) : cidrsubnet(var.vpc_cidr_block, 8, subnet)]
  enable_nat_gateway      = false
  enable_vpn_gateway      = false
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enable_dns_hostnames    = var.enable_dns_hostnames
  tags                    = var.common_tags
}

module "sg" {
  for_each = {
    nginx = "nginx_sg"
    alb   = "nginx_alb_sg"
  }
  source              = "terraform-aws-modules/security-group/aws//modules/http-80"
  version             = "5.1.0"
  name                = "${var.naming_prefix}-${each.value}"
  description         = "Security group for ${each.key} with HTTP ports open within VPC"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = [each.key == "nginx" ? var.vpc_cidr_block : "0.0.0.0/0"]
}

data "aws_subnets" "subnets" {
  filter {
    name   = "subnet-id"
    values = module.vpc.public_subnets
  }
}

data "aws_subnet" "subnet" {
  count = var.vpc_public_subnet_count
  id    = data.aws_subnets.subnets.ids[count.index]
}
