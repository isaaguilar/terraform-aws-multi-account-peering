# Terraform AWS multi-account VPC peering module

Set up a peering connection, auto accept, and add to route tables. The request can be same account or between two different accounts.  


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
