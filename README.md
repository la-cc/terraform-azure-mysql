# Introduction:

The module is used to deploy azure mysql with a default setup (Infrastructure- and Configuration as Code).

> **_NOTE:_** The required providers, providers configuration and terraform version are maintained in the user's configuration and are not maintained in the modules themselves.

# Example Use of Module:

    module "mysql" {
    source                          = "github.com/la-cc/terraform-azure-mysql?ref=1.0.0"

    resource_group_name             = var.resource_group.name
    name                            = var.name
    tags                            = var.tags

    }
