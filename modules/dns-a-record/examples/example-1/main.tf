# DNS A record
module "dns-record" {
  source     = "./modules/dns-a-record"
  dns_zone   = var.dns_zone
  subdomain  = var.subdomain
  ip-address = module.wp-host.elastic_ip
  ttl        = "60"
}