# Outputs for backend configuration

output "backend_resource_group_name" {
  description = "Name of the resource group containing the backend storage account"
  value       = azurerm_resource_group.rg_backend.name
}

output "backend_storage_account_name" {
  description = "Name of the storage account for Terraform state"
  value       = azurerm_storage_account.sa_backend.name
}

output "backend_container_name" {
  description = "Name of the container for Terraform state files"
  value       = azurerm_storage_container.tfstate.name
}

output "backend_state_key_hint" {
  description = "Example state key format for use in backend blocks"
  value       = "env-${var.environment}.tfstate"
}

output "backend_config_example" {
  description = "Example backend configuration block for other labs"
  value = <<-EOT
    terraform {
      backend "azurerm" {
        resource_group_name  = "${azurerm_resource_group.rg_backend.name}"
        storage_account_name = "${azurerm_storage_account.sa_backend.name}"
        container_name       = "${azurerm_storage_container.tfstate.name}"
        key                  = "your-lab-name.tfstate"
      }
    }
  EOT
}
