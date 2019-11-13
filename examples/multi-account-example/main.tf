provider "aws" {
  region  = "us-west-2"
  profile = "account-a" # Profiles assumed to be in ~/.aws/credentials
}

module "multi-account-peering" {
  source = "../../"

  auto_accept_peering = true
  name                = "peering-example"

  # Requester Data

  this_vpc_id          = "vpc-dac1daaf"
  this_cidr_block      = "10.0.0.0/24"
  this_route_table_ids = ["rtb-05d22c6d", "rtb-17c51a6f"] # Set [] to skip

  # Accepter Data

  peer_region          = "us-east-1"
  peer_profile         = "account-b" # Profiles assumed to be in ~/.aws/credentials
  peer_vpc_id          = "vpc-acc6bcff"
  peer_cidr_block      = "10.0.1.0/24"
  peer_route_table_ids = []

  tags = {
    ManagedWith = "terraform"
    Owner       = "Isa Aguilar"
  }
}

