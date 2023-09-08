# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

###########################
## Global Configuration  ##
###########################

# The prefixes to use for all resources in this deployment
org_name           = "anoa"         # This Prefix will be used on most deployed resources.  10 Characters max.
deploy_environment = "FROG"          # dev | test | prod
environment        = "usgovernment" # public | usgovernment

# The default region to deploy to
default_location = "usgovvirginia"

# Enable locks on resources
enable_resource_locks = false # true | false

# Enable NSG Flow Logs
# By default, this will enable flow logs traffic analytics for all subnets.
enable_traffic_analytics = true

######################################
# DMZ Spoke Virtual Network   ###
######################################


# DMZ Virtual Network Parameters
dmz_name               = "wl"
dmz_vnet_address_space = ["10.8.59.0/24"]
dmz_subnets = {
  default = {
    name                                       = "wl"
    address_prefixes                           = ["10.8.59.224/27"]
    service_endpoints                          = ["Microsoft.Storage"]
    private_endpoint_network_policies_enabled  = false
    private_endpoint_service_endpoints_enabled = true
    nsg_subnet_rules = [
      {
        name                       = "Allow-Traffic-From-Spokes",
        description                = "Allow traffic from spokes",
        priority                   = 200,
        direction                  = "Inbound",
        access                     = "Allow",
        protocol                   = "*",
        source_port_range          = "*",
        destination_port_ranges    = ["22", "80", "443", "3389"],
        source_address_prefixes    = ["10.8.6.0/24", "10.8.7.0/24", "10.8.8.0/24"],
        destination_address_prefix = "10.8.59.0/24"
      }
    ]
  }
}

# Private DNS Zones
# Add in the list of private_dns_zones to be created.
dmz_private_dns_zones = []


