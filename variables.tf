variable "vpc_id" {
  description = "The ID of your VPC"
  type        = string
}

variable "ably_vpc_endpoint_dns_entry" {
  description = "The top level DNS entry exposed by your VPC Endpoint (Non-AZ version)"
  type        = string
}

variable "ably_vpc_endpoint_dns_hosted_zone_id" {
  description = "Hosted Zone ID for your VPC Endpoint"
  type        = string
}

variable "dns_global_record" {
  description = "The global DNS CNAME record that you wish to use in a Private DNS Hosted Zone. This should be discussed with Ably."
  type        = string
}

variable "dns_global_record_ttl" {
  description = "TTL Value in seconds for the global DNS CNAME record that you wish to use in a Private DNS Hosted Zone."
  type        = string
  default     = 60
}


variable "dns_regional_record" {
  description = "The regional DNS CNAME record that you wish to use in a Private DNS Hosted Zone. This should be discussed with Ably."
  type        = string
}

variable "dns_regional_record_ttl" {
  description = "TTL Value in seconds for the regional DNS CNAME record that you wish to use in a Private DNS Hosted Zone."
  type        = string
  default     = 60
}

variable "dns_zonal_config" {
  description = "Map containing AWS availability zone and relevant DNS records to use for each AZ."
  type        = map(map(string))
}

variable "dns_zonal_record_ttl" {
  description = "TTL Value in seconds for the zonal DNS CNAME record that you wish to use in a Private DNS Hosted Zone."
  type        = string
  default     = 60
}
