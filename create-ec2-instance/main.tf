# Configure provider
provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

data "aws_security_group" "allow_ssh" {
    name = "allow_ssh"

    filter {
        name = "tag:Name"
        values = [var.sg_name]
    }
}

data "aws_key_pair" "kp" {
    key_name = var.key_name
}

data "aws_subnet" "subnet" {
    filter {
        name = "tag:Name"
        values = [var.subnet_name]
    }
}

data "aws_ami" "ubuntu" {
    owners = [var.owners_name]
    filter {
        name = "architecture"
        values = [var.architecture]
    }

    filter {
        name = "name"
        values = [var.ami_name]
    }
}

resource "aws_instance" "MC_instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.medium"
    key_name = data.aws_key_pair.kp.key_name
    vpc_security_group_ids = [ data.aws_security_group.allow_ssh.id ]
    subnet_id = data.aws_subnet.subnet.id
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = var.instance_name
    }
}

output "public_ip" {
    value = aws_instance.MC_instance.public_ip
}