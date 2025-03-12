# Configure provider
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

# Create a subnet
resource "aws_subnet" "subnet1" {
    vpc_id = data.aws_vpc.vpc.id
    cidr_block = var.cidr_block1

    tags = {
        Name = var.subnet1_name
    }
}

# Create a subnet
resource "aws_subnet" "subnet2" {
    vpc_id = data.aws_vpc.vpc.id
    cidr_block = var.cidr_block2

    tags = {
        Name = var.subnet2_name
    }
}

# Capture vpc_id in output variable
output "vpc_id" {
    value = data.aws_vpc.vpc.id
}

# Capture vpc_cidr_block in output variable
output "vpc_cidr_block" {
    value = data.aws_vpc.vpc.cidr_block
}