module "alb" {
  source                = "terraform-aws-modules/alb/aws"
  version               = "~> 8.0"
  name                  = "${var.naming_prefix}-alb"
  load_balancer_type    = "application"
  vpc_id                = var.vpc_id
  subnets               = var.public_subnets_ids
  security_groups       = var.security_groups_alb
  create_security_group = false

  access_logs = {
    bucket  = var.bucket_id
    prefix  = "alb-logs"
    enabled = true
  }

  target_groups = [
    {
      name_prefix      = "TG-app"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"

      #####################################################################
      ### There is a bug right now in Terraform 1.4 that prevents from    #
      ### using the correct for expression dynamically to add the targets #
      ### So, we must statically add them, of course this will be fixed   #
      #####################################################################
      targets = {
        my_target = {
          target_id = var.instance_ids[0]
          port      = 80
        }
        my_target2 = {
          target_id = var.instance_ids[1]
          port      = 80
        }
      }
      #######################################################
      ### This is how it should be done and it should work  #
      #######################################################

      //      targets = { for instance_id in var.instance_ids :
      //        "target-${uuid()}" => {
      //          target_id = instance_id
      //          port      = 80
      //        }
      //      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = var.common_tags
}
