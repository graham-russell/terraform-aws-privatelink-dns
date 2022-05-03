resource "aws_route53_record" "ably-global" {
  for_each = toset(var.regions)
  zone_id  = var.route53_private_zone_id
  name     = var.dns_global_record

  latency_routing_policy {
    region = each.key
  }

  set_identifier = each.key

  type = "A"

  alias {
    name                   = var.ably_vpc_endpoint_dns_entry
    zone_id                = var.ably_vpc_endpoint_dns_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ably-regional" {
  for_each = toset(var.regions)
  zone_id  = var.route53_private_zone_id
  name     = "${each.key}.${var.dns_global_record}"
  type     = "CNAME"
  ttl      = var.dns_regional_record_ttl
  records  = [var.ably_vpc_endpoint_dns_entry]
}

resource "aws_route53_record" "ably-zonal" {
  for_each = toset(var.azs)
  zone_id  = var.route53_private_zone_id
  name     = "${each.key}.${var.dns_global_record}"
  type     = "CNAME"
  ttl      = var.dns_zonal_record_ttl
  records  = [replace(var.ably_vpc_endpoint_dns_entry, "/^([\\w-]+).(.*)$/", "$1-${each.key}.$2")]
}
