variable "name" {
  description = ""
}

variable "auto_accept_peering" {
  description = ""
  default = true
}

variable "tags" {
  type = "map"
  description = ""
}

####################
## Requester Info ##
####################

variable "this_vpc_id" {
  description = ""
}

variable "this_cidr_block" {
  description = ""
}

variable "this_route_table_ids" {
  description = ""
  type = "list"
  default = []
}

###################
## Accepter Info ##
###################

variable "peer_vpc_id" {
  description = ""
}

variable "peer_region" {
  description = ""
}

variable "peer_profile" {
  description = ""
}

variable "peer_cidr_block" {
  description = ""
}

variable "peer_route_table_ids" {
  description = ""
  type = "list"
  default = []
}

