variable "name" {
  type        = string
  default     = null
  description = "Name of the server. If this input is not specified, a random ID is set as the name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name in which the resources should be created"
}

# SKU
variable "sku_name" {
  default     = "B_Standard_B1ms"
  description = <<-EOT
  The SKU Name for the PostgreSQL Flexible Server.
  The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3
  EOT
}

variable "zone" {

  type        = string
  default     = "1"
  description = "Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located"

}

variable "storage" {
  type = object({
    auto_grow             = bool
    size                  = number
    backup_retention_days = number
    geo_redundant_backup  = bool
    iops                  = number
  })

  default = {
    auto_grow             = true
    size                  = 5120
    backup_retention_days = 30
    geo_redundant_backup  = false
    iops                  = 1000
  }
}

variable "administrator_login" {
  type    = string
  default = "mysqladmin"
}

variable "engine_version" {
  type    = string
  default = "5.7"
}


variable "trusted_network_cidr" {
  type = map(string)
  default = {
    azure_internal = "0.0.0.0/32"
  }

  description = <<-EOT
  Trusted networks to allow access to e.g. Redis and PostgreSQL.
  The key may only contain alphanumeric characters and underscores.
  EOT
}

variable "tags" {
  type        = map(string)
  description = "The tags set allow to identify the resources that are managed by Terraform."
  default = {
    TF-Managed  = "true"
    Maintainer  = ""
    TF-Worfklow = ""
  }
}

variable "configuration" {
  type    = map(string)
  default = {}
}
