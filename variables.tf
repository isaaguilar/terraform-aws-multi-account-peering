variable "peer_vpc_id" {
  description = ""
}

variable "this_vpc_id" {
  description = ""
}

variable "auto_accept_peering" {
  description = ""
  default = true
}

variable "name" {
  description = ""
}

variable "tags" {
  type = "map"
  description = ""
}

variable "route_table_ids" {
  description = ""
  type = "list"
  default = []
}

variable "destination_cidr_block" {
  description = ""
}

variable "peer_region" {
  description = ""
}

variable "peer_profile" {
  description = ""
}
