/**
 * # dns-a-record
 *
 * This module is used for creating a DNS A-record.
 *
 */

data "aws_route53_zone" "parentzone" {
  name = var.dns_zone
}

resource "aws_route53_record" "subdomain_record" {
  zone_id = data.aws_route53_zone.parentzone.zone_id
  name    = var.subdomain
  type    = "A"
  ttl     = var.ttl
  records = [var.ip-address]
}

resource "aws_route53_record" "parent_record" {
  zone_id = data.aws_route53_zone.parentzone.zone_id
  name    = ""
  type    = "A"
  ttl     = var.ttl
  records = [var.ip-address]
}