variable "server_port" {
    description = "Port number the web server hosted on example EC2 instance uses for HTTP requests"
    type = number
    default = 8080
}

#output "public_ip" {
#    value = aws_instance.example.public_ip
#    description = "The public IP of the example EC2 instance"
#}