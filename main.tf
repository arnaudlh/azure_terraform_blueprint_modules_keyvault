provider "azurerm" {}

terraform {
  backend "azurerm" {}
}


locals {
    levels      = ["l0", "l1", "l2", "l3"]
    levels_name = ["level0", "level1", "level2", "level3"]
}

data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

