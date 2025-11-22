# Common variables

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "devopslab"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

# Backend-specific variables

variable "backend_resource_group_name" {
  description = "Optional override for backend resource group name. If empty, will be generated from project_name"
  type        = string
  default     = ""
}

variable "backend_storage_account_name" {
  description = "Optional override for backend storage account name. If empty, will be generated from project_name. Must be 3-24 chars, lowercase alphanumeric only"
  type        = string
  default     = ""

  validation {
    condition     = var.backend_storage_account_name == "" || (length(var.backend_storage_account_name) >= 3 && length(var.backend_storage_account_name) <= 24 && can(regex("^[a-z0-9]+$", var.backend_storage_account_name)))
    error_message = "Storage account name must be 3-24 characters, lowercase letters and numbers only."
  }
}
