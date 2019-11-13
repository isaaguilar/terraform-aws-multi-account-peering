# Accepter's credentials
provider "aws" {
  alias   = "peer"
  region  = var.peer_region
  profile = var.peer_profile
}

data "aws_caller_identity" "peer" {
  provider = aws.peer
}

data "aws_region" "peer" {
  provider = aws.peer
}

########################
# Initiate the request #
########################
resource "aws_vpc_peering_connection" "this" {
  vpc_id        = var.this_vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = data.aws_region.peer.id
  auto_accept   = false
  tags = merge(
    var.tags,
    {
      "Name" = format("%s-peering-requester", var.name)
    },
  )
}

######################
# Accept the request #
######################
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = var.auto_accept_peering
  tags = merge(
    var.tags,
    {
      "Name" = format("%s-peering-accepter", var.name)
    },
  )
}

########################
# Routes for requester #
########################
resource "aws_route" "route_tables" {
  count                     = length(var.this_route_table_ids)
  route_table_id            = element(var.this_route_table_ids, count.index)
  destination_cidr_block    = var.peer_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  depends_on                = [aws_vpc_peering_connection.this]
}

########################
# Routes for accepter  #
########################
resource "aws_route" "peer_route_tables" {
  provider                  = aws.peer
  count                     = length(var.peer_route_table_ids)
  route_table_id            = element(var.peer_route_table_ids, count.index)
  destination_cidr_block    = var.this_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  depends_on                = [aws_vpc_peering_connection.this]
}

