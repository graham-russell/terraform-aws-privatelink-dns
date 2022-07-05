---
id: ztz2g
name: Ably Route53 records for use with AWS PrivateLink Overview
file_version: 1.0.2
app_version: 0.9.1-5
file_blobs:
  example/privatelink.tf: 7a12e19a06c49a6a303cf682a2b4a0305bc0456f
  example/variables.tf: 4ad5ab26152c6aa44a41a459b2f2319a4fb2e088
---

Use this module to configure custom AWS Route53 DNS Records for using Ably over AWS PrivateLink. **NOTE:** You need an active Ably account and will need to engage with Ably's Partner & SRE teams to make use of this module. It will also require discussions about TLS certificates.

For PrivateLink documentation, see [AWS PrivateLink](https://aws.amazon.com/privatelink)

<br/>

the `ably_privatelink`[<sup id="1MxJ0U">↓</sup>](#f-1MxJ0U) module will create an AWS PrivateLink connection for you. See

[https://github.com/ably/terraform-aws-privatelink](https://github.com/ably/terraform-aws-privatelink)

for details of this.
<!-- NOTE-swimm-snippet: the lines below link your snippet to Swimm -->
### 📄 example/privatelink.tf
```tf
🟩 3      module "ably_privatelink" {
🟩 4        for_each                        = var.ably_vpc_service_endpoint_name
🟩 5        source                          = "ably/terraform-aws-privatelink"
🟩 6        version                         = "0.1.0"
🟩 7        vpc_id                          = "ENTER_VPC_ID"
🟩 8        ably_vpc_service_endpoint_name  = var.ably_vpc_service_endpoint_name[each.key]
🟩 9        subnet_ids                      = ["ENTER_SUBNET_ID", "ENTER_SUBNET_ID", "ENTER_SUBNET_ID"]
🟩 10       vpc_endpoint_sg_name            = "privatelink-vpc-endpoint"
🟩 11       vpc_endpoint_sg_description     = "privatelink-vpc-endpoint"
🟩 12       https_ingress_allowed_ipv4_cidr = ["ENTER_ALLOWED_IPV4_CIDR"]
🟩 13       http_ingress_allowed_ipv4_cidr  = ["ENTER_ALLOWED_IPV4_CIDR"]
🟩 14       https_ingress_allowed_ipv6_cidr = []
🟩 15       http_ingress_allowed_ipv6_cidr  = []
🟩 16       egress_allowed_ipv4_cidr        = ["ENTER_ALLOWED_IPV4_CIDR"]
🟩 17       egress_allowed_ipv6_cidr        = ["ENTER_ALLOWED_IPV6_CIDR"]
🟩 18     }
🟩 19     
🟩 20     module "ably_privatelink_dns" {
🟩 21       for_each                             = var.region_config
🟩 22       source                               = "ably/terraform-aws-privatelink-dns"
🟩 23       version                              = "0.1.4"
🟩 24       route53_private_zone_id              = aws_route53_zone.private.id
🟩 25       ably_vpc_endpoint_dns_entry          = module.ably_privatelink[each.key].vpc_endpoint_dns_name
🟩 26       ably_vpc_endpoint_dns_hosted_zone_id = module.ably_privatelink[each.key].vpc_endpoint_dns_hosted_zone_id
🟩 27       dns_global_record                    = "example.com"
🟩 28       regions                              = [each.key]
🟩 29       azs                                  = toset(each.value)
🟩 30       depends_on = [
🟩 31         module.ably_privatelink
🟩 32       ]
🟩 33     }
⬜ 34     
```

<br/>

An AWS region is required in order for the terraform provider to provision resources. A`default`[<sup id="Z2pUKis">↓</sup>](#f-Z2pUKis) value is set for this variable.
<!-- NOTE-swimm-snippet: the lines below link your snippet to Swimm -->
### 📄 example/variables.tf
```tf
🟩 1      variable "aws_region" {
🟩 2        description = "AWS Region to use"
🟩 3        type        = string
🟩 4        default     = "eu-west-1"
🟩 5      }
⬜ 6      
⬜ 7      variable "ably_vpc_service_endpoint_name" {
⬜ 8        description = "Map containing Ably VPC Endpoint Services"
```

<br/>

This variable includes a map of your Ably VPC endpoints. A `default`[<sup id="Z2pUKis">↓</sup>](#f-Z2pUKis) has been provided but is not valid. Your Ably Account manager will provide these to you during setup.
<!-- NOTE-swimm-snippet: the lines below link your snippet to Swimm -->
### 📄 example/variables.tf
```tf
⬜ 4        default     = "eu-west-1"
⬜ 5      }
⬜ 6      
🟩 7      variable "ably_vpc_service_endpoint_name" {
🟩 8        description = "Map containing Ably VPC Endpoint Services"
🟩 9        type        = map(string)
🟩 10       default = {
🟩 11         eu-west-1 = "com.amazonaws.vpce.eu-west-1.vpce-svc-XXXX"
🟩 12       }
🟩 13     }
⬜ 14     
⬜ 15     variable "region_config" {
⬜ 16       type        = map(list(string))
```

<br/>

You will need to provide a list of availability zones per region that you deploy your VPC endpoints in. In this case, we have a single region that has 3 AZs
<!-- NOTE-swimm-snippet: the lines below link your snippet to Swimm -->
### 📄 example/variables.tf
```tf
⬜ 15     variable "region_config" {
⬜ 16       type        = map(list(string))
⬜ 17       description = "Map(list) of regional information use for the privatelink dns module"
⬜ 18       default = {
🟩 19         eu-west-1 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
⬜ 20       }
⬜ 21     }
```

<br/>

<!-- THIS IS AN AUTOGENERATED SECTION. DO NOT EDIT THIS SECTION DIRECTLY -->
### Swimm Note

<span id="f-1MxJ0U">ably_privatelink</span>[^](#1MxJ0U) - "example/privatelink.tf" L3
```tf
module "ably_privatelink" {
```

<span id="f-Z2pUKis">default</span>[^](#Z2pUKis) - "example/variables.tf" L4
```tf
  default     = "eu-west-1"
```

<br/>

This file was generated by Swimm. [Click here to view it in the app](https://app.swimm.io/repos/Z2l0aHViJTNBJTNBdGVycmFmb3JtLWF3cy1wcml2YXRlbGluay1kbnMlM0ElM0FncmFoYW0tcnVzc2VsbA==/docs/ztz2g).