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
resource "aws_subnet" "subnet" {
    vpc_id = data.aws_vpc.vpc.id
    cidr_block = var.cidr_block

    tags = {
        Name = var.subnet_name
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