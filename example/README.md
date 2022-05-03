# Ably AWS PrivateLink DNS Module Example

Provides an example of how to deploy an Interface VPC Endpoint and Ably DNS setup. See repository readme for pre-requisites.  
You will also need to provide AWS credentials to be able to plan/apply this. Documentation on how to authenticate with AWS when using terraform is here [AWS Provider Auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)

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
| ably\_vpc\_service\_endpoint\_name | Map containing Ably VPC Endpoint Services | `map(string)` | <pre>{<br>  "eu-west-1": "com.amazonaws.vpce.eu-west-1.vpce-svc-XXXX"<br>}</pre> | no |
| aws\_region | AWS Region to use | `string` | `"eu-west-1"` | no |
| region\_config | Map(list) of regional information use for the privatelink dns module | `map(list(string))` | <pre>{<br>  "eu-west-1": [<br>    "eu-west-1a",<br>    "eu-west-1b",<br>    "eu-west-1c"<br>  ]<br>}</pre> | no |

## Outputs

No output.

