resource "aws_route53_zone" "private" {
  name = var.dns_global_record
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "ably-global" {
  zone_id = aws_route53_zone.private.zone_id
  name    = var.dns_global_record
  type    = "A"
  
  alias {
    name                   = var.ably_vpc_endpoint_dns_entry
    zone_id                = var.ably_vpc_endpoint_dns_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ably-regional" {
  zone_id = aws_route53_zone.private.zone_id
  name    = var.dns_regional_record
  type    = "CNAME"
  ttl     = var.dns_regional_record_ttl
  records = [var.ably_vpc_endpoint_dns_entry]
}

resource "aws_route53_record" "ably-zonal" {
  for_each = var.dns_zonal_config
  zone_id  = aws_route53_zone.private.zone_id
  name     = each.value["zonal_record"]
  type     = "CNAME"
  ttl      = var.dns_zonal_record_ttl
  records  = [replace(var.ably_vpc_endpoint_dns_entry, "/^([\\w-]+).(.*)$/", "$1-${each.key}.$2")]
}

