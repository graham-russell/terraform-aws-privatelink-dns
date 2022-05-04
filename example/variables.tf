variable "aws_region" {
  description = "AWS Region to use"
  type        = string
  default     = "eu-west-1"
}

variable "ably_vpc_service_endpoint_name" {
  description = "Map containing Ably VPC Endpoint Services"
  type        = map(string)
  default = {
    eu-west-1 = "com.amazonaws.vpce.eu-west-1.vpce-svc-XXXX"
  }
}

variable "region_config" {
  type        = map(list(string))
  description = "Map(list) of regional information use for the privatelink dns module"
  default = {
    eu-west-1 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  }
}
