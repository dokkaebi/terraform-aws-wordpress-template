resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0"

  key_name   = var.environment
  public_key = trimspace(tls_private_key.this.public_key_openssh)
}

resource "local_file" "ssh_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = ".tmp/${terraform.workspace}/id_rsa"
  file_permission = "0400"
}