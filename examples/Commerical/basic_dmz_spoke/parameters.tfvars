###########################
## Global Configuration  ##
###########################

# The prefixes to use for all resources in this deployment
org_name           = "anoa"   # This Prefix will be used on most deployed resources.  10 Characters max.
deploy_environment = "dev"    # dev | test | prod
environment        = "public" # public | usgovernment

# The default region to deploy to
default_location = "eastus"

# Enable locks on resources
enable_resource_locks = false # true | false

# Enable NSG Flow Logs
# By default, this will enable flow logs traffic analytics for all subnets.
enable_traffic_analytics = true

######################################
# Workload Spoke Virtual Network   ###
######################################

# DMZ Virtual Network Parameters
dmz_name               = "vpn"
dmz_vnet_address_space = ["10.8.39.0/24"]
dmz_subnets = {
  default = {
    name                                       = "vpn"
    address_prefixes                           = ["10.8.39.224/27"]
    service_endpoints                          = ["Microsoft.Storage"]
    private_endpoint_network_policies_enabled  = false
    private_endpoint_service_endpoints_enabled = true
    nsg_subnet_rules = [
      {
        name                       = "Allow-Traffic-From-Spokes",
        description                = "Allow traffic from spokes",
        priority                   = 100,
        direction                  = "Inbound",
        access                     = "Allow",
        protocol                   = "Tcp",
        source_port_range          = "*",
        destination_port_range     = "443",
        source_address_prefix      = "*",
        destination_address_prefix = "*"
      }
    ]
  }
}

# Private DNS Zones
# Add in the list of private_dns_zones to be created.
dmz_private_dns_zones = []

