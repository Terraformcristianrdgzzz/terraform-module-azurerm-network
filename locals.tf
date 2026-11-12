locals {
  ipv4_network_start = {
    for prefix in distinct(concat(var.vnet_address_space, var.subnet_prefixes)) :
    prefix => try(
      sum([
        for octet_index, octet in split(".", cidrhost(prefix, 0)) :
        tonumber(octet) * pow(256, 3 - octet_index)
      ]),
      -1
    )
  }

  ipv4_network_end = {
    for prefix in distinct(concat(var.vnet_address_space, var.subnet_prefixes)) :
    prefix => try(
      local.ipv4_network_start[prefix] + pow(2, 32 - tonumber(split("/", prefix)[1])) - 1,
      -1
    )
  }

  subnet_prefixes_fit_vnet = alltrue([
    for subnet_prefix in var.subnet_prefixes :
    anytrue([
      for vnet_prefix in var.vnet_address_space :
      try(
        tonumber(split("/", subnet_prefix)[1]) >= tonumber(split("/", vnet_prefix)[1]) &&
        local.ipv4_network_start[subnet_prefix] >= local.ipv4_network_start[vnet_prefix] &&
        local.ipv4_network_end[subnet_prefix] <= local.ipv4_network_end[vnet_prefix] &&
        floor(
          (local.ipv4_network_start[subnet_prefix] - local.ipv4_network_start[vnet_prefix]) /
          pow(2, 32 - tonumber(split("/", subnet_prefix)[1]))
        ) * pow(2, 32 - tonumber(split("/", subnet_prefix)[1])) ==
        local.ipv4_network_start[subnet_prefix] - local.ipv4_network_start[vnet_prefix],
        false
      )
    ])
  ])
}
