output "ip_address" {
  value = aws_instance.my-working-server.public_ip
}

output "website_url" {
  value = "http://${aws_instance.my-working-server.public_dns}"
}