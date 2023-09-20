output "instance_ids" {
  value = module.ec2_instance[*].id
}
