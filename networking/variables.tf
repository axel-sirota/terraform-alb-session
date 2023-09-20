variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR Block for VPC"
}

variable "vpc_public_subnet_count" {
  type        = number
  description = "Number of public subnets to create."
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map Public IP on subnet launch"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for every object"
}
