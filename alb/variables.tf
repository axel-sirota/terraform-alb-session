variable "bucket_id" {
  type        = string
  description = "Id of the S3 bucket"
}

variable "elb_service_account_arn" {
  type        = string
  description = "ARN of Load Balancer"
}

variable "bucket_name" {
  type        = string
  description = "Name of S3 Bucket"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all objects"
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC"
}

variable "public_subnets_ids" {
  type        = list(string)
  description = "Public subnet ids"
}

variable "security_groups_alb" {
  type        = list(string)
  description = "Ids of security groups"
}

variable "common_tags" {
  description = "Common tags for all objects"
}

variable "instance_ids" {
  type        = list(string)
  description = "Ids of the instances to load balance"
}
