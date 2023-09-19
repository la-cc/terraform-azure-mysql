resource "random_id" "server_name" {
  count = var.name == null ? 1 : 0

  byte_length = 3
}

resource "random_password" "administrator_password" {
  length  = 24
  special = false
  keepers = {
    administrator_login = var.administrator_login
  }
}


resource "azurerm_mysql_server" "main" {
  name                = var.name == null ? random_id.server_name[0].hex : var.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  administrator_login          = var.administrator_login
  administrator_login_password = random_password.administrator_password.result

  sku_name = var.sku_name
  version  = var.engine_version

  auto_grow_enabled                 = var.storage["auto_grow"]
  storage_mb                        = var.storage["size"]
  backup_retention_days             = var.storage["backup_retention_days"]
  geo_redundant_backup_enabled      = var.storage["geo_redundant_backup"]
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  ssl_enforcement_enabled           = var.ssl_enforcement
  ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced
  tags                              = var.tags
}

resource "azurerm_mysql_firewall_rule" "mysql" {
  count               = length(var.trusted_network_cidr)
  name                = element(keys(var.trusted_network_cidr), count.index)
  resource_group_name = azurerm_mysql_server.main.resource_group_name
  server_name         = azurerm_mysql_server.main.name
  start_ip_address    = cidrhost(element(values(var.trusted_network_cidr), count.index), 0)
  end_ip_address      = cidrhost(element(values(var.trusted_network_cidr), count.index), -1)
}
