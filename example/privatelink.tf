data "aws_region" "current" {}

module "ably_privatelink" {
  for_each                        = var.ably_vpc_service_endpoint_name
  source                          = "ably/terraform-aws-privatelink"
  version                         = "0.1.0"
  vpc_id                          = "ENTER_VPC_ID"
  ably_vpc_service_endpoint_name  = var.ably_vpc_service_endpoint_name[each.key]
  subnet_ids                      = ["ENTER_SUBNET_ID", "ENTER_SUBNET_ID", "ENTER_SUBNET_ID"]
  vpc_endpoint_sg_name            = "privatelink-vpc-endpoint"
  vpc_endpoint_sg_description     = "privatelink-vpc-endpoint"
  https_ingress_allowed_ipv4_cidr = ["ENTER_ALLOWED_IPV4_CIDR"]
  http_ingress_allowed_ipv4_cidr  = ["ENTER_ALLOWED_IPV4_CIDR"]
  https_ingress_allowed_ipv6_cidr = []
  http_ingress_allowed_ipv6_cidr  = []
  egress_allowed_ipv4_cidr        = ["ENTER_ALLOWED_IPV4_CIDR"]
  egress_allowed_ipv6_cidr        = ["ENTER_ALLOWED_IPV6_CIDR"]
}

module "ably_privatelink_dns" {
  for_each                             = var.region_config
  source                               = "ably/terraform-aws-privatelink-dns"
  version                              = "0.1.4"
  route53_private_zone_id              = aws_route53_zone.private.id
  ably_vpc_endpoint_dns_entry          = module.ably_privatelink[each.key].vpc_endpoint_dns_name
  ably_vpc_endpoint_dns_hosted_zone_id = module.ably_privatelink[each.key].vpc_endpoint_dns_hosted_zone_id
  dns_global_record                    = "example.com"
  regions                              = [each.key]
  azs                                  = toset(each.value)
  depends_on = [
    module.ably_privatelink
  ]
}
