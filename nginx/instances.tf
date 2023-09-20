data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "aws_subnets" "subnets" {
  filter {
    name   = "subnet-id"
    values = var.public_subnets_ids
  }
}

module "ec2_instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "5.5.0"
  count                  = var.instance_count
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.nginx_profile.name
  monitoring             = true
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = data.aws_subnets.subnets.ids[(count.index % var.vpc_public_subnet_count)]
  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-nginx-${count.index}"
  })
  user_data = templatefile(var.startup_script_location, {
    s3_bucket_name = var.bucket_id
  })
}
