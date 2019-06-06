
resource "azurerm_key_vault_access_policy" "msi_levels" {
  count               = "${length(local.levels)}"
  lifecycle = {
    ignore_changes = ["tenant_id"]
  }
  
  vault_name          = "${element(azurerm_key_vault.security.*.name, count.index)}"
  resource_group_name = "${azurerm_resource_group.keyvault.name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${element(azurerm_user_assigned_identity.msi.*.principal_id, count.index)}"

  key_permissions = []

  secret_permissions = [
    "get",
    "list"
  ]
}

resource "azurerm_key_vault_access_policy" "sp_levels" {

  count               = "${length(local.levels)}"
  lifecycle = {
    ignore_changes = ["tenant_id"]
  }
  
  vault_name          = "${element(azurerm_key_vault.security.*.name, count.index)}"
  resource_group_name = "${azurerm_resource_group.keyvault.name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${element(azurerm_azuread_service_principal.level.*.id, count.index)}"

  key_permissions = []

  secret_permissions = [
    "get",
    "list"
  ]
}

resource "azurerm_key_vault_access_policy" "sp_devops" {

  count               = "${length(local.levels)}"
  lifecycle = {
    ignore_changes = ["tenant_id"]
  }
  
  vault_name          = "${element(azurerm_key_vault.security.*.name, count.index)}"
  resource_group_name = "${azurerm_resource_group.keyvault.name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${azurerm_azuread_service_principal.devops.id}"

  key_permissions = []

  secret_permissions = [
    "get",
    "list"
  ]
}

resource "azurerm_key_vault_access_policy" "service_administrator" {

  count               = "${length(local.levels)}"
  lifecycle = {
    ignore_changes = ["tenant_id"]
  }
  
  vault_name          = "${element(azurerm_key_vault.security.*.name, count.index)}"
  resource_group_name = "${azurerm_resource_group.keyvault.name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${var.sa_objectId}"

  key_permissions = []

  secret_permissions = [
    "set",
    "get",
    "delete",
    "list"
  ]
}
