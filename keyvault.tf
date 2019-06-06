
resource "random_string" "keyvault_name" {
    length  = 22
    upper   = false
    special = false
}

resource "azurerm_resource_group" "keyvault" {
  name      = "${var.resource_group_name}"
  location  = "${var.location}"
}

resource "azurerm_key_vault" "security" {
    name                = "${random_string.keyvault_name.result}"
    location            = "${azurerm_resource_group.keyvault.location}"
    resource_group_name = "${azurerm_resource_group.keyvault.name}"
    enabled_for_disk_encryption = true
    enabled_for_deployment = true
    tenant_id = "${data.azurerm_client_config.current.tenant_id}" 

    sku {
      name = "premium"
    }

    network_acls {
      default_action = "Deny"
      bypass         = "AzureServices"
  }
}
