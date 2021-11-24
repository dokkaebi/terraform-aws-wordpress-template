resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "v0.6.0"

  key_name   = var.environment
  public_key = tls_private_key.this.public_key_openssh

  tags = {
    Environment = var.environment
  }
}

resource "local_file" "ssh_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = ".tmp/id_rsa"
  file_permission = "0400"
}