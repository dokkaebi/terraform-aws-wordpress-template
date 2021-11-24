<!-- BEGIN_TF_DOCS -->
# dns-a-record

This module is used for creating a DNS A-record.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_zone | parent DNS public hosted zone | `string` | n/a | yes |
| ip-address | IP-address the DNS A-record should resolve to | `string` | n/a | yes |
| subdomain | subdomain to create the DNS record for | `string` | n/a | yes |
| ttl | time to live for the DNS record | `string` | n/a | yes |

## Outputs

No outputs.



Example
---
**NOTE**
---
```hcl
# DNS A record
module "dns-record" {
  source     = "./modules/dns-a-record"
  dns_zone   = var.dns_zone
  subdomain  = var.subdomain
  ip-address = module.wp-host.elastic_ip
  ttl        = "60"
}
```
<!-- END_TF_DOCS -->