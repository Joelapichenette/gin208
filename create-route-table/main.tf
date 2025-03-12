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

# Read subnet source
data "aws_subnet" "subnet" {
    filter {
        name = "tag:Name"
        values = var.subnet_name
    }
}

# Create a gw
resource "aws_internet_gateway" "gw" {
    vpc_id = data.aws_vpc.vpc.id

    tags = {
        Name = var.gw_name
    }
}

resource "aws_route_table" "rt" {
    vpc_id = data.aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

    tags = {
        Name = var.rt_name
    }
}

resource "aws_route_table_association" "a" {
    subnet_id = data.aws_subnet.subnet.id
    route_table_id = aws_route_table.rt.id
}

# Capture vpc_id in output variable
output "vpc_id" {
    value = data.aws_vpc.vpc.id
}

# Capture vpc_cidr_block in output variable
output "vpc_cidr_block" {
    value = data.aws_vpc.vpc.cidr_block
}