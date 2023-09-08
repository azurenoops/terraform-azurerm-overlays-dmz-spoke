data "azurerm_virtual_network" "hub-vnet" {
  name                = "anoa-usgva-hub-core-FROG-vnet"
  resource_group_name = "anoa-usgva-hub-core-FROG-rg"
}

data "azurerm_storage_account" "hub-st" {
  name                = "anoausgva85c4535f04st"
  resource_group_name = "anoa-usgva-hub-core-FROG-rg"
}

data "azurerm_firewall" "hub-fw" {
  name                = "anoa-usgva-hub-core-FROG-fw"
  resource_group_name = "anoa-usgva-hub-core-FROG-rg"
}

data "azurerm_log_analytics_workspace" "hub-logws" {
  name                = "anoa-usgva-ops-mgt-logging-FROG-log"
  resource_group_name = "anoa-usgva-ops-mgt-logging-FROG-rg"
}