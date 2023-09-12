# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

output "nsg_ids" {
  value = module.mod_vnet_spoke.network_security_group_ids
}

output "nsg_names" {
  value = module.mod_vnet_spoke.network_security_group_names
}
