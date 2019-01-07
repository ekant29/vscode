resource "azurerm_resource_group" "Terraform-ARG1" {
  name     = "${var.ARG}"
  location = "West US"
}

