# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

resource "azurerm_network_security_group" "nsg" {
 for_each                  = var.spoke_subnets
  //This basically check to see if the user has defined the nsg_subnet_rules block for each
  //  subnet variable and if one is found then make an NSG for that subnet.
 /*  for_each = {
    for subnet, values in var.spoke_subnets : 
        subnet => values if values.nsg_subnet_rules != null
  } */

  name                = var.custom_spoke_network_security_group_name != null ? "${var.custom_spoke_network_security_group_name}_${each.key}" : "${data.azurenoopsutils_resource_name.nsg[each.key].result}"
  resource_group_name = local.resource_group_name
  location            = local.location

  tags = merge({ "ResourceName" = lower("nsg_${each.key}") }, local.default_tags, var.add_tags, )

  dynamic "security_rule" {
    for_each = each.value.nsg_subnet_rules != null ? each.value.nsg_subnet_rules : []

    content {
      name        = security_rule.value["name"]
      description = security_rule.value["description"]
      priority    = security_rule.value["priority"]
      direction   = security_rule.value["direction"]
      access      = security_rule.value["access"]
      protocol    = security_rule.value["protocol"]

      source_port_range  = security_rule.value["source_port_range"]
      source_port_ranges = security_rule.value["source_port_ranges"]

      destination_port_range  = security_rule.value["destination_port_range"]
      destination_port_ranges = security_rule.value["destination_port_ranges"]

      source_address_prefix                 = security_rule.value["source_address_prefix"]
      source_address_prefixes               = security_rule.value["source_address_prefixes"]
      source_application_security_group_ids = security_rule.value["source_application_security_group_ids"]

      destination_address_prefix                 = security_rule.value["destination_address_prefix"]
      destination_address_prefixes               = security_rule.value["destination_address_prefixes"]
      destination_application_security_group_ids = security_rule.value["destination_application_security_group_ids"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsgassoc" {
for_each                  = var.spoke_subnets
  //This basically check to see if the user has defined the nsg_subnet_rules block for each
  //  subnet variable and if one is found then make an NSG association between the NSG and subnet.
/*   for_each = {
    for subnet, values in var.spoke_subnets : 
        subnet => values if values.nsg_subnet_rules != null
  } */

  subnet_id                 = azurerm_subnet.default_snet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
