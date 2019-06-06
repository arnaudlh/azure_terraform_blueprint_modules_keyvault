
# Temp service principal until Azure RM support natively user MSI
resource "azurerm_key_vault_secret" "service_principal_id" {
    depends_on = ["azurerm_key_vault_access_policy.service_administrator"]
    count     = "${length(local.levels)}"
    name      = "client-id"
    value     = "${element(azurerm_azuread_application.level.*.application_id, count.index)}"
    vault_uri = "${element(azurerm_key_vault.security.*.vault_uri, count.index)}"
}

resource "azurerm_key_vault_secret" "service_principal_password" {
    depends_on = ["azurerm_key_vault_access_policy.service_administrator"]
    count     = "${length(local.levels)}"
    name      = "client-secret"
    value     = "${element(azurerm_azuread_service_principal_password.level.*.value, count.index)}"
    vault_uri = "${element(azurerm_key_vault.security.*.vault_uri, count.index)}"
}

resource "azurerm_key_vault_secret" "tenant_id" {
    depends_on = ["azurerm_key_vault_access_policy.service_administrator"]
    count     = "${length(local.levels)}"
    name      = "tenant-id"
    value     = "${data.azurerm_client_config.current.tenant_id}"
    vault_uri = "${element(azurerm_key_vault.security.*.vault_uri, count.index)}"
}

resource "azurerm_key_vault_secret" "application_id" {
    depends_on = ["azurerm_key_vault_access_policy.service_administrator"]
    count     = "${length(local.levels)}"
    name      = "application-id"
    value     = "${element(azurerm_azuread_application.level.*.application_id, count.index)}"
    vault_uri = "${element(azurerm_key_vault.security.*.vault_uri, count.index)}"
}

resource "azurerm_key_vault_secret" "object_id" {
    depends_on = ["azurerm_key_vault_access_policy.service_administrator"]
    count     = "${length(local.levels)}"
    name      = "object-id"
    value     = "${element(azurerm_azuread_application.level.*.id, count.index)}"
    vault_uri = "${element(azurerm_key_vault.security.*.vault_uri, count.index)}"
}

# required to deploy from a release agent that has the user MSI assigned to it.
# see deploy.devops.sh
resource "azurerm_key_vault_secret" "level_user_assigned_identity" {
    depends_on = ["azurerm_key_vault_access_policy.service_administrator"]
    count     = "${length(local.levels)}"
    name      = "user-msi-id"
    value     = "${element(azurerm_user_assigned_identity.msi.*.id, count.index)}"
    vault_uri = "${element(azurerm_key_vault.security.*.vault_uri, count.index)}"
}

