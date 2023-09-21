output "id" {
  value       = azurerm_mysql_flexible_server.main.id
  description = "The ID of the MySQL Server"
}

output "host" {
  value       = azurerm_mysql_flexible_server.main.fqdn
  description = "The FQDN of the MySQL Server."

}

output "server_name" {
  value       = azurerm_mysql_flexible_server.main.name
  description = " Specifies the name of the MySQL Server. Changing this forces a new resource to be created."

}


output "username" {
  value       = azurerm_mysql_flexible_server.main.administrator_login
  description = "The administrator username of the MySQL Server."
}

output "password" {
  value       = random_password.administrator_password.result
  description = "The administrator password of the MySQL Server."
}
