# Lab 01: Azure Remote Backend Setup

## Overview

This lab sets up the foundational infrastructure for storing Terraform state remotely in Azure. You'll create a resource group, storage account, and container that will be used by all subsequent labs to store their Terraform state files.

## Prerequisites

- Azure subscription with appropriate permissions
- Terraform installed (version >= 1.0)
- Azure CLI installed and authenticated, OR
- GitHub repository configured with OIDC authentication to Azure (for CI/CD)

## What You'll Create

1. **Resource Group** - Container for the backend storage resources
2. **Storage Account** - Azure Storage account for state files
   - Standard tier with LRS replication
   - Private access only (no public blob access)
   - TLS 1.2 minimum
3. **Storage Container** - Named `tfstate` to hold state files

## Lab Instructions

### Step 1: Review the Configuration

Examine the following files to understand the setup:

- `main.tf` - Resource definitions
- `variables.tf` - Input variables (customize as needed)
- `outputs.tf` - Output values for use in other labs
- `providers.tf` - Azure provider configuration
- `versions.tf` - Terraform and provider version constraints

### Step 2: Initialize Terraform

```bash
cd 01-azure-remote-backend-setup
terraform init
```

This downloads the required Azure provider.

### Step 3: Customize Variables (Optional)

You can customize the deployment by creating a `terraform.tfvars` file:

```hcl
project_name = "myproject"
environment  = "dev"
location     = "eastus"

# Optional: Override auto-generated names
# backend_resource_group_name   = "rg-custom-tfstate"
# backend_storage_account_name  = "sacustomtfstate"
```

**Note:** Storage account names must be 3-24 characters, lowercase alphanumeric only.

### Step 4: Plan the Deployment

```bash
terraform plan
```

Review the planned changes to ensure everything looks correct.

### Step 5: Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### Step 6: Capture the Outputs

After successful deployment, capture the output values:

```bash
terraform output
```

You'll see output similar to:

```
backend_resource_group_name  = "rg-devopslab-tfstate"
backend_storage_account_name = "sadevopslabtfstate"
backend_container_name       = "tfstate"
backend_state_key_hint       = "env-dev.tfstate"
backend_config_example       = <<-EOT
  terraform {
    backend "azurerm" {
      resource_group_name  = "rg-devopslab-tfstate"
      storage_account_name = "sadevopslabtfstate"
      container_name       = "tfstate"
      key                  = "your-lab-name.tfstate"
    }
  }
EOT
```

### Step 7: Save the Backend Configuration

**IMPORTANT:** Save these output values! You'll need them to configure the backend in other labs.

Create a note with:
- Resource Group Name
- Storage Account Name
- Container Name

## Using This Backend in Other Labs

Once this lab is complete, you can configure other Terraform projects to use this remote backend.

Add the following block to the `terraform` block in other labs' Terraform configurations:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devopslab-tfstate"    # From output
    storage_account_name = "sadevopslabtfstate"       # From output
    container_name       = "tfstate"                  # From output
    key                  = "lab-02.tfstate"           # Unique per lab/environment
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
```

Replace the values with your actual outputs and choose a unique `key` for each lab or environment.

## Important Notes

1. **State Storage:** This lab uses local state because it's the first infrastructure component. All subsequent labs should use this remote backend.

2. **Resource Naming:** Resources are named using the `project_name` variable to ensure uniqueness. You can override these with the optional variables.

3. **Security:** The storage account is configured with:
   - Private container access
   - No public blob access
   - TLS 1.2 minimum
   - HTTPS required for all operations

4. **Cost:** This infrastructure uses Standard LRS storage, which is cost-effective for state files. The costs should be minimal.

## Testing Your Solution

If you're submitting this as part of a course or workshop, open a Pull Request with your solution. The automated workflow will:

1. Validate your Terraform configuration
2. Run `terraform init` to check syntax
3. Run `terraform validate` to verify configuration
4. Check for required resources and security settings

## Cleanup

To destroy the resources created in this lab:

```bash
terraform destroy
```

**WARNING:** Only destroy these resources if you're not using them for state storage in other labs!

## Troubleshooting

### Storage Account Name Too Long
If you get an error about storage account name length, provide a custom shorter name:

```hcl
backend_storage_account_name = "satfstatedev"
```

### Authentication Issues
Ensure you're authenticated to Azure:

```bash
az login
az account show
```

### Permission Errors
Ensure your account has permissions to create resource groups and storage accounts in the subscription.

## Next Steps

After completing this lab, you can proceed to other labs that will use this remote backend for state management.
