provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

# Read vpc resource
data "aws_vpc" "vpc" {
    filter {
        name = "tag:Name"
        values = var.vpc_name
    }
}

resource "aws_security_group" "allow_ssh" {
    name = "allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id = data.aws_vpc.vpc.id

    ingress {
        description = "SSH for IPv4"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Web HTTP"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow all outgoing traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.sec_grp_name
    }
}