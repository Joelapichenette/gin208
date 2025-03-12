# Configure provider
provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "tls_private_key" "MC_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "MC_key" {
    content = tls_private_key.MC_key.private_key_pem
    filename = "${path.module}/MC_key.pem"
}

resource "aws_key_pair" "MC_key" {
    key_name = var.key_name
    public_key = tls_private_key.MC_key.public_key_openssh

    tags = {
        Name = var.key_name
    }
}