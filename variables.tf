variable "server_port" {
    description = "Port number the web server hosted on example EC2 instance uses for HTTP requests"
    type = number
    default = 8080
}

output "alb_dns_name" {
    value = aws_lb.example.dns_name
    description = "The domain name of the ALB"
}