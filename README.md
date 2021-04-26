# Terraform AWS multi-account VPC peering module

Set up a peering connection, auto accept, and add to route tables. The request
can be same account or between two different accounts.


## Usage

```
provider "aws" {
  region = "us-west-2"
  profile = "account-a"
}

module "multi-account-peering" {
  source  = "isaaguilar/multi-account-peering/aws"
  version = "0.1.0"

  auto_accept_peering   = true
  name                  = "peering-example"

  # Requester Data
  this_vpc_id           = "vpc-dac1daaf"
  this_cidr_block       = "10.0.0.0/24"
  this_route_table_ids  = [ "rtb-05d22c6d", "rtb-17c51a6f" ]  # Set [] to skip

  # Accepter Data
  peer_region           = "us-east-1"
  peer_profile          = "account-b"
  peer_vpc_id           = "vpc-acc6bcff"
  peer_cidr_block       = "10.0.1.0/24"
  peer_route_table_ids  = []

  tags = {
    ManagedWith = "terraform"
    Owner = "Isa Aguilar"
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.peer"></a> [aws.peer](#provider\_aws.peer) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route.peer_route_tables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.route_tables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_caller_identity.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_accept_peering"></a> [auto\_accept\_peering](#input\_auto\_accept\_peering) | Whether to auto-accept the peering request | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the peering connection | `any` | n/a | yes |
| <a name="input_peer_cidr_block"></a> [peer\_cidr\_block](#input\_peer\_cidr\_block) | CIDR block of the peer | `any` | n/a | yes |
| <a name="input_peer_profile"></a> [peer\_profile](#input\_peer\_profile) | Profile of the peer | `any` | n/a | yes |
| <a name="input_peer_region"></a> [peer\_region](#input\_peer\_region) | Region of the peer | `any` | n/a | yes |
| <a name="input_peer_route_table_ids"></a> [peer\_route\_table\_ids](#input\_peer\_route\_table\_ids) | Route table IDs of the peer | `list(any)` | `[]` | no |
| <a name="input_peer_vpc_id"></a> [peer\_vpc\_id](#input\_peer\_vpc\_id) | VPC ID of the peer | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply | `map(string)` | n/a | yes |
| <a name="input_this_cidr_block"></a> [this\_cidr\_block](#input\_this\_cidr\_block) | CIDR block of the requestor | `any` | n/a | yes |
| <a name="input_this_route_table_ids"></a> [this\_route\_table\_ids](#input\_this\_route\_table\_ids) | Route table IDs of the requestor | `list(any)` | `[]` | no |
| <a name="input_this_vpc_id"></a> [this\_vpc\_id](#input\_this\_vpc\_id) | VPC ID of the requestor | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
