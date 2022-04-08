# Ably Privatelink DNS

Use this module to configure custom AWS Route53 DNS Records for using Ably over AWS PrivateLink.

**NOTE:** You need an active Ably account and will need to engage with Ably's Partner & SRE teams to make use of this module. It will also require discussions about TLS certificates.

For PrivateLink documentation, see [AWS PrivateLink](https://aws.amazon.com/privatelink)

## Usage

```terraform
module "ably_privatelink" {
  source                          = "ably/terraform-aws-privatelink"
  version                         = "0.1.0"
  vpc_id                          = "vpc_id"
  ably_vpc_service_endpoint_name  = "vpc_service_endpoint"
  subnet_ids                      = ['subnet_id']
  vpc_endpoint_sg_name            = "ably-privatelink-vpc-endpoint-sg"
  vpc_endpoint_sg_description     = "Ably PrivateLink VPC Endpoint SG"
  https_ingress_allowed_ipv4_cidr = ["10.0.0.0/8"]
  http_ingress_allowed_ipv4_cidr  = ["10.0.0.0/8"]
  https_ingress_allowed_ipv6_cidr = []
  http_ingress_allowed_ipv6_cidr  = []
  egress_allowed_ipv4_cidr        = ["0.0.0.0/0"]
  egress_allowed_ipv6_cidr        = ["::/0"]
}

module "ably_privatelink_dns" {
  source                               = "ably/terraform-aws-privatelink-dns"
  version                              = "0.1.0"
  vpc_id                               = "vpc_id"
  ably_vpc_endpoint_dns_entry          = module.ably_privatelink.vpc_endpoint_dns_name
  ably_vpc_endpoint_dns_hosted_zone_id = module.ably_privatelink.vpc_endpoint_dns_hosted_zone_id
  dns_global_record                    = "example.com"
  dns_regional_record                  = "eu-west-1.example.com"
  dns_zonal_config                     = var.vpc_config[var.aws_region]["zonal_config"]
}
```

Zonal config variable referenced above should be of type map(map(string))
Example
```terraform
zonal_config = {
        eu-west-1a = {
          zonal_record = "eu-west-1a.example.com",
        }
        eu-west-1b = {
          zonal_record = "eu-west-1b.example.com"
        }
        eu-west-1c = {
          zonal_record = "eu-west-1c.example.com"
        }
      }
```

## Requirements

| Name | Version |
|------|---------|
| aws | ~> 3.20 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.20 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ably\_vpc\_endpoint\_dns\_entry | The top level DNS entry exposed by your VPC Endpoint (Non-AZ version) | `string` | n/a | yes |
| ably\_vpc\_endpoint\_dns\_hosted\_zone\_id | Hosted Zone ID for your VPC Endpoint | `string` | n/a | yes |
| dns\_global\_record | The global DNS CNAME record that you wish to use in a Private DNS Hosted Zone. This should be discussed with Ably. | `string` | n/a | yes |
| dns\_global\_record\_ttl | TTL Value in seconds for the global DNS CNAME record that you wish to use in a Private DNS Hosted Zone. | `string` | `60` | no |
| dns\_regional\_record | The regional DNS CNAME record that you wish to use in a Private DNS Hosted Zone. This should be discussed with Ably. | `string` | n/a | yes |
| dns\_regional\_record\_ttl | TTL Value in seconds for the regional DNS CNAME record that you wish to use in a Private DNS Hosted Zone. | `string` | `60` | no |
| dns\_zonal\_config | Map containing AWS availability zone and relevant DNS records to use for each AZ. | `map(map(string))` | n/a | yes |
| dns\_zonal\_record\_ttl | TTL Value in seconds for the zonal DNS CNAME record that you wish to use in a Private DNS Hosted Zone. | `string` | `60` | no |
| vpc\_id | The ID of your VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| custom\_ably\_global\_record | ID of the global DNS record |
| custom\_ably\_regional\_record | ID of the regional DNS record |
| custom\_ably\_zonal\_records | List of IDs for zonal DNS records |
| phz\_zone\_id | ID of the Route53 Private DNS Zone |

