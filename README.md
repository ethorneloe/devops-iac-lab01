# DevOps IaC Lab 01 - Azure Remote Backend Setup

This repository contains a lab exercise for setting up an Azure remote backend for Terraform state management.

## Purpose

This lab teaches students how to create and configure Azure Storage as a remote backend for Terraform state files, which is essential for team collaboration and production deployments.

## Repository Structure

```
devops-iac-lab01/
├── 01-azure-remote-backend-setup/
│   ├── main.tf              # Main Terraform configuration
│   ├── variables.tf         # Input variables
│   ├── outputs.tf           # Output values
│   ├── providers.tf         # Provider configuration
│   ├── versions.tf          # Terraform version constraints
│   ├── terraform.tfvars.example  # Example variables file
│   └── README.md            # Lab instructions
├── .github/
│   └── workflows/
│       └── validate-terraform.yml  # PR validation workflow
├── .gitignore               # Git ignore patterns
├── LICENSE
└── README.md                # This file
```

## Getting Started

### Prerequisites

- Azure subscription
- Terraform >= 1.0
- Azure CLI (for local development) OR GitHub repository with OIDC configured (for CI/CD)

### For Students

1. Fork this repository
2. Clone your fork locally
3. Navigate to `01-azure-remote-backend-setup/`
4. Follow the instructions in the lab's README.md
5. Complete the lab exercises
6. Open a Pull Request to test your solution

### Testing Your Solution

When you open a Pull Request, an automated GitHub Actions workflow will:

1. Validate your Terraform syntax
2. Check for required resources
3. Verify security configurations
4. Run `terraform init` and `terraform validate`

The workflow uses OIDC authentication to connect to Azure securely without storing credentials.

## Lab Objectives

By completing this lab, you will:

- Understand why remote state management is important
- Learn how to configure Azure Storage for Terraform state
- Create a reusable backend configuration for team projects
- Practice infrastructure as code best practices
- Work with Terraform outputs for downstream consumption

## Security Considerations

The lab implements security best practices:

- Storage account with private access only
- TLS 1.2 minimum encryption
- No public blob access
- Container-level private access
- OIDC authentication for CI/CD (no stored credentials)

## Support

For questions or issues:

1. Review the lab README.md
2. Check Terraform documentation
3. Review Azure Storage documentation
4. Open an issue in this repository

## License

This project is licensed under the terms in the LICENSE file.

## Contributing

This is a lab exercise repository. If you find issues or have suggestions for improvements, please open an issue or pull request.
