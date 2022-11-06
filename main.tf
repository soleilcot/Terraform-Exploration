provider "aws" {
    region = "us-east-2"
}

resource "aws_launch_configuration" "example" {
    image_id = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.instance.id]

    user_data = <<-E0F
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                E0F
    #This prevents terraform from destroying the old launch config before creating a new one upon modification
    #If this is not done, terraform will not be able to update the config, as the reference to the old config by the asg resource will prevent destruction
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_autoscaling_group" "example" {
    launch_configuration = aws_launch_configuration.example.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    min_size = 2
    max_size = 10

    tag {
      key = "Name"
      value = "terraform-asg-example"
      propagate_at_launch = true
    }
}


