variable "name" {
  type        = string
  default     = null
  description = "Name of the MariaDB server. If this input is not specified, a random ID is set as the name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name in which the resources should be created"
}

# SKU
variable "sku_name" {
  default     = "B_Gen5_2"
  description = <<-EOT
  (Required) Specifies the SKU Name for this MariaDB Server.
  The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8).
  For more information see the product documentation.
  Possible values are:
  - B_Gen5_1
  - B_Gen5_2
  - GP_Gen5_2
  - GP_Gen5_4
  - GP_Gen5_8
  - GP_Gen5_16
  - GP_Gen5_32
  - MO_Gen5_2
  - MO_Gen5_4
  - MO_Gen5_8
  - MO_Gen5_16
  EOT
}

variable "ssl_minimal_tls_version_enforced" {

  type        = string
  default     = "TLS1_2"
  description = "The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2."

}

variable "infrastructure_encryption_enabled" {

  type        = bool
  default     = false
  description = "Whether or not infrastructure is encrypted for this server. Changing this forces a new resource to be created."
}

variable "storage" {
  type = object({
    auto_grow             = bool
    size                  = number
    backup_retention_days = number
    geo_redundant_backup  = bool
  })

  default = {
    auto_grow             = true
    size                  = 5120
    backup_retention_days = 30
    geo_redundant_backup  = false
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

variable "ssl_enforcement" {
  type    = bool
  default = true
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


variable "public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this server."
  default     = true
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
