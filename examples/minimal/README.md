# Minimal Example

This is the simplest possible example using the Proxmox module. It creates a single VM with minimal configuration.

## What This Example Creates

- **minimal-vm-01**: A single VM with 2 CPUs, 2GB RAM, and 20GB disk

## Usage

1. Copy this example to your workspace
2. Update `variables.tf` or create `terraform.tfvars` with your Proxmox credentials
3. Run:

```bash
terraform init
terraform plan
terraform apply
```

## Note

This example uses the module's default values for most settings. Only the essential VM configuration is specified.

