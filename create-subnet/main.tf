# Configure provider
provider "aws" {
    region = ""
    access_key = ""
    secret_key = ""
}

# Create a subnet
resource "aws_subnet" "subnet" {
    vpc_id = ""
    cidr_block = ""

    tags = {
        Name = ""
    }
}

