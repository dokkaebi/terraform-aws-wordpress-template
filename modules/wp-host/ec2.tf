module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3"

  name        = "${var.project}-${var.environment}-wp-host"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.initial_cidr_blocks
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

# Runs a daily Lambda to add cloudflare ips to sg rules
module "cloudflare_ips" {
  source = "github.com/orzarchi/terraform-aws-cloudflare-security-group"
  security_group_id = "${module.security_group.security_group_id}"
}

resource "aws_eip" "wp-eip" {
  tags = {
    Name = "${var.project}-${var.environment}-wp-host-eip"
  }
  domain = "vpc"
}

resource "aws_eip_association" "wp-eip-association" {
  instance_id   = var.spot_enabled ? module.ec2_instance.spot_instance_id : module.ec2_instance.id
  allocation_id = aws_eip.wp-eip.id
}

# Want to avoid ami updates forcing replacement, but can't use `lifecycle` with community module
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.7"

  name = "${var.project}-${var.environment}-spot-instance"

  create_spot_instance = var.spot_enabled
  spot_price           = "0.60"
  spot_type            = "persistent"

  ami                         = data.aws_ami.ubuntu.id
  iam_instance_profile        = aws_iam_instance_profile.profile.name
  instance_type               = var.instance_type
  key_name                    = module.key_pair.key_pair_name
  monitoring                  = false
  vpc_security_group_ids      = [module.security_group.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  availability_zone = var.availability_zone

  user_data = templatefile("${path.module}/userdata/userdata.wp.sh", {
    ZONE_NAME      = var.zone_name
    SUBDOMAIN      = var.subdomain
    TRAEFIK_CONFIG = file("${path.module}/config/traefik.yaml")
    TLS_CRT        = var.tls_server_crt
    TLS_KEY        = var.tls_server_key
    UPLOADS_INI    = file("${path.module}/config/uploads.ini")
    DB_HOST        = var.db_host
    DB_PWD         = var.db_password
    DB_USER        = var.db_user_name
    DB_NAME        = var.db_name
    MAILERSEND_SMTP_PASSWORD = var.mailersend_smtp_password
  })

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 20
    },
  ]

  tags = {
    Name        = "${var.project}-${var.environment}-wp"
  }
}