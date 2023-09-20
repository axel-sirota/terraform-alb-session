variable "bucket_name" {
  type        = string
  description = "Name of the bucket to host the website"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to all objects"
}

variable "instance_count" {
  type        = number
  description = "Number of instances"
}

variable "instance_type" {
  type        = string
  description = "Type of instance to launch"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC"
}


variable "vpc_public_subnet_count" {
  type        = number
  description = "Number of subnets in VPC"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group ids to attach nginx instances"
}

variable "bucket_id" {
  type        = string
  description = "Id of the bucket created"
}

variable "startup_script_location" {
  type        = string
  description = "Path to startup script"
}

variable "public_subnets_ids" {
  type        = list(string)
  description = "List of IDs of public subnets"
}
