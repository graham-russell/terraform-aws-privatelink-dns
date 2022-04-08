output "phz_zone_id" {
  description = "ID of the Route53 Private DNS Zone"
  value       = aws_route53_zone.private.id
}

output "custom_ably_global_record" {
  description = "ID of the global DNS record"
  value       = aws_route53_record.ably-global.id
}

output "custom_ably_regional_record" {
  description = "ID of the regional DNS record"
  value       = aws_route53_record.ably-regional.id
}

output "custom_ably_zonal_records" {
  description = "List of IDs for zonal DNS records"
  value       = [for k in aws_route53_record.ably-zonal : k.id]
}
