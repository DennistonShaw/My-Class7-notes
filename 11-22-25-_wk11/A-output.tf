output "lb_dns_name" {
  value       = "http://${aws_lb.terraform-alb.dns_name}"
  description = "The DNS name of the terraform Load Balancer."
}