output "lb_dns_name" {
  value       = "http://${aws_lb.terraform-alb.dns_name}"
  description = "the urs for the web load balancer"
}
