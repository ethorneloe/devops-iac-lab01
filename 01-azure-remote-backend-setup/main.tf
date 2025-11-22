# Local values for resource naming
locals {
  # Build resource group name from project_name if not overridden
  backend_rg_name = var.backend_resource_group_name != "" ? var.backend_resource_group_name : "rg-${var.project_name}-tfstate"

  # Build storage account name from project_name if not overridden
  # Storage account names must be 3-24 chars, lowercase alphanumeric only
  backend_sa_name = var.backend_storage_account_name != "" ? var.backend_storage_account_name : lower(replace("sa${var.project_name}tfstate", "/[^a-z0-9]/", ""))
}

# Resource Group for Terraform state backend
resource "azurerm_resource_group" "rg_backend" {
  name     = local.backend_rg_name
  location = var.location

  tags = {
    Environment = var.environment
    Purpose     = "Terraform State Backend"
    Project     = var.project_name
  }
}

# Storage Account for Terraform state
resource "azurerm_storage_account" "sa_backend" {
  name                     = local.backend_sa_name
  resource_group_name      = azurerm_resource_group.rg_backend.name
  location                 = azurerm_resource_group.rg_backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false
  min_tls_version          = "TLS1_2"

  tags = {
    Environment = var.environment
    Purpose     = "Terraform State Storage"
    Project     = var.project_name
  }
}

# Container for Terraform state files
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa_backend.name
  container_access_type = "private"
}
