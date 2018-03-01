provider "aws" {
  region = "us-west-2"
  profile = "account-a"       # Profiles assumed to be in ~/.aws/credentials
}


module "multi-account-peering" {
  source  = "isaaguilar/multi-account-peering/aws"
  version = "0.1.0"
  
  auto_accept_peering = true
  name = "peering-example"
  
  
  # Requester Data
  
  this_vpc_id = "vpc-dac1daaf"
  route_table_ids = [ "rtb-05d22c6d", "rtb-17c51a6f" ]  # Set to [] to skip
  
  # Accepter Data
  
  peer_region = "us-east-1"
  peer_profile = "account-b"  # Profiles assumed to be in ~/.aws/credentials
  peer_vpc_id = "vpc-acc6bcff"
  destination_cidr_block = "10.0.1.0/24"
  
  tags = {
    ManagedWith = "terraform"
    Owner = "Isa Aguilar"
  }
}
  