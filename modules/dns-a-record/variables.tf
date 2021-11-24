variable "dns_zone" {
  type        = string
  description = "parent DNS public hosted zone"
}

variable "subdomain" {
  type        = string
  description = "subdomain to create the DNS record for"
}

variable "ip-address" {
  type        = string
  description = "IP-address the DNS A-record should resolve to"
}

variable "ttl" {
  type        = string
  description = "time to live for the DNS record"
}