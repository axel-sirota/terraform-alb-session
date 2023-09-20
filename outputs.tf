output "aws_alb_public_dns" {
  value       = "http://${module.alb.dns_name}"
  description = "Public DNS for the application load balancer"
}
